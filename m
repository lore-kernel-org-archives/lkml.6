Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeCVFkp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 01:40:45 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40710 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbeCVFkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 01:40:43 -0400
X-Google-Smtp-Source: AG47ELsGTLNujkKfguU8ZBbNwCQF/bDHkppeSYxZnQf2AzORrwyNh/OUoywpaXvjhBc6Z1d0JTJmrQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: lee.jones@linaro.org
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [RESEND PATCH] mfd: sprd: Add one syscon cell to access PMIC global registers
Date: Thu, 22 Mar 2018 13:40:25 +0800
Message-Id: <0793c674fed009b9616fbc01a0212d78fb01234e.1521696653.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some global registers in Spreadtrum sc27xx PMICs, which will
be accessed by other drivers. So this patch adds one syscon cell to
help to access the PMIC's global registers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mfd/sprd-sc27xx-spi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 56a4782..3460ef0 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -111,6 +111,9 @@ struct sprd_pmic_data {
 	}, {
 		.name = "sc27xx-poweroff",
 		.of_compatible = "sprd,sc27xx-poweroff",
+	}, {
+		.name = "sc27xx-syscon",
+		.of_compatible = "sprd,sc27xx-syscon",
 	},
 };
 
-- 
1.7.9.5
