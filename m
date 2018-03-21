Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELuHHhOJwoa+UI+QkljBZRUIFNXLlQ6xunQx6/FwNEUspUlKkdI0cVtxfI4YZaTuGVglHic8
ARC-Seal: i=1; a=rsa-sha256; t=1521607333; cv=none;
        d=google.com; s=arc-20160816;
        b=iq6/enTUQtJXia0aEZsh2gqEkLm/dJ84jGtcXjLm3kGjLMsv0vHZqSkDchK5NCHp7e
         ZfBOwmlxJtlJgrQew4oukFNirnvKF8IQcyY509759cljUbvR3cJulks8UahXp/52e27z
         EiRDAYrc+JyGxatAxU33ZTr6BLgp5Xs3Qz3U2IVRr9KphoGndGLMvcIuZ9suSooFTSSC
         QqAzVm96gN63zzGOTcjnuZvi1ITj9VsnwuLM0d/1ot7LbttXKif2uUbHc3CNGm0/NIQY
         FXYe8nkvkvT0Dm0y4i8Yvu0c5kGE22CZYa4GEifHS37uQdd9evvpQ1OA6DkEjR77QgDP
         W/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=MtTk59JajEbZBOppSgzQNyLgpXSUDLXgx+zkgz33RT4=;
        b=yQaGe495nyAbFEpeFK0iHlH8BgM7dRPE2X4FCou/yBovsYuM0AbQ1iOQeiN2cEg9Os
         lZsH8v2uQsdB1MWY+ePhZlen/zWd594CD+AsB1kUAGtIaBLxBTOthLJRzwQw7eZMPM2t
         19yhE0e89QkETNNNnjvhcCxN5rrnFFWduIB0fBCm65A4OudMnLpmqHPbi3h/JhjTce7K
         DV3GMa9knNr14SrQT3jfojWljtJ3W2a1w3OzFyH5A2LWHYMkdqZVf8ElYLP4JIvRQKhv
         JB19c4MwumiYzmQHwK0Y+RNhppnEJJQwE2YVj/Aw6/i2ZmKk423i+mTAEwMcwVZZKQEJ
         T56A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Mar 2018 21:42:12 -0700
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
Subject: [PATCH V2 8/9] arm64: defconfig: enable Nvidia Tegra Tachometer as a module
Date: Wed, 21 Mar 2018 10:10:43 +0530
Message-ID: <1521607244-29734-9-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520931528091677?=
X-GMAIL-MSGID: =?utf-8?q?1595520931528091677?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Tegra Tachometer driver implements PWM capture to measure
period. Enable this driver as a module in the ARM64 defconfig.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: No changes in this patch

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
