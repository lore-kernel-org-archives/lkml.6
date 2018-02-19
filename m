Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753692AbeBSRNQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:13:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43675 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbeBSRNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:13:12 -0500
From: Colin King <colin.king@canonical.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] CIFS: fix copy-n-paste on new sha512 secmech
Date: Mon, 19 Feb 2018 17:13:10 +0000
Message-Id: <20180219171310.10515-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for the sha512 crypto secmech is checking .md5 rather
than .sha512, this looks like a copy-paste error when adding
in this code.  Fix this by using the correct .sha512 field.

Detected by CoverityScan, CID#1465358 ("Copy-paste error")

Fixes: 1c6614d229e7 ("CIFS: add sha512 secmech")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cifs/cifsencrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
index 6fa6d459678e..a6ef088e057b 100644
--- a/fs/cifs/cifsencrypt.c
+++ b/fs/cifs/cifsencrypt.c
@@ -829,7 +829,7 @@ cifs_crypto_secmech_release(struct TCP_Server_Info *server)
 		server->secmech.md5 = NULL;
 	}
 
-	if (server->secmech.md5) {
+	if (server->secmech.sha512) {
 		crypto_free_shash(server->secmech.sha512);
 		server->secmech.sha512 = NULL;
 	}
-- 
2.15.1
