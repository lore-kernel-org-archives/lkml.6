Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A95ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B2D20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6l60hmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B2D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJSUTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:19:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46522 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeJSUTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:19:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id d8-v6so37938706qtk.13;
        Fri, 19 Oct 2018 05:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJwP2bgS/FoVh1EYwS4zKqQD+3FXQyLnh+jfAK9WhLg=;
        b=R6l60hmAg9bA2Vo4rlThJil3PGzfmIb2vDpFyhxhHMxqfuak/JAtJE8qglcir0i/pJ
         /yM5z8nDyaATZJacSBrwEyNjdTGgtr+Fq0HsUDnraDwvR6BdaU+9ls4rRWOM5btiYoy/
         kwHUQj2tuahDQ1JTGYngWPGoUqEkctLUdfY245vIN5Hwyd8USH3f3tEmis4SGRZ8v2T1
         5SX3USot4t+Nz/AR+73FKMJmBg5IHPzIMg6QzgtwgZmHeDIQGxAiuPIuIKiwvW1/Z2CZ
         YYZ5RtEdLLXlgL60xthJq9r+gh4FuY1gScDJYev4Q7uH2u7nkSkY0gk+dnjc7gyTiaZO
         sIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJwP2bgS/FoVh1EYwS4zKqQD+3FXQyLnh+jfAK9WhLg=;
        b=OUgW30NWhmjoIFwVrfTLJg0s9y/oOEmpW9Rk+Qt7HrtysA+oGswDv2qMTJqa+J2W5C
         8ketD/y4W4d8exdqOawJ1UHzKpBo4iRgi8tF1Gp/rRXr/V3UOdq8rB6A8S2pxtbAFyoA
         LFxoOdmXmxlRu5yr3uTLYvGf0JzBSgiHHhkLbfTPXKIONmw/Gba4AnojUOPP50Up3HEP
         Il0M5qCVuo3zWoaU7LhFwJFnmnbs0I03Dp1LdM6cqeX38rhc/3Sl6kpeUb5yDhOm1Cv9
         tAOes3DsuAZhPLAJFb0ubdPTMW/GyJqL20YcdAZoakIXpd9ItBm7jv0XnGHCCMVDIKgj
         CSIw==
X-Gm-Message-State: ABuFfohnN+7lYoaAc7vqaRifjBpX5Y4EicBnJM2s/doQN0bIWHKL/CK4
        UQYLluIt0CaPXlhswNEKT5Ym0MDhrq0PHIjHdl8=
X-Google-Smtp-Source: ACcGV616S27ztvh2OqNFFnoIUDKgB/CbalQj4Z2Q3RX+q+lU4kIelVoYwOeEFVZj6OvoHVevytYKpAz6xcMWdgiMm4g=
X-Received: by 2002:aed:2de3:: with SMTP id i90-v6mr14268810qtd.229.1539951220173;
 Fri, 19 Oct 2018 05:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181006065113.669-1-rajneesh.bhardwaj@linux.intel.com> <20181006065113.669-2-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20181006065113.669-2-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 15:13:29 +0300
Message-ID: <CAHp75Vde__h3XDjw_TLQA8YVrnCU+_JJgr-Mr_gtQE77Pwjy2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] platform/x86: intel_pmc_core: Fix LTR IGNORE Max offset
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 9:54 AM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> Cannonlake PCH allows us to ignore LTR from more IPs than Sunrisepoint
> PCH so make the LTR ignore platform specific.
>

Pushed to my reviewing and testing queue, thanks!

> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 4 +++-
>  drivers/platform/x86/intel_pmc_core.h | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 217a822a8da1..c616cfedf2be 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -148,6 +148,7 @@ static const struct pmc_reg_map spt_reg_map = {
>         .ppfear_buckets = SPT_PPFEAR_NUM_ENTRIES,
>         .pm_cfg_offset = SPT_PMC_PM_CFG_OFFSET,
>         .pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
> +       .ltr_ignore_max = SPT_NUM_IP_IGN_ALLOWED,
>  };
>
>  /* Cannonlake: PGD PFET Enable Ack Status Register(s) bitmap */
> @@ -319,6 +320,7 @@ static const struct pmc_reg_map cnp_reg_map = {
>         .ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
>         .pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>         .pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
> +       .ltr_ignore_max = CNP_NUM_IP_IGN_ALLOWED,
>  };
>
>  static inline u8 pmc_core_reg_read_byte(struct pmc_dev *pmcdev, int offset)
> @@ -565,7 +567,7 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file, const char __user
>                 goto out_unlock;
>         }
>
> -       if (val > NUM_IP_IGN_ALLOWED) {
> +       if (val > map->ltr_ignore_max) {
>                 err = -EINVAL;
>                 goto out_unlock;
>         }
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> index 7a00436e337d..7f8181057ec8 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -44,7 +44,7 @@
>  #define SPT_PMC_READ_DISABLE_BIT               0x16
>  #define SPT_PMC_MSG_FULL_STS_BIT               0x18
>  #define NUM_RETRIES                            100
> -#define NUM_IP_IGN_ALLOWED                     17
> +#define SPT_NUM_IP_IGN_ALLOWED                 17
>
>  #define SPT_PMC_LTR_CUR_PLT                    0x350
>  #define SPT_PMC_LTR_CUR_ASLT                   0x354
> @@ -154,6 +154,7 @@ enum ppfear_regs {
>  #define CNP_PPFEAR_NUM_ENTRIES                 8
>  #define CNP_PMC_READ_DISABLE_BIT               22
>  #define CNP_PMC_LATCH_SLPS0_EVENTS             BIT(31)
> +#define CNP_NUM_IP_IGN_ALLOWED                 19
>  #define CNP_PMC_LTR_CUR_PLT                    0x1B50
>  #define CNP_PMC_LTR_CUR_ASLT                   0x1B54
>  #define CNP_PMC_LTR_SPA                                0x1B60
> @@ -216,6 +217,7 @@ struct pmc_reg_map {
>         const u32 pm_cfg_offset;
>         const int pm_read_disable_bit;
>         const u32 slps0_dbg_offset;
> +       const u32 ltr_ignore_max;
>  };
>
>  /**
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
