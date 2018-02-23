Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeBWOA7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:00:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51316 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeBWOA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:00:58 -0500
From: Colin King <colin.king@canonical.com>
To: Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sfc: falcon: remove duplicated bit-wise or of LOOPBACK_SGMII
Date: Fri, 23 Feb 2018 14:00:56 +0000
Message-Id: <20180223140056.27219-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Bit pattern LOOPBACK_SGMII is being bit-wise or'd twice; remove the
redundant 2nd LOOPBACK_SGMII

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/sfc/falcon/enum.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/falcon/enum.h b/drivers/net/ethernet/sfc/falcon/enum.h
index 30a1136fc909..4824fcf5c3d4 100644
--- a/drivers/net/ethernet/sfc/falcon/enum.h
+++ b/drivers/net/ethernet/sfc/falcon/enum.h
@@ -81,7 +81,6 @@ enum ef4_loopback_mode {
 			    (1 << LOOPBACK_XAUI) |		\
 			    (1 << LOOPBACK_GMII) |		\
 			    (1 << LOOPBACK_SGMII) |		\
-			    (1 << LOOPBACK_SGMII) |		\
 			    (1 << LOOPBACK_XGBR) |		\
 			    (1 << LOOPBACK_XFI) |		\
 			    (1 << LOOPBACK_XAUI_FAR) |		\
-- 
2.15.1
