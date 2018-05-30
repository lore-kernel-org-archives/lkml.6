Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbeE3WEQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:04:16 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42896 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932506AbeE3WEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:04:08 -0400
X-Google-Smtp-Source: ADUXVKL3bANiFeHlnCWwcekRpKR7p0tgcf1BuYzWBBojHYtcZ4DK0i+7WtYYBMrxzt7qjiO+xwZ0dA==
From: Jeffrin Jose T <ahiliation@gmail.com>
To: shuah@kernel.org, daniel.diaz@linaro.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, thomas@m3y3r.de, gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <ahiliation@gmail.com>
Subject: [RESEND PATCH] selftests: intel_pstate: notification about privilege required to run intel_pstate testing script
Date: Thu, 31 May 2018 03:33:39 +0530
Message-Id: <20180530220339.6107-1-ahiliation@gmail.com>
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
index 8576f6564307..e7008f614ad7 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -38,6 +38,12 @@ if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
 	exit $ksft_skip
 fi
 
+msg="skip all tests:"
+if [ $UID != 0 ] && [ $EVALUATE_ONLY == 0 ]; then
+    echo $msg please run this as root >&2
+    exit $ksft_skip
+fi
+
 max_cpus=$(($(nproc)-1))
 
 function run_test () {
-- 
2.17.0
