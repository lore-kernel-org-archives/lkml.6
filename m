Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753824AbeE3Rem (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:34:42 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:35705 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753556AbeE3Rej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:34:39 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org
Cc: tglx@linutronix.de, kstewart@linuxfoundation.org, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: lib: fix prime_numbers module search and skip logic
Date: Wed, 30 May 2018 11:34:08 -0600
Message-Id: <20180530173408.11736-1-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prime_numbers modules search and skip logic removes the module instead
of searching for it. Fix it.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/lib/prime_numbers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib/prime_numbers.sh b/tools/testing/selftests/lib/prime_numbers.sh
index 76602d4b050f..78e7483c8d60 100755
--- a/tools/testing/selftests/lib/prime_numbers.sh
+++ b/tools/testing/selftests/lib/prime_numbers.sh
@@ -5,7 +5,7 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
-if ! /sbin/modprobe -q -r prime_numbers; then
+if ! /sbin/modprobe -q -n prime_numbers; then
 	echo "prime_numbers: module prime_numbers is not found [SKIP]"
 	exit $ksft_skip
 fi
-- 
2.14.1
