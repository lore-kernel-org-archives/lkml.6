Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD3FC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1151220875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1151220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754168AbeFTO0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:26:02 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeFTO0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:26:00 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lla4p-1g5o1K1gKF-00bO8L; Wed, 20 Jun 2018 16:25:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] [v2] reiserfs: remove obsolete print_time function
Date:   Wed, 20 Jun 2018 16:25:04 +0200
Message-Id: <20180620142522.27639-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180620142522.27639-1-arnd@arndb.de>
References: <20180620142522.27639-1-arnd@arndb.de>
X-Provags-ID: V03:K1:XNdbzTUm0j4bJiREs4SG+baP1izgegMxGgbrOBNplV4eiSG81xR
 RnYfrNZ6VPQKEjgZssURiXMfJzPGRiofkPIUTRvANeFZZ9WwGIbjzzCHrMPs6iEwi1L1O33
 +lGRk9hdGnDAr+zvml6R4RSujX9FF04kH5AvlQf0CP1c5oO37PE6UvKINp0axdAundSEdRf
 dNVmseMyawoWoYjmcrL+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A6aV3BrMv6s=:UFBNs0Q9gMo/5pdYFEE279
 UOL6v/9N5Ln5BpyOL9jUkrhkMg6YIxFAX14/xF00dqwXLexYgCTDsUENLxkaWBdjOkl+91s7M
 s+8d/pIvgv71hHW1yTNfv+EQySTR2v25ynAndzfEXjY5+DM0yJwuS9nb/RzEJrkKGF8qt/a4U
 0TGjwbyHjp0IR60Fdvu6ajId4LMvixLsTDuDdLJGP8EOKjOXpeLXVHX9eVeUgF1ucdSGDGQdo
 eFKqAsxcrt/7sLPbV2x8oRW7+59TpSsfKABRUxIQCyMgAT9s2Hgl/aSX/rmfeuACs8A5pzVTg
 yHwkZz/cO/lCWUKFIokqPHYXLdTMmusnib7RNWO6jrPC/NOy2WkuJHCsoS4sBKzKqafg1j3xY
 dmbbK/I5uQWpwFzlSVOoqcdzSv2oq5BuFZsuvHf7ZQtZIpXZ4JIkLDRXqy8jjwIlikUSuCxBR
 RzawwUj6Q54TAy2XkMoCvy7+LFso9Qf1ngImpDC+YGcoYB2AnofPS93DAyqQ66SIzKYfVQwOt
 UsgP0faxu0tNSVe2xjg+KT1TYNOKQbk5J6N/bCcWS2MfLAbGlKjwP8UR+A0Kj3FVv+SgKQdCF
 lcHGKV0xlviaKQNrQALVi492DezQwKDdMv87b3L+pXePJbbD4yUqL7cHFIM+qVhSi8J3f/JRo
 y359Jm0fkBp5ypwoi6xaHnzW1Tv/nfhwIkdrwAgN0HV0sgc6Mwjw0QWcP185QGFuRVKo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before linux-2.4.6, print_time() was used to pretty-print an inode
time when running reiserfs in user space, after that it has become
obsolete and is still a bit incorrect: It behaves differently on 32-bit
and 64-bit machines, and uses a static buffer to hold a string, which
could lead to undefined behavior if we ever called this from multiple
places simultaneously.

Since we always want to treat the timestamps as 'unsigned' anyway,
simply printing them as an integer is both simpler and safer while
avoiding the deprecated time_t type.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: after a second look, I decided to remove it instead of fixing it.
---
 fs/reiserfs/item_ops.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/reiserfs/item_ops.c b/fs/reiserfs/item_ops.c
index e3c558d1b78c..3a5a752d96c7 100644
--- a/fs/reiserfs/item_ops.c
+++ b/fs/reiserfs/item_ops.c
@@ -33,30 +33,22 @@ static int sd_is_left_mergeable(struct reiserfs_key *key, unsigned long bsize)
 	return 0;
 }
 
-static char *print_time(time_t t)
-{
-	static char timebuf[256];
-
-	sprintf(timebuf, "%ld", t);
-	return timebuf;
-}
-
 static void sd_print_item(struct item_head *ih, char *item)
 {
 	printk("\tmode | size | nlinks | first direct | mtime\n");
 	if (stat_data_v1(ih)) {
 		struct stat_data_v1 *sd = (struct stat_data_v1 *)item;
 
-		printk("\t0%-6o | %6u | %2u | %d | %s\n", sd_v1_mode(sd),
+		printk("\t0%-6o | %6u | %2u | %d | %u\n", sd_v1_mode(sd),
 		       sd_v1_size(sd), sd_v1_nlink(sd),
 		       sd_v1_first_direct_byte(sd),
-		       print_time(sd_v1_mtime(sd)));
+		       sd_v1_mtime(sd));
 	} else {
 		struct stat_data *sd = (struct stat_data *)item;
 
-		printk("\t0%-6o | %6llu | %2u | %d | %s\n", sd_v2_mode(sd),
+		printk("\t0%-6o | %6llu | %2u | %d | %u\n", sd_v2_mode(sd),
 		       (unsigned long long)sd_v2_size(sd), sd_v2_nlink(sd),
-		       sd_v2_rdev(sd), print_time(sd_v2_mtime(sd)));
+		       sd_v2_rdev(sd), sd_v2_mtime(sd));
 	}
 }
 
-- 
2.9.0

