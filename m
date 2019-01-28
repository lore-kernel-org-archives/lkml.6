Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB17FC282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96C120C01
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="blIAZz3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfA1CWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 21:22:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfA1CWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 21:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9A2bhWdt92f//3IxfhrgEcbYlio1W9MKRsGBBIyHXas=; b=blIAZz3YetoYoTO4kEHkF8k9S5
        4vaBZs4gU0gmVbLeOTo/XDvwW2mKjB+9Y08abpE4oox949ifkRI9zMZatjHNArCQjDBgG3G7GR5xr
        V+Fw+0GTm3wtLiz1wTRqbSakIssVrCvEKqqb7n0Ok/OX9A9akpy9fzHNkffKf0HksjmhSJCwfHwMn
        nz859Y6KwFg6He4m24FXrj2tt7du7RH4Ps/MXj9GxQYXHnw50kZqfB7giCtHQDS4/zXTmEpaF461H
        ZQnxs1Ut2kJSKl4j7a9V52+8q/mg33X1deDo7p+aTVBdkaS8+rsBvesK6ZcRz/ADf1BaxaWxlp/mu
        Jk/UqMMw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gnwYb-0002xR-6O; Mon, 28 Jan 2019 02:21:53 +0000
To:     LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] mtd: nand: fix kernel-doc warnings
Message-ID: <21d5edd7-1335-2731-6d53-5b15d053462c@infradead.org>
Date:   Sun, 27 Jan 2019 18:21:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings in drivers/mtd/nand/raw:

../drivers/mtd/nand/raw/nand_base.c:420: warning: Function parameter or member 'chip' not described in 'nand_fill_oob'
../drivers/mtd/nand/raw/nand_bbt.c:173: warning: Function parameter or member 'this' not described in 'read_bbt'
../drivers/mtd/nand/raw/nand_bbt.c:173: warning: Excess function parameter 'chip' description in 'read_bbt'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org
---
Do you want Fixes: tags for these:

Fixes: 0813621ba898a ("mtd: rawnand: Stop passing mtd_info objects to internal functions")
Fixes: 99f3351a6d6e0 ("mtd: rawnand: Reorganize code to avoid forward declarations")

 drivers/mtd/nand/raw/nand_base.c |    1 +
 drivers/mtd/nand/raw/nand_bbt.c  |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- lnx-50-rc4.orig/drivers/mtd/nand/raw/nand_base.c
+++ lnx-50-rc4/drivers/mtd/nand/raw/nand_base.c
@@ -410,6 +410,7 @@ static int nand_check_wp(struct nand_chi
 
 /**
  * nand_fill_oob - [INTERN] Transfer client buffer to oob
+ * @chip: NAND chip object
  * @oob: oob data buffer
  * @len: oob data write length
  * @ops: oob ops structure
--- lnx-50-rc4.orig/drivers/mtd/nand/raw/nand_bbt.c
+++ lnx-50-rc4/drivers/mtd/nand/raw/nand_bbt.c
@@ -158,7 +158,7 @@ static u32 add_marker_len(struct nand_bb
 
 /**
  * read_bbt - [GENERIC] Read the bad block table starting from page
- * @chip: NAND chip object
+ * @this: NAND chip object
  * @buf: temporary buffer
  * @page: the starting page
  * @num: the number of bbt descriptors to read


