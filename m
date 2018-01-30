Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeA3OyB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:54:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49123 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeA3Ox7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:53:59 -0500
From: Colin King <colin.king@canonical.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] esp4: remove redundant initialization of pointer esph
Date: Tue, 30 Jan 2018 14:53:48 +0000
Message-Id: <20180130145348.32202-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer esph is being assigned a value that is never read, esph is
re-assigned and only read inside an if statement, hence the
initialization is redundant and can be removed.

Cleans up clang warning:
net/ipv4/esp4.c:657:21: warning: Value stored to 'esph' during
its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/ipv4/esp4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 296d0b956bfe..97689012b357 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -654,7 +654,7 @@ static void esp_input_restore_header(struct sk_buff *skb)
 static void esp_input_set_header(struct sk_buff *skb, __be32 *seqhi)
 {
 	struct xfrm_state *x = xfrm_input_state(skb);
-	struct ip_esp_hdr *esph = (struct ip_esp_hdr *)skb->data;
+	struct ip_esp_hdr *esph;
 
 	/* For ESN we move the header forward by 4 bytes to
 	 * accomodate the high bits.  We will move it back after
-- 
2.15.1
