Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753129AbeBEOME (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:12:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51311 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752767AbeBEOL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:11:57 -0500
From: Colin King <colin.king@canonical.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libnvdimm: remove redundant assignment to pointer 'dev'
Date: Mon,  5 Feb 2018 14:08:52 +0000
Message-Id: <20180205140852.14110-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer dev is being assigned a value that is never read, it is being
re-assigned the same value later on, hence the initialization is redundant
and can be removed.

Cleans up clang warning:
drivers/nvdimm/pfn_devs.c:307:17: warning: Value stored to 'dev' during
its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/nvdimm/pfn_devs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index f5c4e8c6e29d..2f4d18752c97 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -304,7 +304,7 @@ static const struct attribute_group *nd_pfn_attribute_groups[] = {
 struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
 		struct nd_namespace_common *ndns)
 {
-	struct device *dev = &nd_pfn->dev;
+	struct device *dev;
 
 	if (!nd_pfn)
 		return NULL;
-- 
2.15.1
