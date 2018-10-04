Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827A0C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466542082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2pnDQQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466542082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJDTfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:35:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35586 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbeJDTfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:35:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id v19-v6so9656525qtg.2;
        Thu, 04 Oct 2018 05:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrufZivdSX0urUoqLPm9PbL1viV0bBWp7Xp2dvw/XOM=;
        b=H2pnDQQdCGheC/JFWlKJvwzRdEwoO2L5Sl/lU/WhPRNf/lsmZmx91yXZhyqZkrPpF3
         wLL/4xGGxsADTwHo+ue25FdQBOoSfpiZQaCvMhOCTTLTql/ZpuNwhdcQd+CYS9Gjft7i
         UZkqsm++yuBaFzM7ChpPp5pNcbyMILNdNzhQayiUyTzqXD7M8uUtq6NKbe/Wm2hlYzZd
         0Sq/xwI4b1VTOK31uV77Ip2Xsdip5qYrLV+g0L+ByRjyLJ73ChS04sNpMbRiAybFkNR9
         T2+F/OaKns5GUGV8WuTqSPcFKehX3pWgf1MnKF2F8KpmfQSPy94dta8YuBqsN/8T0dzX
         W7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrufZivdSX0urUoqLPm9PbL1viV0bBWp7Xp2dvw/XOM=;
        b=VU/QmW3KH08Ftd52GOMjY0eF0hFsSNFpRPtxeje71ynGXkiaqMuI8/GLzqg2b+PW23
         24k92UmO8XYIutqQ427LVHS1eKmo6AGvrTEMl6aUiBsV5tfI8RVOpndNfXFNy5PiDnie
         JafJJkLyddMfWLznUPJPdrQsdYPF7NjWvuxlbeTQiyhgcWaFwZydBuyfFRnyosf8gtxy
         4LBYhrjB20MMgojH6bfNcSYgFTzwyCtkTriL6aQjkO31Ge3s8JoicBi9g+8gHrhnWZrI
         H2cS46cbReRko1wSLhfYieSwJRw28uKKcGLL+50s0c924ZFWOhngQ68MkjUrl8Q/5W6n
         DVkg==
X-Gm-Message-State: ABuFfogXo8MwvsMQQSRKCp3PePplJ7+J03srhUH85gVrGcrDuqnsSuB2
        YdoFyVHFCIm3MCHibaowEiPTQxLbKZCqy98P5vzbnZEE
X-Google-Smtp-Source: ACcGV61HyjHCTRSBoAVfL5nBAXCewBPET6eC/SXdXgCiS/JFyD3ivGTnMDxbdxi+FoPeL88GwP7C2kCYDiqGbk5c7Wk=
X-Received: by 2002:ac8:234c:: with SMTP id b12-v6mr5247242qtb.187.1538656914689;
 Thu, 04 Oct 2018 05:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181003115110.25996-1-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20181003115110.25996-1-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Oct 2018 15:41:43 +0300
Message-ID: <CAHp75Vf980Wih6+cfEd-SjRDZNKdMT20wbocvsRFZ0OjHaGbhg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: intel_pmc_core: Update MAINTAINERS
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 2:53 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> This removes the entry for pmc_core.h file in the MAINTAINERS as the
> file is already removed by a previous commit.
> "platform/x86: intel_pmc_core: Remove unused header file"
>

Pushed to our for-next branch directly, thanks!

> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ad052aeac39..60d029b65767 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7468,7 +7468,6 @@ M:        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
>  M:     Vishwanath Somayaji <vishwanath.somayaji@intel.com>
>  L:     platform-driver-x86@vger.kernel.org
>  S:     Maintained
> -F:     arch/x86/include/asm/pmc_core.h
>  F:     drivers/platform/x86/intel_pmc_core*
>
>  INTEL PMC/P-Unit IPC DRIVER
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
