Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeCUOak (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:30:40 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40035 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752400AbeCUOac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:30:32 -0400
X-Google-Smtp-Source: AG47ELsO9IbFEFjSIfTAwvB6zpM/yu5xMyDLrHqZ3Jim2fBpAet+jQbdesl2SrXSew6N0WANg4bgZw==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hernan@vanguardiasur.com.ar
Subject: [PATCH 09/11] staging: iio: ad7746: Add devicetree bindings documentation
Date: Wed, 21 Mar 2018 11:28:57 -0300
Message-Id: <1521642539-4845-10-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 .../devicetree/bindings/staging/iio/cdc/ad7746.txt | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt

diff --git a/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt b/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
new file mode 100644
index 0000000..13d0056
--- /dev/null
+++ b/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
@@ -0,0 +1,32 @@
+Analog Devices AD7746/5/7 capacitive sensor driver
+
+Required properties:
+	- compatible: Should be one of
+		* "adi,ad7745": When using the AD7745 device
+		* "adi,ad7746": When using the AD7746 device
+		* "adi,ad7747": When using the AD7747 device
+	- reg: The 7-bits long I2c address of the device
+
+Optional properties:
+	- adi,exclvl: 0 = +-VDD/8
+                1 = +-VDD/4
+                2 = +-VDD * 3/8
+                3 = +-VDD/2 (Default)
+	- adi,nexca_en: Invert excitation output A.
+	- adi,nexcb_en:	Invert excitation output B.
+
+Example:
+Here exclvl would be 1 (VDD/4), Excitation pin A would be inverted and
+Excitation pin B would NOT be inverted.
+
+i2c2 {
+
+      < . . . >
+
+      ad7746: ad7746@60 {
+              compatible = "ad7746";
+              reg = <0x60>;
+              adi,exclvl = <1>;
+              adi,nexca_en;
+      };
+};
-- 
2.7.4
