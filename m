Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbeECUvI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:51:08 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:48568 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbeECUvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:51:07 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From: Shuah Khan <shuah@kernel.org>
Subject: [GIT PULL] kselftest update for 4.17-4
Message-ID: <c5fc8296-5cdc-9827-e7ad-c6e7d00ba0a9@kernel.org>
Date: Thu, 3 May 2018 14:50:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------55735EFA03624D0425E3F438"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------55735EFA03624D0425E3F438
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for 4.17-rc4

This Kselftest update for 4.17-rc4 consists of a fix for a syntax error
in the script that runs selftests. Mathieu Desnoyers found this bug in
the script on systems running GNU Make 3.8 or older.

diff is attached.

thanks,
-- Shuah

-----------------------------------------------------------------------------------
The following changes since commit 8bf24e8319613bbe950d4188682b3a0d9441b76b:

  selftests/filesystems: Don't run dnotify_test by default (2018-04-17 17:01:16 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.17-rc4

for you to fetch changes up to a33554401e4746cc33307910a1baad63ce3fd650:

  selftests: Fix lib.mk run_tests target shell script (2018-04-27 16:06:36 -0600)

----------------------------------------------------------------
linux-kselftest-4.17-rc4

This Kselftest update for 4.17-rc4 consists of a fix for a syntax error
in the script that runs selftests. Mathieu Desnoyers found this bug in
the script on systems running GNU Make 3.8 or older.

----------------------------------------------------------------
Mathieu Desnoyers (1):
      selftests: Fix lib.mk run_tests target shell script

 tools/testing/selftests/lib.mk | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
-----------------------------------------------------------------------------------

--------------55735EFA03624D0425E3F438
Content-Type: text/x-patch;
 name="linux-kselftest-4.17-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-4.17-rc4.diff"

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 195e9d4739a9..c1b1a4dc6a96 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -20,10 +20,10 @@ all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
 .ONESHELL:
 define RUN_TESTS
-	@export KSFT_TAP_LEVEL=`echo 1`;
-	@test_num=`echo 0`;
-	@echo "TAP version 13";
-	@for TEST in $(1); do				\
+	@export KSFT_TAP_LEVEL=`echo 1`;		\
+	test_num=`echo 0`;				\
+	echo "TAP version 13";				\
+	for TEST in $(1); do				\
 		BASENAME_TEST=`basename $$TEST`;	\
 		test_num=`echo $$test_num+1 | bc`;	\
 		echo "selftests: $$BASENAME_TEST";	\

--------------55735EFA03624D0425E3F438--
