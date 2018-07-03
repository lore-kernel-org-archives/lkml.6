Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D24C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AD724DF1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AD724DF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932381AbeGCHRR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:17:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56694 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753788AbeGCHRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:17:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9945D207BD; Tue,  3 Jul 2018 09:17:11 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 346F2203D9;
        Tue,  3 Jul 2018 09:17:11 +0200 (CEST)
Date:   Tue, 3 Jul 2018 09:17:11 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <linux-clk@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] clk: meson: add a sub EMMC clock controller support
Message-ID: <20180703091711.1d52c278@bbrezillon>
In-Reply-To: <20180703145716.31860-1-yixun.lan@amlogic.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 14:57:13 +0000
Yixun Lan <yixun.lan@amlogic.com> wrote:

> This driver will add a EMMC clock controller driver support.
> The original idea about adding a clock controller is during the
> discussion in the NAND driver mainline effort[1].
> 
> I've tested this in the S400 board (AXG platform) by using NAND driver.
> 
> [1] https://lkml.kernel.org/r/20180628090034.0637a062@xps13

This is much better :-).

> 
> Yixun Lan (3):
>   clk: meson: add DT documentation for emmc clock controller
>   clk: meson: add sub EMMC clock dt-bindings IDs
>   clk: meson: add sub EMMC clock controller driver
> 
>  .../bindings/clock/amlogic,emmc-clkc.txt      |  45 ++++++
>  drivers/clk/meson/Kconfig                     |   9 ++
>  drivers/clk/meson/Makefile                    |   1 +
>  drivers/clk/meson/emmc-clkc.c                 | 136 ++++++++++++++++++
>  include/dt-bindings/clock/emmc-clkc.h         |  14 ++
>  5 files changed, 205 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,emmc-clkc.txt
>  create mode 100644 drivers/clk/meson/emmc-clkc.c
>  create mode 100644 include/dt-bindings/clock/emmc-clkc.h
> 

