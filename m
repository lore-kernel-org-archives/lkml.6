Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DC4C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB2A2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB2A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeGSG4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:56:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50506 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbeGSG4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:56:38 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 652A920766; Thu, 19 Jul 2018 08:15:09 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id EE7EB2069C;
        Thu, 19 Jul 2018 08:15:08 +0200 (CEST)
Date:   Thu, 19 Jul 2018 08:15:08 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [RFC PATCH 0/8] mtd: rawnand: ams-delta: Use gpio-omap
 accessors for data I/O
Message-ID: <20180719081508.5dafebde@bbrezillon>
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On Thu, 19 Jul 2018 01:57:02 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Implement the idea suggested by Artem Bityutskiy and Tony Lindgren
> described in commit b027274d2e3a ("mtd: ams-delta: fix
> request_mem_region() failure").

Thanks for doing that. I'll review the patches, but I already have a
extra request: can you convert this driver to ->exec_op()? It does not
necessarily have to be done in this patchset, but, that'd be great to
have one more driver converted to the new interface.

BTW, there seems to be a nand_gpio driver, maybe we should merge
ams-delta code into nand_gpio after it's been patched to use the GPIO
consumer API.

> 
>  arch/arm/mach-omap1/board-ams-delta.c |   22 -
>  drivers/gpio/gpio-omap.c              |   88 ++++++
>  drivers/mtd/nand/raw/ams-delta.c      |  436 +++++++++++++++++++++-------------
>  3 files changed, 376 insertions(+), 170 deletions(-)
> 

