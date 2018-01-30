Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbeA3RrQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:47:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55188 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbeA3RrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:47:12 -0500
From: Colin King <colin.king@canonical.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libnvdimm, namespace: remove redundant initialization of 'nd_mapping'
Date: Tue, 30 Jan 2018 17:47:07 +0000
Message-Id: <20180130174707.4921-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer nd_mapping is being initialized to a value that is never read,
instead it is being updated to a new value in all the cases where it
is being read afterwards, hence the initialization is redundant and
can be removed.

Cleans up clang warning:
drivers/nvdimm/namespace_devs.c:2411:21: warning: Value stored to
'nd_mapping' during its initialization is never rea

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/nvdimm/namespace_devs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index bb3ba8cf24d4..658ada497be0 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -2408,7 +2408,7 @@ static struct device **scan_labels(struct nd_region *nd_region)
 
 static struct device **create_namespaces(struct nd_region *nd_region)
 {
-	struct nd_mapping *nd_mapping = &nd_region->mapping[0];
+	struct nd_mapping *nd_mapping;
 	struct device **devs;
 	int i;
 
-- 
2.15.1
