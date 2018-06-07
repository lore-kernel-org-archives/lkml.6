Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IBQxHpx1GVtDDgAAmS7hNA
	; Thu, 07 Jun 2018 18:13:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 73F21608C1; Thu,  7 Jun 2018 18:13:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0gPbaPW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 36BB6608BA;
	Thu,  7 Jun 2018 18:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36BB6608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936180AbeFGSNz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:13:55 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37443 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933757AbeFGSNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:13:52 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21-v6so14126996lfb.4;
        Thu, 07 Jun 2018 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ns6/WQr67VW0BMC9I8YRPRECvJ1vebAN1ij8bJUxcI=;
        b=m0gPbaPWScoH4udTTtyMi3LKcOv/2Wl3lFG0hYYwK8BCAHS08dXnxB1T5RzaaY4/cN
         mnpbyq07fA2VnpO/vGVA/FdS3lPzn3IDit6Tm0F60ZEe/6DIaPlvjuYCEFE7DiTTBbap
         Ct7+oo3gb3Xoddf3f3kFwIbZ6sXqHHcSEN2OHVz/QT8NYNCA2zG8Bg/Ev8eFMybxxW1U
         9EaE1p8yAD/cYDMc97P/zJ3iZ119IGQCyhNuiupOl0NCHm4XewKJfdOIu43k1C8HSFDb
         zM8TGBPcClQGpspxtRQDc2uaHSTaDrsG4I44mY/BHM+IVs/HW7Tt+RKyHjiGlGxVkb0A
         YxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ns6/WQr67VW0BMC9I8YRPRECvJ1vebAN1ij8bJUxcI=;
        b=jZ00a6b3Lza88Gngd5KPnFuCpN2BK3WXcBqV74GpC0UJpLs6HeW/13XDVSHsNZF5Wm
         RsAd07RR2iXdEWzOOP1lhqZXf0fgC7Jf4cl22HHPTvo2uxMUxyJkR1lo0aIXkQURdPB9
         DM1U/+as0CokeSE2M26vTxRC6YOttYjyOO6/H+y/l73Mk0+7zkXvkwOuciBk4HZ/guDf
         k/MmzG4h5mc+fr+JprSbyBoQa8Zo0skdJwxHZItFW0BCittNN4A5aIK2PkarQmX2dlSj
         Xeq0xYx/tW8tsHEBvLa5wNXwUS2MzwlRjmXrU7b1gBuZcbmDwkFbz7/szUtz39/6wgrA
         Kx5w==
X-Gm-Message-State: APt69E14yyf4rTA1j6kAmY8NVB+OGh40l6zba/lmBl8GM+nSVr2iC83u
        mYHIBL2kNanz5t1ciEwp+w==
X-Google-Smtp-Source: ADUXVKLBSYba0ew9qBTGRPCGwax5jZr6TJlvYq9h0JIW3JU+x5A434jcodeko1gFw5kpV7jvFWfrHA==
X-Received: by 2002:a19:ea1b:: with SMTP id i27-v6mr1906174lfh.98.1528395230232;
        Thu, 07 Jun 2018 11:13:50 -0700 (PDT)
Received: from localhost.localdomain (host81-131-105-100.range81-131.btcentralplus.com. [81.131.105.100])
        by smtp.googlemail.com with ESMTPSA id w4-v6sm3329722ljh.88.2018.06.07.11.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:13:49 -0700 (PDT)
From: Craig Tatlor <ctatlor97@gmail.com>
Cc: ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
Date: Thu,  7 Jun 2018 19:12:51 +0100
Message-Id: <20180607181306.9766-3-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180607181306.9766-1-ctatlor97@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180607181306.9766-1-ctatlor97@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Qualcomm Battery Monitoring system.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
* Changes from v4:
  Uses proper units and expands some definitions,
  along with changing vadc@ to adc@.

 .../bindings/power/supply/qcom_bms.txt        | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom_bms.txt

