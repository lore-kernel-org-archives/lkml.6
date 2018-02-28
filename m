Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbeB1Oms (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:42:48 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40728 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932278AbeB1Olw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:41:52 -0500
X-Google-Smtp-Source: AH8x224HhznzZvqLunn5Xt2hP45M6ICZTqxiU29UkJ+J5HL3n/6G68UNTr+Wp7i9U19HqYB0RiBUGw==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, cphealy@gmail.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 19/22] nvmem: vf610-ocotp: Do not use "&pdev->dev" explicitly
Date: Wed, 28 Feb 2018 06:41:03 -0800
Message-Id: <20180228144106.16363-20-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228144106.16363-1-andrew.smirnov@gmail.com>
References: <20180228144106.16363-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There already a "dev" variable for that. Use it.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: cphealy@gmail.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/nvmem/vf610-ocotp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/vf610-ocotp.c b/drivers/nvmem/vf610-ocotp.c
index 752a0983e7fb..6e6bf7987d9d 100644
--- a/drivers/nvmem/vf610-ocotp.c
+++ b/drivers/nvmem/vf610-ocotp.c
@@ -223,8 +223,7 @@ static int vf610_ocotp_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct vf610_ocotp *ocotp_dev;
 
-	ocotp_dev = devm_kzalloc(&pdev->dev,
-			sizeof(struct vf610_ocotp), GFP_KERNEL);
+	ocotp_dev = devm_kzalloc(dev, sizeof(struct vf610_ocotp), GFP_KERNEL);
 	if (!ocotp_dev)
 		return -ENOMEM;
 
-- 
2.14.3
