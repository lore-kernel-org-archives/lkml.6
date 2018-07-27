Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BA0C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B3920842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0cUPzN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B3920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389492AbeG0VbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:31:08 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:37071 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389206AbeG0VbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:31:07 -0400
Received: by mail-ua0-f195.google.com with SMTP id y10-v6so4116975uao.4;
        Fri, 27 Jul 2018 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0MgcRcAP3mUa8gnoINN0nmzHrwVW9XBnl67fLELCXeY=;
        b=Q0cUPzN3pb4fcumqalFbZ2Db0u47MyRWffmyaZ2oHwuQXj/xkje6aRPeuzE4a8EpVN
         iNoVMSPR4ySHFtwxe1+Vg3pPn+iDLY+bHLZj7ZY+4oy2qkLReaUwVHwd6F2ghnrQFCxj
         SrSGZi5qzTgLGd3A//X4TwA+vr0naD8ov3ZtHBHf+750OY7HbOggopTuFoplc/PQ2pFY
         48j53bCj6UiQEoDFRJKzJcKgQIjf9qS84QmlDEIE5NrO7xgnArDRabQGcbSoUGFfH+nq
         O0/5f4RvgC1sTv4br3fJcQVraADmoNRMcfzFOzw00lcaOjZUU4qgUN3+3RVp94YDGulB
         FdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0MgcRcAP3mUa8gnoINN0nmzHrwVW9XBnl67fLELCXeY=;
        b=KdYyQhKUcHr1G+GBP+TUyrQNlv0DGjQdspRDaG+fd2vPZjFzIdPA7nOJTx9tveG2ff
         8lA71h+e5HmUsk64wb0Rs4QhyuDmTQ9bI1mlBs3W0PvX37M4l4Deyeof3j+wdZoZB/20
         8mNrBA0sbbL8kKahFSLbC0GtBd/JfrXk29AWJAY0ySQCcqsOfD/ql+3181yEo9ZwxKyS
         IYh7pEU1/yCY+eNc31vAkKJamgCqHltbb73hMdzYz8Jtzb8IzM4vV/ZXj8y5TZTRvsH+
         PQcHR+RpN/piv9ZX1AzJo4lONvF0+YqzkFzt2aDHFLFfpTntnUxXbWeM6glhRhsPbXeq
         A17w==
X-Gm-Message-State: AOUpUlEX7vvXcDy7JFmQl86xjV2hhrBf0sk0ezashiQopOUMoDO0UgSK
        ADR8hvAoyaZ6LNrl621F/r11rp9X3hVI/JLmc8o=
X-Google-Smtp-Source: AAOMgpcCGDjjbhUyzxqlSmcWi7zNmfIar339PBUkgDqYv8bOH69/k+cU49uLf8b5LdLgU5Qhj/JgO/CfBNGTOJ60GFw=
X-Received: by 2002:a9f:2187:: with SMTP id 7-v6mr5867249uac.49.1532722060371;
 Fri, 27 Jul 2018 13:07:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 13:07:38
 -0700 (PDT)
In-Reply-To: <20180727195358.23336-2-alexandre.belloni@bootlin.com>
References: <20180727195358.23336-1-alexandre.belloni@bootlin.com> <20180727195358.23336-2-alexandre.belloni@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Jul 2018 23:07:38 +0300
Message-ID: <CAHp75VeC+3A02eErFmfWix87Zx8Wd6dbAQsmQhoT0VF30do7=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] spi: dw: export dw_spi_set_cs
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:53 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Export dw_spi_set_cs so it can be used from the various IP integration
> modules.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/spi/spi-dw.c | 3 ++-
>  drivers/spi/spi-dw.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index f76e31faf694..ac2eb89ef7a5 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -133,7 +133,7 @@ static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
>  }
>  #endif /* CONFIG_DEBUG_FS */
>
> -static void dw_spi_set_cs(struct spi_device *spi, bool enable)
> +void dw_spi_set_cs(struct spi_device *spi, bool enable)
>  {
>         struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
>         struct chip_data *chip = spi_get_ctldata(spi);
> @@ -145,6 +145,7 @@ static void dw_spi_set_cs(struct spi_device *spi, bool enable)
>         if (!enable)
>                 dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
>  }
> +EXPORT_SYMBOL_GPL(dw_spi_set_cs);
>
>  /* Return the max entries we can fill into tx fifo */
>  static inline u32 tx_max(struct dw_spi *dws)
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 446013022849..0168b08364d5 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -245,6 +245,7 @@ struct dw_spi_chip {
>         void (*cs_control)(u32 command);
>  };
>
> +extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
>  extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
>  extern void dw_spi_remove_host(struct dw_spi *dws);
>  extern int dw_spi_suspend_host(struct dw_spi *dws);
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
