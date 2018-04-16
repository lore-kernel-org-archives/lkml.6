Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754757AbeDPM5f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:57:35 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38640 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbeDPM5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:57:01 -0400
X-Google-Smtp-Source: AIpwx4908k0msEKK56QGjzT2/+gbomhcYkRvHFyKyigaHWkTG911F7EaWHzQG9qbWuuo4sdiWZFu1g==
From: Lee Jones <lee.jones@linaro.org>
To: linus.walleij@linaro.org, ldewangan@nvidia.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 1/3] mfd: Provide MACRO to declare commonly defined MFD cell attributes
Date: Mon, 16 Apr 2018 13:56:25 +0100
Message-Id: <20180416125627.22156-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180416125627.22156-1-lee.jones@linaro.org>
References: <20180416125627.22156-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
Tested-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 include/linux/mfd/core.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 99c0395fe1f9..2bdae891fd24 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -16,6 +16,35 @@
 
 #include <linux/platform_device.h>
 
+#define MFD_RES_SIZE(arr) (sizeof(arr) / sizeof(struct resource))
+
+#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, _match)\
+	{								\
+		.name = (_name),					\
+		.resources = (_res),					\
+		.num_resources = MFD_RES_SIZE((_res)),			\
+		.platform_data = (_pdata),				\
+		.pdata_size = (_pdsize),				\
+		.of_compatible = (_compat),				\
+		.acpi_match = (_match),					\
+		.id = (_id),						\
+	}
+
+#define OF_MFD_CELL(_name, _res, _pdata, _pdsize,_id, _compat)		\
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, NULL)	\
+
+#define ACPI_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _match)	\
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, _match)	\
+
+#define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id)		\
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, NULL)	\
+
+#define MFD_CELL_RES(_name, _res)					\
+	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, NULL)		\
+
+#define MFD_CELL_NAME(_name)						\
+	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, NULL)		\
+
 struct irq_domain;
 struct property_entry;
 
-- 
2.14.1
