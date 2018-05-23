Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeEWFU4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:20:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:5118 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754004AbeEWFUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:20:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,431,1520924400";
   d="scan'208";a="43489644"
Subject: [PATCH v2 7/7] mm, hmm: Mark hmm_devmem_{add,
 add_resource} EXPORT_SYMBOL_GPL
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Cc: =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Tue, 22 May 2018 22:10:54 -0700
Message-ID: <152705225448.21414.18197203048027308208.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152705221686.21414.771870778478134768.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152705221686.21414.771870778478134768.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routines hmm_devmem_add(), and hmm_devmem_add_resource() are small
wrappers around devm_memremap_pages(). The devm_memremap_pages()
interface is a subset of the hmm functionality which has more and deeper
ties into the kernel memory management implementation. It was an
oversight that these symbols were not marked EXPORT_SYMBOL_GPL from the
outset due to how they originally copied (and now reuse)
devm_memremap_pages().

Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/hmm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 5723331f6910..25c338d46576 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1063,7 +1063,7 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 		return result;
 	return devmem;
 }
-EXPORT_SYMBOL(hmm_devmem_add);
+EXPORT_SYMBOL_GPL(hmm_devmem_add);
 
 struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
 					   struct device *device,
@@ -1117,7 +1117,7 @@ struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
 		return result;
 	return devmem;
 }
-EXPORT_SYMBOL(hmm_devmem_add_resource);
+EXPORT_SYMBOL_GPL(hmm_devmem_add_resource);
 
 /*
  * A device driver that wants to handle multiple devices memory through a
