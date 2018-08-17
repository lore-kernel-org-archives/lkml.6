Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C06C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A064C208D6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A064C208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeHQLtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:49:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45802 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbeHQLtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:49:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 10229207EB; Fri, 17 Aug 2018 10:47:08 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9916020618;
        Fri, 17 Aug 2018 10:46:57 +0200 (CEST)
Date:   Fri, 17 Aug 2018 10:46:57 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     <linux-mtd@lists.infradead.org>, Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [RFC PATCH v2 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
Message-ID: <20180817104657.7a1da2c4@bbrezillon>
In-Reply-To: <20180719094612.5833-3-yixun.lan@amlogic.com>
References: <20180719094612.5833-1-yixun.lan@amlogic.com>
        <20180719094612.5833-3-yixun.lan@amlogic.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yixun,

I know I said I would finish reviewing the driver, but I didn't have
time to do it, so feel free to send a new version addressing the
comments I already made.

On Thu, 19 Jul 2018 17:46:12 +0800
Yixun Lan <yixun.lan@amlogic.com> wrote:


> +static void meson_nfc_select_chip(struct mtd_info *mtd, int chip)
> +{
> +	struct nand_chip *nand = mtd_to_nand(mtd);
> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> +
> +	if (chip < 0 || chip > MAX_CE_NUM)

			^ chip > meson_chip->nsels)

> +		return;
> +
> +	nfc->param.chip_select = meson_chip->sels[chip] ? NAND_CE1 : NAND_CE0;
> +	nfc->param.rb_select = nfc->param.chip_select;
> +}
> +

Regards,

Boris
