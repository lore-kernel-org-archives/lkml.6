Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeCTQWY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:22:24 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:13648 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeCTQWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:22:17 -0400
X-IronPort-AV: E=Sophos;i="5.48,336,1517900400";
   d="scan'208";a="12469070"
Subject: Re: [PATCH v2 2/2] mtd: nand: Remove print after allocation failure
To: Arushi Singhal <arushisinghal19971997@gmail.com>,
        <boris.brezillon@free-electrons.com>
CC: <richard@nod.at>, <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <maxime.ripard@free-electrons.com>,
        <alexandre.belloni@free-electrons.com>, <rainyfeeling@outlook.com>,
        <miquel.raynal@free-electrons.com>
References: <1521559885-10523-1-git-send-email-arushisinghal19971997@gmail.com>
 <1521559885-10523-2-git-send-email-arushisinghal19971997@gmail.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <a2e42b52-d43c-5fcb-ebe6-661d1695e89f@microchip.com>
Date: Tue, 20 Mar 2018 17:21:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521559885-10523-2-git-send-email-arushisinghal19971997@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2018 at 16:31, Arushi Singhal wrote:
> The prints after [k|v][m|z|c]alloc() etc. functions are not needed, because
> in case of failure, allocator will print their internal error prints
> anyway.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   drivers/mtd/nand/ams-delta.c             |  1 -
>   drivers/mtd/nand/atmel/nand-controller.c | 13 +++---------

For Atmel NAND driver:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

