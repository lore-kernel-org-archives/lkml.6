Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D2C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B059320821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544480310;
	bh=3mauFr4t4ujcCEY2Kq5nfGUi7cD3ZKlkfdF3tz4bBRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j6hYf3763AisqJ4Qqxvj6omyRpER4m03fYuh+RFXWq0bIQL+zgF0NCQJMamz9lbz4
	 yymNgsm8T2VXG2j95ep8yOpLX7xMyQmtV/ao0irBysfxKxs5ayFPkRUFkrz/nzXcCe
	 yLa9ld4vWVbXUjo3Q3kpMMtUXHeT+CiZ/CU7HdsY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B059320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbeLJWS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:18:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35717 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeLJWS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:18:29 -0500
Received: by mail-oi1-f193.google.com with SMTP id v6so10410822oif.2;
        Mon, 10 Dec 2018 14:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZVmaNxU28RZRbtYzOac5EiHZYnbg7QMeLMNiI/ZFWhU=;
        b=k7+tcOe7DYcHqCn/X06JISw+AIc12b7LYOt1gtATK2Cr968TXkGhyRC3kuBpNS0GUK
         cgdPjk3qhdxFI3daWh9L/8s4AAMlmRJgppVeg5Hn9yXyTxn4qF5hXkN2FCoBHiJGvR+Y
         FHrZO8zdEOPttwnMdaLV7XAQ0+OY7BjBT0ns5mKGVAWBTgBAN2l3SffFnXQyNe10VpyQ
         ZI60TmqTfJ5YWZqBtPNLx0jDagFVfwlYgqdf/RmUKrUdZ0/DwBJ5MYnGOLK7PX8uepyq
         x75qLgMSsTpBRhg0YWxJx7nHrxQzmKnL+WIDFE03ZVCaONKAxm68UWYwh/7xT1SDU6MN
         LLrQ==
X-Gm-Message-State: AA+aEWYEnP+ISooSpgvc0UGivnNB9N+LH4HYNbRgDMAEYuj7PYpxIsjh
        U1b+u17y0vNeJS1VKLA1wg==
X-Google-Smtp-Source: AFSGD/UlgDCJ1x2oIz2waE1mkWw0r1GD/2yoS1FQ2EhKNF3Naxg8stJ+LTjZKvREb+zqWxDIx/Tv7Q==
X-Received: by 2002:aca:3a55:: with SMTP id h82mr8911536oia.86.1544480307362;
        Mon, 10 Dec 2018 14:18:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r17sm5887977otn.0.2018.12.10.14.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 14:18:26 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:18:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH v5 2/6] arm64: add basic DTS for i.MX8MQ
Message-ID: <20181210221826.GA21311@bogus>
References: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
 <1544365552-30270-3-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544365552-30270-3-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2018 14:26:07 +0000, Abel Vesa wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the basic DTS for the i.MX8MQ.
> For now only the following peripherals are supported:
> - IOMUXC (pin controller)
> - CCM (clock controller)
> - GPIO
> - UART
> - uSDHC (SD/eMMC controller)
> - FEC (ethernet controller)
> - i2c
> 
> This is enough to get a very basic board support up and running.
> 
> One known limitation is that the driver for the GPC interrupt
> controller is still missing, rendering the CPU sleep states unusable
> as there is nothing waking them up anymore.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Dong Aisheng <Aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt  |   4 +
>  arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h | 623 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi      | 392 ++++++++++++++++
>  3 files changed, 1019 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq.dtsi
> 

Reviewed-by: Rob Herring <robh@kernel.org>
