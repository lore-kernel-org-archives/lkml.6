Return-Path: <hernan@vanguardiasur.com.ar>
ARC-Seal: i=1; a=rsa-sha256; t=1523637535; cv=none;
        d=google.com; s=arc-20160816;
        b=F/tEUD9T5fV/eQjgCiSJT0CH/ljXiLYJLVWbWzq0mRjubRrmvloUqwQ1y9khPC1heY
         twXLAigxje+Hbg5ZLsMK6yGitbtpRkgO3u3XOcjPy7tZmzDbN2xFs24JtSzYqFRoszbP
         Yw4jXmSYuuINLBA/7an5fOfRDoFXxJ8IFunSMGl2RFJ/MOFrAvolhkkduy1iHUmdYHGN
         tTtbk4T6JToOoW26ovmwnDnZxd9sCVEistcgXfbgy9Bw7/QvBXdvkWiCJ6TRKufJONmR
         SJ1nIyViLhiEEXBPo0bq5hSCmwy+mw0PRAdG0+xH/naf0Jt0INV/hR9A1ltWOBOMKsOu
         jExw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=fqad0JL1kL3pMkYu/Qj9OQPHjEDBrQkDFE7DHln+X4w=;
        b=h9vE8IZkBplXnz10aZJEekRXrGjh6XOO44PczelkmP7xSXTAYeEdcQt2uMrfNLA+px
         fMUMVs911kQHDuug1z3SHpubAINR/waS1QitYQKI2zH2aSXTTrmmj8DV1r7uivK25Yuf
         9qrpc9T1+MwDS2aTVW8kpN/xlGp1FpavYz03Etqvyc1p0WQuTIezsIqNOBNpX2GcP79t
         /2R6HHzK6uI2bw2d74g8S3IOnCGRpTmrOE7tWel6sk4yBmLoFROR7gBlbj7m/Bhr/xkh
         9B+eoIjZTbOvAHMuhwcwILdgBROzVTmr3XQk9cRTEoRaSelJH5VUelUuWmLSLLW8CwSe
         eZcg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=CGner4T2;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
Authentication-Results: mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=CGner4T2;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
X-Google-Smtp-Source: AIpwx49PTu3qpPxKPO7/wZGSoPWAhmCd+zxKWgFmXAUsnT322lG0t1WWYJ5ExMFai0WC9K0Dqdl/iQ==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org
Subject: [PATCH v2 11/14] staging: iio: ad7746: Add devicetree bindings documentation
Date: Fri, 13 Apr 2018 13:36:48 -0300
Message-Id: <1523637411-8531-12-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649752365907922?=
X-GMAIL-MSGID: =?utf-8?q?1597649752365907922?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 .../devicetree/bindings/staging/iio/cdc/ad7746.txt | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt

diff --git a/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt b/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
new file mode 100644
index 0000000..7740f05
--- /dev/null
+++ b/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
@@ -0,0 +1,34 @@
+Analog Devices AD7746/5/7 capacitive sensor driver
+
+Required properties:
+	- compatible: Should be one of
+		* "adi,ad7745"
+		* "adi,ad7746"
+	  * "adi,ad7747"
+	- reg: The 7-bits long I2c address of the device
+
+Optional properties:
+	- adi,exclvl: This property defines the excitation voltage level for the
+    capacitance to be measured. Possible values are:
+      * 0 = +-VDD/8
+      * 1 = +-VDD/4
+      * 2 = +-VDD * 3/8
+      * 3 = +-VDD/2 (Default)
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
