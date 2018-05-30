Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753708AbeE3PJY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:09:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37927 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753180AbeE3PJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:09:20 -0400
From: Colin King <colin.king@canonical.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] bpf: devmap: remove redundant assignment of dev = dev
Date: Wed, 30 May 2018 16:09:16 +0100
Message-Id: <20180530150916.16808-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The assignment dev = dev is redundant and should be removed.

Detected by CoverityScan, CID#1469486 ("Evaluation order violation")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/bpf/devmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index ae16d0c373ef..1fe3fe60508a 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -352,7 +352,7 @@ int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
 static void *dev_map_lookup_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_dtab_netdev *obj = __dev_map_lookup_elem(map, *(u32 *)key);
-	struct net_device *dev = dev = obj ? obj->dev : NULL;
+	struct net_device *dev = obj ? obj->dev : NULL;
 
 	return dev ? &dev->ifindex : NULL;
 }
-- 
2.17.0
