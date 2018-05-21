Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752245AbeEUWpm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:45:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:48435 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbeEUWph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:45:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,427,1520924400";
   d="scan'208";a="48696924"
Subject: [PATCH 5/5] mm, hmm: mark hmm_devmem_{add,
 add_resource} EXPORT_SYMBOL_GPL
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Cc: Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date: Mon, 21 May 2018 15:35:40 -0700
Message-ID: <152694214044.5484.1081005408496303826.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Cc: Christoph Hellwig <hch@lst.de>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/hmm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index a4162406067c..d9aef1266ed6 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1072,7 +1072,7 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 
 	return devmem;
 }
-EXPORT_SYMBOL(hmm_devmem_add);
+EXPORT_SYMBOL_GPL(hmm_devmem_add);
 
 struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
 					   struct device *device,
@@ -1131,7 +1131,7 @@ struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
 
 	return devmem;
 }
-EXPORT_SYMBOL(hmm_devmem_add_resource);
+EXPORT_SYMBOL_GPL(hmm_devmem_add_resource);
 
 /*
  * A device driver that wants to handle multiple devices memory through a
