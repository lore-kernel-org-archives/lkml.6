Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbeDQMnR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:43:17 -0400
Received: from m12-11.163.com ([220.181.12.11]:38423 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752609AbeDQMnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:43:15 -0400
From: Wenle Chen <solomonwen@163.com>
To: chenwenle@huawei.com
Cc: jhogan@kernel.org, linux@roeck-us.net, rostedt@goodmis.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        solachenclever@hotmail.com, solomonwen@163.com
Subject: [PATCH] scripts : sync the var type between memory and print
Date: Tue, 17 Apr 2018 20:41:04 +0800
Message-Id: <1523968864-3892-1-git-send-email-solomonwen@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C8CowAC3zb5669Va_FA+Pg--.57994S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy7ZFWUWr4xJw18GrW8Crg_yoW8Gr45pF
        s0ka4rW3s7uFZ5Cr9rt340yFyrAws5AF15urZ5XF4rAF4rXr9Ygw47C3yfZ345C3Z7t3yr
        CF45ury8CF1kJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UuCJQUUUUU=
X-Originating-IP: [113.116.237.34]
X-CM-SenderInfo: 5vro0zprqzv0i6rwjhhfrp/1tbiLRsrSVSIWZ3SngAAsA
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenle Chen <chenwenle@huawei.com>

    The %d in printf need get a int
But the real type of these vars is unsigned.
It may let some compilers show a warning.

Signed-off-by: Wenle Chen <chenwenle@huawei.com>
---
 scripts/recordmcount.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 8c9691c..6f900fa 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -459,7 +459,7 @@ do_file(char const *const fname)
 	switch (ehdr->e_ident[EI_DATA]) {
 		static unsigned int const endian = 1;
 	default:
-		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
+		fprintf(stderr, "unrecognized ELF data encoding %u: %s\n",
 			ehdr->e_ident[EI_DATA], fname);
 		fail_file();
 		break;
@@ -500,7 +500,7 @@ do_file(char const *const fname)
 	gpfx = 0;
 	switch (w2(ehdr->e_machine)) {
 	default:
-		fprintf(stderr, "unrecognized e_machine %d %s\n",
+		fprintf(stderr, "unrecognized e_machine %u %s\n",
 			w2(ehdr->e_machine), fname);
 		fail_file();
 		break;
@@ -541,7 +541,7 @@ do_file(char const *const fname)
 
 	switch (ehdr->e_ident[EI_CLASS]) {
 	default:
-		fprintf(stderr, "unrecognized ELF class %d %s\n",
+		fprintf(stderr, "unrecognized ELF class %u %s\n",
 			ehdr->e_ident[EI_CLASS], fname);
 		fail_file();
 		break;
-- 
2.7.4
