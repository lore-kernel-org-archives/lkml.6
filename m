Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778C7C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D27D2083F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9YfHtyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D27D2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbeLEOYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:24:47 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36844 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLEOYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:24:47 -0500
Received: by mail-vs1-f65.google.com with SMTP id v205so12178495vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hn1arwVE4ACKQ+qm2z7nQF28/vDd3cWKfLDYp2IP3ZU=;
        b=g9YfHtygVAfxdUM9kVinuEnD/bTRoIgcGm8U1cav4pjVErUT+6xbxugKblX3VNfDHv
         tzld2mgi/E2lzj13RbpCVXhNNdHsghiD4m05imY6rKMWQS4+cltgBeyyFiXE99w/aSOu
         3AgNry2KltjViQdOTqwvTviaW4+FJY/5ggyTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hn1arwVE4ACKQ+qm2z7nQF28/vDd3cWKfLDYp2IP3ZU=;
        b=CuWkSoOWWy++noHYQZIplvbST5JYR6gBYhjQ5y8D6dZo5x4JAans/YtX633+oFAUK9
         sN+H2Q7Xp5HMojGmn66ZGxalsJykC7FsUobg34qpv4YdBbJtO+GivR4/trZ4lXqRXu4o
         O/sz4HcBtlsh+z0X2ExjRep9xPnMNgZ6DRiF8hHIxAvIp1dJPGA73LD+igs0X450/Yd3
         J2VhJ2mmhAlTpE13+rZbLLVdfe78PY9QaIHM4bIVg9QXpUHp4CfUOEVWhLyKfK5o0/Mr
         0vMM76GEpOIpyt9CPLTvzoIJcZvMmpeqRhds12vaCmcnu0i27KuTAT9MX9cTt8Poy+Tn
         rTFw==
X-Gm-Message-State: AA+aEWZm0FTZo1wqjGL1j7M7Tk32Xu7bLYrxvJskXI1MilW5uGvcwO4/
        aYUL6xUVm2FmsOXFphtGz2zMI4Hcveokpsjl44yIEA==
X-Google-Smtp-Source: AFSGD/UCTdghTei9ZRVB/jXrf1Ed+/rOyVV14g1PlVKx5WCAiTW2SyoFNfnIczfJ81x4gRN175EOcJkNvF3TZmW0/AI=
X-Received: by 2002:a67:7685:: with SMTP id r127mr10763045vsc.35.1544019885509;
 Wed, 05 Dec 2018 06:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20181201152457.8252-1-tiny.windzz@gmail.com>
