Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933020AbeCOQB0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:01:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:21918 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932983AbeCOQBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:01:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="34161404"
Subject: [PATCH v6 10/15] memremap: mark devm_memremap_pages()
 EXPORT_SYMBOL_GPL
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz,
        ross.zwisler@linux.intel.com, hch@lst.de, linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2018 08:52:18 -0700
Message-ID: <152112913855.24669.14758139703848244412.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152112908134.24669.10222746224538377035.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152112908134.24669.10222746224538377035.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_memremap_pages() facility is tightly integrated with the
kernel's memory hotplug functionality. It injects an altmap argument
deep into the architecture specific vmemmap implementation to allow
allocating from specific reserved pages, and it has Linux specific
assumptions about page structure reference counting relative to
get_user_pages() and get_user_pages_fast(). It was an oversight that
this was not marked EXPORT_SYMBOL_GPL from the outset.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/memremap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 72d0bb6fc47d..766cb9a487ae 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -430,7 +430,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	devres_free(pgmap);
 	return ERR_PTR(error);
 }
-EXPORT_SYMBOL(devm_memremap_pages);
+EXPORT_SYMBOL_GPL(devm_memremap_pages);
 
 unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
 {
