Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeBAQ6r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:58:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46912 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbeBAQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:58:45 -0500
From: Colin King <colin.king@canonical.com>
To: Guo-Fu Tseng <cooldavid@cooldavid.org>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: jme: remove unused initialization of 'rxdesc'
Date: Thu,  1 Feb 2018 16:58:42 +0000
Message-Id: <20180201165842.21906-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer rxdesc is assigned a value that is never read, it is overwritten
by a new assignment inside a while loop hence the initial assignment
is redundant and can be removed.

Cleans up clang warning:
drivers/net/ethernet/jme.c:1074:17: warning: Value stored to 'rxdesc'
during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/jme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index 62d848df26ef..8a165842fa85 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -1071,7 +1071,7 @@ static int
 jme_process_receive(struct jme_adapter *jme, int limit)
 {
 	struct jme_ring *rxring = &(jme->rxring[0]);
-	struct rxdesc *rxdesc = rxring->desc;
+	struct rxdesc *rxdesc;
 	int i, j, ccnt, desccnt, mask = jme->rx_ring_mask;
 
 	if (unlikely(!atomic_dec_and_test(&jme->rx_cleaning)))
-- 
2.15.1
