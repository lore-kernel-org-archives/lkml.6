Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeBBIjn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 03:39:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:25646 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbeBBIji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 03:39:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,447,1511856000";
   d="scan'208";a="27489066"
Subject: [PATCH] libnvdimm, namespace: make min namespace size 4K
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: ross.zwisler@linux.intel.com, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Cheng-mean Liu <soccerl@microsoft.com>
Date: Fri, 02 Feb 2018 00:30:32 -0800
Message-ID: <151756023262.24612.12933966286242265340.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arbitrary 4MB minimum namespace size turns out to be too large for
some environments. Quoting Cheng-mean Liu:

    In the case of emulated NVDIMM devices in the VM environment, there
    are scenarios that NVDIMM device with much smaller sizes are
    desired, for example, we might use a single enumerated NVDIMM DAX
    device for representing each container layer, which in some cases
    could be just a few KBs size.

PAGE_SIZE is the minimum where we can still support DAX of at least
a single page.

Cc: Matthew Wilcox <willy@infradead.org>
Reported-by: Cheng-mean Liu <soccerl@microsoft.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/uapi/linux/ndctl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
index 30ef1236aafa..7e27070b9440 100644
--- a/include/uapi/linux/ndctl.h
+++ b/include/uapi/linux/ndctl.h
@@ -209,7 +209,7 @@ enum nd_driver_flags {
 };
 
 enum {
-	ND_MIN_NAMESPACE_SIZE = 0x00400000,
+	ND_MIN_NAMESPACE_SIZE = PAGE_SIZE,
 };
 
 enum ars_masks {
