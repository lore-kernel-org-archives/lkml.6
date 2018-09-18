Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6913DECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAB621471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAB621471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbeIRPGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:06:49 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53143 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729650AbeIRPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:06:48 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42DyWl63Znz1qwwF;
        Tue, 18 Sep 2018 11:34:59 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42DyWl57VHz1qr2Y;
        Tue, 18 Sep 2018 11:34:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id hZq7Dylz8JCJ; Tue, 18 Sep 2018 11:34:58 +0200 (CEST)
X-Auth-Info: rsVpbuj/3Npz3LsVjZx+PJVvQVZeitB3ryYtOsO6s7Y=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 18 Sep 2018 11:34:58 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 1/3] dt-bindings: spi: Provide bindings for fsl dspi working in slave mode
Date:   Tue, 18 Sep 2018 11:34:35 +0200
Message-Id: <20180918093437.26799-2-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180918093437.26799-1-lukma@denx.de>
References: <20180918093437.26799-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit provides the description of new property: "fsl,spi-slave-mode"
which enables support for DSPI driver working in slave mode.

As the new compatible shall be used with SPI bus equipped with master
device a new "spidev" based node has been introduced to avoid confusion.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index 18eeafe359d8..b30af19a2bc5 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -26,6 +26,7 @@ Optional SPI properties for slave nodes:
 - fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping the clock
   signal and deactivating chip select, at the end of a transfer.
 - bus-num : the slave chip chipselect signal number.
+- fsl,spi-slave-mode: if present, controller runs in slave mode.
 
 Example:
 
@@ -56,6 +57,13 @@ dspi0@4002c000 {
 		fsl,spi-cs-sck-delay = <100>;
 		fsl,spi-sck-cs-delay = <50>;
 	};
+
+	spidev3@1 {
+		compatible = "fsl,vf610-dspi";
+		spi-max-frequency = <30000000>;
+		reg = <1>;
+		fsl,spi-slave-mode;
+	};
 };
 
 
-- 
2.11.0

