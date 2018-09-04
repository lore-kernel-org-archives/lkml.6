Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FA7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7232073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7232073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeIECWv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:22:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54594 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbeIECWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:22:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2B18020731; Tue,  4 Sep 2018 23:55:48 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7D0B7208BE;
        Tue,  4 Sep 2018 23:55:37 +0200 (CEST)
Date:   Tue, 4 Sep 2018 23:55:35 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Jagdish Gediya <jagdish.gediya@nxp.com>,
        Jane Wan <Jane.Wan@nokia.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mtd: rawnand: fsl_ifc: fix SRAM initialization
 for newer controller
Message-ID: <20180904235535.165be621@xps13>
In-Reply-To: <20180813071846.9433-1-kurt@linutronix.de>
References: <20180813071846.9433-1-kurt@linutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kurt,

Kurt Kanzenbach <kurt@linutronix.de> wrote on Mon, 13 Aug 2018 09:18:44
+0200:

> Hi,
> 
> this is version two of
> 
>  lkml.kernel.org/r/20180806092137.9287-1-kurt@linutronix.de
> 
> Changes since v1:
> 
>  - Addressed comments from Miquel Raynal
>    - Changed subject
>    - Coding style
>    - Using timeout constants
>    - Moving version check completely into fsl_ifc_sram_init()
> 
> Thanks,
> Kurt
> 
> Kurt Kanzenbach (2):
>   mtd: rawnand: fsl_ifc: check result of SRAM initialization
>   mtd: rawnand: fsl_ifc: fixup SRAM init for newer ctrl versions
> 
>  drivers/mtd/nand/raw/fsl_ifc_nand.c | 36 ++++++++++++++++++++++++++++++++----
>  include/linux/fsl_ifc.h             |  2 ++
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 

Series applied to nand/next.

Thanks,
Miquèl
