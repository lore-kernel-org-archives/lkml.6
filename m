Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2FAE2C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E294B208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E294B208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigma-star.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752930AbeFNHZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:25:23 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:54602 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbeFNHZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:25:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 2759418186341;
        Thu, 14 Jun 2018 09:25:21 +0200 (CEST)
From:   Richard Weinberger <richard@sigma-star.at>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Philipp Rosenberger <p.rosenberger@linutronix.de>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 0/3] mtd: rawnand: denali: add new clocks and improve setup_data_interface
Date:   Thu, 14 Jun 2018 09:25:19 +0200
Message-ID: <6557713.S7AzxIg9TS@blindfold>
In-Reply-To: <1528953067-24324-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528953067-24324-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro,

Am Donnerstag, 14. Juni 2018, 07:11:04 CEST schrieb Masahiro Yamada:
> 
> The ->setup_data_interface() hook needs to know the clock frequency.
> In fact, this IP needs three clocks, bus "which clock?" is really
> confusing.  (It is not described in the DT-binding at all.)
> 
> This series adds more clocks.  In the new binding, three clocks
> are required: core clock, bus interface clock, ECC engine clock.
> 
> This series also takes care of the backward compatibility by
> providing hardcoded values in case the new clocks are missing.
> So, existing DT should work.
> 
> 
> Changes in v2:
>   - Split patches into sensible chunks
> 
> Masahiro Yamada (3):
>   mtd: rawnand: denali_dt: use dev as a shorthand of &pdev->dev
>   mtd: rawnand: denali_dt: add more clocks based on IP datasheet
>   mtd: rawnand: denali: optimize timing parameters for data interface

This still means that we need to feed at least 2/3 and 3/3 into -stable to
unbreak the driver.
I'd really prefer a single self-hosting fix that can go into -stable and then
patches on top of the fix can prettify the driver.

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y
