Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594DDC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C33E218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfA3Kee convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:34:34 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:58781 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbfA3Ked (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:34:33 -0500
Received: from xps13 (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 52742200015;
        Wed, 30 Jan 2019 10:34:28 +0000 (UTC)
Date:   Wed, 30 Jan 2019 11:34:28 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <bbrezillon@kernel.org>, <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <christophe.kerello@st.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH -next] mtd: rawnand: stm32_fmc2: Make some functions
 static
Message-ID: <20190130113428.37570a55@xps13>
In-Reply-To: <20190130100908.19532-1-yuehaibing@huawei.com>
References: <20190130100908.19532-1-yuehaibing@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

YueHaibing <yuehaibing@huawei.com> wrote on Wed, 30 Jan 2019 18:09:08
+0800:

> Fixes the following sparse warning:
> drivers/mtd/nand/raw/stm32_fmc2_nand.c:1228:6: warning: symbol 'stm32_fmc2_read_data' was not declared. Should it be static?
> drivers/mtd/nand/raw/stm32_fmc2_nand.c:1275:6: warning: symbol 'stm32_fmc2_write_data' was not declared. Should it be static?
> drivers/mtd/nand/raw/stm32_fmc2_nand.c:1707:32: warning: symbol 'stm32_fmc2_nand_ooblayout_ops' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> index e057282..999ca6a 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -1225,8 +1225,8 @@ static irqreturn_t stm32_fmc2_irq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -void stm32_fmc2_read_data(struct nand_chip *chip, void *buf,
> -			  unsigned int len, bool force_8bit)
> +static void stm32_fmc2_read_data(struct nand_chip *chip, void *buf,
> +				 unsigned int len, bool force_8bit)
>  {
>  	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
>  	void __iomem *io_addr_r = fmc2->data_base[fmc2->cs_sel];
> @@ -1272,8 +1272,8 @@ void stm32_fmc2_read_data(struct nand_chip *chip, void *buf,
>  		stm32_fmc2_set_buswidth_16(fmc2, true);
>  }
>  
> -void stm32_fmc2_write_data(struct nand_chip *chip, const void *buf,
> -			   unsigned int len, bool force_8bit)
> +static void stm32_fmc2_write_data(struct nand_chip *chip, const void *buf,
> +				  unsigned int len, bool force_8bit)
>  {
>  	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
>  	void __iomem *io_addr_w = fmc2->data_base[fmc2->cs_sel];
> @@ -1704,7 +1704,7 @@ static int stm32_fmc2_nand_ooblayout_free(struct mtd_info *mtd, int section,
>  	return 0;
>  }
>  
> -const struct mtd_ooblayout_ops stm32_fmc2_nand_ooblayout_ops = {
> +static const struct mtd_ooblayout_ops stm32_fmc2_nand_ooblayout_ops = {
>  	.ecc = stm32_fmc2_nand_ooblayout_ecc,
>  	.free = stm32_fmc2_nand_ooblayout_free,
>  };

This is nand/next material, so if you don't mind I would like to squash
this fix into the original commit inserting the driver.


Thanks,
Miquèl
