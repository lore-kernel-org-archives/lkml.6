Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A56FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E241820666
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qD/s95Ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E241820666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeLCVWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:22:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35734 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLCVWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:22:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so13751517wrb.2;
        Mon, 03 Dec 2018 13:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7txZif9/Hx2iC9bMiJ4rqvh6/rIrzGiz1zZ8f4eIqDg=;
        b=qD/s95HazlKoDFis6xViAecDz5okAJhFPqZcwraHHRCDLU/EUTCE4d1cFK1O4KDTse
         C63VQ5sNwrl/TEN4dOLJ7M8qsdqASBj1Upfu7aj10CRkElgkhDZFGDbl07K66t8LXTa/
         MMyaIIF4f4hNe6X9HaoLbBaAKvSdJ9brvO5EBdOfeCMMT1jgmNR/mDnxiqb/HTHp5d8h
         6BnfPG66z9KuQkZMqwOOwWZEn+QI5vF863GkzCNEK5r+um7fAqoDyBK4lkUsrcp2Z80r
         AkBBHnBcX3RI4rd+B9ABz2JWxe66TU/+UtzqcvhPCn0pxBJjtrYg0k/XO+YdCy62e1Vb
         Y1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=7txZif9/Hx2iC9bMiJ4rqvh6/rIrzGiz1zZ8f4eIqDg=;
        b=p3uikVDkpIuRKaaBh3nddxt8owtxhkq4ESgNtQ6/7Jrlk3zktXApD/aJtHlmHBSpjW
         gErodx6JkxlwHFCZ8ZPE1G77/LyGXBmywtJpu+2QI9SCl28JXjSSuY1l02PAK3Hk02bm
         eWGeF7y0+3JCYk7OlI9FKXbpKOm3OaDzBpE02s5bFAbV7OMpDvGuOYuqGa+8vNkBwSUE
         I81a4nGdrwh5+h/bFiXTb///4NffuKieyJb19pGWfYWyYmJ3M/dT8FZIU65HXuNPshwd
         Nq7bQSSrKTr06e1tqbMNGzVnhrVA7lUb4spEUlewAPyLXYSpn6JOLN93ir9/8AYc2sCu
         IVHg==
X-Gm-Message-State: AA+aEWa/GQqba5iHckeQ9HXVAwX3JQeY48qmrhjR/vXDxOaZhLhuQFvX
        5M9naU3/MA569vS0KTte+gw=
X-Google-Smtp-Source: AFSGD/Ua88aiBHciR/BIfNYaC6A4A2lXVGrrDJDcLORtBXBqI9Wyv9fIL9BB0AUfEEjw/fISxb8yKA==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr15133700wrg.230.1543872152219;
        Mon, 03 Dec 2018 13:22:32 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id j76sm22135498wmf.26.2018.12.03.13.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 13:22:31 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id C5BD1114100F; Mon,  3 Dec 2018 22:22:29 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     trivial@kernel.org, kernel-janitors@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: annotate implicit fall throughs
Date:   Mon,  3 Dec 2018 22:22:13 +0100
Message-Id: <20181203212214.8862-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings. Fix them up.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/mtd/nand/raw/jz4780_bch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/jz4780_bch.c b/drivers/mtd/nand/raw/jz4780_bch.c
index 731c6051d91e..7201827809e9 100644
--- a/drivers/mtd/nand/raw/jz4780_bch.c
+++ b/drivers/mtd/nand/raw/jz4780_bch.c
@@ -136,8 +136,10 @@ static void jz4780_bch_read_parity(struct jz4780_bch *bch, void *buf,
 	switch (size8) {
 	case 3:
 		dest8[2] = (val >> 16) & 0xff;
+		/* fall through */
 	case 2:
 		dest8[1] = (val >> 8) & 0xff;
+		/* fall through */
 	case 1:
 		dest8[0] = val & 0xff;
 		break;
-- 
2.19.2

