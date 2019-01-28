Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D90C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C69217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548668630;
	bh=jEcDe2UQ46jLm//RqXuIKf3f33l5baUrnMSD5SYJlD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=14bSHXess+F8mN8dDnNSDhf1D0qX8Os/6GkzRep/47DinQImwrVTd+Y0fD9WHo77R
	 cb/gaiNMie3DzCy5qSD02Dd1F5hz4JAr6dYb3oljB5zxzw6zreog0B+diW2jDkC57Z
	 6Obp77pkYjyfY9b31BRX2heGoc2lFwL2MCT3umPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfA1Jns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:43:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbfA1Jnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:43:47 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D80C20989;
        Mon, 28 Jan 2019 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548668627;
        bh=jEcDe2UQ46jLm//RqXuIKf3f33l5baUrnMSD5SYJlD4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IWH1YOi9aSNg50TeubHklI0s/Ynbij8EDza7wqKoxeqM5SZp9FSg6u1puZBI7YFV0
         +i5EDMmKKkJvy9J9PtDm21/wzZ7CtstPkhLTbovat71KyFNfW5XlAV/Njyu9RCxXMt
         6OdHgIk3B9xEBnHNtvKhfouxOZnqv+lacKYs2kEQ=
Date:   Mon, 28 Jan 2019 10:43:38 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: nand: fix kernel-doc warnings
Message-ID: <20190128104319.7a9effde@bbrezillon>
In-Reply-To: <21d5edd7-1335-2731-6d53-5b15d053462c@infradead.org>
References: <21d5edd7-1335-2731-6d53-5b15d053462c@infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2019 18:21:42 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warnings in drivers/mtd/nand/raw:
> 
> ../drivers/mtd/nand/raw/nand_base.c:420: warning: Function parameter or member 'chip' not described in 'nand_fill_oob'
> ../drivers/mtd/nand/raw/nand_bbt.c:173: warning: Function parameter or member 'this' not described in 'read_bbt'
> ../drivers/mtd/nand/raw/nand_bbt.c:173: warning: Excess function parameter 'chip' description in 'read_bbt'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-mtd@lists.infradead.org
> ---
> Do you want Fixes: tags for these:
> 
> Fixes: 0813621ba898a ("mtd: rawnand: Stop passing mtd_info objects to internal functions")

Will add this one.

> Fixes: 99f3351a6d6e0 ("mtd: rawnand: Reorganize code to avoid forward declarations")

Well, I don't think that one is responsible for the new warnings since
all I did was moving code around.

Thanks,

Boris

> 
>  drivers/mtd/nand/raw/nand_base.c |    1 +
>  drivers/mtd/nand/raw/nand_bbt.c  |    2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> --- lnx-50-rc4.orig/drivers/mtd/nand/raw/nand_base.c
> +++ lnx-50-rc4/drivers/mtd/nand/raw/nand_base.c
> @@ -410,6 +410,7 @@ static int nand_check_wp(struct nand_chi
>  
>  /**
>   * nand_fill_oob - [INTERN] Transfer client buffer to oob
> + * @chip: NAND chip object
>   * @oob: oob data buffer
>   * @len: oob data write length
>   * @ops: oob ops structure
> --- lnx-50-rc4.orig/drivers/mtd/nand/raw/nand_bbt.c
> +++ lnx-50-rc4/drivers/mtd/nand/raw/nand_bbt.c
> @@ -158,7 +158,7 @@ static u32 add_marker_len(struct nand_bb
>  
>  /**
>   * read_bbt - [GENERIC] Read the bad block table starting from page
> - * @chip: NAND chip object
> + * @this: NAND chip object
>   * @buf: temporary buffer
>   * @page: the starting page
>   * @num: the number of bbt descriptors to read
> 
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

