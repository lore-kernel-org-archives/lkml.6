Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA5CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20EC20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohCVMB10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20EC20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeLCTJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:09:48 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38835 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeLCTJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:09:48 -0500
Received: by mail-qt1-f195.google.com with SMTP id p17so15110983qtl.5;
        Mon, 03 Dec 2018 11:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9B6ZvdHB5QzgldK0P6MI9mVpmAd5Mev5B7zmvE7Cvs=;
        b=ohCVMB10Mt8J7IVOoCHR+mwayqfuqCnGDua2kT7kWBGRE023wmDsQeWbwNYy3hNSFH
         ZO3LTNCPwS96B60KnYBTwSzbtC5iA3/yMTHNCyE8sVAydTspxtUkbfSgjYaUG3ZYZEoY
         twqgVxFst6KEy2VsfWND86tn/ktc8Tut9QYp4iDZ+D7GpfpffQxBLI3deBpUFuGouKp1
         Dz6ImqdaIYflfqMIqO9nf6m8V3M7YCCYfhBGeFQ1kU2kPUsswuhPiI6Ioui1pCOzjBcj
         dwtjQDOfl7esXalhvMRws3w6BOIlTaqC6EDEj+3JrpxryNvIv8rS867NMVkUnrUuXQc8
         QoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9B6ZvdHB5QzgldK0P6MI9mVpmAd5Mev5B7zmvE7Cvs=;
        b=cBaKsGmcSHo3FxqNUDFLr0r/ScU7kRlu9h0+bpeCBM6KyzPMB7GPWi7pkf7fXWpPOe
         PO+cLmGfiVa6ZCxOuzzSoGzD+u01lpBPwdVsbfTdQF9PMP3DCYH99b9+52fmANFzYjLT
         BFFwJfhnonHT+TCqSN0FhVUmvlgnJ4hokG4OSAyJb0P42156RZQinwuQAF+A7mSxX39b
         ffV/6Ot9KPp0/A/T29O8ja8zf3uu6H7r1vsviRC8nK9fRSAWuJ3J9HLqDaSKN3H0au8F
         GCCeM0MdcgpWiKO6Sblhbtc9SFNAF8n9uHo0/iTS3Ni+K6n/xk86q9uXLtcoWbv7YRSa
         dobw==
X-Gm-Message-State: AA+aEWbnWZHbCmdIWVEGyI9M5BQ1bacVlcm9LZebR7fhTZKkIKFGkyJC
        RKJw0HuJLc25b5Hth4GGP6zQUmHq5d5wiB8eW4c=
X-Google-Smtp-Source: AFSGD/Wxx0BiHV7COBKME+1OAzp1RmiAzzQqE/uBjN7tZ1qb+HuFzIpJysCjjgWPH7R3cxbHUg/hY2TybU363BwqaIk=
X-Received: by 2002:a0c:c2ce:: with SMTP id c14mr17434788qvi.7.1543864185584;
 Mon, 03 Dec 2018 11:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20181201155229.8532-1-tiny.windzz@gmail.com>
In-Reply-To: <20181201155229.8532-1-tiny.windzz@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 21:09:34 +0200
Message-ID: <CAHp75VdEbr9YfaCgHXNqScZC-KMobF2fU8rZb29nhZPBJvm2gg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
To:     tiny.windzz@gmail.com
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        David Box <david.e.box@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 5:52 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

By some reason it's not applicable.
Please, rebase on top of our for-next branch, thanks!

