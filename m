Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D437C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD68214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD68214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbeKVBbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:31:37 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51659 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbeKVBbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:31:37 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3D19F207A8; Wed, 21 Nov 2018 15:56:50 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id E14EB20510;
        Wed, 21 Nov 2018 15:56:39 +0100 (CET)
Date:   Wed, 21 Nov 2018 15:56:39 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Subject: [PATCH v4 0/4] mtd: rawnand: ams-delta: Use GPIO API
 for data I/O
Message-ID: <20181121155639.77873f7f@bbrezillon>
In-Reply-To: <20181121110806.32076-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
        <20181121110806.32076-1-jmkrzyszt@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 12:08:02 +0100
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Finalize implementation of the idea suggested by Artem Bityutskiy and
> Tony Lindgren, described in commit b027274d2e3a ("mtd: ams-delta: fix
> request_mem_region() failure"). Use pure GPIO consumer API, as reqested
> by Boris Brezillon.
> 
> Janusz Krzysztofik (4):
>       ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
>       mtd: rawnand: ams-delta: Request data port GPIO resource
>       mtd: rawnand: ams-delta: Use GPIO API for data I/O
>       ARM: OMAP1: ams-delta: Drop obsolete NAND resources
> 
>  arch/arm/mach-omap1/board-ams-delta.c |   22 ++----
>  drivers/mtd/nand/raw/ams-delta.c      |  120 +++++++++++++++++++---------------
>  2 files changed, 80 insertions(+), 62 deletions(-)
> 
> Performance on Amstrad Delta is now acceptable after recent extensions
> to GPIO API and rawnanad enhancements.
> 
> Series intented to be merged via mtd tree, should not conflict with
> other OMAP1 patches submitted for 4.21.

We'll prepare an immutable tag, just in case.
