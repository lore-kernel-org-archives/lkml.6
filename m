Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeDGKDN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 06:03:13 -0400
Received: from m12-16.163.com ([220.181.12.16]:55126 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751153AbeDGKDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 06:03:12 -0400
From: Wenle Chen <solomonwen@163.com>
To: chenwenle@huawei.com
Cc: jhogan@kernel.org, linux@roeck-us.net, rostedt@goodmis.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        solachenclever@hotmail.com, solomonwen@163.com
Subject: [PATCH] scripts : sync the var type between memory and print
Date: Sat,  7 Apr 2018 18:01:35 +0800
Message-Id: <1523095295-5575-1-git-send-email-solomonwen@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EMCowAB31swXl8haCyDsIA--.41758S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy7ZFWUWr4xJw18GrW8Crg_yoW8Gr45pF
        s0ka4rW3s7uFZ5Cr9rt340yFyrAws5AF15urZ5XF4rAF4rXr9Ygw47C3yfZ345C3Z7t3yr
        CF45ury8CF1kJw7anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07brg4fUUUUU=
X-Originating-IP: [121.35.0.115]
X-CM-SenderInfo: 5vro0zprqzv0i6rwjhhfrp/1tbiKxkhSVQHJGwUBQABsR
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
