Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBWRRD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:17:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55773 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751430AbeBWRRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:17:00 -0500
From: Colin King <colin.king@canonical.com>
To: Wei Liu <wei.liu2@citrix.com>, Paul Durrant <paul.durrant@citrix.com>,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] xen-netback: make function xenvif_rx_skb static
Date: Fri, 23 Feb 2018 17:16:57 +0000
Message-Id: <20180223171657.5748-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function xenvif_rx_skb is local to the source and does not need
to be in global scope, so make it static.

Cleans up sparse warning:
drivers/net/xen-netback/rx.c:422:6: warning: symbol 'xenvif_rx_skb'
was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/xen-netback/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xen-netback/rx.c b/drivers/net/xen-netback/rx.c
index b1cf7c6f407a..ef5887037b22 100644
--- a/drivers/net/xen-netback/rx.c
+++ b/drivers/net/xen-netback/rx.c
@@ -419,7 +419,7 @@ static void xenvif_rx_extra_slot(struct xenvif_queue *queue,
 	BUG();
 }
 
-void xenvif_rx_skb(struct xenvif_queue *queue)
+static void xenvif_rx_skb(struct xenvif_queue *queue)
 {
 	struct xenvif_pkt_state pkt;
 
-- 
2.15.1
