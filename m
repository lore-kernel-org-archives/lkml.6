Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09845C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E4D217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="N57EjDTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfBZPCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:02:36 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39325 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBZPCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:02:36 -0500
Received: by mail-ed1-f66.google.com with SMTP id p27so10997058edc.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 07:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3ZkxLHdisqPpY2rCIjfhitPW7Q3/erE1IBcwy1ug3A=;
        b=N57EjDTT4jv74HYsvVdn0YoQrSI8jsneRuuMsN6wLTVx4XXW9/ZQSttVz9WJgdYT9G
         q1yniE/YdnI7DbL1Af9ykPTMnKNAcgAWkl7GGVE3GMOLilSwAZoDWKY3Yf3ulAOxvsAI
         Uy0k+TSCsrHxJy+zdPayI0QwvrjHD1+X24gWYvjFPKNzS7SrOfaoGqVFFNVY1SLIRsMJ
         75FLHaqjMHiccfpn+y3I0IOZ/mJqh47w9CBfU8hsQS4646atkA3a9RehFmPhW055lqOZ
         RFnCeQvX9pDUVJN26Iu61WGaMRk3FycLiyDhzk7lHlEqaI9US155gOIadThzw7BVRgnA
         jDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3ZkxLHdisqPpY2rCIjfhitPW7Q3/erE1IBcwy1ug3A=;
        b=ui5JHkTcv+p7O/ykgUWih4dz2m0kufroUc6wwX6cu7q5OzeMUY5B94LOh7afViInbr
         G8pqIi5RHNx+pdIqTshnGOm62h6iWjFB1+myjbce8lxK2icVFKTbNdATqVSC06fyg/3V
         VMKND3Vo+3khaznAE80v894e5pQNzJ2H5z+lwE1YXD4rBEL/L1K141sZi/9r/1eQ5Gsj
         IH6bnD+Evu70p5nIol1BS912IVVwALQaaqsDMjquMZ0vWbo2AynhnxPcJCr+tludfNUe
         Jfg7xCuOdg91ySGXKafs463X6zH13ukvmkeAuQZ/yKoncSHvoJOpzQi6L+VkGLnhq2Lv
         mhqQ==
X-Gm-Message-State: AHQUAualZ7cY7cF9PaNG5zHXB7fcuw9G6/eqyPZo3IAib3sFWmwO9LXw
        BktLpYisKjtiD2DAUVCQKjbwIw==
X-Google-Smtp-Source: AHgI3Ia/67D5PYvuK/XfqdBzRwZUcfOPzs1Em1orj/0sEPBmaOXPI1YUF5+W+gFd+9L0AoGPFugt/A==
X-Received: by 2002:a17:906:4e98:: with SMTP id v24mr17465641eju.58.1551193354179;
        Tue, 26 Feb 2019 07:02:34 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id x45sm3521308edb.42.2019.02.26.07.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 07:02:33 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v5 1/2] iio:temperature:max31856:Add device tree bind info
Date:   Tue, 26 Feb 2019 16:02:13 +0100
Message-Id: <20190226150214.19467-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>

This patch added device tree binding info for MAX31856 driver.

Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
Changes
v1 -> v2
[Matt
 - Removed comment block and added possibilities of
   thermocouple type in device tree binding doc.

v2 -> v3
 - Rebased

v3 -> v4
 - Removed one-shot property related information.
 - Used standard name 'temp-sensor'

v4 -> v5
[Patrick
 - Rename thermocouple type to maxim,thermocouple-type for DT entry
---
 .../bindings/iio/temperature/max31856.txt     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/max31856.txt

diff --git a/Documentation/devicetree/bindings/iio/temperature/max31856.txt b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
new file mode 100644
index 000000000000..b4396069b8fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
@@ -0,0 +1,29 @@
+Maxim MAX31856 thermocouple support
+
+https://datasheets.maximintegrated.com/en/ds/MAX31856.pdf
+
+Required properties:
+	- compatible: must be "maxim,max31856"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: As per datasheet max. supported freq is 5000000
+	- spi-cpha: must be defined for max31856 to enable SPI mode 1
+	- maxim,thermocouple-type: Type of thermocouple (By default is K-Type)
+		0x00 : TYPE_B
+		0x01 : TYPE_E
+		0x02 : TYPE_J
+		0x03 : TYPE_K (default)
+		0x04 : TYPE_N
+		0x05 : TYPE_R
+		0x06 : TYPE_S
+		0x07 : TYPE_T
+
+	Refer to spi/spi-bus.txt for generic SPI slave bindings.
+
+ Example:
+	temp-sensor@0 {
+		compatible = "maxim,max31856";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		spi-cpha;
+		maxim,thermocouple-type = <0x03>;
+	};
-- 
2.19.1

