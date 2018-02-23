Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeBWVOR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:14:17 -0500
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:47672 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeBWVOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:14:16 -0500
From: Toshi Kani <toshi.kani@hpe.com>
To: dan.j.williams@intel.com
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH 1/2] libnvdimm, label: change min label storage size per UEFI 2.7
Date: Fri, 23 Feb 2018 14:59:21 -0700
Message-Id: <20180223215922.25415-2-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180223215922.25415-1-toshi.kani@hpe.com>
References: <20180223215922.25415-1-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UEFI 2.7 defines in page 758 that:

  Initial Label Storage Area Configuration
     :
  The minimum size of the Label Storage Area is large enough to
  hold 2 index blocks and 2 labels.

The mininum index block size is 256 bytes, and the minimum label size
is also 256 bytes.

Change ND_LABEL_MIN_SIZE to (256 * 4) so that NVDIMM devices with
the minimum label storage area do not fail with the size check in
nvdimm_init_config_data().

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/label.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
index 1ebf4d3d01ba..18bbe183b3a9 100644
--- a/drivers/nvdimm/label.h
+++ b/drivers/nvdimm/label.h
@@ -33,7 +33,7 @@ enum {
 	BTTINFO_UUID_LEN = 16,
 	BTTINFO_FLAG_ERROR = 0x1,    /* error state (read-only) */
 	BTTINFO_MAJOR_VERSION = 1,
-	ND_LABEL_MIN_SIZE = 512 * 129, /* see sizeof_namespace_index() */
+	ND_LABEL_MIN_SIZE = 256 * 4, /* see sizeof_namespace_index() */
 	ND_LABEL_ID_SIZE = 50,
 	ND_NSINDEX_INIT = 0x1,
 };
