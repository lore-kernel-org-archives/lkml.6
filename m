Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZrPi5z2/7zSFq2zCPPb3vmeDVexJjCy6Udufb7tSDaiP2p9aT+Clk8X13xBE8+B9cDcCpvp
ARC-Seal: i=1; a=rsa-sha256; t=1525215384; cv=none;
        d=google.com; s=arc-20160816;
        b=qsWZMnMBbbxbAsOLWNNQ5kTDnda7FibSk830BNMjl+fsvCuxNHKVQRBMeo13JlFXY+
         loa5AdRQdu5IZG0BlYzsfeUT3LnKglAnzRDX3nUe6O0MyAUQrv4pJ+9gWwgf7pM2ZaC9
         GTtuUPNeYDbDA1bIa5ACTd+zRkjCsNxeFkP1KRmH9qc1xOW0CC3KUFnw9z/xxsuQwjQa
         bznLD45ksH3Q43GGgQeh811qbesg/X1EPaR//6aXgosN/rgYXjFAsS3Sz7am1F4eOalV
         ZEL+WeOY/JtPqfIEb76w65ehSHurNdbmL3HoLH+7UdnxWMlCpY6i+zOi++HPhM9S4isd
         xmsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Cph3ikkVxKIk9hoPxtlG3vr9rhC41eAo/cyhuxBdpzY=;
        b=exFTwYhNlJTmTFqiX/45h5RwAlNOLBp0aikO4yOw58n23sprI1RD+779cmU3qEHoaK
         FfIExUjhWHD56Oiu8Ayur+d0ys8jzUYsGufcl0gw33QuGrzNzGg+wZWkKy4dQwiMJkAC
         LLh1loE/4O4ZdikVATFEJ3D7OAFJOU+40d2hDq08FWFswtR6Hi+eoQ8OUYrvJePVlhL8
         G1V/Y/4wQqvXru6VnHAzUrQ7Y+W8D+plxGUB9N+JKj0s8U2rs8ruDhppwJkkFzRtJ7ln
         NePPkrE5aM5cP5jXFtNHKwTZbpyNDuuwJm1Oz9Qw6Aw4j90jbJRng96O3Lk6hTYH/roW
         vHiw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeEAWz3 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 1 May 2018 18:55:29 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38374 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeEAWz0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 May 2018 18:55:26 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] selftests: lib.mk: Include test suite name in the RUN_TESTS output
Date: Tue,  1 May 2018 16:54:36 -0600
Message-Id: <87a45d125d28566835bfe836732c40805055b665.1525212671.git.shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1525212671.git.shuah@kernel.org>
References: <cover.1525212671.git.shuah@kernel.org>
In-Reply-To: <cover.1525212671.git.shuah@kernel.org>
References: <cover.1525212671.git.shuah@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599304246960161033?=
X-GMAIL-MSGID: =?utf-8?q?1599304246960161033?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently just the test name is printed in the RUN_TESTS output. For
example, when raw_skew sub-test from timers tests in run, the output
shows just raw_skew. Include main test name when printing sub-test
results.

In addition, remove duplicate strings for printing common information
with a new for the test header information.

Before the change:

selftests: raw_skew
========================================
WARNING: ADJ_OFFSET in progress, this will cause inaccurate results
Estimating clock drift: -20.616(est) -20.586(act)       [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..7 selftests: raw_skew [PASS]

After the change:

selftests: timers: raw_skew
========================================
WARNING: ADJ_OFFSET in progress, this will cause inaccurate results
Estimating clock drift: -19.794(est) -19.896(act)       [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..7 selftests: timers: raw_skew [PASS]

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/lib.mk | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index dd516f92f7c2..eb2be6dabbda 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -20,26 +20,27 @@ all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
 .ONESHELL:
 define RUN_TEST_PRINT_RESULT
-	echo "selftests: $$BASENAME_TEST";	\
+	TEST_HDR_MSG="selftests: "`basename $$PWD`:" $$BASENAME_TEST";	\
+	echo $$TEST_HDR_MSG;					\
 	echo "========================================";	\
 	if [ ! -x $$TEST ]; then	\
-		echo "selftests: Warning: file $$BASENAME_TEST is not executable, correct this.";\
-		echo "not ok 1..$$test_num selftests: $$BASENAME_TEST [FAIL]"; \
+		echo "$$TEST_HDR_MSG: Warning: file $$BASENAME_TEST is not executable, correct this.";\
+		echo "not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]"; \
 	else					\
 		cd `dirname $$TEST` > /dev/null; \
 		if [ "X$(summary)" != "X" ]; then	\
 			(./$$BASENAME_TEST > /tmp/$$BASENAME_TEST 2>&1 && \
-			echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") || \
+			echo "ok 1..$$test_num $$TEST_HDR_MSG [PASS]") || \
 			(if [ $$? -eq $$skip ]; then	\
-				echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [SKIP]";				\
-			else echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]";					\
+				echo "not ok 1..$$test_num $$TEST_HDR_MSG [SKIP]";				\
+			else echo "not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]";					\
 			fi;)			\
 		else				\
 			(./$$BASENAME_TEST &&	\
-			echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") ||						\
+			echo "ok 1..$$test_num $$TEST_HDR_MSG [PASS]") ||						\
 			(if [ $$? -eq $$skip ]; then \
-				echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [SKIP]"; \
-			else echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]";				\
+				echo "not ok 1..$$test_num $$TEST_HDR_MSG [SKIP]"; \
+			else echo "not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]";				\
 			fi;)		\
 		fi;				\
 		cd - > /dev/null;		\
-- 
2.14.1

