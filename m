Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936421AbeE0NJK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 09:09:10 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46982 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936343AbeE0NJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 09:09:08 -0400
X-Google-Smtp-Source: AB8JxZqFu+DRxn3i0463z1qSjEJkfnqAN5ZrGL+i1i3q/gkQHWbMpMK2NHjKidJYd/JKkLBLhYehbg==
Date: Sun, 27 May 2018 18:39:01 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: pablo@netfilter.org
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iptables-compat: homogenize error message
Message-ID: <20180527130901.GA18320@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a difference between error messages in iptables and
iptables-compat:

#sudo iptables-compat -D INPUT 4
iptables: No chain/target/match by that name.

#sudo iptables -D INPUT 4
iptables: Index of deletion too big.

Now, will show same error message.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 iptables/nft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index e33d00f..40646f4 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -2603,7 +2603,7 @@ const char *nft_strerror(int err)
 	    { nft_rule_add, E2BIG, "Index of insertion too big" },
 	    { nft_rule_check, ENOENT, "Bad rule (does a matching rule exist in that chain?)" },
 	    { nft_rule_replace, ENOENT, "Index of replacement too big" },
-	    { nft_rule_delete_num, E2BIG, "Index of deletion too big" },
+	    { nft_rule_delete_num, ENOENT, "Index of deletion too big" },
 /*	    { TC_READ_COUNTER, E2BIG, "Index of counter too big" },
 	    { TC_ZERO_COUNTER, E2BIG, "Index of counter too big" }, */
 	    { nft_rule_add, ELOOP, "Loop found in table" },
-- 
2.7.4
