Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756286AbeDJWtb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 18:49:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:33656 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755650AbeDJWt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 18:49:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,433,1517904000";
   d="scan'208";a="190471424"
Subject: [PATCH 4/5] tools/testing/nvdimm: fix missing newline in
 nfit_test_dimm 'handle' attribute
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2018 15:39:29 -0700
Message-ID: <152339996986.16061.7075031344411812909.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152339994885.16061.1760220735664848631.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152339994885.16061.1760220735664848631.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sysfs userspace tooling generally expects the kernel to emit a newlines
when reading sysfs attributes.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/nvdimm/test/nfit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index c8c88363311b..51fc41c24a77 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1193,7 +1193,7 @@ static ssize_t handle_show(struct device *dev, struct device_attribute *attr,
 	if (dimm < 0)
 		return dimm;
 
-	return sprintf(buf, "%#x", handle[dimm]);
+	return sprintf(buf, "%#x\n", handle[dimm]);
 }
 DEVICE_ATTR_RO(handle);
 
