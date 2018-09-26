Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3234C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE9B208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfX9mYL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE9B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeIZUKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:10:40 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38565 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbeIZUKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:10:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id s129-v6so12917116qke.5;
        Wed, 26 Sep 2018 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q3VmB7Ot6GmKtuvhY4iOwR40nBrw3cZ9AokfNRmhSuA=;
        b=vfX9mYL4yBOAvv0gyFScuiVDFzxAGwLcQFxop/kdxUDruXNRkzIQJAiGqwa8oMMjoo
         aiBf8LfZZ2H0Dt64vygxnBUP94JdesaVkF19OgUq72/WBQTvhtJzfe61S+3Q7khHfdS1
         fC84xZbK+4mY4vt3Kxku9EpNOMxwlcbvL2TKH51rXiJZB4QFMINb47xGX65JIGKPY/eo
         OlrpjZfBB7HUPEeJOTrFIpdI3bg6Y5A4qCgKut2BA7STsD+FK7Wp42gIQCbi0WnmxMtp
         PqaeFe9tmXdKHOB5YpeNSg0K8NPVSA3BHXs5fThbpcvDjijCwpToVm3tHBpILhxQPeqZ
         zw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3VmB7Ot6GmKtuvhY4iOwR40nBrw3cZ9AokfNRmhSuA=;
        b=FVo0ej69FcL2vdwGQDP2UstGhmNAwXpP13Z/YN9rDi2OMH7vK2IxN0ABiaP9DVfAUP
         tRTEwG9iEslQqDm0tUazGQ5WCaeimSfZmONJtldbr0fCRwEeom701LMjJmgYjHYyNpBg
         P5SE4hIXf4KMplsF6mBVkg5mVtRG7n/ScJwTaW9eQPnE2FBAuZvEZUCDrD21Jtfjbfyj
         tniRrCABkQuAd3vqoCPQjrDL4MnA3qpSE3W4B47r8C8UiQyAwgC8kpSKMm7FkOVPa4w3
         gegnoGCW1JSce82H3QByW8pM6GAffd4XM186PWhSaa+8sC2LwsSbx0DiA+ZiFClrUe/J
         N05g==
X-Gm-Message-State: ABuFfoh22wLjC9M8H7irl8bYyyxi79VZPi+qXL2Il5uu7w9/SdWxFVre
        QVOimWsRxeuBOa/vep+ajOVhpot4skawDPev3D0=
X-Google-Smtp-Source: ACcGV63bSrqnSlzZ9XIol13kq2seqS7vaGRYI5qJUt8pN4dzpkKgcJhtU7FbRBQoXQSwSakZv7J8FClA88xsSGrb5DA=
X-Received: by 2002:ae9:e50d:: with SMTP id w13-v6mr4357157qkf.137.1537970254832;
 Wed, 26 Sep 2018 06:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com> <20180903180415.31575-2-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20180903180415.31575-2-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 16:57:23 +0300
Message-ID: <CAHp75Vcx-rk_dgf6fNRMa6o-zFeSXAG+HSNMAN-1XVCsXvvv1w@mail.gmail.com>
Subject: Re: [PATCH 2/4] platform/x86: intel_pmc_core: Fix LTR IGNORE Max offset
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 9:05 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> Cannonlake PCH allows us to ignore LTR from more IPs than Sunrisepoint
> PCH so make the LTR ignore platform specific.
>

This looks fine to me.

> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 4 +++-
>  drivers/platform/x86/intel_pmc_core.h | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 972735bd4c75..c1330a03523d 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -149,6 +149,7 @@ static const struct pmc_reg_map spt_reg_map = {
>         .ppfear_buckets = SPT_PPFEAR_NUM_ENTRIES,
>         .pm_cfg_offset = SPT_PMC_PM_CFG_OFFSET,
>         .pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
> +       .ltr_ignore_max = SPT_NUM_IP_IGN_ALLOWED,
>  };
>
>  /* Cannonlake: PGD PFET Enable Ack Status Register(s) bitmap */
> @@ -320,6 +321,7 @@ static const struct pmc_reg_map cnp_reg_map = {
>         .ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
>         .pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>         .pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
> +       .ltr_ignore_max = CNP_NUM_IP_IGN_ALLOWED,
>  };
>
>  static inline u8 pmc_core_reg_read_byte(struct pmc_dev *pmcdev, int offset)
> @@ -566,7 +568,7 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file, const char __user
>                 goto out_unlock;
>         }
>
> -       if (val > NUM_IP_IGN_ALLOWED) {
> +       if (val > map->ltr_ignore_max) {
>                 err = -EINVAL;
>                 goto out_unlock;
>         }
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> index b24407048fa1..12663c58f122 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -44,7 +44,7 @@
>  #define SPT_PMC_READ_DISABLE_BIT               0x16
>  #define SPT_PMC_MSG_FULL_STS_BIT               0x18
>  #define NUM_RETRIES                            100
> -#define NUM_IP_IGN_ALLOWED                     17
> +#define SPT_NUM_IP_IGN_ALLOWED                 17
>  #define SPT_PMC_LTR_CUR_PLT                    0x350
>  #define SPT_PMC_LTR_CUR_ASLT                   0x354
>  #define SPT_PMC_LTR_SPA                                0x360
> @@ -153,6 +153,7 @@ enum ppfear_regs {
>  #define CNP_PPFEAR_NUM_ENTRIES                 8
>  #define CNP_PMC_READ_DISABLE_BIT               22
>  #define CNP_PMC_LATCH_SLPS0_EVENTS             BIT(31)
> +#define CNP_NUM_IP_IGN_ALLOWED                 19
>  #define CNP_PMC_LTR_CUR_PLT                    0x1B50
>  #define CNP_PMC_LTR_CUR_ASLT                   0x1B54
>  #define CNP_PMC_LTR_SPA                                0x1B60
> @@ -215,6 +216,7 @@ struct pmc_reg_map {
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
