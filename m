Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970D0C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29422241D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="isVo8wV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29422241D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754174AbeGELT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:19:27 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.132]:10945 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753598AbeGELTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530789562;
        s=strato-dkim-0002; d=as-electronics.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=IsJAdg1xLBii0EDcJvb73W7s/Ws9tzCdp4ai5kBldHE=;
        b=isVo8wV/2mibRjZLlUEDE3TxwAJA2afhHOwuPTEWRX1zo0zbQfuSr7Bfy/+ZkV76Qw
        Qd7gKPuKeI7tOTbIxWQHWTDlhHj3hJyS3vD4nKK5uXa9DN+bWEtYnWa8QXvXc6oYVFaa
        To6MihkQxK19f1o9hgUhh9KLSZzGTwtD/7r05qKv+m4tbnUsqx6hUxCYCcnOi3uKoinh
        jgiYEFKAnPlDoB0jy+B/RpHkAhoGqnUC5Z4ipcOvY9jOyfNqqbshxQRSLDhNXe+x+PPy
        H0IF3XmGonqypCKH9CGMRA1cofhR6wOkOJ4JXCQaboQ5wzaQPCOP2ooqDo8h2O8Qz/M5
        Km6A==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx+daE87UU5bgm7XHzClQnm8VxHglxo5wj3H1fls="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id a0925bu65BIn4iW
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Jul 2018 13:18:49 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, shawnguo@kernel.org,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/12] MAINTAINERS: Move the Freescale QSPI driver to the SPI framework
Date:   Thu,  5 Jul 2018 13:15:08 +0200
Message-Id: <1530789310-16254-13-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was ported to the SPI framework so it can be used as
a generic SPI memory driver and not only for SPI NOR.
Reflect this transition in the MAINTAINERS file.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63700ce..14039e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5746,9 +5746,9 @@ F:	Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
 
 FREESCALE QUAD SPI DRIVER
 M:	Han Xu <han.xu@nxp.com>
-L:	linux-mtd@lists.infradead.org
+L:	linux-spi@vger.kernel.org
 S:	Maintained
-F:	drivers/mtd/spi-nor/fsl-quadspi.c
+F:	drivers/spi/spi-fsl-qspi.c
 
 FREESCALE QUICC ENGINE LIBRARY
 M:	Qiang Zhao <qiang.zhao@nxp.com>
-- 
2.7.4

