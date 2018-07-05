Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F47C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696C523F82
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8bZSYVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696C523F82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753819AbeGEPi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:38:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35004 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbeGEPiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:38:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id v3-v6so8089054wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cdjhUmIPqam8zEYCKZ6+m4ragvWF/0w4cr2GGAFhHQg=;
        b=N8bZSYVu4k6i1HcX+PAvSN8Ua1/MtWBGYpbMosXdzSYdU0KZe8CR3Bgl+OSzwqRsQt
         0w4TXeps0hWVDungeUoVkcuG4uKT8/7xoRuMvIxwpW59atB8F4OjvJarmx5Zq8IiFff6
         DTLs2mTzezPzpAxE/7ZHCcG7n5eVami0rQN0wLIqSETPvUhghxVybIBipT+NcnKMzl6X
         LyPj9SroJ3dr0/KeRs25kqKuAAwkV/SEEBtiWrZRjQF12ZnB7uPvNZteXptCxzJLCAYS
         rjcTf2r1YW3ARUOLJNUh5HI1UNE1SITxc4bxRo4lvN6RPLQBzYyC5ng+PphSTf7YItJS
         noTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cdjhUmIPqam8zEYCKZ6+m4ragvWF/0w4cr2GGAFhHQg=;
        b=WFVvbErlQl3zQkYguMfMytETe/M8sGuXiC6DR6fJqgnv6g/SpRjn6zkDovnWh3WAdT
         eURkw+65fX95BZRyO9DmEBa1P3vQFJ0PNGXTqW4XXtG4n39cWUNFxZf790yimIDubdGp
         m5WRlNuvTX64ZiWb3CsGhgJfu93NcBx4s+F0U9QKQVFqdzgbqYXPuPeIqAgqUfckzf6o
         qZr/8A0dKWCX+8LC0JhbcTE0y6rPafZ6AEAg71ZDHYtpZXcZZA/uzC8WxeosMbjgRfWR
         xHnxBj8p8DfYlFbNWYER1lJn6keyME7KkqM3wa53+NU00CG0KFMn5RbAxQkjh+EveSnw
         3p7A==
X-Gm-Message-State: APt69E0zqI7yZDcC6gkZS/YNvEBCZ7GEB0SAP2Fdb4f+drg5HM70R+Xa
        W3v7eqnPOgjnzIjPPzgVdAg=
X-Google-Smtp-Source: AAOMgpfJrBQp2f0bJKJb2oVycJRh/55J1Fm0nuvsEtCgrJjq08ckGkjKV6xKK2tf3/Pvq6bOjcisiQ==
X-Received: by 2002:a1c:2d54:: with SMTP id t81-v6mr4882326wmt.31.1530805103783;
        Thu, 05 Jul 2018 08:38:23 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 24-v6sm16420794wrz.94.2018.07.05.08.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 08:38:23 -0700 (PDT)
Date:   Thu, 5 Jul 2018 17:38:20 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     KY Srinivasan <kys@microsoft.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
 enlightenment.
Message-ID: <20180705153820.GA26768@gmail.com>
References: <20180703230155.15160-1-kys@linuxonhyperv.com>
 <20180704161039.GA23658@gmail.com>
 <MW2PR2101MB111396005B0F5572C92B4CD7A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW2PR2101MB111396005B0F5572C92B4CD7A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* KY Srinivasan <kys@microsoft.com> wrote:

> 
> 
> > -----Original Message-----
> > From: Ingo Molnar <mingo.kernel.org@gmail.com> On Behalf Of Ingo Molnar
> > Sent: Wednesday, July 4, 2018 9:11 AM
> > To: KY Srinivasan <kys@microsoft.com>
> > Cc: x86@kernel.org; gregkh@linuxfoundation.org; linux-
> > kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> > apw@canonical.com; jasowang@redhat.com; tglx@linutronix.de;
> > hpa@zytor.com; Stephen Hemminger <sthemmin@microsoft.com>; Michael
> > Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> > Subject: Re: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
> > enlightenment.
> > 
> > 
> > * kys@linuxonhyperv.com <kys@linuxonhyperv.com> wrote:
> > 
> > > From: "K. Y. Srinivasan" <kys@microsoft.com>
> > >
> > > The IPI hypercalls depend on being able to map the Linux notion of CPU ID
> > > to the hypervisor's notion of the CPU ID. The array hv_vp_index[] provides
> > > this mapping. Code for populating this array depends on the IPI
> > functionality.
> > > Break this circular dependency.
> > >
> > > Fixes: 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")
> > >
> > > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > > Tested-by: Michael Kelley <mikelley@microsoft.com>
> > > ---
> > >  arch/x86/hyperv/hv_apic.c       | 5 +++++
> > >  arch/x86/hyperv/hv_init.c       | 5 ++++-
> > >  arch/x86/include/asm/mshyperv.h | 2 ++
> > >  3 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > Ugh, this patch wasn't even build tested, on 64-bit allyes/allmodconfig:
> > 
> >  arch/x86/hyperv/hv_apic.c: In function ‘__send_ipi_mask’:
> >  arch/x86/hyperv/hv_apic.c:171:4: error: label ‘ipi_mask_done’ used but not
> > defined
> >  scripts/Makefile.build:317: recipe for target 'arch/x86/hyperv/hv_apic.o'
> > failed
> >  make[2]: *** [arch/x86/hyperv/hv_apic.o] Error 1
> 
> Sorry Ingo. I had a clean build on the linux-next tree (tag: next-20180702) that
> I used to base this patch. What was the tree you applied the patch to?

If you look at the error message, it won't build against *any* tree, because 
there's no 'ipi_mask_done' label either in the kernel source, or introduced
by the patch.

So whatever tree you used it on, if you build arch/x86/hyperv/hv_apic.o it should 
be broken.

Thanks,

	Ingo