>   drivers/mtd/nand/marvell_nand.c          |  8 ++------
>   drivers/mtd/nand/nandsim.c               | 35 ++++++++------------------------
>   drivers/mtd/nand/ndfc.c                  |  4 +---
>   drivers/mtd/nand/sunxi_nand.c            |  4 +---
>   6 files changed, 15 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
> index 9de6572..6e7f6e0 100644
> --- a/drivers/mtd/nand/ams-delta.c
> +++ b/drivers/mtd/nand/ams-delta.c
> @@ -185,7 +185,6 @@ static int ams_delta_init(struct platform_device *pdev)
>   	/* Allocate memory for MTD device structure and private data */
>   	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
>   	if (!this) {
> -		printk (KERN_WARNING "Unable to allocate E3 NAND MTD device structure.\n");
>   		err = -ENOMEM;
>   		goto out;
>   	}
> diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
> index b2f00b3..b973d42 100644
> --- a/drivers/mtd/nand/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/atmel/nand-controller.c
> @@ -1615,10 +1615,8 @@ static int atmel_nand_register(struct atmel_nand *nand)
>   		mtd->name = devm_kasprintf(nc->dev, GFP_KERNEL,
>   					   "%s:nand.%d", dev_name(nc->dev),
>   					   nand->cs[0].id);
> -		if (!mtd->name) {
> -			dev_err(nc->dev, "Failed to allocate mtd->name\n");
> +		if (!mtd->name)
>   			return -ENOMEM;
> -		}
>   	}
>   
>   	ret = nand_scan_tail(mtd);
> @@ -1657,10 +1655,8 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
>   	nand = devm_kzalloc(nc->dev,
>   			    sizeof(*nand) + (numcs * sizeof(*nand->cs)),
>   			    GFP_KERNEL);
> -	if (!nand) {
> -		dev_err(nc->dev, "Failed to allocate NAND object\n");
> +	if (!nand)
>   		return ERR_PTR(-ENOMEM);
> -	}
>   
>   	nand->numcs = numcs;
>   
> @@ -2217,11 +2213,8 @@ atmel_hsmc_nand_controller_init(struct atmel_hsmc_nand_controller *nc)
>   	nc->sram.virt = gen_pool_dma_alloc(nc->sram.pool,
>   					    ATMEL_NFC_SRAM_SIZE,
>   					    &nc->sram.dma);
> -	if (!nc->sram.virt) {
> -		dev_err(nc->base.dev,
> -			"Could not allocate memory from the NFC SRAM pool\n");
> +	if (!nc->sram.virt)
>   		return -ENOMEM;
> -	}
>   
>   	return 0;
>   }
> diff --git a/drivers/mtd/nand/marvell_nand.c b/drivers/mtd/nand/marvell_nand.c
> index 2196f2a..9dd2673 100644
> --- a/drivers/mtd/nand/marvell_nand.c
> +++ b/drivers/mtd/nand/marvell_nand.c
> @@ -2307,10 +2307,8 @@ static int marvell_nand_chip_init(struct device *dev, struct marvell_nfc *nfc,
>   				    (nsels *
>   				     sizeof(struct marvell_nand_chip_sel)),
>   				    GFP_KERNEL);
> -	if (!marvell_nand) {
> -		dev_err(dev, "could not allocate chip structure\n");
> +	if (!marvell_nand)
>   		return -ENOMEM;
> -	}
>   
>   	marvell_nand->nsels = nsels;
>   	marvell_nand->selected_die = -1;
> @@ -2506,10 +2504,8 @@ static int marvell_nand_chip_init(struct device *dev, struct marvell_nfc *nfc,
>   		mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL,
>   					   "%s:nand.%d", dev_name(nfc->dev),
>   					   marvell_nand->sels[0].cs);
> -		if (!mtd->name) {
> -			dev_err(nfc->dev, "Failed to allocate mtd->name\n");
> +		if (!mtd->name)
>   			return -ENOMEM;
> -		}
>   	}
>   
>   	ret = nand_scan_tail(mtd);
> diff --git a/drivers/mtd/nand/nandsim.c b/drivers/mtd/nand/nandsim.c
> index 44322a3..b6a5c09 100644
> --- a/drivers/mtd/nand/nandsim.c
> +++ b/drivers/mtd/nand/nandsim.c
> @@ -569,13 +569,11 @@ static int __init alloc_device(struct nandsim *ns)
>   		ns->pages_written = vzalloc(BITS_TO_LONGS(ns->geom.pgnum) *
>   					    sizeof(unsigned long));
>   		if (!ns->pages_written) {
> -			NS_ERR("alloc_device: unable to allocate pages written array\n");
>   			err = -ENOMEM;
>   			goto err_close;
>   		}
>   		ns->file_buf = kmalloc(ns->geom.pgszoob, GFP_KERNEL);
>   		if (!ns->file_buf) {
> -			NS_ERR("alloc_device: unable to allocate file buf\n");
>   			err = -ENOMEM;
>   			goto err_free;
>   		}
> @@ -584,10 +582,8 @@ static int __init alloc_device(struct nandsim *ns)
>   	}
>   
>   	ns->pages = vmalloc(ns->geom.pgnum * sizeof(union ns_mem));
> -	if (!ns->pages) {
> -		NS_ERR("alloc_device: unable to allocate page array\n");
> +	if (!ns->pages)
>   		return -ENOMEM;
> -	}
>   	for (i = 0; i < ns->geom.pgnum; i++) {
>   		ns->pages[i].byte = NULL;
>   	}
> @@ -769,11 +765,8 @@ static int __init init_nandsim(struct mtd_info *mtd)
>   
>   	/* Allocate / initialize the internal buffer */
>   	ns->buf.byte = kmalloc(ns->geom.pgszoob, GFP_KERNEL);
> -	if (!ns->buf.byte) {
> -		NS_ERR("init_nandsim: unable to allocate %u bytes for the internal buffer\n",
> -			ns->geom.pgszoob);
> +	if (!ns->buf.byte)
>   		return -ENOMEM;
> -	}
>   	memset(ns->buf.byte, 0xFF, ns->geom.pgszoob);
>   
>   	return 0;
> @@ -844,10 +837,8 @@ static int parse_weakblocks(void)
>   		if (*w == ',')
>   			w += 1;
>   		wb = kzalloc(sizeof(*wb), GFP_KERNEL);
> -		if (!wb) {
> -			NS_ERR("unable to allocate memory.\n");
> +		if (!wb)
>   			return -ENOMEM;
> -		}
>   		wb->erase_block_no = erase_block_no;
>   		wb->max_erases = max_erases;
>   		list_add(&wb->list, &weak_blocks);
> @@ -895,10 +886,8 @@ static int parse_weakpages(void)
>   		if (*w == ',')
>   			w += 1;
>   		wp = kzalloc(sizeof(*wp), GFP_KERNEL);
> -		if (!wp) {
> -			NS_ERR("unable to allocate memory.\n");
> +		if (!wp)
>   			return -ENOMEM;
> -		}
>   		wp->page_no = page_no;
>   		wp->max_writes = max_writes;
>   		list_add(&wp->list, &weak_pages);
> @@ -946,10 +935,8 @@ static int parse_gravepages(void)
>   		if (*g == ',')
>   			g += 1;
>   		gp = kzalloc(sizeof(*gp), GFP_KERNEL);
> -		if (!gp) {
> -			NS_ERR("unable to allocate memory.\n");
> +		if (!gp)
>   			return -ENOMEM;
> -		}
>   		gp->page_no = page_no;
>   		gp->max_reads = max_reads;
>   		list_add(&gp->list, &grave_pages);
> @@ -1000,10 +987,8 @@ static int setup_wear_reporting(struct mtd_info *mtd)
>   		return -ENOMEM;
>   	}
>   	erase_block_wear = kzalloc(mem, GFP_KERNEL);
> -	if (!erase_block_wear) {
> -		NS_ERR("Too many erase blocks for wear reporting\n");
> +	if (!erase_block_wear)
>   		return -ENOMEM;
> -	}
>   	return 0;
>   }
>   
> @@ -1558,10 +1543,8 @@ static int prog_page(struct nandsim *ns, int num)
>   		 * again and deadlocks. This was seen in practice.
>   		 */
>   		mypage->byte = kmem_cache_alloc(ns->nand_pages_slab, GFP_NOFS);
> -		if (mypage->byte == NULL) {
> -			NS_ERR("prog_page: error allocating memory for page %d\n", ns->regs.row);
> +		if (!mypage->byte)
>   			return -1;
> -		}
>   		memset(mypage->byte, 0xFF, ns->geom.pgszoob);
>   	}
>   
> @@ -2209,10 +2192,8 @@ static int __init ns_init_module(void)
>   	/* Allocate and initialize mtd_info, nand_chip and nandsim structures */
>   	chip = kzalloc(sizeof(struct nand_chip) + sizeof(struct nandsim),
>   		       GFP_KERNEL);
> -	if (!chip) {
> -		NS_ERR("unable to allocate core structures.\n");
> +	if (!chip)
>   		return -ENOMEM;
> -	}
>   	nsmtd       = nand_to_mtd(chip);
>   	nand        = (struct nandsim *)(chip + 1);
>   	nand_set_controller_data(chip, (void *)nand);
> diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
> index d8a8068..ea8d652 100644
> --- a/drivers/mtd/nand/ndfc.c
> +++ b/drivers/mtd/nand/ndfc.c
> @@ -223,10 +223,8 @@ static int ndfc_probe(struct platform_device *ofdev)
>   	dev_set_drvdata(&ofdev->dev, ndfc);
>   
>   	ndfc->ndfcbase = of_iomap(ofdev->dev.of_node, 0);
> -	if (!ndfc->ndfcbase) {
> -		dev_err(&ofdev->dev, "failed to get memory\n");
> +	if (!ndfc->ndfcbase)
>   		return -EIO;
> -	}
>   
>   	ccr = NDFC_CCR_BS(ndfc->chip_select);
>   
> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> index f5a55c6..f38359f7 100644
> --- a/drivers/mtd/nand/sunxi_nand.c
> +++ b/drivers/mtd/nand/sunxi_nand.c
> @@ -2030,10 +2030,8 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
>   			    sizeof(*chip) +
>   			    (nsels * sizeof(struct sunxi_nand_chip_sel)),
>   			    GFP_KERNEL);
> -	if (!chip) {
> -		dev_err(dev, "could not allocate chip\n");
> +	if (!chip)
>   		return -ENOMEM;
> -	}
>   
>   	chip->nsels = nsels;
>   	chip->selected = -1;
> 


-- 
Nicolas Ferre
