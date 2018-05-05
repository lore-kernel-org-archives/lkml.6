Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeEEBPu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:15:50 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50470 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbeEEBPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:15:48 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org, daniel.diaz@linaro.org, thomas@m3y3r.de
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/24] selftests: intel_pstate: return Kselftest Skip code for skipped tests
Date: Fri,  4 May 2018 19:13:15 -0600
Message-Id: <20180505011328.32078-11-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When intel_pstate test is skipped because of unmet dependencies and/or
unsupported configuration, it returns 0 which is treated as a pass
by the Kselftest framework. This leads to false positive result even
when the test could not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/intel_pstate/run.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index c670359becc6..6ded61670f6d 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -30,9 +30,12 @@
 
 EVALUATE_ONLY=0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
 	echo "$0 # Skipped: Test can only run on x86 architectures."
-	exit 0
+	exit $ksft_skip
 fi
 
 max_cpus=$(($(nproc)-1))
-- 
2.14.1
