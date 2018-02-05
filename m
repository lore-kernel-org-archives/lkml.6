Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeBEMzE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:55:04 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40714 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753079AbeBEMyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:54:40 -0500
X-Google-Smtp-Source: AH8x224dUgJjNq9R3DPfR4mXTuOgFv7Ja7uSJwVBYgNRmBm4cqbcpucbjcq5GoTrDgxAW61hOHVwqg==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: mediatek: Explicitly include pinctrl headers
Date: Mon,  5 Feb 2018 13:54:36 +0100
Message-Id: <20180205125436.24005-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180205124750.19305-1-thierry.reding@gmail.com>
References: <20180205124750.19305-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The Mediatek ethernet driver fails to build after commit 23c35f48f5fb
("pinctrl: remove include file from <linux/device.h>") because it relies
on the pinctrl/consumer.h and pinctrl/devinfo.h being pulled in by the
device.h header implicitly.

Include these headers explicitly to avoid the build failure.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 29826dd15204..9e74c165f3ca 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -23,6 +23,8 @@
 #include <linux/reset.h>
 #include <linux/tcp.h>
 #include <linux/interrupt.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/devinfo.h>
 
 #include "mtk_eth_soc.h"
 
-- 
2.15.1
