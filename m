Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AIpwx4/kuBDA9JCZm7hQbM++K08K8m7+O1a879VCaVMgC9MQHBurzqTQKmvx+k2RjpnkjRaSWiga
ARC-Seal: i=1; a=rsa-sha256; t=1521802838; cv=none;
        d=google.com; s=arc-20160816;
        b=b/aYL3L8Q+MTO5/oxrKxDrPldC53lgMFN+Pk8p8fPPTBuK9eG1ZGTzO6upxI4Bg9i7
         wONKSVt3ZYvkh2SyArdO6TgDamqkEF8eDHCMimrC4MeaTafJcAVLoZKUiQQZxpPRX+zM
         04GKAijmu8YDXtAefIuECat9O7jsQU4hyOAzGAxtcaOhj6aYQpWrCKD7E0yUBeG0g/fi
         hRw0UN7ImhY6h6d3ANi5mAXeknNG437CnGWEq3DDG28SY2gcrBmRbSekcOIVtxVF3tOw
         a8NSpnIbC/tRRllTPDmTC4YR8YDWeO0QMY4LccZcuNbyULsd/hBj1Z6mYndfeDzDtfsB
         f5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=sjdJh/ijod2F4perrDPNeBDx/H4X+IWv1JZzUs7dGgk=;
        b=cU89DsUzrazeDSaanwFHwihNMJ6WArijIqJ5E9oOv8MFNjk0J87DBfdU0KjGG2y8kv
         +iJkefvzNiQ0ujtONbIRqSgXogSf7EOY2iso5hQFQUBm9N3VpaAKgAaoZHOFg7i91pAt
         Zj+ETpZ/9cOeV4nnm+l6PNd1AnreWbBLvWPXOcg4r7zzzI/iTrU2QNCfRPqy5G9YuNz5
         YyvjD8Q9bIHuZXPRft9Jx+cJVnttW+ecVU9Yrhf8O9ObzwMMXxXnwzmT4zK7dENg+oev
         l1mjM0e7DPtPzMlA2su1ZkW+9H5OhRQTLpotcF9rlayMMIiBQ2nx1nKrHBArP1VQcZEc
         Kkxg==
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
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
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
Subject: [PATCH v3 06/11] dt-bindings: i3c: Add macros to help fill I3C/I2C device's reg property
Date: Fri, 23 Mar 2018 12:00:15 +0100
Message-Id: <20180323110020.19080-7-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180323110020.19080-1-boris.brezillon@bootlin.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725933191562034?=
X-GMAIL-MSGID: =?utf-8?q?1595725933191562034?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The reg property of devices connected to an I3C bus have 3 cells, and
filling them manually is not trivial. Provides macros to help doing
that.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
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
