Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965356AbeE2R1S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:27:18 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34730 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937187AbeE2R1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:27:14 -0400
X-Google-Smtp-Source: AB8JxZrmq5rzdrQsw07Jci8S7LfyyIW3y24YMCWniTzvim2tzzPLkDXICedHu5fkjJwenRFuxoj4OA==
From: Jeffrin Jose T <ahiliation@gmail.com>
To: shuah@kernel.org, kstewart@linuxfoundation.org, tglx@linutronix.de,
        pombredanne@nexb.com, gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <ahiliation@gmail.com>
Subject: [PATCH] [RESEND] selftest: intel_pstate: debug support message from aperf.c and return value fix.
Date: Tue, 29 May 2018 22:54:36 +0530
Message-Id: <20180529172436.4432-1-ahiliation@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional message along with an error message which is more
verbose for debug support from aperf.c and updated with the
new return value "KSFT_SKIP".

Signed-off-by: Jeffrin Jose T [Rajagiri SET] <ahiliation@gmail.com>
---
 tools/testing/selftests/intel_pstate/aperf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/intel_pstate/aperf.c b/tools/testing/selftests/intel_pstate/aperf.c
index d21edea9c560..f6cd03a87493 100644
--- a/tools/testing/selftests/intel_pstate/aperf.c
+++ b/tools/testing/selftests/intel_pstate/aperf.c
@@ -9,6 +9,8 @@
 #include <sys/timeb.h>
 #include <sched.h>
 #include <errno.h>
+#include <string.h>
+#include "../kselftest.h"
 
 void usage(char *name) {
 	printf ("Usage: %s cpunum\n", name);
@@ -41,8 +43,8 @@ int main(int argc, char **argv) {
 	fd = open(msr_file_name, O_RDONLY);
 
 	if (fd == -1) {
-		perror("Failed to open");
-		return 1;
+		printf("/dev/cpu/%d/msr: %s\n", cpu, strerror(errno));
+		return KSFT_SKIP;
 	}
 
 	CPU_ZERO(&cpuset);
-- 
2.17.0
