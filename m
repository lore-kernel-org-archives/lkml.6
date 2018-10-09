Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E161C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260BB2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/QAgJrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260BB2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeJIVaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:30:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35962 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIVaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:30:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id u34-v6so1740525qth.3;
        Tue, 09 Oct 2018 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kq5wa5PWVVx/kxt3A42TS1IApA4ReTV/1jPPl7qBSAY=;
        b=s/QAgJrEGe+qg/bnjsUx4nUJRfBbkjQ0ec/HCNCdl1A5s/lZT5gky704OtnwnDqDo4
         JUix4wqp/ihiP7Za9fKRXgt4LdxhS86tpaaMPlDplcxikjSirAssMJaMuEPtRgw/VOWH
         iyY4n9aj366NW/CPc24LHKPSvI+OlPrHxufEjmuC67G05HOe3tgPgFcDpLFLHHD95pPs
         k1Ra2q3tquHVcl/n4gICLYZVATd5HXwvHsc5FuBUuRA27DzXR+NeNvSVji0pNBX3UZLE
         oCjItp74y6KL2HgTCNi3DP2+0w/5VmIPX5K/IFHolTEyohTjD/SfMbfOUWnJBCNCrbFh
         rXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kq5wa5PWVVx/kxt3A42TS1IApA4ReTV/1jPPl7qBSAY=;
        b=XD5xI0WOB4Kldysa35UgN7gUdg+mVblZivf5Zn5gOkqP4otGbM7LvN32NzA39+xbxR
         lgsr2kfpAIl2dvXMa9Kg1jExOt5fiL9ML6xCaeYtOBysw8bo4tij4wHT8LMrB6HrYFPO
         n0qcA057OJuryClCXbxtyJLBCrFsip1QWq06TLisqMIn2YPth/OzFn9+IY2FAfe51g2V
         YsIkG6rO8MJDsPfyS4CWOa1OQKzfcTL16txdqMuZS273dfVTJHrl23xdZn+AENHJonhY
         Iw8Vcvu5Pf8tVlKcrqyywaSHa4gteP9FtIFSB0lR1jvi6Kh8ynigO4ehY03gQirTwjOK
         ivlg==
X-Gm-Message-State: ABuFfoj94I4QArMfU48lcQ75J1H4h1PuI1EB8hv3iCqIbL9nPAqJ47s0
        yLK0TyUSDwWtd1Ah05VxGkTfFgOzYpPQkWzicZE=
X-Google-Smtp-Source: ACcGV60bLzo1FXdU0LyiIgroshSHN4BbgilUhudNnmm+EN2MO2RgWpzkRUSvLT0+FychB4h0HVuQAndq02zA82QrxVQ=
X-Received: by 2002:a0c:93c5:: with SMTP id g5mr2140332qvg.136.1539094416348;
 Tue, 09 Oct 2018 07:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181008144303.23878-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VfNsasf-hpiubrfw=x+iVjBOOcY=uj6dB97iVpkoT6K=w@mail.gmail.com> <f6742716-d302-9af6-4d7f-428def965279@linux.intel.com>
In-Reply-To: <f6742716-d302-9af6-4d7f-428def965279@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Oct 2018 17:13:25 +0300
Message-ID: <CAHp75VcHUZzzemZdtuNgOYMA=DJ-naWk1Cxj0yPxZn3-W151Bw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: intel_telemetry: Update maintainers info
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 5:12 PM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
>
>
> On 09-Oct-18 5:07 PM, Andy Shevchenko wrote:
> > On Mon, Oct 8, 2018 at 5:44 PM Rajneesh Bhardwaj
> > <rajneesh.bhardwaj@linux.intel.com> wrote:
> >> Add myself and David as the new maintainers for Intel Telemetry driver.
> >>
> > There is no explanation why.
> > (Like previous one left the company, and / or you are doing set of the
> > drivers related to PMC where telemetry is part of, etc)
>
> Hi Andy,
>   Souvik no longer works with Intel. I and David are volunteering to
> take up the task on his behalf since we do work on drivers which are
> pretty close to this one in terms of functionalities.
>

Good, please update the commit message and send v2. Thanks!

> Thanks
> Rajneesh
>
> >> Signed-off-by: Box, David E <david.e.box@linux.intel.com>
> >> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> >> ---
> >>   MAINTAINERS | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 22065048d89d..f33ebd1b8034 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -7530,7 +7530,8 @@ F:        arch/x86/crypto/sha*-mb/
> >>   F:     crypto/mcryptd.c
> >>
> >>   INTEL TELEMETRY DRIVER
> >> -M:     Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
> >> +M:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> >> +M:     Box, David E <david.e.box@linux.intel.com>
> >>   L:     platform-driver-x86@vger.kernel.org
> >>   S:     Maintained
> >>   F:     arch/x86/include/asm/intel_telemetry.h
> >> --
> >> 2.17.1
> >>
> >
>


-- 
With Best Regards,
Andy Shevchenko
