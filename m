Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD3FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF8120685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="h0DMf7/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF8120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeGYKyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:54:40 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:51398 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeGYKyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:54:40 -0400
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com [209.85.213.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w6P9hPdc020990
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 18:43:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w6P9hPdc020990
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532511806;
        bh=BSYE25bK9x7HZTDaSdseKI/ws3wyuKg4RmBcta9xJa4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=h0DMf7/8xQeK4+UFbM19uLTEVsyNYmF9iQTSoqdzkDNwpNNfE4Xpc8ksUHnKeHTyR
         DuYwPsYSrTS7Bz33Eyc7z1ac9SD9JlPukoiBRdZ7XbsVotjZYBXnw8OAez7u60HFfO
         FROj0qOl6n1uDNGoCulHPe0K7iwk7lndQfBEFHOnkTVI/WMIQGwQwgbsSriHLpMDzc
         i0y2DKdOfaS0PKUlHfgI46M292pnI5GFnWC24Qe7wp248waD3EPVAkBYBJaKmDrSpP
         qoB5VQ5EAxa4RWlG+kaD8L3vYcw87XzbmjcCZxHsxWM2Cf5gKa/L79Qc+k6oCe9PXS
         2HmWkO8i2l0GA==
X-Nifty-SrcIP: [209.85.213.46]
Received: by mail-vk0-f46.google.com with SMTP id y70-v6so3487573vkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 02:43:25 -0700 (PDT)
X-Gm-Message-State: AOUpUlHspRzaRWwVpagJCG7B9Dt0XqNcj1HGpPfOSBaDmAWK5oxcHKXv
        ubPwgQx6KfEM8xDfPz+TqgxMygKPVaIN+aosSfg=
X-Google-Smtp-Source: AAOMgpcdMe4wUXqqOzLm+cu8SUuvtXXbbzbUyF2xLzMZaRmv0NyWHw4cUmzanuv2UjebnHVSXnSYCsl+fbxX1NExVqM=
X-Received: by 2002:a1f:df42:: with SMTP id w63-v6mr13183652vkg.135.1532511804709;
 Wed, 25 Jul 2018 02:43:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 02:42:44
 -0700 (PDT)
In-Reply-To: <20180720151527.16038-5-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com> <20180720151527.16038-5-miquel.raynal@bootlin.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 25 Jul 2018 18:42:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNASmJRWM7Gj9qqqZqwenPkoRFeA8tupx+3PKPXC6OxD_eA@mail.gmail.com>
Message-ID: <CAK7LNASmJRWM7Gj9qqqZqwenPkoRFeA8tupx+3PKPXC6OxD_eA@mail.gmail.com>
Subject: Re: [PATCH v4 04/35] mtd: rawnand: denali: convert to nand_scan()
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>, Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


2018-07-21 0:14 GMT+09:00 Miquel Raynal <miquel.raynal@bootlin.com>:
> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/denali.c | 138 +++++++++++++++++++++++-------------------
>  1 file changed, 77 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
> index 4d53f41ada08..2fa92c297a66 100644
> --- a/drivers/mtd/nand/raw/denali.c
> +++ b/drivers/mtd/nand/raw/denali.c
> @@ -1205,62 +1205,12 @@ static int denali_multidev_fixup(struct denali_nand_info *denali)
>         return 0;
>  }
>
> -int denali_init(struct denali_nand_info *denali)
> +static int denali_attach_chip(struct nand_chip *chip)
>  {
> -       struct nand_chip *chip = &denali->nand;
>         struct mtd_info *mtd = nand_to_mtd(chip);
> -       u32 features = ioread32(denali->reg + FEATURES);
> +       struct denali_nand_info *denali = mtd_to_denali(mtd);
>         int ret;
>
> -       mtd->dev.parent = denali->dev;
> -       denali_hw_init(denali);
> -
> -       init_completion(&denali->complete);
> -       spin_lock_init(&denali->irq_lock);
> -
> -       denali_clear_irq_all(denali);
> -
> -       ret = devm_request_irq(denali->dev, denali->irq, denali_isr,
> -                              IRQF_SHARED, DENALI_NAND_NAME, denali);
> -       if (ret) {
> -               dev_err(denali->dev, "Unable to request IRQ\n");
> -               return ret;
> -       }
> -
> -       denali_enable_irq(denali);
> -       denali_reset_banks(denali);
> -
> -       denali->active_bank = DENALI_INVALID_BANK;
> -
> -       nand_set_flash_node(chip, denali->dev->of_node);
> -       /* Fallback to the default name if DT did not give "label" property */
> -       if (!mtd->name)
> -               mtd->name = "denali-nand";
> -
> -       chip->select_chip = denali_select_chip;
> -       chip->read_byte = denali_read_byte;
> -       chip->write_byte = denali_write_byte;
> -       chip->read_word = denali_read_word;
> -       chip->cmd_ctrl = denali_cmd_ctrl;
> -       chip->dev_ready = denali_dev_ready;
> -       chip->waitfunc = denali_waitfunc;
> -
> -       if (features & FEATURES__INDEX_ADDR) {
> -               denali->host_read = denali_indexed_read;
> -               denali->host_write = denali_indexed_write;
> -       } else {
> -               denali->host_read = denali_direct_read;
> -               denali->host_write = denali_direct_write;
> -       }
> -
> -       /* clk rate info is needed for setup_data_interface */
> -       if (denali->clk_rate && denali->clk_x_rate)
> -               chip->setup_data_interface = denali_setup_data_interface;
> -
> -       ret = nand_scan_ident(mtd, denali->max_banks, NULL);
> -       if (ret)
> -               goto disable_irq;
> -
>         if (ioread32(denali->reg + FEATURES) & FEATURES__DMA)
>                 denali->dma_avail = 1;
>
> @@ -1293,7 +1243,7 @@ int denali_init(struct denali_nand_info *denali)
>                                    mtd->oobsize - denali->oob_skip_bytes);
>         if (ret) {
>                 dev_err(denali->dev, "Failed to setup ECC settings.\n");
> -               goto disable_irq;
> +               return ret;
>         }
>
>         dev_dbg(denali->dev,
> @@ -1337,7 +1287,7 @@ int denali_init(struct denali_nand_info *denali)
>
>         ret = denali_multidev_fixup(denali);
>         if (ret)
> -               goto disable_irq;
> +               return ret;
>
>         /*
>          * This buffer is DMA-mapped by denali_{read,write}_page_raw.  Do not
> @@ -1345,26 +1295,92 @@ int denali_init(struct denali_nand_info *denali)
>          * guarantee DMA-safe alignment.
>          */
>         denali->buf = kmalloc(mtd->writesize + mtd->oobsize, GFP_KERNEL);
> -       if (!denali->buf) {
> -               ret = -ENOMEM;
> -               goto disable_irq;
> +       if (!denali->buf)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +static void denali_detach_chip(struct nand_chip *chip)
> +{
> +       struct mtd_info *mtd = nand_to_mtd(chip);
> +       struct denali_nand_info *denali = mtd_to_denali(mtd);
> +
> +       kfree(denali->buf);
> +}
> +
> +static const struct nand_controller_ops denali_controller_ops = {
> +       .attach_chip = denali_attach_chip,
> +       .detach_chip = denali_detach_chip,
> +};
> +
> +int denali_init(struct denali_nand_info *denali)
> +{
> +       struct nand_chip *chip = &denali->nand;
> +       struct mtd_info *mtd = nand_to_mtd(chip);
> +       u32 features = ioread32(denali->reg + FEATURES);
> +       int ret;
> +
> +       mtd->dev.parent = denali->dev;
> +       denali_hw_init(denali);
> +
> +       init_completion(&denali->complete);
> +       spin_lock_init(&denali->irq_lock);
> +
> +       denali_clear_irq_all(denali);
> +
> +       ret = devm_request_irq(denali->dev, denali->irq, denali_isr,
> +                              IRQF_SHARED, DENALI_NAND_NAME, denali);
> +       if (ret) {
> +               dev_err(denali->dev, "Unable to request IRQ\n");
> +               return ret;
> +       }
> +
> +       denali_enable_irq(denali);
> +       denali_reset_banks(denali);
> +
> +       denali->active_bank = DENALI_INVALID_BANK;
> +
> +       nand_set_flash_node(chip, denali->dev->of_node);
> +       /* Fallback to the default name if DT did not give "label" property */
> +       if (!mtd->name)
> +               mtd->name = "denali-nand";
> +
> +       chip->select_chip = denali_select_chip;
> +       chip->read_byte = denali_read_byte;
> +       chip->write_byte = denali_write_byte;
> +       chip->read_word = denali_read_word;
> +       chip->cmd_ctrl = denali_cmd_ctrl;
> +       chip->dev_ready = denali_dev_ready;
> +       chip->waitfunc = denali_waitfunc;
> +
> +       if (features & FEATURES__INDEX_ADDR) {
> +               denali->host_read = denali_indexed_read;
> +               denali->host_write = denali_indexed_write;
> +       } else {
> +               denali->host_read = denali_direct_read;
> +               denali->host_write = denali_direct_write;
>         }
>
> -       ret = nand_scan_tail(mtd);
> +       /* clk rate info is needed for setup_data_interface */
> +       if (denali->clk_rate && denali->clk_x_rate)
> +               chip->setup_data_interface = denali_setup_data_interface;
> +
> +       chip->dummy_controller.ops = &denali_controller_ops;
> +       ret = nand_scan(mtd, denali->max_banks);
>         if (ret)
> -               goto free_buf;
> +               goto disable_irq;
>
>         ret = mtd_device_register(mtd, NULL, 0);
>         if (ret) {
>                 dev_err(denali->dev, "Failed to register MTD: %d\n", ret);
>                 goto cleanup_nand;
>         }
> +
>         return 0;
>
>  cleanup_nand:
>         nand_cleanup(chip);
> -free_buf:
> -       kfree(denali->buf);
>  disable_irq:
>         denali_disable_irq(denali);
>
> --
> 2.14.1
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/





You need to remove kfree(denali->buf)
from denali_remove(), right?



void denali_remove(struct denali_nand_info *denali)
{
        struct mtd_info *mtd = nand_to_mtd(&denali->nand);

        nand_release(mtd);
        kfree(denali->buf);       <---- REMOVE !!
        denali_disable_irq(denali);
}




Otherwise, denali_remove() will free denali->buf twice
because kfree(denali->buf) is called from denali_detach_chip().






-- 
Best Regards
Masahiro Yamada
