Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5953CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DE42075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DE42075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeGRIWb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:22:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39246 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeGRIWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:22:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ED23920766; Wed, 18 Jul 2018 09:45:54 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7D4F520741;
        Wed, 18 Jul 2018 09:45:44 +0200 (CEST)
Date:   Wed, 18 Jul 2018 09:45:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        boris.brezillon@bootlin.com, dev@lynxeye.de, mirza.krak@gmail.com,
        benjamin.lindqvist@endian.se, krzk@kernel.org,
        marek.vasut@gmail.com, richard@nod.at, digetx@gmail.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        dan.carpenter@oracle.com,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2] mtd: rawnand: tegra: check bounds of die_nr properly
Message-ID: <20180718094544.76607c0f@xps13>
In-Reply-To: <20180717084618.25249-1-marcel@ziswiler.com>
References: <20180717084618.25249-1-marcel@ziswiler.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Marcel Ziswiler <marcel@ziswiler.com> wrote on Tue, 17 Jul 2018
10:46:18 +0200:

> From: Stefan Agner <stefan@agner.ch>
> 
> The Tegra driver currently only support a single chip select, hence
> check boundaries accordingly. This fixes a off by one issue catched
> with Smatch:
>     drivers/mtd/nand/raw/tegra_nand.c:476 tegra_nand_select_chip()
>     warn: array off by one? 'nand->cs[die_nr]'
> 
> Also warn in case the stack asks for a chip select we currently do
> not support.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied on nand/next in place of the previous one (with my SoB after
yours).

Thanks,
Miquèl
