Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9339BC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD1E20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD1E20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJHPEL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:04:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34408 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbeJHPEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:04:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3947A207CC; Mon,  8 Oct 2018 09:53:44 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0D3FC2072D;
        Mon,  8 Oct 2018 09:53:34 +0200 (CEST)
Date:   Mon, 8 Oct 2018 09:53:34 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the nand tree
Message-ID: <20181008095334.6850f033@xps13>
In-Reply-To: <20181008113842.4bfc8cf9@canb.auug.org.au>
References: <20181008113842.4bfc8cf9@canb.auug.org.au>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Stephen Rothwell <sfr@canb.auug.org.au> wrote on Mon, 8 Oct 2018
11:38:42 +1100:

> Hi Boris,

Boris is still there but I'm in charge of the NAND tree these days (and
the one to blame too for this one :) ).

> 
> After merging the nand tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> drivers/mtd/nand/raw/nand_toshiba.c: In function 'toshiba_nand_read_page_benand':
> drivers/mtd/nand/raw/nand_toshiba.c:54:19: warning: unused variable 'mtd' [-Wunused-variable]
>   struct mtd_info *mtd = nand_to_mtd(chip);
>                    ^~~
> drivers/mtd/nand/raw/nand_toshiba.c: In function 'toshiba_nand_read_subpage_benand':
> drivers/mtd/nand/raw/nand_toshiba.c:68:19: warning: unused variable 'mtd' [-Wunused-variable]
>   struct mtd_info *mtd = nand_to_mtd(chip);
>                    ^~~
> 
> Introduced by commit
> 
>   fe8b76ec9886 ("mtd: rawnand: toshiba: Pass a single nand_chip object to the status helper")

Thanks for the warning, I'll correct it for tomorrow.

Kind regards,
Miquèl
