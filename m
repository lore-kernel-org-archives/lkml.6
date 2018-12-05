Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA88C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE39720989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwYwfESS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE39720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeLEXMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:12:43 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44690 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeLEXMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:12:43 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so19091161oig.11;
        Wed, 05 Dec 2018 15:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EkizHcBY6p+rcRAqBQZOi//Lbe0QzeeHQoMKr+sJteE=;
        b=qwYwfESSnjbgrzRSar3FJo+WqSbFWRJD8jktRTWBLtORkCNLdsYCu5h2WzCb+34Fy4
         1/YzvCo7VF6QhIrJTSMHcj4CNmK+hnjoP5rYaqU9JJFriiMqkCVUAQZBvVTBtgAXWHwB
         ufnqVO2QWYji4mP31UlJIczjOZgkO8qCRwnXNG7Cud7M2XZnp8FadFFBzHAibxUimUGG
         jGhIC9pjs2psgDJan1h58p3pFYoHPo+FnCTrrUNIt6qdSysJeYVORGc3FEoDmNf5KHG8
         DibQm2TzbiPmzcXyIqxu7QLS/kX3P3EE7nMOFhiX3B0S9okOv7qjHoxQJyxseG+4UQW7
         a4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EkizHcBY6p+rcRAqBQZOi//Lbe0QzeeHQoMKr+sJteE=;
        b=cLqTXpAqkLYi5+f9r4dQB+nmvy8lhlD6rWAXMJkDO8+xm9Wf2Ov83VzisEdGCkpHMS
         jUM2cfWp0z7uKi4k5bwrJaCwzI3Fkm/DHpEEKdd6K4diJAMjrFkSyaGwTGeiE3XOSpYD
         5h+AjcYhI+FotmnvZeBAFvfMmwUOX6SpHCsEctn3uGEuoK2JTx03u2MNV77VwTxSwGNJ
         K6K471T90JWvbAfdEqX4doYi5tw/GyPqeFoyBKyiyYfzlcGwcP34Hv+sheX7DOjOUTH7
         YLiIgNpR9000Ut5M2paUruIUamvagG5SOXYOOx31KZPIfYXFBe15Q6DXZgBKpJ6pTRO8
         23Sg==
X-Gm-Message-State: AA+aEWaRBQdhnx2cX4qvUPpUGlO3WDaxNRW7vf4Vu1v/lfFExu14IGd5
        WryNz2ALQTsn+uG/7TlkJga9oz1hmoZGteyeAmQ=
X-Google-Smtp-Source: AFSGD/XNWHNO35u7npYzx2TaJUjo9t7cFy3iAuhvfArtyDL09u7BdAkcKi7Kq89bNh5nWMUMGYSPAxKvBUVofm1y8jU=
X-Received: by 2002:aca:3092:: with SMTP id w140mr16652500oiw.237.1544051562355;
 Wed, 05 Dec 2018 15:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20180921152726.31742-1-lukma@denx.de> <20181009105028.17971-1-lukma@denx.de>
In-Reply-To: <20181009105028.17971-1-lukma@denx.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 5 Dec 2018 21:12:46 -0200
Message-ID: <CAOMZO5BN5KJ+s6F9CJXQPX=Ta0Ow0PaV_AmFHYSDNr78jLjziQ@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: Add support for Liebherr's BK4 device (vf610 based)
To:     Lukasz Majewski <lukma@denx.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz/Rob,

On Tue, Oct 9, 2018 at 7:50 AM Lukasz Majewski <lukma@denx.de> wrote:

> +&dspi3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_dspi3>;
> +       bus-num = <3>;
> +       status = "okay";
> +       spi-slave;
> +
> +       slave@0 {
> +               compatible = "lwn,bk4";
> +               spi-max-frequency = <30000000>;
> +               reg = <0>;
> +       };
> +};

This is causing the following dtc warning in linux-next:

  DTC     arch/arm/boot/dts/vf610-bk4.dtb
arch/arm/boot/dts/vfxxx.dtsi:550.24-563.6: Warning (spi_bus_bridge):
/soc/aips-bus@40080000/spi@400ad000: incorrect #address-cells for SPI
bus
  also defined at arch/arm/boot/dts/vf610-bk4.dts:106.8-118.3
arch/arm/boot/dts/vf610-bk4.dtb: Warning (spi_bus_reg): Failed
prerequisite 'spi_bus_bridge'

If spi-slave property is removed the warning is gone.

Looking at drivers/spi/spi-fsl-dspi.c I don't see the "spi-slave"
property being handled there.

Any ideas on how to fix this?

Thanks
