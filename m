Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9066DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485412081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2EAcrjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485412081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeKCDhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:37:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36561 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCDhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:37:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id o125so4576497qkf.3;
        Fri, 02 Nov 2018 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/95QvQYdgLcnWwVdJz8gKv25pRkUN+WGIMqBdOVIpk=;
        b=V2EAcrjjVdBPEtSp9cDL1qrxB2l8Rnrvo78I2PIxWxkjzt1vBLo/UmESmZj/3WT7Hw
         lAnK/lbianxjzdhyIGYbapStYGECA50HMNLHyBBCmNwb8H0d49UEcqHppFtSzkd3adNd
         OQxdI5/gJZNHFZLbShR9sfHB6dlRPDQ060S8mONru8VBsDZteYEzZMxjMQOxtwY05zHf
         AaiXUfZfKTM9rvdMzTMNsiIZQGjNGRRQ65JY2opZPTYtRig7xKxsQYFp8fxrjcNWdFFW
         lKWH5Wvc2RLC8ZMWL7oOiLfzmU6EMZAc196VlLmox92R0iiJnAsNxHPsZBVJsqshYFo1
         jG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/95QvQYdgLcnWwVdJz8gKv25pRkUN+WGIMqBdOVIpk=;
        b=BUrv1xNRxO7yOB4JjaysIl6GYmuqk2/tT8UaUNh0f4qwA5XKVlKgylsVyyJ0qAPnFG
         c8PF/K6YEmqJfwcm/72V6Jiz6rNEKU8VnPHGJaigdOHgAZl3fYj09YUtyocOdgp8Bq95
         nyRx0roaItMXycUO637P4DZba3td0BZ1g24wJXKQR4aCOjgePvfdMvwASolE8fJqyz3m
         /X3Gj49DsgSh/2lx7bkEzx+2O2X0UWyn2/XkkBPEkdSPBT5ToHOQonwGE9vXWVG/+laf
         0C6IUu/WS1+ASCxKOrCD0fxGgE2C21jdPw/HkIUkbsJ7B8yewWqXCaK7rre7FTqnh6h5
         v47g==
X-Gm-Message-State: AGRZ1gKzFQavK2ghQYaG7F9fO4zob1t7Vtq5yuqw7xRM8oTi9uBGlnCV
        2uhRJz/Ue7OQqy8T2xJxWBxoC4VDNLdc6iBegr0=
X-Google-Smtp-Source: AJdET5fft2Z2xp/ftJX9DW8I/FzxG/n5weZQ4YqwTRGU6rcJ/SnubS9Oh+gzx/d3E/Pow3NFVZNz8yviFiez3Dom5nU=
X-Received: by 2002:a37:c3c3:: with SMTP id r64mr11606173qkl.70.1541183343185;
 Fri, 02 Nov 2018 11:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181102102703.21846-1-rajneesh.bhardwaj@linux.intel.com> <20181102102703.21846-2-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20181102102703.21846-2-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Nov 2018 20:28:52 +0200
Message-ID: <CAHp75VdYKaBEMDCR6MxdBbDHU81CB9Qc7gt0yJy6dEbLMaBx-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] platform/x86: intel_pmc_core: Fix LTR IGNORE Max offset
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 12:29 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> Cannonlake PCH allows us to ignore LTR from more IPs than Sunrisepoint
> PCH so make the LTR ignore platform specific.
>

This one fine, thanks!

> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 4 +++-
>  drivers/platform/x86/intel_pmc_core.h | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 69270888558b..11e8ecde95f0 100644
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
