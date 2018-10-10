Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A529C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598272086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598272086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbeJKAdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:33:23 -0400
Received: from shell.v3.sk ([90.176.6.54]:54181 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbeJKAdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:33:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 90227BCFA8;
        Wed, 10 Oct 2018 19:10:16 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id heItyk6ZBJIb; Wed, 10 Oct 2018 19:10:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D4281BCF9B;
        Wed, 10 Oct 2018 19:09:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TYDpJjB-UXnv; Wed, 10 Oct 2018 19:09:53 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 51E82BCF87;
        Wed, 10 Oct 2018 19:09:52 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 03/11] spi: pxa2xx: Use an enum for type
Date:   Wed, 10 Oct 2018 19:09:28 +0200
Message-Id: <20181010170936.316862-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010170936.316862-1-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That seems to be the correct type.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi-pxa2xx.c   | 6 +++---
 include/linux/pxa2xx_ssp.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 14f4ea59caff..f674541675bb 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1429,7 +1429,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct resource *res;
 	const struct acpi_device_id *adev_id =3D NULL;
 	const struct pci_device_id *pcidev_id =3D NULL;
-	int type;
+	enum pxa_ssp_type type;
=20
 	adev =3D ACPI_COMPANION(&pdev->dev);
=20
@@ -1443,9 +1443,9 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		return NULL;
=20
 	if (adev_id)
-		type =3D (int)adev_id->driver_data;
+		type =3D (enum pxa_ssp_type)adev_id->driver_data;
 	else if (pcidev_id)
-		type =3D (int)pcidev_id->driver_data;
+		type =3D (enum pxa_ssp_type)pcidev_id->driver_data;
 	else
 		return NULL;
=20
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 13b4244d44c1..262e1f318836 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -217,7 +217,7 @@ struct ssp_device {
=20
 	const char	*label;
 	int		port_id;
-	int		type;
+	enum pxa_ssp_type type;
 	int		use_count;
 	int		irq;
=20
--=20
2.19.0

