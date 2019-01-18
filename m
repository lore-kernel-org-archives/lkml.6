Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7809AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504B020883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfARIZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:25:40 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33654 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfARIZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:25:40 -0500
Received: by mail-vs1-f65.google.com with SMTP id p74so7957192vsc.0;
        Fri, 18 Jan 2019 00:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xfqq3e6qu7bc6iU64I4bUHm0HZdRoiEGbOYPlLEwVsg=;
        b=GFgZOpGVdKlJjVWyb7WtzyRIBNpd5uZAIzvn8y2UDNM1HXxhaPQk3x98qu1sscXl6A
         Pu9RuHNFP8SNHJohFVwzILkaF24r1nzwLiTKaDmGH7Ot3B8x+noM6+i/Z5/5ff8GcEzp
         AjU+MJ4C+plYVkALg5Rkb6G1OKaU7ziP+dSSN1cOA8zE9x/V5Bj0SmgO9yMMfKLhRtPR
         eVlTzkDYef7xqKT6HFbqyi6ubFl2QH9S4oKTaj7FhWSY3+mIHSaWTCEfyRHZkcau8yaO
         DYc8fVRPP2ys7LXTGtXhKpATQE9tYAc7ELe6qAIx68nXJ1G2wA81dMdntY7M2wN9zN0d
         f67Q==
X-Gm-Message-State: AJcUukfmuCYSOVvrLAgt3ctDClTbxfXn1CqbS2bD8lAsGo2T4DcRpSne
        Qq0un/QCgvTSN09QbR/kVW16mFkPDSgfe2vgbi5VRg==
X-Google-Smtp-Source: ALg8bN7NOnvzKkyEhXPIKZacaStEuYFL3a4jTVbLTy+lCj7+RZf/79OWah6cYYtBZlQCuno3HcvXyH5LqatrndGyabk=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr7493738vsm.152.1547799938802;
 Fri, 18 Jan 2019 00:25:38 -0800 (PST)
MIME-Version: 1.0
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw> <1547790855-22120-2-git-send-email-masonccyang@mxic.com.tw>
In-Reply-To: <1547790855-22120-2-git-send-email-masonccyang@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Jan 2019 09:25:26 +0100
Message-ID: <CAMuHMdW21JEz+pZbU5bb2Jcn8xpopsZ5LbbYhh2iGZFqtWCeQg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Fri, Jan 18, 2019 at 6:55 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks for the update!


> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,800 @@

> +static int rpc_spi_xfer_message(struct rpc_spi *rpc,
> +                               struct spi_transfer *t)

As "t" is not an arbitrary transfer, but the last transfer containing the
actual data, I'd call it "last", or "data_xfer".

> +{
> +       int ret;
> +
> +       ret = rpc_spi_set_freq(rpc, t->speed_hz);
> +       if (ret)
> +               return ret;
> +
> +       ret = rpc_spi_io_xfer(rpc,
> +                             rpc->xfer_dir == SPI_MEM_DATA_OUT ?
> +                             t->tx_buf : NULL,
> +                             rpc->xfer_dir == SPI_MEM_DATA_IN ?
> +                             t->rx_buf : NULL);
> +
> +       return ret;
> +}
> +
> +static int rpc_spi_transfer_one_message(struct spi_controller *ctlr,
> +                                       struct spi_message *msg)
> +{
> +       struct rpc_spi *rpc = spi_controller_get_devdata(ctlr);
> +       struct spi_transfer *t;

Likewise.

> +       int ret;
> +
> +       rpc_spi_transfer_setup(rpc, msg);
> +
> +       t = list_last_entry(&msg->transfers, struct spi_transfer,
> +                           transfer_list);
> +
> +       ret = rpc_spi_xfer_message(rpc, t);

As this function is small, perhaps just inline it here?
IMHO that makes the flow clearer.

> +       if (ret)
> +               goto out;
> +
> +       msg->status = 0;
> +       msg->actual_length = rpc->totalxferlen;
> +out:
> +       spi_finalize_current_message(ctlr);
> +       return 0;
> +}

The rest looks good to me, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
