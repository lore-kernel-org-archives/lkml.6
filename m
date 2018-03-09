Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELvmmU79dU/0aXaGtuWow17otc4m647kIf1YshrnTOkhCGtLtTGhMG+sLtlz/HGUVGLwc7Q1
ARC-Seal: i=1; a=rsa-sha256; t=1520585176; cv=none;
        d=google.com; s=arc-20160816;
        b=DGDOsbQL/+qnyCmivGySOvzHG3kYzrnrVLiUATYFGow+sghgMzn6uqLmuezQ3GY1ju
         FT5C16ZKSIX1wTOa+SVu+SD+xbAnY62n+hiq5RP7hXMs9PEW0GHST6SqCi0OTO/Dvj0E
         9F7uzw4aScLK1taU+poI8i2UIUgeGvVUpnb0RKSvAgqA8xIfe058bnLJ9ftYf726+fz6
         qQywcwTk3p3PYHzh7Vu40DYTBjaBU2S0h1O0FsRtKaKiPk/OOQJZ1VJnMGEvq0xgsA6h
         FQmJ20P2QmRjV/C6qlFTGlUGuEfjqma1HWmVYTzXLrKddM8FbIBDyUVi9pIZWwqN1dxM
         wNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ijPwfbNYnqjlihLmlEhr+SWHAb7e1lvK/FIp4is7S/A=;
        b=i+l+xo9ANXnzwtCl31VhFX3Fkd4vuFqFkLA1S/wbZub1yovJdeT/oScZL1TPqoRNnC
         BBvwjAU2+E9hGAlB3msF0nhtQM1TaDgQVTBXQXvFDfoMUiVQE9cDLmUxMrgfW4RQqSRV
         ZvQaLQbxDKGqFMxG4DRZ3JnUT9OFgKsAjE2XFtJ5EgWEFn6qdzib4aYQ6PAYyoqxpFyK
         6BD8CONPeYaVKiL0g0vmcQUq54QivmvvEUIKktYdxfBzN8c335GIsot3/g2UutWyHHna
         Rbmtk1ovbKLKMfFFIGynYiAqJz0ZKEpJDALhM9nRy1XMZu1anRgvQp5/q6bd1IKPgdAo
         PlBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.20 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.20 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <1e36333984add8b0d6c155a5e1c5ad9a>
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
Subject: [RESEND PATCH v4 4/4] ARM: rockchip: Set name of regmap_config
Date: Fri,  9 Mar 2018 16:43:51 +0800
Message-Id: <20180309084351.32009-5-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180309084351.32009-1-jeffy.chen@rock-chips.com>
References: <20180309084351.32009-1-jeffy.chen@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594449121753375625?=
X-GMAIL-MSGID: =?utf-8?q?1594449121753375625?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We are now allowing to register debugfs without a valid device, and not
having a valid name will end up using "dummy*" to create debugfs dir.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

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
