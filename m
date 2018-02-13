Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AH8x227Bd9jKUoXFQC8UWKR9dv0DLvdxKyKC9jpl7InsWTuUgAkQ2yNzWdM1pjPcIqptcvH272gM
ARC-Seal: i=1; a=rsa-sha256; t=1518552797; cv=none;
        d=google.com; s=arc-20160816;
        b=bl8xX+3dwZi6C0n0ZtRSXZQfDKS27ijKgFayd0qwBEFMjANsPMnBeFpYp9AH7+lDIe
         w3sjpnaA522RbHE0YJiW05dXrVE2s4DZu7Iy754drsEI4j1h69NabQyhqjdwR6LVwjXH
         uA+zVqHYa+A1HgdkzIFpThgxDTLErv7FKUwQdhHStkxmHU0NA9nlV7gJrpiQ2vbfNf6l
         NBvDesyZuIjmwEJy76mAqtbQ1s0N/9OLwFkukVPOvaTgc3Mk/emU2VnbDmw2GWSTiBrf
         IHzyqg626+O9x74LTr2mQ38MWG2SArzvWZglat54lxZjHCMhmTg7Ax7zAagFfBsPmCsN
         hpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=YNmecZYXQBLnBRZmD0WO7alVZU7iHfrb4+JtuZx88jQ=;
        b=ozOtGOxA4y/Psoz+4TtU23OdlcbmtQ+ibQv5w/2B1ydIalXFFef8GdQBUP+RpHuI+D
         sQG1Ko+1rjYGaGRooEvE0fzLnrj2p66zpGHeXbYYi3nfWb9FpJZfZYRJZyhNT6oG2Zo+
         W/OxrURVzY2iA6GUsuxYVJY1iVyTB7MfrJbXqlTeFkgHEZjqv+jfg27e2W/y0a/wlGys
         GbZ8skZ7U4/c4r3lEC0QqfUO/TOE9+fyKCLaYaCkRHEFdsbHrWUmy2/GkuHNTFafslu5
         283nt74acTRSXmZNnZFXkF4CyI+zBtUjxifF3lJUTqtziSC8EL4uQCuh+O5dcj/YmEHY
         wGZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v1 1/4] platform/x86: mlx-platform: Use define for the channel numbers
Date: Tue, 13 Feb 2018 22:09:33 +0000
Message-Id: <1518559776-188942-2-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
References: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318017435554507?=
X-GMAIL-MSGID: =?utf-8?q?1592318017435554507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add define for the channels number for mux device, instead of using
hardcoded value inside the code in order to improve code readability.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/x86/mlx-platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 454e14f..71b452a 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -85,6 +85,9 @@
 #define MLXPLAT_CPLD_FAN_MASK		GENMASK(3, 0)
 #define MLXPLAT_CPLD_FAN_NG_MASK	GENMASK(5, 0)
 
+/* Number of channels in group */
+#define MLXPLAT_CPLD_GRP_CHNL_NUM		8
+
 /* Start channel numbers */
 #define MLXPLAT_CPLD_CH1			2
 #define MLXPLAT_CPLD_CH2			10
@@ -124,7 +127,7 @@ static const struct resource mlxplat_lpc_resources[] = {
 };
 
 /* Platform default channels */
-static const int mlxplat_default_channels[][8] = {
+static const int mlxplat_default_channels[][MLXPLAT_CPLD_GRP_CHNL_NUM] = {
 	{
 		MLXPLAT_CPLD_CH1, MLXPLAT_CPLD_CH1 + 1, MLXPLAT_CPLD_CH1 + 2,
 		MLXPLAT_CPLD_CH1 + 3, MLXPLAT_CPLD_CH1 + 4, MLXPLAT_CPLD_CH1 +
-- 
2.1.4
