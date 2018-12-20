Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF2FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA1821852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbeLTNoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:44:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34329 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731126AbeLTNn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:43:59 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 680062072F; Thu, 20 Dec 2018 14:43:57 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        by mail.bootlin.com (Postfix) with ESMTPSA id 149A720717;
        Thu, 20 Dec 2018 14:43:57 +0100 (CET)
Date:   Thu, 20 Dec 2018 14:43:57 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND
 flash controller driver
Message-ID: <20181220144357.630df47c@bbrezillon>
In-Reply-To: <1544781488-18723-3-git-send-email-christophe.kerello@st.com>
References: <1544781488-18723-1-git-send-email-christophe.kerello@st.com>
        <1544781488-18723-3-git-send-email-christophe.kerello@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 10:58:07 +0100
Christophe Kerello <christophe.kerello@st.com> wrote:

> The driver adds the support for the STMicroelectronics FMC2 NAND
> Controller found on STM32MP SOCs.
> 
> This patch is based on FMC2 command sequencer.
> The purpose of the command sequencer is to facilitate the programming
> and the reading of NAND flash pages with the ECC and to free the CPU
> of sequencing tasks.
> It requires one DMA channel for write and two DMA channels for read
> operations.
> 
> Only NAND_ECC_HW mode is actually supported.
> The driver supports a maximum 8k page size.
> The following ECC strength and step size are currently supported:
>  - nand-ecc-strength = <8>, nand-ecc-step-size = <512> (BCH8)
>  - nand-ecc-strength = <4>, nand-ecc-step-size = <512> (BCH4)
>  - nand-ecc-strength = <1>, nand-ecc-step-size = <512> (Extended ECC
>    based on Hamming)
> 
> This patch has been tested on Micron MT29F8G08ABACAH4 and
> MT29F8G16ABACAH4
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
