Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0B4C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92269208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92269208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbeGHVvg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:51:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38205 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932545AbeGHVvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:51:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7893C207DA; Sun,  8 Jul 2018 23:51:32 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 903B1203B4;
        Sun,  8 Jul 2018 23:51:31 +0200 (CEST)
Date:   Sun, 8 Jul 2018 23:51:31 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        dan.carpenter@oracle.com, dev@lynxeye.de, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, mirza.krak@gmail.com,
        gaireg@gaireg.de, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: tegra: check bounds of die_nr properly
Message-ID: <20180708235131.348f95f9@xps13>
In-Reply-To: <20180704091310.22003-1-stefan@agner.ch>
References: <20180704091310.22003-1-stefan@agner.ch>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Stefan Agner <stefan@agner.ch> wrote on Wed,  4 Jul 2018 11:13:10 +0200:

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
> ---

Applied to nand/next.

Thanks,
Miquèl
