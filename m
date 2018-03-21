Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELs7lJ+KrPASNKYDGH/Jay7rNgH7tzeGNKeB4oOAes0EsZL6aZRAzdXvZa0FxL2w21neHPhN
ARC-Seal: i=1; a=rsa-sha256; t=1521607349; cv=none;
        d=google.com; s=arc-20160816;
        b=P1rn1/m5R7Bcad7CPZ13mpwIQkMuGcvifQtuntMu6hpr/Qemet5/GhRAmLOHgSVs0U
         hEOZJj/tC97LggpRVzyH4C+nWq2czDWResnfrz8g5dm/pYSvNDphWKE/S1CQl0zI6dR1
         5iimvry9L6SWxguOaridKTvpi3+0ApEueeNxfk9OpslrE+iszSBC0JEHZQhzdMJq0Wvy
         4zxSxEci96WcmPiBOth6VVPqgsyViz9/hSeju6V34JV/k8po7DWqxgam8y9BVKv9kLgr
         TKgnqWWLkwba2ipzWfhGDIl3rq6TO3RpZSLlgCApSJp1ZRlZFzsUnsa91t8rpjNgPPx4
         zPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=cF7rO+sRqwp4Jg+H8s4amQDMaMT6hekinylXglqx3Hg=;
        b=T7Q69lzr+FHGBCaizplxXOLkC9whMaQH5s9GUyFwJvpgwC1FD7vXTHDSNCfxWiqE06
         kfyt1fSdYWA5aERZ1JcpSxmBFyVJmB07Utx8yL3UMDWGfalQBeS57V0d0tMdavfeIFTp
         lbcMwTchAHA4H+0Ljai7s0bQx+2ulEcxskOHny2JZQ4c1oop1I1+M3Tqf6knY60a54I7
         pvsgBfuneXF4lzPjdUVroY0i4RUGqT6/XqveqVBAkEoQ6uEZ2ldH+cO3N904YG7HDS2u
         I4xRAnGFdGrNBKEoVa5Y+Fju8GDbfvv5DY6Dv4xRhRX+kcAYEButwCtQ/R3RQJlHcW0h
         Ju+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Mar 2018 21:42:28 -0700
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
Subject: [PATCH V2 9/9] arm64: defconfig: enable pwm-fan as a loadable module
Date: Wed, 21 Mar 2018 10:10:44 +0530
Message-ID: <1521607244-29734-10-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520948397518341?=
X-GMAIL-MSGID: =?utf-8?q?1595520948397518341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Enable pwm-fan driver to make use of a PWM interface to
read speed of a fan in rotations per minute.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: Added pwm-fan driver support as a loadable module.
    Removed generic-pwm-tachometer driver support which was added as part of v1

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8b2bda7..50aa3bce 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -320,6 +320,7 @@ CONFIG_SYSCON_REBOOT_MODE=y
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_LM90=m
+CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
-- 
2.1.4
