Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932569AbeCEAQD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 19:16:03 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33421 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932426AbeCEAPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 19:15:38 -0500
X-Google-Smtp-Source: AG47ELvzdynUFF1wPxxMgi9eynE4RRGHGsASo0nw+nmYZ/8ZuIdfqZCVBkELUNRyPItINtvYDgT/BQ==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, cpandya@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] memblock: add memblock_free() alloc when CONFIG_HAVE_MEMBLOCK is not set
Date: Sun,  4 Mar 2018 16:14:48 -0800
Message-Id: <1520208889-3908-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

When CONFIG_HAVE_MEMBLOCK is not set, an error version of
memblock_alloc() exists.  Add the matching memblock_free().

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Andrew or Michal, can you please ack this patch to be accepted
by Rob?


With "of: add early boot allocation of
of_find_node_by_phandle() cache" applied, kbuild test robot reports
tilex architecture build error due to no prototype for memblock_free().

The version of the patch that kbuild test robot reported was
"[PATCH v4 2/2] of: add early boot allocation of
of_find_node_by_phandle() cache".  An updated version of that
patch is now patch 3/3 of this series.

 include/linux/memblock.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 8be5077efb5f..d6973b1d92bc 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -432,6 +432,10 @@ static inline unsigned long memblock_reserved_memory_within(phys_addr_t start_ad
 	return 0;
 }
 
+static inline int memblock_free(phys_addr_t base, phys_addr_t size)
+{
+	return 0;
+}
 #endif /* CONFIG_HAVE_MEMBLOCK */
 
 #endif /* __KERNEL__ */
-- 
Frank Rowand <frank.rowand@sony.com>
