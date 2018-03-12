Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELssS/4yWgWnZ4r25023GXDvCXvfXzSjtPXiOygzKyKZmufyTQCYhswgIOxH+AWdIE+p7DL9
ARC-Seal: i=1; a=rsa-sha256; t=1520848377; cv=none;
        d=google.com; s=arc-20160816;
        b=mzrx8yL5rUA+SdZZd/XdzLpAcg+W4QEl8cb3X2ofv+fVtB+8bcsZX6Ks5OlOUt1Y23
         3yQz3XYJjqI98KfUzB9piOgico/9I2eRbLZS/v6kv8TJ2uAfgcv/j4Q0j3jz1f3DjeeQ
         vLYMW4hkvb+FThEJCREr8zNawtTvLxl9ExFQ1JTIkRGxdnI8tiXbf3MtAI3Ten9wKy/S
         vHsAqegYU0F+SJ/iHQM87QBVfB35cNf+VlciaUBGvfoLXR3c/2cS8FKolevn2uIPrZh/
         iihouSM4vTWhdcECA9V8QvnVlgnwMvq8n5nPYcSKDA7CArW+zwKny7Yg4pvZNVb8Zev4
         xTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=0SYFxVnMi2vESLqYpuLpGJyisCo1MiNaYCdNwNlGgkM=;
        b=gqj4RyEemBouVZDMdwehDnaNOBOCJi/nUNnduRo1V4i2G5KqtbJUyVqxkJacVznmyq
         4pbIAZNvB8pyYHTl1kHNmQ8mf3cE3DXsR+DyEk9QFfiluTqXwVCEThRGopRPKEuAhj/z
         FcanUh4Jq4eLD/Encqv6k6+257gibn1zVBXi+TziObs9iqw+JrC4V42pNfY8Yq2CACSK
         3xgqntCbfb1aKYYXM0bNAe/PbTfhJV4rMbpAwLaJhU0FjLaEJAd5TtASsztl9DGuXQiS
         3VxxXSy4wzmzXFl/+amr8/3Ab8gZenAMZCL83N3+qRFWlsL4WLDJKKVPyY186ojg5YfK
         XjVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.18 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.18 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <92fde1b0f2490ddfaa040ccf1c5616de>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com
Cc: Guenter Roeck <linux@roeck-us.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Joseph Lo <josephl@nvidia.com>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	lee.jones@linaro.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Heiko Stuebner <heiko@sntech.de>,
	Brian Norris <briannorris@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	linux-rockchip@lists.infradead.org,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	devicetree@vger.kernel.org,
	stephen lu <lumotuwe@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v5 4/4] ARM: rockchip: Set name of regmap_config
Date: Mon, 12 Mar 2018 17:51:42 +0800
Message-Id: <20180312095142.30854-5-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594725108978688321?=
X-GMAIL-MSGID: =?utf-8?q?1594725108978688321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We are now allowing to register debugfs without a valid device, and not
having a valid name will end up using "dummy*" to create debugfs dir.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None

 arch/arm/mach-rockchip/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index ecec340ca345..51984a40b097 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -208,6 +208,7 @@ static int __init rockchip_smp_prepare_sram(struct device_node *node)
 }
 
 static const struct regmap_config rockchip_pmu_regmap_config = {
+	.name = "rockchip-pmu",
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-- 
2.11.0
