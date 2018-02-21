Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AH8x225eKE2wmGS96+XxWBaTZBm7y0deLo0uYLKFjo3GP1cP+HayvflGmEe5nZObmJ8wvNBkWmXC
ARC-Seal: i=1; a=rsa-sha256; t=1519196467; cv=none;
        d=google.com; s=arc-20160816;
        b=pu0kLVNgGtuaCjCR1dm29qfgudX0Q8SUcvdsJF41PF7Mx+UnoMzPYWvQxvA8QhhkQQ
         kr2NHApJ+LkLVv+Qy3vhdFhCNUXR/RNNVZYJl7ku7XuYgQFnfOeiUdGErqav55t2mCKe
         GlFa8Y3emwvPOXE06W27Wj8dZwOWv93QiS/32y2/d6lTUruxshgiMypNnjVu3os1dK26
         Y9Ynyh0NzaOW0sTHO0X8acWmEaFm4xR7uxY4cvoskHeRe3bdrG03KCtyKLOIaJPxsF1+
         eUM5QWNuWDrtiZkQk392urr3Xo7mssA6ar4KZ0Qi3y5aEzRPksENrsBKT1ukFJu4CWmv
         L2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=mic54XDw61N4vVOQlosKzsEHLBU/WMSs1leRruG2WI8=;
        b=YqRq/8xtMNcW261DDCNKhuTX9TBdanIj9MCnyyqS3TKA+9eU2VUpy40YLYL0N98KOU
         xQr57W3xInqjQzZtCU/xiA2yn3AOoGUSTKO+f/WDGf2v8mS509zyT7esrEiRpHpmGQd4
         PsBn5HqX7rHfF1jBxWgqdFILUnv5SsfxMSs1KkJmbsOg7tQkmev33KrVUqSn59KwS7yV
         MdZMB95upOU2ov/hcBsJjP/S/+23kxhNUbZnyLWWQ/MvQtKIWw0R/en+OjKifFjO9mtG
         tz8hQjVPHq4AWCu/jGZRBI8klXKbLzGZdUrBVK5aXQbYMT0+u8SGLpG0aK5/DByFeeAh
         oUnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Feb 2018 23:01:05 -0800
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
Subject: [PATCH 10/10] arm64: tegra: Add PWM controller on Tegra186 soc
Date: Wed, 21 Feb 2018 12:28:59 +0530
Message-ID: <1519196339-9377-11-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992954689277124?=
X-GMAIL-MSGID: =?utf-8?q?1592992954689277124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The NVIDIA Tegra186 SoC has a PWM controller which is
used in FAN control use case.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 37149e9..c6f154e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1032,6 +1032,17 @@
 		interrupt-parent = <&gic>;
 	};
 
+	pwm@c340000 {
+		compatible = "nvidia,tegra186-pwm";
+		reg = <0x0 0xc340000 0x0 0x10000>;
+		clocks = <&bpmp TEGRA186_CLK_PWM4>;
+		clock-names = "pwm";
+		#pwm-cells = <2>;
+		resets = <&bpmp TEGRA186_RESET_PWM4>;
+		reset-names = "pwm";
+		status = "disabled";
+	};
+
 	tegra_tachometer: tachometer@39c0000 {
 		compatible = "nvidia,tegra186-pwm-tachometer";
 		reg = <0x0 0x039c0000 0x0 0x10>;
-- 
2.1.4
