Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeCQQtS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 12:49:18 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:38597 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeCQQtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 12:49:16 -0400
X-Google-Smtp-Source: AG47ELvleyN+vfiUOhbUnWthG41xrah1PGqQR3jXq2BlcRfGJ3EDBqZkoLpfFpiWFrHFeoLw60GqYA==
Date: Sat, 17 Mar 2018 19:49:11 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] proc: fixup read test even more
Message-ID: <20180317164911.GA3445@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/sysrq-trigger lives on the ground floor so to speak.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	FOLD INTO proc-shotgun-test-read-readdir-readlink-a-little-write-fix.patch

 tools/testing/selftests/proc/read.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/proc/read.c
+++ b/tools/testing/selftests/proc/read.c
@@ -106,10 +106,10 @@ static void f(DIR *d, unsigned int level)
 			int fd;
 
 		case DT_REG:
-			if (level == 1 && streq(de->d_name, "clear_refs")) {
-				f_reg_write(d, de->d_name, "1", 1);
-			} else if (level == 1 && streq(de->d_name, "sysrq-trigger")) {
+			if (level == 0 && streq(de->d_name, "sysrq-trigger")) {
 				f_reg_write(d, de->d_name, "h", 1);
+			} else if (level == 1 && streq(de->d_name, "clear_refs")) {
+				f_reg_write(d, de->d_name, "1", 1);
 			} else if (level == 3 && streq(de->d_name, "clear_refs")) {
 				f_reg_write(d, de->d_name, "1", 1);
 			} else {
