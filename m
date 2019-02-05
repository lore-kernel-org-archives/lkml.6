Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADC4C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F69620818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfBEM7u convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:59:50 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:34165 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBEM7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:59:50 -0500
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 18BC7240002;
        Tue,  5 Feb 2019 12:59:46 +0000 (UTC)
Date:   Tue, 5 Feb 2019 13:59:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     han.xu@nxp.com, bbrezillon@kernel.org, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Subject: Re: [PATCH] mtd: rawnand: gpmi: fix MX28 bus master lockup problem
Message-ID: <20190205135946.64eda55c@xps13>
In-Reply-To: <20190129153700.18717-1-martink@posteo.de>
References: <20190129153700.18717-1-martink@posteo.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin Kepplinger <martink@posteo.de> wrote on Tue, 29 Jan 2019
16:37:00 +0100:

> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> Disable BCH soft reset according to MX23 erratum #2847 ("BCH soft
> reset may cause bus master lock up") for MX28 too. It has the same
> problem.
> 
> Observed problem: once per 100,000+ MX28 reboots NAND read failed on
> DMA timeout errors:
> [    1.770823] UBI: attaching mtd3 to ubi0
> [    2.768088] gpmi_nand: DMA timeout, last DMA :1
> [    3.958087] gpmi_nand: BCH timeout, last DMA :1
> [    4.156033] gpmi_nand: Error in ECC-based read: -110
> [    4.161136] UBI warning: ubi_io_read: error -110 while reading 64
> bytes from PEB 0:0, read only 0 bytes, retry
> [    4.171283] step 1 error
> [    4.173846] gpmi_nand: Chip: 0, Error -1
> 
> Without BCH soft reset we successfully executed 1,000,000 MX28 reboots.
> 
> I have a quote from NXP regarding this problem, from July 18th 2016:
> 
> "As the i.MX23 and i.MX28 are of the same generation, they share many
> characteristics. Unfortunately, also the erratas may be shared.
> In case of the documented erratas and the workarounds, you can also
> apply the workaround solution of one device on the other one. This have
> been reported, but I’m afraid that there are not an estimated date for
> updating the Errata documents.
> Please accept our apologies for any inconveniences this may cause."
> 
> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
> 
> This is something we have in our tree for years and is running on
> production systems and I hope that this helps others too.
> 
> thanks
>                               martin

Thanks for sharing this.

On my side the patch looks ok, maybe an Acked-by from Han would be
great?

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Boris, do you want to take this? If you don't have more fixes to send I
can queue it to nand/next.

Thanks,
Miquèl
