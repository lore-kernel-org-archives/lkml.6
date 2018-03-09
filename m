Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELv1jklbZSqiL9Y/jTIhj5YK/Kg6ETMdfqeC18sfVA7I+s4afDCJisrBVLmevthXPyKd/tXo
ARC-Seal: i=1; a=rsa-sha256; t=1520585144; cv=none;
        d=google.com; s=arc-20160816;
        b=pz8qlroHXf/cOftOHY0f900gxRLWzLwrKCAOn8jlSaKUpu4AmaSpZGSbF9SP/VXNyP
         Z0ac153VNguFuB8Rbwnpd6tFcifvDLSo08ZQtAQ/PvHtSAGA8je+C7DsmHNIdxIPzY8P
         pwxLusElnQ8sB7uMqP47kasOjb3ZkK3700KPLquxagyE4OUm3YbZOPaCCpW1enDNvsuE
         jsl+a3ZHY9hycl1MUEUkNoiEKj0O8HIlMxRfEmQ3H6jfgXVJTcGzZJB+J4oWpWtuYbFM
         brZ13+8u2y9c63qhApvb8XkoqzrMb5z2YTR3yPDVxOAT/7jOwJAQwBiAYw0aGPfkmrHK
         kQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=XESAkslWyKFUYmATx2Wym9n1kl90w78/MpxOrWqdfh8=;
        b=NuQQnQOf6J3YksnGbvqgu9N582tOVARcwhXA4102Qhi8k98JNowBWfWMHbs3tUQ1W8
         DTlEIDMEHrcjeAa9sVbcyUTNaxbRC4GJwqSiAE7AxQK2prOoKc3FBVlFbxpWvWbT+3Nk
         zW1CQS4/vWWFpKL+n+kRGkX5x923u9SkBL+KpsBJrLJ8dUhA7ffY7MX+xndvEcY7grfS
         l1rLvKpbw/c/vq2qJauoVIF7EqBukeqq7gBnem1ZAN+DP45V+PBvN9qUOPMYzbvd2888
         41HTH2/kUkL0au6d3XqNTVnpJVTAm+HLpcl0V1VT2mvczEG+jzLEIVOry+Sdp7lsRKhS
         ZocA==
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
X-UNIQUE-TAG: <9899e2c94258fe984e5a5fe7dd9cd02e>
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
	Lee Jones <lee.jones@linaro.org>
Subject: [RESEND PATCH v4 1/4] mfd: syscon: Set name of regmap_config
Date: Fri,  9 Mar 2018 16:43:48 +0800
Message-Id: <20180309084351.32009-2-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180309084351.32009-1-jeffy.chen@rock-chips.com>
References: <20180309084351.32009-1-jeffy.chen@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594449087814408748?=
X-GMAIL-MSGID: =?utf-8?q?1594449087814408748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We are now allowing to register debugfs without a valid device, and not
having a valid name will end up using "dummy*" to create debugfs dir.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

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
