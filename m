Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95159C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA1D24003
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vAhXc71B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA1D24003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754060AbeGFKAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:00:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39810 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753616AbeGFKAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:00:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so13844483wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u5EfOWTq2SM6w5whiJyFSPsfNoKS7YMx8CI0Lov5eCI=;
        b=vAhXc71B43yZSSYhoSxxY4BDXpr7K/Prh/KWEKc1VU6ejYd9o1I5wweGTFFD+VbMOl
         jXATtVvvF1rWjXhZBFRjRsAygMnOe6FtqaasJcKX2tqdJ4FFzxp9EHm6d3y8dcRaXyE+
         +KEAxz2hAf/YyMTJm0ly0Z+YCLcNYDxYzlh3+XZBbxvyMEljRwKWLoFNpPSFrZMRDXa0
         XQbKwosALyQ6rv6+TbRwUD+kSjdcwiQEv+y8UDwfjA0980ADpKdVltDbSzGbNrkIlCpe
         gDPCKx4OOIdaQDL3yfTjkm4TVPXtZbtt+kOqFpPsrVdymu0KY6H8ODhYhZoisNGA+iPh
         Lu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=u5EfOWTq2SM6w5whiJyFSPsfNoKS7YMx8CI0Lov5eCI=;
        b=tYNp1Tq/TjuNspbgee0NbCgVTazJLdm9WmLFYRiVt016mC+idMTgkZ+X/kP5Y0MMgb
         wE9+UT3Pp3T/hMbYTY0U/FcHhkmslht7ADvvZPWVNFNOF78wV9mXnJyl2ZaDi0BgUNIa
         CQVY/fbrHUf6/zhj0SBfOmFHbGBaXdOA8OZMvKTtPo110rYqEkDtHO7bJ3zRKfoab+gy
         /K2aKpPtN/SFTCMM3s/vnIqcIZal47IYBBhEkbrxLDBPtdg1rG6ESP/WfiXJqoBu+LBp
         vNXCCyMs2prDQ886aRoV9lRtoUVWMZpXvB+uV68/LhvTgUUo5Y9PJP+UZ+s3XhkAGqqa
         0Mbw==
X-Gm-Message-State: APt69E0ADHNXiajOZ07FeG7QpxZPXpBcE90S4iiM911fouhHa2DD4xaM
        FGIiS6YzWadvpS5kj6LqPuw=
X-Google-Smtp-Source: AAOMgpcdeVVzXRRMz3g/Ofw8HTKuhyrbY4PBHqZdILO/HfEQcA5XVAIvDq8WI/ECXqfe0zTI2XYZaQ==
X-Received: by 2002:a1c:5f82:: with SMTP id t124-v6mr6098434wmb.14.1530871211376;
        Fri, 06 Jul 2018 03:00:11 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 185-v6sm15916303wmw.23.2018.07.06.03.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 03:00:10 -0700 (PDT)
Date:   Fri, 6 Jul 2018 12:00:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     KY Srinivasan <kys@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
 enlightenment.
Message-ID: <20180706100008.GA3483@gmail.com>
References: <20180703230155.15160-1-kys@linuxonhyperv.com>
 <20180704161039.GA23658@gmail.com>
 <MW2PR2101MB111396005B0F5572C92B4CD7A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <20180705153820.GA26768@gmail.com>
 <MW2PR2101MB1113ABC82EC62E2C8DBA2400A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <20180705222302.GB5410@gmail.com>
 <alpine.DEB.2.21.1807060043290.1771@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807060043290.1771@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 6 Jul 2018, Ingo Molnar wrote:
> > * KY Srinivasan <kys@microsoft.com> wrote:
> > > I am confused. The label ipi_mask_done was introduced in this patch
> > > (the patch under question fixes a circular dependency in this patch):
> > > 
> > > commit 68bb7bfb7985df2bd15c2dc975cb68b7a901488a
> > > Author: K. Y. Srinivasan <kys@microsoft.com>
> > > Date:   Wed May 16 14:53:31 2018 -0700
> > > 
> > >     X86/Hyper-V: Enable IPI enlightenments
> > > 
> > >     Hyper-V supports hypercalls to implement IPI; use them.
> > > 
> > >     Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > >     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > >     Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > > 
> > > This patch was committed by Thomas some weeks ago and is in linux-next.
> > > This patch is also in 4.18-rc3.
> > 
> > And then that name was changed to a different label in:
> > 
> >   4bd06060762b: x86/hyper-v: Use cheaper HVCALL_SEND_IPI hypercall when possible
> > 
> > So maybe you were testing on an older kernel. Could you try the latest -tip?
> 
> The problem is that the wreckage is in Linus tree and needs to be fixed
> there, i.e. via x86/urgent.

Indeed, I missed that!

> Now we have the new bits queued in x86/hyperv already which collide. So we
> need to merge x86/urgent into x86/hyperv after applying the fix and mop up
> the merge wreckage in x86/hyperv.
> 
> I'll have a look tomorrow morning unless you beat me to it.

Ok!

Thanks,

	Ingo
