Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7047DC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275FB206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275FB206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbeKTS3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:29:31 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36380 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeKTS3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:29:30 -0500
Received: by mail-ua1-f68.google.com with SMTP id j3so337446uap.3;
        Tue, 20 Nov 2018 00:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/i/NMJE34HRbvX9W/5vg6A1j8yPDWGSRqnxkRrtKchI=;
        b=FfWxYYgfa+KRTm+Vre+UNCSKuxLwJfcq6v1gUxJjV5J2MMN4TOPgCdAPFQu4qVZQJ/
         2JE/vkkvzRbREj2Z51Rvk2Nbj16Q0xDVvzRyBGkYrG+SSKxNKrGKEKFE5Ce1x+33sfQP
         GnHp6NsmVr1NcJnVE4ZQLVr7qf+xI5y2d2TFcRE2GPLI6hiHkjtprBUOZl1qojo+oXNF
         gRatoiDG3ajVCUUmgSD34broiTWt1F1HvF0dIaMRg+31Ps0hGtbT9asgmaipiCgdwHqU
         ZIOhtPEMun/ij0pKuAyimA7jsJglNpUBlttD0ZzDbcmDWZmGXHEs8CPN7/pGfI0CYth9
         qBlg==
X-Gm-Message-State: AA+aEWaA+21G4w7RX0q5McpP8nUXx/xYPvGADtLccBOYjzZHn9H8iUau
        3TC+VPpNA+1UNH+kx53JFj7t2uiPRftvS3kpPJLc/6NH
X-Google-Smtp-Source: AFSGD/VVvA6zbzCj2u+xlT/G7mkCfzQj9pJW1bBRAOhFEdxZRGbaFcyCzvHtxV20SMVIAfnGVT956/HcG5R+z76WliU=
X-Received: by 2002:ab0:465:: with SMTP id 92mr445526uav.28.1542700901707;
 Tue, 20 Nov 2018 00:01:41 -0800 (PST)
MIME-Version: 1.0
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw> <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
In-Reply-To: <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Nov 2018 09:01:29 +0100
Message-ID: <CAMuHMdVjqkHsqEjEgBWg0eGtE-9ND+a=OeHwu=r39LrfkQq=Yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
To:     masonccyang@mxic.com.tw
Cc:     Mark Brown <broonie@kernel.org>, Trent Piepho <tpiepho@impinj.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        juliensu@mxic.com.tw, Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Mon, Nov 19, 2018 at 11:01 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Add a driver for Renesas R-Car D3 RPC SPI controller driver.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,750 @@

> +static int rpc_spi_set_freq(struct rpc_spi *rpc, unsigned long freq)
> +{
> +       int ret;
> +
> +       if (rpc->cur_speed_hz == freq)
> +               return 0;
> +
> +       clk_disable_unprepare(rpc->clk_rpc);
> +       ret = clk_set_rate(rpc->clk_rpc, freq);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(rpc->clk_rpc);
> +       if (ret)
> +               return ret;

The clk_{disable_unprepare,prepare_enable}() may be needed on the Macronix
controller you based this driver on, but will be futile on Renesas SoCs.

As the RPC is part of the CPG/MSSR clock domain, its clock will be controlled
by the Runtime PM.  As you've already called pm_runtime_get_sync() from your
.probe() calback, Runtime PM will have enabled the clock.
If you disable it manually, you create an imbalance between automatic and
manual clock control.

So please don't control the clock explicitly, but always use
pm_runtime_*() calls.

> +static int __maybe_unused rpc_spi_runtime_suspend(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct spi_master *master = platform_get_drvdata(pdev);
> +       struct rpc_spi *rpc = spi_master_get_devdata(master);
> +
> +       clk_disable_unprepare(rpc->clk_rpc);

At this point, the clock is enabled due to Runtime PM, and you disable it
manually.
During system suspend, the clock will be disabled by the PM framework
again, leading to a negative enable count.
I expect you to see warning splats during system suspend.
Hence please drop the explicit clock management from this function.

I'm not familiar with the spimem framework, but for a normal SPI controller,
you want to call spi_master_resume(master) here.
See e.g. commit c1ca59c22c56930b ("spi: rspi: Fix invalid SPI use during
system suspend")

> +
> +       return 0;
> +}
> +
> +static int __maybe_unused rpc_spi_runtime_resume(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct spi_master *master = platform_get_drvdata(pdev);
> +       struct rpc_spi *rpc = spi_master_get_devdata(master);
> +       int ret;
> +
> +       ret = clk_prepare_enable(rpc->clk_rpc);
> +       if (ret)
> +               dev_err(dev, "Can't enable rpc->clk_rpc\n");

Likewise, please drop the explicit clock management here. The PM core
code will handle it through the clock domain.

+ spi_master_resume(master)

> +
> +       return ret;
> +}
> +
> +static const struct dev_pm_ops rpc_spi_dev_pm_ops = {
> +       SET_RUNTIME_PM_OPS(rpc_spi_runtime_suspend,
> +                          rpc_spi_runtime_resume, NULL)

Ah, you only use these for Runtime PM.  Not needed, as Runtime PM handles
the clock domain without any callbacks.

With spi_master_{suspend,resume}() added, you can use SIMPLE_DEV_PM_OPS(),
and make everything work during/after system suspend.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
