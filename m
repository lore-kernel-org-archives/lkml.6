Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE10ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DE02145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DE02145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeJSEhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:37:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46366 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725738AbeJSEhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:37:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D0ACD207C4; Thu, 18 Oct 2018 22:34:27 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 58C202072C;
        Thu, 18 Oct 2018 22:34:27 +0200 (CEST)
Date:   Thu, 18 Oct 2018 22:34:26 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     <linux-mtd@lists.infradead.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
Message-ID: <20181018223426.5bfa23a1@bbrezillon>
In-Reply-To: <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
References: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
        <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 13:09:05 +0800
Jianxin Pan <jianxin.pan@amlogic.com> wrote:

> +static int meson_nand_bch_mode(struct nand_chip *nand)
> +{
> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
> +	struct meson_nand_ecc meson_ecc[] = {
> +		MESON_ECC_DATA(NFC_ECC_BCH8_1K, 8),
> +		MESON_ECC_DATA(NFC_ECC_BCH24_1K, 24),
> +		MESON_ECC_DATA(NFC_ECC_BCH30_1K, 30),
> +		MESON_ECC_DATA(NFC_ECC_BCH40_1K, 40),
> +		MESON_ECC_DATA(NFC_ECC_BCH50_1K, 50),
> +		MESON_ECC_DATA(NFC_ECC_BCH60_1K, 60),
> +	};
> +	int i, ret = 0;
> +
> +	if (nand->ecc.strength > 60 || nand->ecc.strength < 8)
> +		return -EINVAL;
> +
> +	for (i = 0; i < sizeof(meson_ecc); i++) {
> +		if (meson_ecc[i].strength == nand->ecc.strength) {
> +			meson_chip->bch_mode = meson_ecc[i].bch;
> +			break;

			return 0;

> +		}
> +	}
> +
> +	return ret;

	return -EINVAL;

> +}
