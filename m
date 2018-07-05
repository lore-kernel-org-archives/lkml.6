Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C90AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B806B2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qm48Z/Qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B806B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbeGEWXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:23:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39451 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753421AbeGEWXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:23:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so2296410wre.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 15:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QJfz60KODRdFqOqeBvtyLUqnDFpl3mt8rRqaUZ6ento=;
        b=qm48Z/QhJ8vUvisEaSpzTeGJoLC/TIUDTeLalgXPCB48MUFNkkNCoUv7MrHwYcHg3f
         L6Nw3+/epTtzUbL1/QS7smTNI+FRcnQgHt/2oCcpRKkHYrQ9BA7WLRolr2/1TlY8P1pi
         svodDr0tUMzYjHwddhRiZ1IuUjevfBsVt0sAzb8mQBfLlp6p2SGI8wVblLbzDfzFt6iX
         QJVwubnuIkQu/luGRpd+40JP+fvAtztS2hENJdOn3JyUcdcow2xh7QAsj5K0seykJOUZ
         vbg3DT2DaCBVhQmDzB0wjFAj3oBMAsiMMB94kAWM8fo/PFm0+SJoqZo9f5MfIXzq4trb
         PW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QJfz60KODRdFqOqeBvtyLUqnDFpl3mt8rRqaUZ6ento=;
        b=kH5/aowWONz2OaqUslHivQ7QO7JsfIlW+FzcomNLr/l1Uij4tsOVhFfOD/lteKmJdl
         UPXdKKzgTiMAqltoo5p41cVuE3cyYzR/RHfpDNJ21c3hz11pRjhTpNAvAEtTULR7lFc7
         EPm6e+GnQiboIJ/XTPTk3jQcYq2QzBc7Fm4rbVx2YCjv+EkS0jFrgGpASKOcitlv5jnL
         dKmcTsspr908QYcBL8I4AuiX77mUZAInsowtmzuKffyE4mSggzG3SpV3r30r13OBSlMq
         netKkXLcf9CO9/J47DNYT1ECzwfiZl1wLt9LrL4bMiXRWukF216kYyL9qHU/fVI7deWo
         a7OA==
X-Gm-Message-State: APt69E3yTNSHnF0z/zBsgZ+L7+AqaZPri0dLOa/NWqTi3lzCp3ci1Maz
        +vGeALiUjp5NR2wm0+DhV/Y=
X-Google-Smtp-Source: AAOMgpeVIrZ/DpNyBaVWyUuZfiBxg1swxlumYY/qwEU7tz8GOosKqYjUbJYN/DbOX1BEEhOVEf6uMw==
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr5599048wrp.161.1530829385074;
        Thu, 05 Jul 2018 15:23:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a2-v6sm5111917wmb.6.2018.07.05.15.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 15:23:04 -0700 (PDT)
Date:   Fri, 6 Jul 2018 00:23:02 +0200
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
Message-ID: <20180705222302.GB5410@gmail.com>
References: <20180703230155.15160-1-kys@linuxonhyperv.com>
 <20180704161039.GA23658@gmail.com>
 <MW2PR2101MB111396005B0F5572C92B4CD7A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <20180705153820.GA26768@gmail.com>
 <MW2PR2101MB1113ABC82EC62E2C8DBA2400A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW2PR2101MB1113ABC82EC62E2C8DBA2400A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
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
> > Sent: Thursday, July 5, 2018 8:38 AM
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
> > * KY Srinivasan <kys@microsoft.com> wrote:
> > 
> > >
> > >
> > > > -----Original Message-----
> > > > From: Ingo Molnar <mingo.kernel.org@gmail.com> On Behalf Of Ingo
> > Molnar
> > > > Sent: Wednesday, July 4, 2018 9:11 AM
> > > > To: KY Srinivasan <kys@microsoft.com>
> > > > Cc: x86@kernel.org; gregkh@linuxfoundation.org; linux-
> > > > kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> > > > apw@canonical.com; jasowang@redhat.com; tglx@linutronix.de;
> > > > hpa@zytor.com; Stephen Hemminger <sthemmin@microsoft.com>;
> > Michael
> > > > Kelley (EOSG) <Michael.H.Kelley@microsoft.com>;
> > vkuznets@redhat.com
> > > > Subject: Re: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
> > > > enlightenment.
> > > >
> > > >
> > > > * kys@linuxonhyperv.com <kys@linuxonhyperv.com> wrote:
> > > >
> > > > > From: "K. Y. Srinivasan" <kys@microsoft.com>
> > > > >
> > > > > The IPI hypercalls depend on being able to map the Linux notion of CPU
> > ID
> > > > > to the hypervisor's notion of the CPU ID. The array hv_vp_index[]
> > provides
> > > > > this mapping. Code for populating this array depends on the IPI
> > > > functionality.
> > > > > Break this circular dependency.
> > > > >
> > > > > Fixes: 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")
> > > > >
> > > > > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > > > > Tested-by: Michael Kelley <mikelley@microsoft.com>
> > > > > ---
> > > > >  arch/x86/hyperv/hv_apic.c       | 5 +++++
> > > > >  arch/x86/hyperv/hv_init.c       | 5 ++++-
> > > > >  arch/x86/include/asm/mshyperv.h | 2 ++
> > > > >  3 files changed, 11 insertions(+), 1 deletion(-)
> > > >
> > > > Ugh, this patch wasn't even build tested, on 64-bit allyes/allmodconfig:
> > > >
> > > >  arch/x86/hyperv/hv_apic.c: In function ‘__send_ipi_mask’:
> > > >  arch/x86/hyperv/hv_apic.c:171:4: error: label ‘ipi_mask_done’ used but
> > not
> > > > defined
> > > >  scripts/Makefile.build:317: recipe for target 'arch/x86/hyperv/hv_apic.o'
> > > > failed
> > > >  make[2]: *** [arch/x86/hyperv/hv_apic.o] Error 1
> > >
> > > Sorry Ingo. I had a clean build on the linux-next tree (tag: next-20180702)
> > that
> > > I used to base this patch. What was the tree you applied the patch to?
> > 
> > If you look at the error message, it won't build against *any* tree, because
> > there's no 'ipi_mask_done' label either in the kernel source, or introduced
> > by the patch.
> > 
> > So whatever tree you used it on, if you build arch/x86/hyperv/hv_apic.o it
> > should
> > be broken.
> 
> Ingo,
> 
> I am confused. The label ipi_mask_done was introduced in this patch
> (the patch under question fixes a circular dependency in this patch):
> 
> commit 68bb7bfb7985df2bd15c2dc975cb68b7a901488a
> Author: K. Y. Srinivasan <kys@microsoft.com>
> Date:   Wed May 16 14:53:31 2018 -0700
> 
>     X86/Hyper-V: Enable IPI enlightenments
> 
>     Hyper-V supports hypercalls to implement IPI; use them.
> 
>     Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
> This patch was committed by Thomas some weeks ago and is in linux-next.
> This patch is also in 4.18-rc3.

And then that name was changed to a different label in:

  4bd06060762b: x86/hyper-v: Use cheaper HVCALL_SEND_IPI hypercall when possible

So maybe you were testing on an older kernel. Could you try the latest -tip?

Thanks,

	Ingo
