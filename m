Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeCaENd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 00:13:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:63461 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752972AbeCaENV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 00:13:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,383,1517904000";
   d="scan'208";a="216457100"
Subject: [PATCH v8 14/18] memremap: mark devm_memremap_pages()
 EXPORT_SYMBOL_GPL
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Michal Hocko <mhocko@suse.com>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz, snitzer@redhat.com
Date: Fri, 30 Mar 2018 21:03:25 -0700
Message-ID: <152246900495.36038.12673192605922080966.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152246892890.36038.18436540150980653229.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152246892890.36038.18436540150980653229.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/memremap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 07a6a405cf3d..4b0e17df8981 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -257,7 +257,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	devres_free(pgmap);
 	return ERR_PTR(error);
 }
-EXPORT_SYMBOL(devm_memremap_pages);
+EXPORT_SYMBOL_GPL(devm_memremap_pages);
 
 unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
 {