In-Reply-To: <20181201152457.8252-1-tiny.windzz@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Dec 2018 15:24:09 +0100
Message-ID: <CAPDyKFqLXR1Ez4952cXw2GShQ36+p_9NmraJCqufEKmYaTpVgA@mail.gmail.com>
Subject: Re: [PATCH] mmc: convert to DEFINE_SHOW_ATTRIBUTE
To:     tiny.windzz@gmail.com
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ben Dooks <ben-linux@fluff.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Andreas Kemnade <andreas@kemnade.info>, Kishon <kishon@ti.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2018 at 16:25, Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Nice cleanup, applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc_test.c   | 14 ++------------
>  drivers/mmc/host/atmel-mci.c  | 31 +++++--------------------------
>  drivers/mmc/host/omap_hsmmc.c | 14 ++------------
>  drivers/mmc/host/s3cmci.c     | 30 ++++--------------------------
>  4 files changed, 13 insertions(+), 76 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index ef18daeaa4cc..eabb1cab1765 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -3145,17 +3145,7 @@ static int mtf_testlist_show(struct seq_file *sf, void *data)
>         return 0;
>  }
>
> -static int mtf_testlist_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, mtf_testlist_show, inode->i_private);
> -}
> -
> -static const struct file_operations mmc_test_fops_testlist = {
> -       .open           = mtf_testlist_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(mtf_testlist);
>
>  static void mmc_test_free_dbgfs_file(struct mmc_card *card)
>  {
> @@ -3216,7 +3206,7 @@ static int mmc_test_register_dbgfs_file(struct mmc_card *card)
>                 goto err;
>
>         ret = __mmc_test_register_dbgfs_file(card, "testlist", S_IRUGO,
> -               &mmc_test_fops_testlist);
> +               &mtf_testlist_fops);
>         if (ret)
>                 goto err;
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index be53044086c7..7469a7e369c0 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -446,18 +446,7 @@ static int atmci_req_show(struct seq_file *s, void *v)
>         return 0;
>  }
>
> -static int atmci_req_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, atmci_req_show, inode->i_private);
> -}
> -
> -static const struct file_operations atmci_req_fops = {
> -       .owner          = THIS_MODULE,
> -       .open           = atmci_req_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(atmci_req);
>
>  static void atmci_show_status_reg(struct seq_file *s,
>                 const char *regname, u32 value)
> @@ -583,18 +572,7 @@ static int atmci_regs_show(struct seq_file *s, void *v)
>         return ret;
>  }
>
> -static int atmci_regs_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, atmci_regs_show, inode->i_private);
> -}
> -
> -static const struct file_operations atmci_regs_fops = {
> -       .owner          = THIS_MODULE,
> -       .open           = atmci_regs_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(atmci_regs);
>
>  static void atmci_init_debugfs(struct atmel_mci_slot *slot)
>  {
> @@ -608,13 +586,14 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
>                 return;
>
>         node = debugfs_create_file("regs", S_IRUSR, root, host,
> -                       &atmci_regs_fops);
> +                                  &atmci_regs_fops);
>         if (IS_ERR(node))
>                 return;
>         if (!node)
>                 goto err;
>
> -       node = debugfs_create_file("req", S_IRUSR, root, slot, &atmci_req_fops);
> +       node = debugfs_create_file("req", S_IRUSR, root, slot,
> +                                  &atmci_req_fops);
>         if (!node)
>                 goto err;
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 467d889a1638..6094e9e687b1 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1652,7 +1652,7 @@ static struct mmc_host_ops omap_hsmmc_ops = {
>
>  #ifdef CONFIG_DEBUG_FS
>
> -static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
> +static int mmc_regs_show(struct seq_file *s, void *data)
>  {
>         struct mmc_host *mmc = s->private;
>         struct omap_hsmmc_host *host = mmc_priv(mmc);
> @@ -1691,17 +1691,7 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
>         return 0;
>  }
>
> -static int omap_hsmmc_regs_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, omap_hsmmc_regs_show, inode->i_private);
> -}
> -
> -static const struct file_operations mmc_regs_fops = {
> -       .open           = omap_hsmmc_regs_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(mmc_regs);
>
>  static void omap_hsmmc_debugfs(struct mmc_host *mmc)
>  {
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index f77493604312..51069a43d609 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1406,18 +1406,7 @@ static int s3cmci_state_show(struct seq_file *seq, void *v)
>         return 0;
>  }
>
> -static int s3cmci_state_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, s3cmci_state_show, inode->i_private);
> -}
> -
> -static const struct file_operations s3cmci_fops_state = {
> -       .owner          = THIS_MODULE,
> -       .open           = s3cmci_state_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(s3cmci_state);
>
>  #define DBG_REG(_r) { .addr = S3C2410_SDI##_r, .name = #_r }
>
> @@ -1459,18 +1448,7 @@ static int s3cmci_regs_show(struct seq_file *seq, void *v)
>         return 0;
>  }
>
> -static int s3cmci_regs_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, s3cmci_regs_show, inode->i_private);
> -}
> -
> -static const struct file_operations s3cmci_fops_regs = {
> -       .owner          = THIS_MODULE,
> -       .open           = s3cmci_regs_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(s3cmci_regs);
>
>  static void s3cmci_debugfs_attach(struct s3cmci_host *host)
>  {
> @@ -1484,14 +1462,14 @@ static void s3cmci_debugfs_attach(struct s3cmci_host *host)
>
>         host->debug_state = debugfs_create_file("state", 0444,
>                                                 host->debug_root, host,
> -                                               &s3cmci_fops_state);
> +                                               &s3cmci_state_fops);
>
>         if (IS_ERR(host->debug_state))
>                 dev_err(dev, "failed to create debug state file\n");
>
>         host->debug_regs = debugfs_create_file("regs", 0444,
>                                                host->debug_root, host,
> -                                              &s3cmci_fops_regs);
> +                                              &s3cmci_regs_fops);
>
>         if (IS_ERR(host->debug_regs))
>                 dev_err(dev, "failed to create debug regs file\n");
> --
> 2.17.0
>
