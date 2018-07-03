Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46416C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADD9224FD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADD9224FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933041AbeGCHVO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:21:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56885 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932782AbeGCHVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:21:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 55CE6207BD; Tue,  3 Jul 2018 09:21:07 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id E43DD203D9;
        Tue,  3 Jul 2018 09:21:06 +0200 (CEST)
Date:   Tue, 3 Jul 2018 09:21:07 +0200
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
Subject: Re: [PATCH 2/3] clk: meson: add sub EMMC clock dt-bindings IDs
Message-ID: <20180703092107.51497a8f@bbrezillon>
In-Reply-To: <20180703145716.31860-3-yixun.lan@amlogic.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
        <20180703145716.31860-3-yixun.lan@amlogic.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 14:57:15 +0000
Yixun Lan <yixun.lan@amlogic.com> wrote:

> Add two clock bindings IDs which provided by the EMMC clock controller,
> These two clocks will be used by EMMC or NAND driver.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  include/dt-bindings/clock/emmc-clkc.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 include/dt-bindings/clock/emmc-clkc.h
> 
> diff --git a/include/dt-bindings/clock/emmc-clkc.h b/include/dt-bindings/clock/emmc-clkc.h
> new file mode 100644
> index 000000000000..d9972c400e58
> --- /dev/null
> +++ b/include/dt-bindings/clock/emmc-clkc.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Meson EMMC sub clock tree IDs
> + *
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef __EMMC_CLKC_H
> +#define __EMMC_CLKC_H
> +
> +#define CLKID_EMMC_C_MUX				0

Looks like the MUX clk is the parent of the DIV one, and I guess the clk
driver is able to select the best parent+div pair for a requested rate.
Do you really need to expose the MUX to users?

> +#define CLKID_EMMC_C_DIV				1
> +
> +#endif