>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c         | 46 ++++---------------
>  .../platform/x86/intel_telemetry_debugfs.c    | 42 +++--------------
>  2 files changed, 14 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 6b31d410cb09..95311ad6ec6f 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -311,7 +311,7 @@ static void pmc_core_display_map(struct seq_file *s, int index,
>                    pf_map[index].bit_mask & pf_reg ? "Off" : "On");
>  }
>
> -static int pmc_core_ppfear_sts_show(struct seq_file *s, void *unused)
> +static int pmc_core_ppfear_show(struct seq_file *s, void *unused)
>  {
>         struct pmc_dev *pmcdev = s->private;
>         const struct pmc_bit_map *map = pmcdev->map->pfear_sts;
> @@ -330,17 +330,7 @@ static int pmc_core_ppfear_sts_show(struct seq_file *s, void *unused)
>         return 0;
>  }
>
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
> @@ -372,7 +362,7 @@ static int pmc_core_send_msg(u32 *addr_xram)
>         return 0;
>  }
>
> -static int pmc_core_mphy_pg_sts_show(struct seq_file *s, void *unused)
> +static int pmc_core_mphy_pg_show(struct seq_file *s, void *unused)
>  {
>         struct pmc_dev *pmcdev = s->private;
>         const struct pmc_bit_map *map = pmcdev->map->mphy_sts;
> @@ -425,17 +415,7 @@ static int pmc_core_mphy_pg_sts_show(struct seq_file *s, void *unused)
>         return err;
>  }
>
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
> @@ -472,17 +452,7 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
>         return err;
>  }
>
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
> @@ -602,19 +572,19 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>                             &pmc_core_dev_state);
>
>         debugfs_create_file("pch_ip_power_gating_status", 0444, dir, pmcdev,
> -                           &pmc_core_ppfear_ops);
> +                           &pmc_core_ppfear_fops);
>
>         debugfs_create_file("ltr_ignore", 0644, dir, pmcdev,
>                             &pmc_core_ltr_ignore_ops);
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
> diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
> index 40bce560eb30..98ba9185a27b 100644
> --- a/drivers/platform/x86/intel_telemetry_debugfs.c
> +++ b/drivers/platform/x86/intel_telemetry_debugfs.c
> @@ -466,17 +466,7 @@ static int telem_pss_states_show(struct seq_file *s, void *unused)
>         return 0;
>  }
>
> -static int telem_pss_state_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, telem_pss_states_show, inode->i_private);
> -}
> -
> -static const struct file_operations telem_pss_ops = {
> -       .open           = telem_pss_state_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(telem_pss_states);
>
>  static int telem_ioss_states_show(struct seq_file *s, void *unused)
>  {
> @@ -505,17 +495,7 @@ static int telem_ioss_states_show(struct seq_file *s, void *unused)
>         return 0;
>  }
>
> -static int telem_ioss_state_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, telem_ioss_states_show, inode->i_private);
> -}
> -
> -static const struct file_operations telem_ioss_ops = {
> -       .open           = telem_ioss_state_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(telem_ioss_states);
>
>  static int telem_soc_states_show(struct seq_file *s, void *unused)
>  {
> @@ -664,17 +644,7 @@ static int telem_soc_states_show(struct seq_file *s, void *unused)
>         return 0;
>  }
>
> -static int telem_soc_state_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, telem_soc_states_show, inode->i_private);
> -}
> -
> -static const struct file_operations telem_socstate_ops = {
> -       .open           = telem_soc_state_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(telem_soc_states);
>
>  static int telem_s0ix_res_get(void *data, u64 *val)
>  {
> @@ -960,7 +930,7 @@ static int __init telemetry_debugfs_init(void)
>
>         f = debugfs_create_file("pss_info", S_IFREG | S_IRUGO,
>                                 debugfs_conf->telemetry_dbg_dir, NULL,
> -                               &telem_pss_ops);
> +                               &telem_pss_states_fops);
>         if (!f) {
>                 pr_err("pss_sample_info debugfs register failed\n");
>                 goto out;
> @@ -968,7 +938,7 @@ static int __init telemetry_debugfs_init(void)
>
>         f = debugfs_create_file("ioss_info", S_IFREG | S_IRUGO,
>                                 debugfs_conf->telemetry_dbg_dir, NULL,
> -                               &telem_ioss_ops);
> +                               &telem_ioss_states_fops);
>         if (!f) {
>                 pr_err("ioss_sample_info debugfs register failed\n");
>                 goto out;
> @@ -976,7 +946,7 @@ static int __init telemetry_debugfs_init(void)
>
>         f = debugfs_create_file("soc_states", S_IFREG | S_IRUGO,
>                                 debugfs_conf->telemetry_dbg_dir,
> -                               NULL, &telem_socstate_ops);
> +                               NULL, &telem_soc_states_fops);
>         if (!f) {
>                 pr_err("ioss_sample_info debugfs register failed\n");
>                 goto out;
> --
> 2.17.0
>


-- 
With Best Regards,
Andy Shevchenko
