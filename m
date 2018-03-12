Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeCLR0a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:26:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36627 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932525AbeCLRZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:25:43 -0400
From: Colin King <colin.king@canonical.com>
To: David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rxrpc: remove redundant initialization of variable 'len'
Date: Mon, 12 Mar 2018 17:25:38 +0000
Message-Id: <20180312172538.31707-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable 'len' is being initialized with a value that is never
read and it is re-assigned later, hence the initialization is redundant
and can be removed.

Cleans up clang warning:
net/rxrpc/recvmsg.c:275:15: warning: Value stored to 'len' during its
initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/rxrpc/recvmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 9d45d8b56744..7bff716e911e 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -272,7 +272,7 @@ static int rxrpc_locate_data(struct rxrpc_call *call, struct sk_buff *skb,
 			     unsigned int *_offset, unsigned int *_len)
 {
 	unsigned int offset = sizeof(struct rxrpc_wire_header);
-	unsigned int len = *_len;
+	unsigned int len;
 	int ret;
 	u8 annotation = *_annotation;
 
-- 
2.15.1
