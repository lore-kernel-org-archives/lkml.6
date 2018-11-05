Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8B6C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CB92081B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WUZ8XqoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CB92081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeKEL4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:56:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKEL4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HbmB3NIfZH/KfC/X4c+NeZWUlTMZ9PB5wfYnSKn7c2w=; b=WUZ8XqoRiMnTw57kmF7CRmWrV
        aRSCmVaOz5Gce0UT6n2tL5A5EPa5TWTxMf5TXGf38vZwitAQZKg9wYlvh5RtBu6dSYdIkD7lu74gg
        qAkuReK8bWKMW5txFkBFRpPVDfzcAo+Xby0BVTg3+pMN1XzO7qGJEoqr9YPCwS43d1WWDreW4/nsg
        QP81jctHVQlttCZXIV0rGf9BggtN1AGoix22yKxnlF5cCSp3a5yuSFr6OrqyfSma8058MqXBQ5sfh
        pmv6ZpZYowCuAUSZHU+Ziz1ne85AA4LVva+pcDTqYe1nErqogYiFloo/lTqN1ZiPzsCIg7B/cVHRw
        yZ2JISWGA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJUmk-0002oF-1L; Mon, 05 Nov 2018 02:38:38 +0000
To:     LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] mtd: nand: drop kernel-doc notation for a deleted function
 parameter
Message-ID: <88c00c96-cfd2-4ff1-e753-8875501895df@infradead.org>
Date:   Sun, 4 Nov 2018 18:38:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Remove kernel-doc notation for a deleted function parameter to prevent
a kernel-doc warning:

../drivers/mtd/nand/raw/nand_base.c:603: warning: Excess function parameter 'mtd' description in 'panic_nand_wait'

Fixes: f1d46942e823 ("mtd: rawnand: Pass a nand_chip object to chip->waitfunc()")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
---

 drivers/mtd/nand/raw/nand_base.c |    1 -
 1 file changed, 1 deletion(-)

--- lnx-420-rc1.orig/drivers/mtd/nand/raw/nand_base.c
+++ lnx-420-rc1/drivers/mtd/nand/raw/nand_base.c
@@ -590,7 +590,6 @@ retry:
 
 /**
  * panic_nand_wait - [GENERIC] wait until the command is done
- * @mtd: MTD device structure
  * @chip: NAND chip structure
  * @timeo: timeout
  *


