Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AH8x225/Xz6aEHk97HVUZzsQ3grhr+dtoZAbVItuwfzEfpcH28nwnDHuWNGCIBlCDlxwHB4HKuwF
ARC-Seal: i=1; a=rsa-sha256; t=1517554168; cv=none;
        d=google.com; s=arc-20160816;
        b=zbvyVfMrtLP5yUtdtlSnhvolEi2eI8zUsSpp+F8eJ2gSbvXTZCxt2xpoXkb1FCUHeN
         yhdZ1eA1mx5SSb2T4M+NsfpD2oYDd5BNKrceXwadhGJjNaym60Pj1TTW2ywh91TjvOC8
         UsB0PO+Her7DzwjqIV+khPjRdsOMUOeNvH4VId8Gg4njXipl9F47qFEmN5vZHtXoks6T
         f4qW/9XQnQuBQMUqDSqfZDHVaQpv+UvY7X4ZfyhVpvX1SOZSAzIdAZiVeFa2+hvbtv30
         VR+6TJpzjz+258rJxw234mNODGlYTjFhdDcxtIRqkYpRlhJZImmpAycD147iTl0Yin63
         ZMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/wRfuaqzk8rhVCcwgQby3V4Ldf7qPayUDtpUBfj1MBU=;
        b=H0oeOCr6ayE25H83uZZxe/Oq7aD/Gy0W2KPcKVL6gYd8tfI9x6IZEHFh4Tg5n24dr1
         U1fFujUdnnMvdN9udyEjO9CxuozyYxnSNUsaz5wPm8ddZJRVs0ODgNxTmKPv6wUsPzbA
         3JS75SBfypQV5/IDP0eV9RovsjMIUEAxofgnjzSvXc1eI+iZe111U8ekzTodjKkXBn0j
         2GGMXheapWJXfPexTSjkkLF48deaPlx1jw8EKaKX/MJgPH3cKbkLfv2bsefEoSrGs4jy
         0nQkPRI7pV//30c9NOuEBBSiEHKeo18vtUe6b8rYuwRZox/GIT4qVyNofi3kNNvz+3dr
         KBdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, Vadim Pasternak <vadimp@mellanox.com>
Subject: [patch v1 1/4] platform/x86: mlx-platform: Use defines for bus assignment
Date: Fri,  2 Feb 2018 08:45:45 +0000
Message-Id: <1517561148-38587-2-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1517561148-38587-1-git-send-email-vadimp@mellanox.com>
References: <1517561148-38587-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591270879147108176?=
X-GMAIL-MSGID: =?utf-8?q?1591270879147108176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add defines the bus Ids, used for hotplug devices topology in order to
improve code readability. Defines added for FAN and power units.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/x86/mlx-platform.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index dfecba4..a1ae93d 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -89,6 +89,13 @@
 /* Number of LPC attached MUX platform devices */
 #define MLXPLAT_CPLD_LPC_MUX_DEVS		2
 
+/* Hotplug devices adapter numbers */
+#define MLXPLAT_CPLD_PSU_DEFAULT_NR		10
+#define MLXPLAT_CPLD_FAN1_DEFAULT_NR		11
+#define MLXPLAT_CPLD_FAN2_DEFAULT_NR		12
+#define MLXPLAT_CPLD_FAN3_DEFAULT_NR		13
+#define MLXPLAT_CPLD_FAN4_DEFAULT_NR		14
+
 /* mlxplat_priv - platform private data
  * @pdev_i2c - i2c controller platform device
  * @pdev_mux - array of mux platform devices
@@ -190,14 +197,14 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_psu_items_data[] = {
 		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
 		.mask = BIT(0),
 		.hpdev.brdinfo = &mlxplat_mlxcpld_psu[0],
-		.hpdev.nr = 10,
+		.hpdev.nr = MLXPLAT_CPLD_PSU_DEFAULT_NR,
 	},
 	{
 		.label = "psu2",
 		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
 		.mask = BIT(1),
 		.hpdev.brdinfo = &mlxplat_mlxcpld_psu[1],
-		.hpdev.nr = 10,
+		.hpdev.nr = MLXPLAT_CPLD_PSU_DEFAULT_NR,
 	},
 };
 
@@ -207,14 +214,14 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_pwr_items_data[] = {
 		.reg = MLXPLAT_CPLD_LPC_REG_PWR_OFFSET,
 		.mask = BIT(0),
 		.hpdev.brdinfo = &mlxplat_mlxcpld_pwr[0],
-		.hpdev.nr = 10,
+		.hpdev.nr = MLXPLAT_CPLD_PSU_DEFAULT_NR,
 	},
 	{
 		.label = "pwr2",
 		.reg = MLXPLAT_CPLD_LPC_REG_PWR_OFFSET,
 		.mask = BIT(1),
 		.hpdev.brdinfo = &mlxplat_mlxcpld_pwr[1],
-		.hpdev.nr = 10,
+		.hpdev.nr = MLXPLAT_CPLD_PSU_DEFAULT_NR,
 	},
 };
 
@@ -224,28 +231,28 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_fan_items_data[] = {
 		.reg = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 		.mask = BIT(0),
 		.hpdev.brdinfo = &mlxplat_mlxcpld_fan[0],
-		.hpdev.nr = 11,
+		.hpdev.nr = MLXPLAT_CPLD_FAN1_DEFAULT_NR,
 	},
 	{
 		.label = "fan2",
 		.reg = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 		.mask = BIT(1),
 		.hpdev.brdinfo = &mlxplat_mlxcpld_fan[1],
-		.hpdev.nr = 12,
+		.hpdev.nr = MLXPLAT_CPLD_FAN2_DEFAULT_NR,
 	},
 	{
 		.label = "fan3",
 		.reg = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 		.mask = BIT(2),
 		.hpdev.brdinfo = &mlxplat_mlxcpld_fan[2],
-		.hpdev.nr = 13,
+		.hpdev.nr = MLXPLAT_CPLD_FAN3_DEFAULT_NR,
 	},
 	{
 		.label = "fan4",
 		.reg = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 		.mask = BIT(3),
 		.hpdev.brdinfo = &mlxplat_mlxcpld_fan[3],
-		.hpdev.nr = 14,
+		.hpdev.nr = MLXPLAT_CPLD_FAN4_DEFAULT_NR,
 	},
 };
 
-- 
2.1.4
