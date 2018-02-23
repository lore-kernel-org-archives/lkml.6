Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224F2w69SFTqTFAPiicEmfDzsweotgv8ffaFPhZnUOcoZrNfO3GIhffqdnLQBukcSXBrjgBB
ARC-Seal: i=1; a=rsa-sha256; t=1519424009; cv=none;
        d=google.com; s=arc-20160816;
        b=cJZ8NdJEW4bHU0Uc1C6DeGjMTsz+bCWfXlG7BWGGqxJvNTpUbz01AXH2vPMAwZqTQg
         ehB7dSkEvSCjfoBF4O1Lj0B+DsUCdrOGENYXdWj6zue5CpyKRMy8OQi8V0s+NoeT742+
         zM/hyBRxgOCs3daAGHJHCNRgHsKvd3xo2IFM3PHnkXmzHl41MltLzLUoPseC0Eb2LyAX
         scPxUz3j8k6mrMc8u9atjlgwnCcqGLxyUpdyYuv2pmRoa88fbQdGZiFnuEbsdS3aJvIu
         h2157CcMs+Fb8H3Bghh9vh26353Ae8UCrIvXjtBQdlEKbiBF24ZDAmK6KFC4nmAd1rMw
         stIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=F4vip6i7E9Mh1r/rQX2xiuN3v/Xp04uEkC6osTeF29A=;
        b=yjioDDrcRxeyMm3LepA2Vz/nP3Z85bYbdeqoRuLv8QjZ7HAQ1Zp1ajRObsWx8zDcAF
         18F+hdqXpmXbOttwdf31P8lDYf4yx0WkDtfyNKZrzPiNgz2RpCkAVz500C1GGm1M16q1
         ylyWru39TbzNJafnttQtR+RcG6yYse170MoPsykXs6TTsCgzObvBzi4RJChS3xLl/Fv+
         Y79wtB8gKEib8Wf1l9YmaS35MFAH97oMihYUKEhsroWiGU3yR1eQdej7vXrMyZ+Z3d3G
         acdNGHD3wb3DjSHShQl8PXxEgsUrjJPffq3AIKVJnhaJf0j0FAUR6kwAU0wCWDr9Hu8J
         454Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeBWWMN (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 23 Feb 2018 17:12:13 -0500
Received: from osg.samsung.com ([64.30.133.232]:60999 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752119AbeBWWMK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Feb 2018 17:12:10 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: shuah@kernel.org, dvhart@infradead.org, tbird20d@gmail.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 3/5] selftests: Makefile set KSFT_TAP_LEVEL to prevent nested TAP headers
Date: Fri, 23 Feb 2018 15:11:38 -0700
Message-Id: <98cdd2fff184b478e36038f3ef3578425ca644d8.1519423341.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1519423340.git.shuahkh@osg.samsung.com>
References: <cover.1519423340.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1519423340.git.shuahkh@osg.samsung.com>
References: <cover.1519423340.git.shuahkh@osg.samsung.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593231549988348580?=
X-GMAIL-MSGID: =?utf-8?q?1593231549988348580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Export KSFT_TAP_LEVEL and add TAP Header echo to the run_kselftest.sh
script from emit_tests target handling.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/testing/selftests/Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 7442dfb73b7f..a41b4be28b9f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -66,6 +66,12 @@ ifndef BUILD
   BUILD := $(shell pwd)
 endif
 
+# KSFT_TAP_LEVEL is used from KSFT framework to prevent nested TAP header
+# printing from tests. Applicable to run_tests case where run_tests adds
+# TAP header prior running tests and when a test program invokes another
+# with system() call. Export it here to cover override RUN_TESTS defines.
+export KSFT_TAP_LEVEL=`echo 1`
+
 export BUILD
 all:
 	@for TARGET in $(TARGETS); do		\
@@ -125,10 +131,12 @@ ifdef INSTALL_PATH
 	echo "else" >> $(ALL_SCRIPT)
 	echo "  OUTPUT=/dev/stdout" >> $(ALL_SCRIPT)
 	echo "fi" >> $(ALL_SCRIPT)
+	echo "export KSFT_TAP_LEVEL=`echo 1`" >> $(ALL_SCRIPT)
 
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		echo "echo ; echo Running tests in $$TARGET" >> $(ALL_SCRIPT); \
+		echo "echo ; echo TAP version 13" >> $(ALL_SCRIPT);	\
+		echo "echo Running tests in $$TARGET" >> $(ALL_SCRIPT); \
 		echo "echo ========================================" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		make -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
-- 
2.14.1

