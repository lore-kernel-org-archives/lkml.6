Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AH8x227aB/Rd9QK3pdHT7Mqsja70jz87VmztEI1cd1OJgIwmifHWcqfxXYcJ5hIQ0DRa62ekOGod
ARC-Seal: i=1; a=rsa-sha256; t=1519196456; cv=none;
        d=google.com; s=arc-20160816;
        b=qE5dPl+Qf9IpUTMMhnRRkjwNdbhEtkFWX/TCMUkvJcmu3tL6QaNSMOkdJBlVtQL5K8
         c1RSdIDVGCoCAG9TjznhSCQCtM19dh1C0NTUAUCO/owdisBTwftjpMBWlDoAUF57vx70
         35o9srA3yEkhYF6mhTNHRI5nvXYVD0JTBHp3ND59GTspwZepdP/3pXC6EyO9DS/VKrGz
         DHqVsp7FJlzgnQWZxGoFZCb+fRMEytXVP1+u3bO0+YKyyDQryEQpfiqLLNGQwEvpxD7k
         Q3wofHiFw8nP9S3Em64a8rwcyjKgFv3q4qkqlahA1gWaD9S4BlRrcW03rhkANgcln1DT
         XuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=GvAqzio6+QRPaNRRfShsCbIdJ/jlOs0b/B8c32IC5Qw=;
        b=ZVgjd5Xk34ISOKJvI/Aybyt9BTdPlFy39M9RN3PCdO8AhqjKZRmH/CN1RXy/rrDXR+
         u/DC85mZ6Sk+iZE6nIUjGQLd6nuShrzP/gbvPYBkiyqXt2tpJ5Po0VWSbedAIxF4/5+q
         O4HWuJcQ0qKjHL15sa/WzcEQ0fe0yEs2PDpiAf60DYRImfFyeI+iqNU8T8NXgFbqF1B0
         Zt85hPuZNzgtI+Jp/KsZP9z8YfeXWlI0hCF7nFWzQhiTf5ca0G+d0szf4u8GUYYaRBCC
         RHVMo6we0xj2t1XX33tKMl3eT4ygqyW7C0z/3k/zGtjzQHEdWKaeVq0ZSlThra6ZNeFI
         HptQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Feb 2018 23:00:54 -0800
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
Subject: [PATCH 09/10] arm64: defconfig: Enable Generic PWM based Tachometer driver
Date: Wed, 21 Feb 2018 12:28:58 +0530
Message-ID: <1519196339-9377-10-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992943149980700?=
X-GMAIL-MSGID: =?utf-8?q?1592992943149980700?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Enable Generic PWM based Tachometer driver which implements a simple
interface for monitoring the speed of a fan in roatations per minute,
and exposes it to the user space by using the hwmon's sysfs interface.
Enable this driver as a module in the ARM64 defconfig.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8b2bda7..1b29109 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -321,6 +321,7 @@ CONFIG_BATTERY_BQ27XXX=y
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_INA2XX=m
+CONFIG_GENERIC_PWM_TACHOMETER=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
-- 
2.1.4