diff --git a/Documentation/devicetree/bindings/power/supply/qcom_bms.txt b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
new file mode 100644
index 000000000000..a1a32d6ab460
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
@@ -0,0 +1,91 @@
+Qualcomm Battery Monitoring System
+
+The Qualcomm Battery Monitoring System is found inside of Qualcomm PM8941
+PMICs. It provides open circuit voltage (OCV) and coulomb counter registers
+that allow the OS to infer a capacity level.
+
+Required properties:
+- compatible:                   Should contain "qcom,pm8941-bms".
+- reg:                          Specifies the SPMI address and length of the
+				controller's registers.
+- interrupts:                   OCV threshold interrupt.
+- io-channels:                  Should contain IIO channel specifier for the
+				ADC channel that reports battery temperature.
+- io-channel-names:             Should contain "temp".
+- qcom,fcc-temp-legend-celcius: An array containing the temperature, in degC,
+				for each column of the full charge capacity
+				lookup table.
+- qcom,fcc-lut-microamp-hours:  An array of full charge capacity values in uah,
+				one entry for each temperature defined in in
+				qcom,fcc-temp-legend-celcius.
+- qcom,ocv-temp-legend-celcius: An array containing the temperature, in degC,
+				for each column of the OCV lookup table.
+- qcom,ocv-capacity-legend:     An array containing the capacity for each
+				row of the OCV lookup table.
+- qcom,ocv-lut-microvolt:       An array of OCV values in uV, one entry for each
+				capacity defined in qcom,ocv-capacity-legend.
+
+Example:
+		pm8941_vadc: adc@3100 {
+			compatible = "qcom,spmi-vadc";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			bat_temp {
+				reg = <VADC_LR_MUX1_BAT_THERM>;
+			};
+		};
+
+		bms@4000 {
+			compatible = "qcom,pm8941-bms";
+			reg = <0x4000>;
+			interrupts = <0x0 0x40 0x4 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ocv_thr";
+
+			io-channels = <&pm8941_vadc VADC_LR_MUX1_BAT_THERM>;
+			io-channel-names = "temp";
+
+			qcom,fcc-temp-legend-celsius = /bits/ 8 <(-10) 0 25 50 65>;
+			qcom,fcc-lut-microamp-hours = <3230000 3260000 3380000 3410000 3360000>;
+
+			qcom,ocv-capacity-legend = /bits/ 8 <100 95 90 85 80 75
+							     70 65 60 55 50 45
+							     40 35 30 25 20 15
+							     10 9 8 7 6 5 4 3 2
+							     1 0>;
+			qcom,ocv-temp-legend-celsius = /bits/ 8 <(-10) 0 25 50 65>;
+			qcom,ocv-lut-microvolt = <43050000 43050000 43030000 42990000 42950000
+						  42770000 42570000 42550000 42510000 42310000
+						  42180000 41980000 41970000 41920000 41720000
+						  41590000 41390000 41450000 41400000 41200000
+						  41010000 40810000 40920000 40890000 40690000
+						  40480000 40280000 40440000 40420000 40220000
+						  40040000 39840000 40010000 39980000 39780000
+						  39620000 39420000 39550000 39560000 39360000
+						  39210000 39010000 39090000 39160000 38960000
+						  38830000 38630000 38740000 38790000 38590000
+						  38550000 38350000 38440000 38430000 38230000
+						  38310000 38110000 38230000 38180000 37980000
+						  38190000 37990000 38040000 38000000 37800000
+						  38060000 37860000 37900000 37840000 37640000
+						  37890000 37690000 37770000 37660000 37460000
+						  37720000 37520000 37560000 37450000 37250000
+						  37480000 37280000 37290000 37250000 37050000
+						  37240000 37040000 37020000 36990000 36790000
+						  37030000 36830000 36730000 36700000 36500000
+						  36940000 36740000 36670000 36640000 36440000
+						  36850000 36650000 36600000 36590000 36390000
+						  36750000 36550000 36520000 36550000 36350000
+						  36690000 36490000 36380000 36400000 36200000
+						  36460000 36260000 36180000 36120000 35920000
+						  36080000 35880000 35680000 35640000 35440000
+						  35510000 35310000 35050000 35020000 34820000
+						  34730000 34530000 34300000 34250000 34050000
+						  33870000 33670000 33040000 32820000 32620000
+						  30000000 30000000 30000000 30000000 30000000>;
+		};
+	};
+};
-- 
2.17.0
