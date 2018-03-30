Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AIpwx4+oj8fZ1pmFcKoGy1dVL8Bqyh3rENVY4t6lUQFxamb6bHN56zdpLngU85FG9aRsGAQzhDIC
ARC-Seal: i=1; a=rsa-sha256; t=1522396078; cv=none;
        d=google.com; s=arc-20160816;
        b=pL4076Qgqm2Ux8KKuG3lCR6losQQDNNJqMbCPNq8JVmTOu5DqvLc/PkPd49+g4jiI1
         K6of2C+umx5CBZMKtAedpM0ad4By3gsl6CkVr+sD2atSYZHZEGQB055lMa1vjt07jbdK
         nxzC73ktSV1ZoZ9sTPxBYRLpvq/u/JyyyY1CT9MJ3EKvM3pluj4izzmszbDeqc9TNVr1
         haXktQbxsdB8r1fD2mddfIxZnREoao3LpGqN7X14X5MoXwDiEjaQPhglACt90mBsDkTT
         1GfC2n96n0xuaEBZKskBRogMADQItDkTwjU+ia60828R39u5S9I198SFfFROk5dU8I/g
         B+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=d9GO7dGHt+gRVArEzrUchj/2BTua36FWmjURZvGrsio=;
        b=Szq+PDDapNngwZ0r/CWqIlQt/rx38aUUS/hcQIGc+alqRxHnAMCY53L6v5a0r25XZw
         D76NkMwTxVwya32G9kfn9Hlv+98GAPVWenrVnDBzJINPgejepWPUkn00e4OOY3WTMT0c
         9rvt8J4eosnTR/PNTalgxOMQch7gY0NRErytFhRopkVdWrK9xrVEtTr1FiAKGjh483qf
         Vuk1Hb3LbpAauISF4HS7USDnEH4lbKJMbgyQtjiJLfomzCnUvxVdva+vYYlazk5iBcBV
         MO/Sbs8AepS+9usawd03YdGp3srRVKeahg1QplVbaduD+mEXQYzm/Umk3EK0muZ0aDOc
         oUgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Wolfram Sang <wsa@the-dreams.de>,
	linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>,
	Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>,
	Bartosz Folta <bfolta@cadence.com>,
	Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>,
	Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>,
	Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>,
	linux-gpio@vger.kernel.org,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v4 05/10] dt-bindings: i3c: Add macros to help fill I3C/I2C device's reg property
Date: Fri, 30 Mar 2018 09:47:46 +0200
Message-Id: <20180330074751.25987-6-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180330074751.25987-1-boris.brezillon@bootlin.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347990519200027?=
X-GMAIL-MSGID: =?utf-8?q?1596347990519200027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The reg property of devices connected to an I3C bus have 3 cells, and
filling them manually is not trivial. Provides macros to help doing
that.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/i3c/i3c.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 include/dt-bindings/i3c/i3c.h

diff --git a/include/dt-bindings/i3c/i3c.h b/include/dt-bindings/i3c/i3c.h
new file mode 100644
index 000000000000..97448c546649
--- /dev/null
+++ b/include/dt-bindings/i3c/i3c.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2017 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#ifndef _DT_BINDINGS_I3C_I3C_H
+#define _DT_BINDINGS_I3C_I3C_H
+
+#define IS_I2C_DEV		0x80000000
+
+#define I2C_DEV(addr, lvr)					\
+	(addr) (IS_I2C_DEV | (lvr)) 0x0
+
+#define I3C_PID(manufid, partid, instid, extrainfo)		\
+	((manufid) << 1)					\
+	(((partid) << 16) | ((instid) << 12) | (extrainfo))
+
+#define I3C_DEV_WITH_STATIC_ADDR(addr, manufid, partid,		\
+				 instid, extrainfo)		\
+	(addr) I3C_PID(manufid, partid, instid, extrainfo)
+
+#define I3C_DEV(manufid, partid, instid, extrainfo)		\
+	I3C_DEV_WITH_STATIC_ADDR(0x0, manufid, partid,		\
+				 instid, extrainfo)
+
+#endif
-- 
2.14.1
