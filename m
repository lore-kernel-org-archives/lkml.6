Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC45C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADB22084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548058226;
	bh=CDRG7Y7DEjMUWnDIU9dXSY+scfnXpjjIKacUStsfXaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=W5RL0e338WwQtYYKfImJHfpCwrGTydzP9D8QQ6wlSdVBKepu3OpVO3WSwN/pguZaD
	 oTWE/gTrC6PIkpZEU1O+D3Qq+Qp45rjr4y9sY++s1dhlX30eolqdrqn5BB/zr1tfx5
	 6uTvSxBl/eG1kIPy4PDCX+B6Qw/irxyXNEpQuMzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfAUIKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:10:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:51550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfAUIKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:10:24 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4390120823;
        Mon, 21 Jan 2019 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548058223;
        bh=CDRG7Y7DEjMUWnDIU9dXSY+scfnXpjjIKacUStsfXaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IUqP+x95oZ62BYTRTfWYTGAeUhPhVvJtSS2vTjTYF8LLyQDertppR4v42eB/Uvw2t
         rrawqwJDddfzy2SSyoDd5x89VoF+Tf0Z+ORb+dTW1uI8DMLUCgHMyTytid+G4U7nOE
         V0UdaaIkWYewPgfHxaMsd8DXZpkxzIO3V2V9LIYE=
Date:   Mon, 21 Jan 2019 09:10:13 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: denali: remove ->erase hook
Message-ID: <20190121091013.4a6f55a2@bbrezillon>
In-Reply-To: <1548046326-26776-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548046326-26776-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 13:52:06 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Commit f9ebd1bb4103 ("mtd: rawnand: Deprecate ->erase()") discouraged
> the use of this hook, so I am happy to follow the suggestion.
> 
> Although the Denali IP provides a special MAP10 command for erasing,
> using it would not buy us much. The Denali IP actually works with the
> generic erasing by single_erase() + ->cmdfunc hook (nand_command_lp)
> + ->cmd_ctrl hook (denali_cmd_ctrl).
> 
> This method is also deprecated, but denali_erase() can go away
> irrespective of ->exec_op conversion.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> 
>  drivers/mtd/nand/raw/denali.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
> index 6e8edc9..21320b1 100644
> --- a/drivers/mtd/nand/raw/denali.c
> +++ b/drivers/mtd/nand/raw/denali.c
> @@ -37,9 +37,6 @@
>  #define DENALI_MAP11_ADDR	((DENALI_MAP11) | 1)	/* address cycle */
>  #define DENALI_MAP11_DATA	((DENALI_MAP11) | 2)	/* data cycle */
>  
> -/* MAP10 commands */
> -#define DENALI_ERASE		0x01
> -
>  #define DENALI_BANK(denali)	((denali)->active_bank << 24)
>  
>  #define DENALI_INVALID_BANK	-1
> @@ -903,23 +900,6 @@ static int denali_waitfunc(struct nand_chip *chip)
>  	return irq_status & INTR__INT_ACT ? 0 : NAND_STATUS_FAIL;
>  }
>  
> -static int denali_erase(struct nand_chip *chip, int page)
> -{
> -	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
> -	uint32_t irq_status;
> -
> -	denali_reset_irq(denali);
> -
> -	denali->host_write(denali, DENALI_MAP10 | DENALI_BANK(denali) | page,
> -			   DENALI_ERASE);
> -
> -	/* wait for erase to complete or failure to occur */
> -	irq_status = denali_wait_for_irq(denali,
> -					 INTR__ERASE_COMP | INTR__ERASE_FAIL);
> -
> -	return irq_status & INTR__ERASE_COMP ? 0 : -EIO;
> -}
> -
>  static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
>  				       const struct nand_data_interface *conf)
>  {
> @@ -1244,7 +1224,6 @@ static int denali_attach_chip(struct nand_chip *chip)
>  	chip->ecc.write_page_raw = denali_write_page_raw;
>  	chip->ecc.read_oob = denali_read_oob;
>  	chip->ecc.write_oob = denali_write_oob;
> -	chip->legacy.erase = denali_erase;
>  
>  	ret = denali_multidev_fixup(denali);
>  	if (ret)

