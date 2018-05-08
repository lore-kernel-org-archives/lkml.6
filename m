Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754862AbeEHKmd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:42:33 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43959 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754476AbeEHKmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:42:31 -0400
X-Google-Smtp-Source: AB8JxZobKhb0Orb83wvXOEIjB3nhG4r/H9uCweHCBtah4dTnMJL4Qk+mH27m3Ynn1AgQKrsgPFjbPQ==
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm/memblock: print memblock_remove
Date: Tue,  8 May 2018 19:42:23 +0900
Message-Id: <20180508104223.8028-1-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memblock_remove report is useful to see why MemTotal of /proc/meminfo
between two kernels makes difference.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/memblock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 5228f594b13c..03d48d8835ba 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -697,6 +697,11 @@ static int __init_memblock memblock_remove_range(struct memblock_type *type,
 
 int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
 {
+	phys_addr_t end = base + size - 1;
+
+	memblock_dbg("memblock_remove: [%pa-%pa] %pS\n",
+		     &base, &end, (void *)_RET_IP_);
+
 	return memblock_remove_range(&memblock.memory, base, size);
 }
 
-- 
2.17.0.441.gb46fe60e1d-goog
