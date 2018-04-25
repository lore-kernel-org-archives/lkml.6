Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbeDYK4o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:56:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41797 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbeDYKnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:43:11 -0400
From: Colin King <colin.king@canonical.com>
To: "David S . Miller" <davem@davemloft.net>,
        Johannes Berg <johannes.berg@intel.com>,
        Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mkiss: remove redundant check for len > 0
Date: Wed, 25 Apr 2018 11:43:07 +0100
Message-Id: <20180425104307.8310-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for len > 0 is always true and hence is redundant as
this check is already being made to execute the code inside the
while-loop. Hence it is redundant and can be removed.

Cleans up cppcheck warning:
drivers/net/hamradio/mkiss.c:220: (warning) Identical inner 'if'
condition is always true.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/hamradio/mkiss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index c180b480f8ef..13e4c1eff353 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -217,7 +217,7 @@ static int kiss_esc_crc(unsigned char *s, unsigned char *d, unsigned short crc,
 			c = *s++;
 		else if (len > 1)
 			c = crc >> 8;
-		else if (len > 0)
+		else
 			c = crc & 0xff;
 
 		len--;
-- 
2.17.0
