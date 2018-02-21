Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AH8x225lROdWH7T5I9DXJzNTg7LFD6arslzK3CjD1jIM/ETQ45V0pTwsTyOVh1wujw1oicrG+Yve
ARC-Seal: i=1; a=rsa-sha256; t=1519196423; cv=none;
        d=google.com; s=arc-20160816;
        b=J352J9mYQWk+SYmggft0Z9ehryWNaA0/GKsD8Hz25UG+JRxRxYI0ohqOxfDyZWl2/E
         aqXjQQcQ4SbYLCMBViEKAmployl7dsN50aZBKwOvaudZYdfzb3NNSQ2Ss/xIe2TKIa4I
         NNaqLpfpSY8i8IIP8ocG0LclTtBEn6IXpLu5GwQmqoYo8G+IMU8Z8wpuaYOI+8S2eI4S
         igHJX0eCCDYSRfeH72N6w0PWNput1WxQ1OD9GS4u2haiO23l39JNpeSEkWY9HK63fiEL
         X6lUU9yfe1KiIjHZ9nZeGjH++8Uk0a6oKgA1SUh/CDY18KZczFNjgCudOp2Yfvr91pQ8
         ZGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=PyK3N3I3jFVv3LwVXAan44NRFfJtHC66jZZkcraMgm4=;
        b=N3sMSL8xLYT5NGSKXgRBvfINpqXObUbK9qey53//HFCHzMtND99F6wGPVAa5iCtX3Z
         vFr9dUCuXHmfoJ5hJbBUgr7aTBUvphFoSin4KfhdccUSAN822rkw9RCea2/yQThmORHu
         A+TCJh5o//Y1S0Vhl81I576UhOptTY1Gu88sFjn2f9MCXSnvD2l1zHKfYmBLt3DLUrQQ
         28XlC0U2nu4X4pRzBxF37C3K13XvVDMJlsH11SM5aMtjzLJGlXYbdzB+JcY/SFpHCL68
         zmMbixS9jjp1GRQJrXTRtrVjqi1G+J7hYBsDrZSzAA0V3UQ25C164yh+mmYjryrU1Yam
         448w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Feb 2018 23:00:22 -0800
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
Subject: [PATCH 06/10] arm64: tegra: Add Tachometer Controller on Tegra186
Date: Wed, 21 Feb 2018 12:28:55 +0530
Message-ID: <1519196339-9377-7-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992909578156623?=
X-GMAIL-MSGID: =?utf-8?q?1592992909578156623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The NVIDIA Tegra186 SoC has a Tachometer Controller that analyzes the
PWM signal of a Fan and reports the period value through pwm interface.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |  5 +++++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index bd5305a..13c3e59 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -172,4 +172,9 @@
 			vin-supply = <&vdd_5v0_sys>;
 		};
 	};
+
+	tachometer@39c0000 {
+		nvidia,pulse-per-rev = <2>;
+		nvidia,capture-window-len = <2>;
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index b762227..8f2d598 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1031,4 +1031,15 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&gic>;
 	};
+
+	tegra_tachometer: tachometer@39c0000 {
+		compatible = "nvidia,tegra186-pwm-tachometer";
+		reg = <0x0 0x039c0000 0x0 0x10>;
+		#pwm-cells = <2>;
+		clocks = <&bpmp TEGRA186_CLK_TACH>;
+		clock-names = "tachometer";
+		resets = <&bpmp TEGRA186_RESET_TACH>;
+		reset-names = "tachometer";
+		status = "disabled";
+	};
 };
-- 
2.1.4
