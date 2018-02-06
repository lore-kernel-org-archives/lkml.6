Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753135AbeBFVmj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:42:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56864 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeBFVmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:42:38 -0500
From: Colin King <colin.king@canonical.com>
To: David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: cell: make afs_cell_gc_delay static
Date: Tue,  6 Feb 2018 21:42:32 +0000
Message-Id: <20180206214232.11049-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable afs_cell_gc_delay is local to the source and does not need
to be in global scope, so make it static.

Cleans up sparse warning:
fs/afs/cell.c:21:24: warning: symbol 'afs_cell_gc_delay' was not
declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/afs/cell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 9bb921d120d0..80b8a7e8f38b 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -18,7 +18,7 @@
 #include <keys/rxrpc-type.h>
 #include "internal.h"
 
-unsigned __read_mostly afs_cell_gc_delay = 10;
+static unsigned __read_mostly afs_cell_gc_delay = 10;
 
 static void afs_manage_cell(struct work_struct *);
 
-- 
2.15.1
