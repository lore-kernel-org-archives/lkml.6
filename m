Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933824AbeEWSYW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:24:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754802AbeEWSYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:24:16 -0400
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH RFCv2 1/4] ACPI: NUMA: export pxm_to_node
Date: Wed, 23 May 2018 20:24:01 +0200
Message-Id: <20180523182404.11433-2-david@redhat.com>
In-Reply-To: <20180523182404.11433-1-david@redhat.com>
References: <20180523182404.11433-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will be needed by paravirtualized memory devices.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/acpi/numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 85167603b9c9..7ffee2959350 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -50,6 +50,7 @@ int pxm_to_node(int pxm)
 		return NUMA_NO_NODE;
 	return pxm_to_node_map[pxm];
 }
+EXPORT_SYMBOL(pxm_to_node);
 
 int node_to_pxm(int node)
 {
-- 
2.17.0
