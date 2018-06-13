Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EEEEAC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EA2208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSQ9bHNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EA2208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934250AbeFMQIK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:08:10 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45190 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935042AbeFMQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:08:03 -0400
Received: by mail-pf0-f194.google.com with SMTP id a22-v6so1657489pfo.12;
        Wed, 13 Jun 2018 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ykpUq9dGpbWI8vy0HcfjSUmwylFnC/Wij4GjPWjU48=;
        b=LSQ9bHNmXI+2h9EkX9Cg82EauSeN7lcZf/feLrRSAPmfPMHlCC5OpzSlRHBNe8sLJM
         JXlXZxdniipfwOO0McS7C/EVl38PKS9GPYFBiD2jh5ZROt8/3F7mU0gXYlBQYJ8NBCve
         f4Uq5QaEblbpDuDyGS5b5gXNR1zh8unA5DMZO0HVwbJTEszW7iJSAGHw8t8V6KIh/Klk
         mCvLBqzy4w+skWJ/5xVmrPgA7lItUzknoWzCQS8kfRPHkUDlHUjFrh1iJiR3yDoiha/m
         yOT5ynJIp7ugN0l2jEPzJtXJKFFlPq+GtI10zNEkew5ZLd+wVt4pvdkjk6VPMVHeli7H
         CUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ykpUq9dGpbWI8vy0HcfjSUmwylFnC/Wij4GjPWjU48=;
        b=Qky+rz6JKfVYquih8/4zBl08Ue6kmhr/Jz5IIwOukCh+iJvgTmBIKUODwa0hPCaxfz
         LYMhfjtu2eBr4pctIGQIhhsiXq5261huBUHBErjQBIcTU1lx4RgKN3L1ovG0RnQ2yIzW
         iatMIetGY+Xzh4DCmE3CK/x5aj4xva2JciXBSnBQ+tfi7ZNEtufB5sAmxX4FFHAcuCBy
         6tLYSxIdPiZ4WaXRhbCnjCLWu9hZ20fakL7yMxRCOw6vVY0cGiWaWvjoQeQtMzgVnaIy
         T6akp8x/ug8MI66ZGl8fGjRWv+2+N14kbN8/WtShDKBKZJ216EBwBVZ8K1ghoeWrM8c3
         E2gQ==
X-Gm-Message-State: APt69E01uWxcaxHs16n/Cfyh8d8vFK2lehW3as6T2FDxQJJCVyYfot59
        0TiXITUlkevMMeRdBhCe0g==
X-Google-Smtp-Source: ADUXVKLuTopDPoKy3CulzmaHN2CnEXVnEKNlukySNzPW1o43pZU5ShINRzFjBKfryhAu4oYOUqSpZA==
X-Received: by 2002:a63:78c6:: with SMTP id t189-v6mr4556032pgc.239.1528906082517;
        Wed, 13 Jun 2018 09:08:02 -0700 (PDT)
Received: from localhost.localdomain (host81-131-105-100.range81-131.btcentralplus.com. [81.131.105.100])
        by smtp.googlemail.com with ESMTPSA id z19-v6sm4459577pfe.163.2018.06.13.09.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 09:08:02 -0700 (PDT)
From:   Craig Tatlor <ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
Date:   Wed, 13 Jun 2018 17:06:24 +0100
Message-Id: <20180613160643.12638-3-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180613160643.12638-1-ctatlor97@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180613160643.12638-1-ctatlor97@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Qualcomm Battery Monitoring system.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---

* Changes from v5:
  Mentions which values are 8 bit.

* Changes from v4:
  Uses proper units and expands some definitions,
  along with changing vadc@ to adc@.
 .../bindings/power/supply/qcom_bms.txt        | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom_bms.txt

diff --git a/Documentation/devicetree/bindings/power/supply/qcom_bms.txt b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
new file mode 100644
index 000000000000..9a29a2eb9f04
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
@@ -0,0 +1,92 @@
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
+- qcom,fcc-temp-legend-celcius: An 8 bit array containing the temperature,
+				in degC, for each column of the full charge
+				capacity lookup table.
+- qcom,fcc-lut-microamp-hours:  An array of full charge capacity values in uah,
+				one entry for each temperature defined in in
+				qcom,fcc-temp-legend-celcius.
+- qcom,ocv-temp-legend-celcius: An 8 bit array containing the temperature,
+				in degC, for each column of the OCV lookup
+				table.
+- qcom,ocv-capacity-legend:     An 8 bit array containing the capacity for each
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

