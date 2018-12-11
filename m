Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CE0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7882081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do4cNtF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7882081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeLKKQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:16:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39144 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeLKKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:16:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so6424680pgl.6;
        Tue, 11 Dec 2018 02:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5gTzS+Qp8bCx/9Rf+cOjyNPvBUue27jJlDhXBkck4Y=;
        b=Do4cNtF/O8UHuKOl0DRBHcNo71Tw4c+dM/s5SZ3R9EjZUDSsC/NkbvzyDtHkSmqmRM
         sxAHx42of4VCB6lFXJMOqBdpVuAsgaWU74PQ5CSjfFBsf5M+mST1XfWh0Jn/4aCyDpHa
         X6ddzH7q/XhNinQACUQhHM9BzfcAJpq0gs2PT6c0jeETTBvfi/h+Td0Vb7ALYpALGkom
         /3T2zHbwDOSzXPm+AfVShLmEKQq3N0tebpkClQhWZpXUC3an66t1xs2gipvTvSdymozx
         063ShOgaBUs3TDIITnyx7bzl5t8p7W84c0//z16O6CO7yrXaaWGgaWqcqk1viQUfH2pC
         7r4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5gTzS+Qp8bCx/9Rf+cOjyNPvBUue27jJlDhXBkck4Y=;
        b=CF9IdEVTY9tUGFcIWoy3gaLmbflF87aI3Jx/x1oCPcwB2lOuQshSis988EBjVtX3Fx
         oMzhQLod+ZlT5gyl9ZGgS2YUlCuc4hRNB3afQdAnNO94Kct/F1rhpSyIHZZBFem2VXZg
         NMMK2BbN1ronRxUerhqy64/Bv7C2TiRZMYgcuWO3xXnz+Sl91RqGoxDFmCh4OVyVE7Il
         ZzxglaMg+Bq+2nkCOWGASpSG1ewjvXYWZsPNlG8PpqEaRS9fFUMmGB2r+u/gGTDPFFZc
         3ag+68T0zHIReqsB44SG5OkiFX5VU4W9u/dgV4XyWY0hk+c/fVjH9FdiVJP4Q/BFALL6
         jBlA==
X-Gm-Message-State: AA+aEWaaaLmdPJNjlUY2ga/BvUX0JBd3Cjwg3YC8ei81lbWSCucEDXMq
        +KvFV5KuOURP5PnyW+glTlhh6EvlIoSQnMPJYLg=
X-Google-Smtp-Source: AFSGD/VZ+VNDgO6L9H5g18zE8pXk+4O5dloCcGlo4jSD10QeA7KA2N/FIrduMDlsoYOqFacqsnTKHiaPnAxWojffthg=
X-Received: by 2002:a63:20e:: with SMTP id 14mr14019700pgc.161.1544523399243;
 Tue, 11 Dec 2018 02:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20181205151255.15367-1-tiny.windzz@gmail.com>
In-Reply-To: <20181205151255.15367-1-tiny.windzz@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Dec 2018 12:16:27 +0200
Message-ID: <CAHp75VcsQPx2pn84Fhh-qT71JwR1-0fEQm8nj2sei0oHByy7Dg@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: intel_pmc_core: convert to DEFINE_SHOW_ATTRIBUTE
To:     tiny.windzz@gmail.com
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 5:13 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>

Both patches had been pushed, thanks!

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 49 +++++----------------------
>  1 file changed, 8 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index eba6f5c27e2f..22dbf115782e 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -367,7 +367,7 @@ static void pmc_core_display_map(struct seq_file *s, int index,
>                    pf_map[index].bit_mask & pf_reg ? "Off" : "On");
>  }
>
> -static int pmc_core_ppfear_sts_show(struct seq_file *s, void *unused)
> +static int pmc_core_ppfear_show(struct seq_file *s, void *unused)
>  {
>         struct pmc_dev *pmcdev = s->private;
>         const struct pmc_bit_map *map = pmcdev->map->pfear_sts;
> @@ -385,18 +385,7 @@ static int pmc_core_ppfear_sts_show(struct seq_file *s, void *unused)
>
>         return 0;
>  }
> -
> -static int pmc_core_ppfear_sts_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, pmc_core_ppfear_sts_show, inode->i_private);
> -}
> -
> -static const struct file_operations pmc_core_ppfear_ops = {
> -       .open           = pmc_core_ppfear_sts_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(pmc_core_ppfear);
>
>  /* This function should return link status, 0 means ready */
>  static int pmc_core_mtpmc_link_status(void)
> @@ -428,7 +417,7 @@ static int pmc_core_send_msg(u32 *addr_xram)
>         return 0;
>  }
>
> -static int pmc_core_mphy_pg_sts_show(struct seq_file *s, void *unused)
> +static int pmc_core_mphy_pg_show(struct seq_file *s, void *unused)
>  {
>         struct pmc_dev *pmcdev = s->private;
>         const struct pmc_bit_map *map = pmcdev->map->mphy_sts;
> @@ -480,18 +469,7 @@ static int pmc_core_mphy_pg_sts_show(struct seq_file *s, void *unused)
>         mutex_unlock(&pmcdev->lock);
>         return err;
>  }
> -
> -static int pmc_core_mphy_pg_sts_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, pmc_core_mphy_pg_sts_show, inode->i_private);
> -}
> -
> -static const struct file_operations pmc_core_mphy_pg_ops = {
> -       .open           = pmc_core_mphy_pg_sts_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(pmc_core_mphy_pg);
>
>  static int pmc_core_pll_show(struct seq_file *s, void *unused)
>  {
> @@ -527,18 +505,7 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
>         mutex_unlock(&pmcdev->lock);
>         return err;
>  }
> -
> -static int pmc_core_pll_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, pmc_core_pll_show, inode->i_private);
> -}
> -
> -static const struct file_operations pmc_core_pll_ops = {
> -       .open           = pmc_core_pll_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
>
>  static ssize_t pmc_core_ltr_ignore_write(struct file *file, const char __user
>  *userbuf, size_t count, loff_t *ppos)
> @@ -729,7 +696,7 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>                             &pmc_core_dev_state);
>
>         debugfs_create_file("pch_ip_power_gating_status", 0444, dir, pmcdev,
> -                           &pmc_core_ppfear_ops);
> +                           &pmc_core_ppfear_fops);
>
>         debugfs_create_file("ltr_ignore", 0644, dir, pmcdev,
>                             &pmc_core_ltr_ignore_ops);
> @@ -738,12 +705,12 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>
>         if (pmcdev->map->pll_sts)
>                 debugfs_create_file("pll_status", 0444, dir, pmcdev,
> -                                   &pmc_core_pll_ops);
> +                                   &pmc_core_pll_fops);
>
>         if (pmcdev->map->mphy_sts)
>                 debugfs_create_file("mphy_core_lanes_power_gating_status",
>                                     0444, dir, pmcdev,
> -                                   &pmc_core_mphy_pg_ops);
> +                                   &pmc_core_mphy_pg_fops);
>
>         if (pmcdev->map->slps0_dbg_maps) {
>                 debugfs_create_file("slp_s0_debug_status", 0444,
> --
> 2.17.0
>


-- 
With Best Regards,
Andy Shevchenko
