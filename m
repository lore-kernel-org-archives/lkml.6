Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD51C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EBB2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EBB2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeLEJG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:06:27 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46205 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEJG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:06:27 -0500
Received: by mail-ua1-f67.google.com with SMTP id v24so6822015uap.13;
        Wed, 05 Dec 2018 01:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mCUOjCGOyLp+NHbGq7VeDSbZZ34FLc+sxZbSgDhZxp8=;
        b=kHd6iTe1CZ3jvkHDRRMa/F0/wdxATsC73OLAkOzUJ3iculGa38N3VMblB21JBZqwvH
         SCD2OwSWOs+F+/cZEdCQ9p0Cy+kJtnaf10JSD7/iI+2YJ9mLJh7uP3S5Cx2YpPT/p4U8
         PUEuc50tRVKltS3kO4ty0jwQB3ihVxVEdFfSv/7OIHzFWrMYob41xxpO7X8Qhint6w/o
         B9CGkDtBPuabEvbE00AnxwHmY4eyDE13MAxZbuV3A5v+0qQyM8HWL0viA1tzfShnfbup
         AjNWXeWVz6IQzZjlC0X4X/pB34rR4hIT0swyIi68qkFihLTWF8btEUyt96WjmHsWXhKi
         w3Kg==
X-Gm-Message-State: AA+aEWZuB31FAMeHIqrIZYzmZ1reuhgFR7WO2ipRD332Clg6/in65N0l
        HgQc8/F7L2TO7VwKeqDk57A3oLwZSwhcAsQmMxM=
X-Google-Smtp-Source: AFSGD/Uhgq5SHQA89QuOQHEHYA1oAXFDz4dyaM+fZ6+N9Es6PFKeqMeYKYkXq6LQRSUa93AkTWuxCPFL1kihDQzXPd8=
X-Received: by 2002:ab0:465:: with SMTP id 92mr10681582uav.28.1544000784679;
 Wed, 05 Dec 2018 01:06:24 -0800 (PST)
MIME-Version: 1.0
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw> <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
In-Reply-To: <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Dec 2018 10:06:12 +0100
Message-ID: <CAMuHMdWEiOTSSM=rKu67r-kgJ=TyAi7p7ndhAS4d5-6gccmmoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller driver
To:     masonccyang@mxic.com.tw
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Mon, Dec 3, 2018 at 10:19 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Add a driver for Renesas R-Car Gen3 RPC SPI controller.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

Thanks for your patch!

> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -528,6 +528,12 @@ config SPI_RSPI
>         help
>           SPI driver for Renesas RSPI and QSPI blocks.
>
> +config SPI_RENESAS_RPC
> +       tristate "Renesas R-Car Gen3 RPC SPI controller"
> +       depends on SUPERH || ARCH_RENESAS || COMPILE_TEST

So this driver is intended for SuperH SoCs, too?
If not, please drop the dependency.

> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c

> +#ifdef CONFIG_RESET_CONTROLLER
> +static int rpc_spi_do_reset(struct rpc_spi *rpc)

What's the purpose of the reset routine?
Given the #ifdef, is it optional or required?

> +{
> +       int i, ret;
> +
> +       ret = reset_control_reset(rpc->rstc);
> +       if (ret)
> +               return ret;
> +
> +       for (i = 0; i < LOOP_TIMEOUT; i++) {
> +               ret = reset_control_status(rpc->rstc);
> +               if (ret == 0)
> +                       return 0;
> +               usleep_range(0, 1);
> +       }

Why do you need this loop?
The delay in cpg_mssr_reset() should be sufficient.

> +
> +       return -ETIMEDOUT;
> +}
> +#else
> +static int rpc_spi_do_reset(struct rpc_spi *rpc)
> +{
> +       return -ETIMEDOUT;
> +}
> +#endif

> +static int rpc_spi_transfer_one_message(struct spi_master *master,
> +                                       struct spi_message *msg)
> +{
> +       struct rpc_spi *rpc = spi_master_get_devdata(master);
> +       struct spi_transfer *t;
> +       int ret;
> +
> +       rpc_spi_transfer_setup(rpc, msg);
> +
> +       list_for_each_entry(t, &msg->transfers, transfer_list) {
> +               if (!list_is_last(&t->transfer_list, &msg->transfers))
> +                       continue;
> +               ret = rpc_spi_xfer_message(rpc, t);

rpc_spi_xfer_message() sounds like a bad name to me, given it operates
on a transfer, not on a message.

> +               if (ret)
> +                       goto out;
> +       }
> +
> +       msg->status = 0;
> +       msg->actual_length = rpc->totalxferlen;
> +out:
> +       spi_finalize_current_message(master);
> +       return 0;
> +}


> +static int rpc_spi_probe(struct platform_device *pdev)
> +{

> +       rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +       if (IS_ERR(rpc->rstc))
> +               return PTR_ERR(rpc->rstc);

This will return an error if CONFIG_RESET_CONTROLLER is not set, hence
the #ifdef above is moot.

> +
> +       pm_runtime_enable(&pdev->dev);
> +       master->auto_runtime_pm = true;
> +
> +       master->num_chipselect = 1;
> +       master->mem_ops = &rpc_spi_mem_ops;
> +       master->transfer_one_message = rpc_spi_transfer_one_message;

Is there any reason you cannot use the standard
spi_transfer_one_message, i.e. provide spi_controller.transfer_one()
instead of spi_controller.transfer_one_message()?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
