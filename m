Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032213AbeEZRCG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 13:02:06 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44134 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031950AbeEZRCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 13:02:04 -0400
X-Google-Smtp-Source: AB8JxZq2WeQ7kUv0I78aHHCQA/nR0QLxV3BhOkCQDjsC6AkDYmpVSGYPasGYk+pMUX5yPXv9Z+08SA==
From: Jeffrin Jose T <ahiliation@gmail.com>
To: shuah@kernel.org, kstewart@linuxfoundation.org, daniel.diaz@linaro.org,
        pombredanne@nexb.com, thomas@m3y3r.de, gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <ahiliation@gmail.com>
Subject: [PATCH] selftests: intel_pstate: notification about privilege required to run intel_pstate testing script
Date: Sat, 26 May 2018 22:31:35 +0530
Message-Id: <20180526170135.3340-1-ahiliation@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intel_pstate related testing script need root level privileges
when trying to access certain file for the successful execution of
the script.But this is not the case always like when using evaluation
only mode, which only require user level privilege.

This patch is to notify the user about the privilege the script
demands for the successful execution of the test.

Signed-off-by: Jeffrin Jose T (Rajagiri SET) <ahiliation@gmail.com>
---
 tools/testing/selftests/intel_pstate/run.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index 6ded61670f6d..4ddd389c2cb9 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -33,6 +33,12 @@ EVALUATE_ONLY=0
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+msg="skip all tests:"
+if [ $UID != 0 ] && [ $EVALUATE_ONLY == 0 ]; then
+    echo $msg please run this as root >&2
+    exit $ksft_skip
+fi
+
 if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
 	echo "$0 # Skipped: Test can only run on x86 architectures."
 	exit $ksft_skip
-- 
2.17.0
