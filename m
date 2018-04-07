Return-Path: <ctatlor97@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523108858; cv=none;
        d=google.com; s=arc-20160816;
        b=b7TbrNmkIz587ydrIbz+45Ask56sOB+vvwcTTRdX3nlqRiwUuR7FFklF3iPfZi5yAy
         OBjMGe/TLZcVIvhFhgG5wSCqgbO3Pa55tDNJca8Tnb3a74ykAlN+pzL9LJTbzDBLQMIO
         IiK2FXoP0jF7TLJx4ffrHGNOOxp6Ev62oiZd+kiBvwMTOKlulELafEGqiaxzl/FBJrzE
         3CwHU663OmZ92Fb3RR17Hc273ZaZK1GLS0jFMCeLFjkegodGU7Q2BS7QH9UG3pLMSKtV
         2YyvAOxCR77Of2bkDYleadIE6VYLCPYX6oAJHRHPQkc3Wi3FURuWUDSdFmNpf/UQ8KL2
         lh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=27cfSDsvWDdzvwlAft84buSjDfaGQsFTl5134571HQ8=;
        b=qWs7IVdA7YJUvqSH33VBkTAnpYq7S2nRfq9O+N/0VvFBfJkqSRW5Loa0IKlkg+Sgcv
         raSp3xHwmKyTT3cmYSNvp49K0t8IU5CNsl0j0fK5FVwa3yoPB/X9VlHcLZW9I8EZoOnj
         UtVyRqjj8HWS72jU5GlDz/OQCtz7S1MAE9E9m6Rq1Bo7Ge4yzexi5tG7J1hXLrrujOmE
         5EnDfLbX4X2AsmRCrBhDvg1U6wDXPJuA4T4rmZHLm0BuJ2sn6VxhgsK9T9OcP/dxoLwI
         GsD5oPgo1Gm7qzEw2XW9f43pOXUl2pUKfA4F28Ea7T8GXJKPf41wyPZKCXrZJ7zTVeJx
         VU5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QfumJP9a;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QfumJP9a;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49vhXTu8c/iUHZDxL2nRjGgEMyqadcUh3MeSRkMl6gN1WmPyTeWB6w19VNO4S/2s9p5cCpiCA==
From: Craig Tatlor <ctatlor97@gmail.com>
To: 
Cc: ctatlor97@gmail.com,
	linux-arm-msm@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: power: supply: qcom_bms: Add bindings
Date: Sat,  7 Apr 2018 14:46:57 +0100
Message-Id: <20180407134712.23131-2-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180407134712.23131-1-ctatlor97@gmail.com>
References: <20180407134712.23131-1-ctatlor97@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597095394982255487?=
X-GMAIL-MSGID: =?utf-8?q?1597095394982255487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add bindings for the Qualcomm battery measurement system.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 .../bindings/power/supply/qcom_bms.txt        | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom_bms.txt

diff --git a/Documentation/devicetree/bindings/power/supply/qcom_bms.txt b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
new file mode 100644
index 000000000000..6296399edc09
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
@@ -0,0 +1,93 @@
+Qualcomm Battery Measurement System
+
+The Qualcomm Battery Measurement System is found inside of Qualcomm PM8941
+PMICs. It provides OCV and coulomb counter registers that allow the kernel
+to infer a capacity level.
+
+Required properties:
+- compatible:               Should contain "qcom,pm8941-bms".
+- reg:                      Specifies the SPMI address and length of the
+			    controller's registers.
+- interrupts:               OCV threshold interrupt.
+- io-channels:              Should contain IIO channel specifier for the
+			    ADC channel that reports battery temperature.
+- io-channel-names:         Should contain "temp".
+- qcom,fcc-temp-legend:     An array containing the temperature, in degC,
+			    for each column of the FCC lookup table.
+- qcom,fcc-lut:             An array of FCC values in mah, one entry for each
+			    temperature defined in in qcom,fcc-temp-legend.
+- qcom,ocv-temp-legend:     An array containing the temperature, in degC,
+			    for each column of the OCV lookup table.
+- qcom,ocv-capacity-legend: An array containing the capacity for each
+			    row of the OCV lookup table.
+- qcom,ocv-lut:             An array of OCV values in mV, one entry for each
+			    capacity defined in qcom,ocv-capacity-legend.
+
+Example:
+
+		pm8941_vadc: vadc@3100 {
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
+			qcom,fcc-temp-legend = /bits/ 8 <(-10) 0 25 50 65>;
+			qcom,fcc-lut = /bits/ 16 <6010 6070 6680 6780 6670>;
+
+			qcom,ocv-capacity-legend = /bits/ 8 <100 95 90 85
+							     80 75 70 65
+							     60 55 50 45
+							     40 35 30 25
+							     20 15 10 9
+							     8 7 6 5 4
+							     3 2 1 0>;
+
+			qcom,ocv-temp-legend = /bits/ 8 <(-10) 0 25 50 65>;
+			qcom,ocv-lut = /bits/ 16 <4288 4288 4306 4315 4315
+						  4261 4241 4259 4266 4246
+						  4201 4181 4201 4207 4187
+						  4153 4133 4150 4155 4135
+						  4105 4085 4100 4104 4084
+						  4058 4038 4052 4058 4038
+						  4012 3992 4004 4014 3994
+						  3970 3950 3959 3971 3951
+						  3931 3911 3915 3927 3907
+						  3899 3879 3880 3884 3864
+						  3873 3853 3851 3853 3833
+						  3848 3828 3827 3829 3809
+						  3829 3809 3808 3809 3789
+						  3815 3795 3791 3791 3771
+						  3801 3781 3775 3772 3752
+						  3785 3765 3751 3746 3726
+						  3767 3747 3727 3719 3699
+						  3750 3730 3702 3692 3672
+						  3728 3708 3680 3672 3652
+						  3720 3700 3676 3665 3645
+						  3712 3692 3670 3660 3645
+						  3695 3675 3658 3648 3633
+						  3662 3647 3629 3620 3610
+						  3620 3605 3589 3580 3570
+						  3562 3552 3538 3529 3519
+						  3490 3480 3474 3470 3465
+						  3403 3398 3388 3380 3375
+						  3320 3300 3255 3221 3206
+						  3000 3000 3000 3000 3000>;
+		};
+	};
+};
-- 
2.17.0
