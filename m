Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD205ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453A62084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453A62084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbeGRHIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:08:39 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:57207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbeGRHIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:08:39 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.32.110]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0MUEy2-1fWI3a0Ymw-00QxTn; Wed, 18 Jul 2018 08:32:20 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 3/3] net: qca_spi: Fix log level if probe fails
Date:   Wed, 18 Jul 2018 08:31:45 +0200
Message-Id: <1531895505-26971-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531895505-26971-1-git-send-email-stefan.wahren@i2se.com>
References: <1531895505-26971-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:yKn9e5cbJfk7eo2MEC4fFsBjcqAv8I3D8RvyA5A70nDcNhekrYc
 rt92yiFWm6diu2LD7yOmZhF0WuinQNUG3eUqLOhiFvEZ6EmnW5a6+77njDQdqWKYn32+aHk
 k2A3/1kMlbO/QOymrMK7z78mRkIelUZ5HY09+whZaJ+7w5SL87dBTb3smw62Sp9cGU4AGyP
 v1J7Zym7okFPuBQJOt4PQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OWFjPRqSxhg=:a83b0TMPWsvZbvEYtuKI3/
 gp9sm0BTCtZXIMovuFf4RWhemwiOjK5hg4ifX6bmXsBumi0jF/2V7OqL0o/MHrAci2n3iVPIm
 D/TaxRKR912DuBVpyays022y9lEMmZyvOQw5k6p5emcWmEyQ+7gN+66Uf0KUPFIzedhm37WXy
 dEB6UuF1ioUWXFZfj3IiDdCpzrOuCgkN0Ixr1FQgnTLTAY7oX42p1sGZTYqjJIAs5dpqqExm2
 BM4V4mzxmPdHX3ztokbFBiBznHYfqjbA4tNL/rCNbLAv9amqqj4tfhXdXRkIRobauyxZZHj1K
 E78nODxFkPq98S9FT8Hl7mm41RRdJ1waCGXrt5IXG0xKNMqX5fC7TFB3LqbkzVl/qCIVSIU/P
 zCNr+7D217a7BwF+Q7wiUgVmbbY9qtNc9P1V8fAhOsr05Cj3uvVa97+v57X1vABlzFsBfh6zx
 tZ5UXlwUv/+bEfUAYZhP2JHLHhvakkQM9P8N6QKfgPxpIMSpX+EU+aTnCb/CBfx0jIvXJNy15
 1sVsPNnPTqIuZNlqgHAzDPUdlUDHDOhFY1gB4S2YqTA5KSJ+jdYyQioFQUKsTPtl9SZxuK17V
 4ri5kFfCUl2mx87WG7PWgsudIGz5lauMydttPHWK+Mp+QCjbcaXtXD8uSh3YBmLUAxnEcdCPC
 SpGN8xpAe70/LILD7fWTyyFpDrYn9LbADgGZFvN9nXoTazXZHZ8piJaqPPLSOwK2VoMk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases the probing fails the log level of the messages should
be an error.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/net/ethernet/qualcomm/qca_spi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 7fa815d..206f026 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -881,22 +881,22 @@ qca_spi_probe(struct spi_device *spi)
 
 	if ((qcaspi_clkspeed < QCASPI_CLK_SPEED_MIN) ||
 	    (qcaspi_clkspeed > QCASPI_CLK_SPEED_MAX)) {
-		dev_info(&spi->dev, "Invalid clkspeed: %d\n",
-			 qcaspi_clkspeed);
+		dev_err(&spi->dev, "Invalid clkspeed: %d\n",
+			qcaspi_clkspeed);
 		return -EINVAL;
 	}
 
 	if ((qcaspi_burst_len < QCASPI_BURST_LEN_MIN) ||
 	    (qcaspi_burst_len > QCASPI_BURST_LEN_MAX)) {
-		dev_info(&spi->dev, "Invalid burst len: %d\n",
-			 qcaspi_burst_len);
+		dev_err(&spi->dev, "Invalid burst len: %d\n",
+			qcaspi_burst_len);
 		return -EINVAL;
 	}
 
 	if ((qcaspi_pluggable < QCASPI_PLUGGABLE_MIN) ||
 	    (qcaspi_pluggable > QCASPI_PLUGGABLE_MAX)) {
-		dev_info(&spi->dev, "Invalid pluggable: %d\n",
-			 qcaspi_pluggable);
+		dev_err(&spi->dev, "Invalid pluggable: %d\n",
+			qcaspi_pluggable);
 		return -EINVAL;
 	}
 
@@ -958,8 +958,8 @@ qca_spi_probe(struct spi_device *spi)
 	}
 
 	if (register_netdev(qcaspi_devs)) {
-		dev_info(&spi->dev, "Unable to register net device %s\n",
-			 qcaspi_devs->name);
+		dev_err(&spi->dev, "Unable to register net device %s\n",
+			qcaspi_devs->name);
 		free_netdev(qcaspi_devs);
 		return -EFAULT;
 	}
-- 
2.7.4

