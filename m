Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD58C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD7F2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="K42SPqwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbeL0POM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 10:14:12 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:60224 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeL0POK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 10:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aa9a5kkWLzAfKwYkuodPGMPj7HIEaEqbQu15t2kgRwo=; b=K42SPqwx0aA7Kgzrbype0UOXB
        3xksoWJqKDmsXB2rNPH3oSlCum3bqlN2KouvcSTLGg7ChAAr7DA0wibJh/aVV9IBOEMPzQaSMGO/H
        o+E9uAj8hL39AuNwatw3sTyLVs4R6cpjYS5VV8zFM6xACftZWm7iZw6nm39OendHkKrvw=;
Received: from p200300ccfbcbef001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbcb:ef00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gcXMD-0003PR-1e; Thu, 27 Dec 2018 16:13:57 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gcXMD-0007ku-1W; Thu, 27 Dec 2018 16:13:57 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/2] devicetree: hwmon: Add bindings documentation for HIH6130
Date:   Thu, 27 Dec 2018 16:13:49 +0100
Message-Id: <20181227151349.29753-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181227151349.29753-1-andreas@kemnade.info>
References: <20181227151349.29753-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for HIH6130 driver.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 Documentation/devicetree/bindings/hwmon/hih6130.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/hih6130.txt

diff --git a/Documentation/devicetree/bindings/hwmon/hih6130.txt b/Documentation/devicetree/bindings/hwmon/hih6130.txt
new file mode 100644
index 000000000000..2c43837af4c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/hih6130.txt
@@ -0,0 +1,12 @@
+Honeywell Humidicon HIH-6130 humidity/temperature sensor
+--------------------------------------------------------
+
+Requires node properties:
+- compatible : "honeywell,hi6130"
+- reg : the I2C address of the device. This is 0x27.
+
+Example:
+	hih6130@27 {
+		compatible = "honeywell,hih6130";
+		reg = <0x27>;
+	};
-- 
2.11.0

