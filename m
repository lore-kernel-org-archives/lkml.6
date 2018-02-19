Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbeBSRLS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:11:18 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.219]:43631 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753184AbeBSRLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:11:16 -0500
Date: Mon, 19 Feb 2018 11:11:13 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Steve French <sfrench@samba.org>, Aurelien Aptel <aaptel@suse.com>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] CIFS: fix sha512 check in cifs_crypto_secmech_release
Message-ID: <20180219171113.GA16636@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1enoyB-000fMj-Ah
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:38064
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems this is a copy-paste error and that the proper variable to use
in this particular case is _sha512_ instead of _md5_.

Addresses-Coverity-ID: 1465358 ("Copy-paste error")
Fixes: 1c6614d229e7 ("CIFS: add sha512 secmech")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/cifs/cifsencrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
index 6fa6d45..a6ef088 100644
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
2.7.4
