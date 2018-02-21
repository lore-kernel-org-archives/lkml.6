Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AH8x224ago8sq4wUq+7PRXV21w//z49DWaTyXmSa1OrO0IlPFmIeON5WInCsn04ynJv03dL0vsSY
ARC-Seal: i=1; a=rsa-sha256; t=1519196444; cv=none;
        d=google.com; s=arc-20160816;
        b=ieZWh8Ps4z0cpYIGLbnfTHRqbT7V/ty6K5BB3ep38d20RQm1ZXgM9uUj7gf0VTn59L
         5Zum0U1JGityEo269aOhNplEjmgMC9916rFd3MDHQe+Eu2xQXCMoD7Cy+v3Uk7B8XzaS
         ZZ1vsX48rDuu0+qhboxUXvk9VWdhWphPfVWSsDnGh2y7CI8+7TwX2V63CayQco5rXRtO
         73DgkpmTJ/kR24ZSfYtGhAUJpXtykbC5TsdpuMdSkC68FPXzY4TVWvOXVdSIUdDJMYSd
         CFjis1K5dP87UKKudXgMuWDIwrElh08wf+smfbg//6FvW71SaA5s5ZnZ1ltgdgRWT68M
         E8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=LFZGvbtoYtDWxds+GswChQbG8TvLZuvU9Z6u54Tx5QQ=;
        b=yeNsjiiojrhQKnaD8nPbd4+bECqt477VKgz0zXOfoGYZ0ZE998zezfuvpLbSxsiFPC
         WSvSjHj6cnznmlo1KB9Y9LCGbRlj2YaiXjHxs8II03BE2FJXSJ6aVe6CKZqHlLgogmY9
         1M9rDuKl43SQtgE7PIQpZUWze32+eViQzL3ujEsFa0PNjFJqZ6bU7HVBi7ZbmEx7njys
         eKskv03pPonQt3EHGhAaL1FI0iqHLE7plOOZ/arEbnYk/pKWUIYi24CA5Sj5MMNDDLKf
         heWIjdPSDhtqKq2grBoeNj85/HLQxd/vZzd7aQb8Ot/OUwJj+5x71n9Q2ooxfd4FMiOx
         lCoA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Feb 2018 23:00:43 -0800
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
Subject: [PATCH 08/10] arm64: defconfig: enable Nvidia Tegra Tachometer as a module
Date: Wed, 21 Feb 2018 12:28:57 +0530
Message-ID: <1519196339-9377-9-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992930689642092?=
X-GMAIL-MSGID: =?utf-8?q?1592992930689642092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Tegra Tachometer driver implements PWM capture to measure
period. Enable this driver as a module in the ARM64 defconfig.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 634b373..8b2bda7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -550,6 +550,7 @@ CONFIG_PWM_MESON=m
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_TEGRA=m
+CONFIG_PWM_TEGRA_TACHOMETER=m
 CONFIG_PHY_RCAR_GEN3_USB2=y
 CONFIG_PHY_HI6220_USB=y
 CONFIG_PHY_QCOM_USB_HS=y
-- 
2.1.4
