Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELuYY0hfXxUxDUpn7MaolmCksTToyw1f3lZk9jAtqJO5mpaBUemZ1+VFI9oWtN0shON8y3Lc
ARC-Seal: i=1; a=rsa-sha256; t=1521607263; cv=none;
        d=google.com; s=arc-20160816;
        b=ZzN9lirmPXsfcBXESgYFl+69+tK8bs+fZZ/W8YvlMic68BwNpkfvaTsmTzqZeh46Ya
         4BMieVeYwt0AgaGJI2KV7Gg/PBDGNmroF+/gxRKfVp7jZvaILZpUSH80brfPbTT6FnmY
         eyU7VE+vgJkrx4YuNqnGIYCi5oCV3bD5oRAhdSd0wuIQpKuOJF45YCmJiS/ytKlLt8SX
         Q9cSGW6Rdq4hS1BmcazfKqDZlTXkOw3ij0g6Ypf85RXrESRmOaNCXGCRHkaF4E9PTlaA
         vM9OVZ/k9PYzojvzSU2hLbSaDjUlxPCCx+zfZWacGUCe0WFQTebJd1T0i6bGLFhBFdYG
         3DZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=hJmzDEkv7SrhWCv0nJDRB7ZY16gUIx1/FSLG1mnAJak=;
        b=QidVtfxrTUl9N8qVrof1kc4UqAVl9aECYNozO7ZdGLsAtqvSV8P5Wbpn2jagr5IyWi
         3IMi3JI20Vip5HtgJQ/PueiOuYu6S4qeVtnhyAc2qX8oIy9Nkz4TOUawEuPz1gDB9ByO
         mV60ZJahk7zP9ps3LAIEVER/1GBU+deawnhBrjqCQ1og7QoCm/ooMiR9GKrsJwDvKANb
         ST1DxM+YqpUTmRyuq+vxzwUoheNvVyuNJbaBpf7C0iUCRZ16UB072UPLmJUtin/MrXEv
         ODBSP1srAWUO9w5++AC1pbYQvlLVYPRI/3MmoCCW7cHfBDeDaSKvP/Q1w8SPrCpss2Kg
         fEtA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Mar 2018 21:41:02 -0700
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
Subject: [PATCH V2 2/9] arm64: tegra: Add PWM controller on Tegra186 soc
Date: Wed, 21 Mar 2018 10:10:37 +0530
Message-ID: <1521607244-29734-3-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520858346049354?=
X-GMAIL-MSGID: =?utf-8?q?1595520858346049354?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The NVIDIA Tegra186 SoC has a PWM controller which is
used in FAN control use case.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: no changes in this patch

 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index b762227..731cd01 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1031,4 +1031,15 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&gic>;
 	};
+
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
 };
-- 
2.1.4
