Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1F6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2017E25116
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2017E25116
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeGBM2z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:28:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57672 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751761AbeGBM2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:28:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 35A41207D4; Mon,  2 Jul 2018 14:28:50 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id D204B20703;
        Mon,  2 Jul 2018 14:28:39 +0200 (CEST)
Date:   Mon, 2 Jul 2018 14:28:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 0/5] mtd: rawnand: denali: add new clocks and improve
 setup_data_interface
Message-ID: <20180702142840.42801396@xps13>
In-Reply-To: <1529683598-25783-1-git-send-email-yamada.masahiro@socionext.com>
References: <1529683598-25783-1-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Sat, 23 Jun
2018 01:06:33 +0900:

> The ->setup_data_interface() hook needs to know the clock frequency.
> In fact, this IP needs three clocks, but the current driver does not
> represent it.  Thus, it is hard to understand what is the correct
> clock frequency.
> (at least, clock property is not described in the DT-binding at all.)
> 
> This series adds more clocks based on the IP datasheet, and document
> it in the DT binding.
> In the new binding, three clocks are required: core clock, bus interface
> clock, ECC engine clock.
> 
> 1/5 is a backport candidate to fix SOCFPGA.
> 
> 
> Masahiro Yamada (5):
>   mtd: rawnand: denali_dt: set clk_x_rate to 200 MHz unconditionally
>   mtd: rawnand: denali_dt: use dev as a shorthand of &pdev->dev
>   dt-binding: mtd: denali_dt: document clock property
>   mtd: rawnand: denali_dt: add more clocks based on IP datasheet
>   mtd: rawnand: denali: optimize timing parameters for data interface

Applied patches 2-5/5 to nand/next on top of v4-18.rc3 (to have the fix
1/5).

Thanks,
Miquèl
