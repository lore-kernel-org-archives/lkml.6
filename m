Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELtGyM9OQJbNT5qdRiD8viWlSmVoL6ZYHVQrq58XN+tdUHTH53o4QGyCkPwDFRjbXkV8c30M
ARC-Seal: i=1; a=rsa-sha256; t=1519196380; cv=none;
        d=google.com; s=arc-20160816;
        b=FVhYRe0zCsOnv7BoFrhNFXVha8iejkDeQTeTXWB2hbb0R9YM6zd2dRi/mI6gadE3qL
         4WM3t0GU63LPBkEL6Jbmu2ntJYAeR7tYEbxfxtRz7ChvnJylU2jc0CpFV6oI7ug7/r9s
         rmgT+wcwCSpTnZPGmIidVm2HWrTmIOgpnfkHuB0HiCPGXdrtHx/+32g28xT71iYPhf3b
         qH3FbmPSSGs2XKzJpO588rgaWrZe2BmHVp8kdNrtKZRSBoFVFveekGolQY80uUZ1UQ64
         YuAkIca/1NJEhkEY1TcEBhAogTleBQLzNlkpB8fNugx/H5S6G1X90tBL61xZrSxcWewm
         ehMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=GRuCgM09V3EDVYBgNx7hUgZc0TAkwLNljd/WjUgsMMg=;
        b=mZfbXSapEhTMnsw9oabiLfItDiZ6YTUK2vOSyxwtCvGUGemHiozZ/cZPF/zZCq/dyP
         nBIQhm6M2CCasJw5BiiVIMEXV4+GTrESoXWI68K4daelXIsTfmdcudWP170XJL+vfdDZ
         42cGNliwkdOMTYwk8Z+xUnOzgWztI0TA9UvoHSk/UIxc8QI3GBPZRJl037M2LwP2PGSk
         9cjWivT0JWWhEY6vf/4SAvCu1A46zG9SIlDomtozva2xkohAR/GxVVsdDojzkEnOFsnh
         jlmooGc89y/Wks7gwyKJzmm8ZF7AASVHM7vTqahN1YTtyWVX4ZDS4p0879CXGqD19r6m
         SKeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Feb 2018 22:59:38 -0800
From: Rajkumar Rampelli <rrajk@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>,
	<arnd@arndb.de>, <gregory.clement@free-electrons.com>,
	<timur@codeaurora.org>, <andy.gross@linaro.org>, <xuwei5@hisilicon.com>,
	<elder@linaro.org>, <heiko@sntech.de>, <krzk@kernel.org>,
	<ard.biesheuvel@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>,
	<rrajk@nvidia.com>
Subject: [PATCH 02/10] dt-bindings: Tegra186 tachometer device tree bindings
Date: Wed, 21 Feb 2018 12:28:51 +0530
Message-ID: <1519196339-9377-3-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992863655359191?=
X-GMAIL-MSGID: =?utf-8?q?1592992863655359191?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Supply Device tree binding documentation for the NVIDIA
Tegra186 SoC's Tachometer Controller

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---
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
