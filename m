Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92FBC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCFB21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="PdUSE2fF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCFB21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbeHBOpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:45:44 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.134]:23149 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387490AbeHBOpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533214479;
        s=strato-dkim-0002; d=as-electronics.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=8q57JZNYbenQBiT361UPYFH2hWlsC7pLZ2/SJra925w=;
        b=PdUSE2fFlWy9ue1kiiB3sg6XDEX4ISDcT3XxAOBtHoS9meZMKvo9AqBUI2+nWVFcIQ
        +y8tM7GdV30UMFHqXle1TEed05ewt3/8qGMMwtgSeL6JA6YnC63Xj7+LfNFXpBf5Hzqx
        wPfJFQpXYpBFIAqeHE4gIrS/hHnNaJaky7HHK3wAPA6GutyJfIGWkDJrdWOD4Hzh9UIz
        BkNBjslERJRPLA/t+mDKwq9/oQhr3DczC36lxB9OYRR0hOR7Nl3NjTE5TOhOz6T2oq/7
        0S5Mn3+8GNvmeUs65K3+sUDZWdk8ZyCyRD8YLVBeawKsEEZ1Yvj7g7QHZESxGMAfun6r
        S3RQ==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx+ReE5zXU1i255vGQvjM+ToVYx2MGL/3gV0P3t0="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 43.14 AUTH)
        with ESMTPSA id Z0998bu72CsR7Pb
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 2 Aug 2018 14:54:27 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, marek.vasut@gmail.com, richard@nod.at,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org
Cc:     cyrille.pitchen@wedev4u.fr, frieder.schrempf@exceet.de,
        pp@emlix.com, Zhiqiang.Hou@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] spi: spi-mem: Fix a typo in the documentation of struct spi_mem
Date:   Thu,  2 Aug 2018 14:53:52 +0200
Message-Id: <1533214434-28761-2-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533214434-28761-1-git-send-email-frieder.schrempf@exceet.de>
References: <1533214434-28761-1-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 include/linux/spi/spi-mem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 4fa34a2..72cc9bc 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -124,7 +124,7 @@ struct spi_mem_op {
 /**
  * struct spi_mem - describes a SPI memory device
  * @spi: the underlying SPI device
- * @drvpriv: spi_mem_drviver private data
+ * @drvpriv: spi_mem_driver private data
  *
  * Extra information that describe the SPI memory device and may be needed by
  * the controller to properly handle this device should be placed here.
-- 
2.7.4

