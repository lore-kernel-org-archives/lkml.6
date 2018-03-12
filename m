Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELsnqRFRWvX1ZBVt/Nofg/7+gpa77QijVTEn9Xo8hQW0ZyoKX1Bbmhe4VhjAf5Rt8nC23m5Q
ARC-Seal: i=1; a=rsa-sha256; t=1520848341; cv=none;
        d=google.com; s=arc-20160816;
        b=OAGXasnmxE2Z0zQv1VgCGL/CS89SJ+E+lxzKjwGKTM/JLGaKNfw9YHteL93ZNfiD+S
         JVDCRb0CsTyMwT9L4mMQU951SzGJNcskG/U6vvhjRmCvstnlvTmEpcPSNg9Cf1615Dzy
         Su8yt3SgVxklAwueZ99gAbdyTYnwJJFUfQZiGWd/yp8QRHFItd5futgcLwq0NQy+Ooj4
         EFe6C1IUE6wLD4ig32QPoYqAl6hsRPTVlPYVLMRKEe883t7p2VeAjB5NpZ+qYCd5OtBu
         kfvUuUv3631CZpQ2YLLoVwosFQBs+whGWWtXXp60qtQPyEhYvTSIZVC8vjWURA10e12A
         jv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=qgMQh8lD/JeHzSg0OGWZNpYHqPAQf91VvQ3E4+c/WCw=;
        b=STk4A8FYApTNrkBhDtxQEvgD6q2MqLz91hT5JoBssrx9t+AOQ37MksFsW/qeH1eb72
         0D3yFZooI2N85sa/ImIa3e+HeE/XoYJj/mI7qfEmQzv6lrU36VKDknhvezgFOyRX/BNh
         DhnJg9Yl392f/KD7yVjDuanlTDdCDH2YgJQWjiY1UBC3O6xmI8zwz1eCnmrJAP8gx/ff
         NXRpDLTNN2DW219FcFwMdi9+xxLbyLCT3TmugwCVxsaWWjA7j4IhtZkRSfKc8ObwpDWJ
         SGOs4VeViVcQ2o77xvinoLQ0sJq8Hs++Ax6FLiRlMfAumtSm8/ZwRWdbblQ6ftelReMj
         KSsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.24 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.24 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <45d36ed535f590c789c82f4cc2adfd87>
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
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 1/4] mfd: syscon: Set name of regmap_config
Date: Mon, 12 Mar 2018 17:51:39 +0800
Message-Id: <20180312095142.30854-2-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594449087814408748?=
X-GMAIL-MSGID: =?utf-8?q?1594725071038601189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We are now allowing to register debugfs without a valid device, and not
having a valid name will end up using "dummy*" to create debugfs dir.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5:
CC lee.jones@linaro.org

Changes in v4: None
Changes in v3:
Modify commit message.

 drivers/mfd/syscon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index fc9ba0ea4e44..b6d05cd934e6 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -110,6 +110,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
 	syscon_config.reg_stride = reg_io_width;
 	syscon_config.val_bits = reg_io_width * 8;
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
+	syscon_config.name = of_node_full_name(np);
 
 	regmap = regmap_init_mmio(NULL, base, &syscon_config);
 	if (IS_ERR(regmap)) {
-- 
2.11.0
