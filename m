Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbeDQNiG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:38:06 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40896 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753638AbeDQNiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:38:04 -0400
X-Google-Smtp-Source: AIpwx48BLlRvw6w0Z7/+Cs3w+LE6GY/BbG5gfJBdDIEarJzpTJLNwxzY/gPmPYvNMrc7ngjGcqczyw==
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of/numa: drop export of of_node_to_nid
Date: Tue, 17 Apr 2018 08:38:02 -0500
Message-Id: <20180417133802.19774-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "generic" implementation of of_node_to_nid is only used by
arm64 and only in built-in code, so remove its export. Any
device with a struct device should be able to use dev_to_node()
instead. Also, exporting of_node_to_nid doesn't actually work if
we build a module on an arch that doesn't select OF_NUMA nor provide its
own of_node_to_nid implementation.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/of_numa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index f9d5480a4ae5..27d9b4bba535 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -177,7 +177,6 @@ int of_node_to_nid(struct device_node *device)
 
 	return NUMA_NO_NODE;
 }
-EXPORT_SYMBOL(of_node_to_nid);
 
 int __init of_numa_init(void)
 {
-- 
2.14.1
