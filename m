Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeDEKuP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 06:50:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47549 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbeDEKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 06:50:13 -0400
From: Colin King <colin.king@canonical.com>
To: Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] orangefs: make struct orangefs_file_vm_ops static
Date: Thu,  5 Apr 2018 11:50:10 +0100
Message-Id: <20180405105010.11210-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The struct orangefs_file_vm_ops is local to the source and does not need
to be in global scope, so make it static.

Cleans up sparse warning:
fs/orangefs/file.c:547:35: warning: symbol 'orangefs_file_vm_ops' was not
declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/orangefs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 26358efbf794..84f44365bfb3 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -544,7 +544,7 @@ static int orangefs_fault(struct vm_fault *vmf)
 	return filemap_fault(vmf);
 }
 
-const struct vm_operations_struct orangefs_file_vm_ops = {
+static const struct vm_operations_struct orangefs_file_vm_ops = {
 	.fault = orangefs_fault,
 	.map_pages = filemap_map_pages,
 	.page_mkwrite = filemap_page_mkwrite,
-- 
2.15.1
