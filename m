Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELsoQyxd1sDytUv9WAFa6BQIwBqT3UCRPuCzCeHWfhtyMfPOJDPi+69GXGXnJemoI3tnxJiN
ARC-Seal: i=1; a=rsa-sha256; t=1521607275; cv=none;
        d=google.com; s=arc-20160816;
        b=qZSW97/80yd4OWEUQXhvsqv/nAL4y/Lf+IYZNSMN2gLX/mFV83CIGvVjNk+rraQSGL
         /czgwOGHRgki+D6syU8lyZj/2dAVijvgQxOmITDDwaMSDcCgNR+c1bsEp79LXWsmCfvI
         pLB1BbAdFQlW+6XEXB6yM/IXhS1djW0QoGOCGjOcTlUHW09rbwZcm0p8JNll7jZIDUZt
         SGoJjpHVXSl6aa+3bGsqqzHVJHdsTV7h9WQ3kw8PLHzTSk0dNyCA/xmTTflpp1m0ACkV
         kwIK4LzWE8oqSyvtFF8KX2cXZ5UlXUH2U9hBfL0mFsxDSDRCtL1qtTa3iGDtJQLE8FdU
         u0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=pDEoS2pjTLc1mjyNls4/N38Si0s9oQolR31TvPGdDJo=;
        b=hdRKscSFcWhc8oCYWdBG2dkKa8CeAWEEpC7W+QoiGF2oBLDOLV9+HTKljgl8Xfxt41
         12nmlHaB8erh9c9vbWgfS4ckYnJB66x7SwvaHCiDKf1muqjl81mkmw2Ewe0RzaP5SnJm
         5XIJj/ZEoF/zUa2HODy/jOqwhY7JFKHF7RkVZO618t7eo+GmrSGY7RUf+qK+JAczkrai
         q3T0hQxr6sny6vgo+DKyhWPvXV32PqNOlBPWYYch8pU+KYWpnDWjIFvam73kfWh597Gp
         cbP6FG+GfOj2wZlwq1UMqfSlsEZX8mLSgejMoHpp85E7DJEpvqBNvZceeqA7sna7voJ+
         9u5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate102.nvidia.com on Tue, 20 Mar 2018 21:41:10 -0700
From: Rajkumar Rampelli <rrajk@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>,
	<arnd@arndb.de>, <timur@codeaurora.org>, <andy.gross@linaro.org>,
	<xuwei5@hisilicon.com>, <elder@linaro.org>, <heiko@sntech.de>,
	<krzk@kernel.org>, <ard.biesheuvel@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>,
	<rrajk@nvidia.com>
Subject: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree bindings
Date: Wed, 21 Mar 2018 10:10:38 +0530
Message-ID: <1521607244-29734-4-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520871004470026?=
X-GMAIL-MSGID: =?utf-8?q?1595520871004470026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Supply Device tree binding documentation for the NVIDIA
Tegra186 SoC's Tachometer Controller

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: Renamed compatible string to "nvidia,tegra186-pwm-tachometer"
    Renamed dt property values of clock-names and reset-names to "tachometer"
    from "tach"

 .../bindings/pwm/pwm-tegra-tachometer.txt          | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt b/Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt
new file mode 100644
index 0000000..4a7ead4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt
@@ -0,0 +1,31 @@
+Bindings for a PWM based Tachometer driver
+
+Required properties:
+- compatible: Must be "nvidia,tegra186-pwm-tachometer"
+- reg: physical base addresses of the controller and length of
+  memory mapped region.
+- #pwm-cells: should be 2. See pwm.txt in this directory for a
+  description of the cells format.
+- clocks: phandle list of tachometer clocks
+- clock-names: should be "tachometer". See clock-bindings.txt in documentations
+- resets: phandle to the reset controller for the Tachometer IP
+- reset-names: should be "tachometer". See reset.txt in documentations
+- nvidia,pulse-per-rev: Integer, pulses per revolution of a Fan. This value
+  obtained from Fan specification document.
+- nvidia,capture-window-len: Integer, window of the Fan Tach monitor, it indicates
+  that how many period of the input fan tach signal will the FAN TACH logic
+  monitor. Valid values are 1, 2, 4 and 8 only.
+
+Example:
+	tegra_tachometer: tachometer@39c0000 {
+		compatible = "nvidia,tegra186-pwm-tachometer";
+		reg = <0x0 0x039c0000 0x0 0x10>;
+		#pwm-cells = <2>;
+		clocks = <&tegra_car TEGRA186_CLK_TACH>;
+		clock-names = "tachometer";
+		resets = <&tegra_car TEGRA186_RESET_TACH>;
+		reset-names = "tachometer";
+		nvidia,pulse-per-rev = <2>;
+		nvidia,capture-window-len = <2>;
+		status = "disabled";
+	};
-- 
2.1.4
