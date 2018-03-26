Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELs4ClhxHk74/5agOrrmtb9Xt37wN0ejklGOLztvdo+nsReQ74I47RZzs3KYYrmQNYM/7hwb
ARC-Seal: i=1; a=rsa-sha256; t=1522056839; cv=none;
        d=google.com; s=arc-20160816;
        b=NgmbMxEpMiBizIzrdAIBw+T2rm4Obiz2KOiT7znYSia6U7c7HLWwIbVUbHV9Bkh92u
         fa8y21y0LlfgxkHRkUS64eBef/mtpRZvaPebyqZVQPcAUFrYTQ/bEM+rMEIbVp2IXs/B
         CDQX3e2474d6MmJXsPDjF3U8Q7uAeQ4pEstQ6Pyu5Khfo7CFoWF/0YcuDY/L/sXhG0g6
         3Q2r6FB5nngM4Dh4tFd7iEPpOcxCREeNlyQgdBeZC8e6UGAhEMejXRYn6em3kwc0AwWH
         LBhPTYy81QKrPFoCseKlwpGsi6ZDbHzMAHrImmaGYEHKJtCVm7NcfjFLY8/EZlCV8Vl0
         Pv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WOxbaoN+7cC96I1++eLbmKbUdBXDgCRDJulouqhqv/Q=;
        b=d97NKsmZkG8D8YC5hF+5F23vxl+KKBP6rL+jJUmBF0uDglkbUG+rKnHaal4KQvHKmg
         K/P9FbpWlsg2SR6IyTO5zQNDVqu+OV9stlGXbe8iFyQHJaP3qnq1RLsMHx/tJbtoyNZw
         1XV4ruAI0zG1y1HR04AVgNOkiGow4eBrgbK5KMkYeJnKaDRDTKTONCTyFraRMpinarMQ
         NIEeAhOOB668THdWJN+HuP7sj+Zo5GkWKSk8AgLJjx/NAwF7NtM7dQiIpBgVHWSzvO3c
         LdEBkF6D3fkIQJxB+UtlYeD0TXUJbz5oSvNrhPONSzkEunmBn30yJFdie/JjFkDfWCML
         3G5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeCZJdS (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 05:33:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:43803 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbeCZJdN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 05:33:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="36851568"
From: changbin.du@intel.com
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH 1/4] selftests/Makefile: append a slash to env variable OUTPUT
Date: Mon, 26 Mar 2018 17:23:25 +0800
Message-Id: <1522056208-4004-2-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
References: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595992271774759248?=
X-GMAIL-MSGID: =?utf-8?q?1595992271774759248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Changbin Du <changbin.du@intel.com>

The tools/build/Makefile.build use 'OUTPUT' variable as below example:
objprefix    := $(subst ./,,$(OUTPUT)$(dir)/)

So it requires the 'OUTPUT' already has a slash at the end.

This patch can kill below odd paths:
make[3]: Entering directory '/home/changbin/work/linux/tools/gpio'
  CC       /home/changbin/work/linux/tools/testing/selftests/gpiolsgpio.o
  CC       /home/changbin/work/linux/tools/testing/selftests/gpiogpio-utils.o
  LD       /home/changbin/work/linux/tools/testing/selftests/gpiolsgpio-in.o

A correct path should be:
/home/changbin/work/linux/tools/testing/selftests/gpio/lsgpio.o

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 tools/testing/selftests/Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 7442dfb..7916aa2 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -71,31 +71,31 @@ all:
 	@for TARGET in $(TARGETS); do		\
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		mkdir $$BUILD_TARGET  -p;	\
-		make OUTPUT=$$BUILD_TARGET -C $$TARGET;\
+		make OUTPUT=$$BUILD_TARGET/ -C $$TARGET;\
 	done;
 
 run_tests: all
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		make OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests;\
+		make OUTPUT=$$BUILD_TARGET/ -C $$TARGET run_tests;\
 	done;
 
 hotplug:
 	@for TARGET in $(TARGETS_HOTPLUG); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		make OUTPUT=$$BUILD_TARGET -C $$TARGET;\
+		make OUTPUT=$$BUILD_TARGET/ -C $$TARGET;\
 	done;
 
 run_hotplug: hotplug
 	@for TARGET in $(TARGETS_HOTPLUG); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		make OUTPUT=$$BUILD_TARGET -C $$TARGET run_full_test;\
+		make OUTPUT=$$BUILD_TARGET/ -C $$TARGET run_full_test;\
 	done;
 
 clean_hotplug:
 	@for TARGET in $(TARGETS_HOTPLUG); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		make OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
+		make OUTPUT=$$BUILD_TARGET/ -C $$TARGET clean;\
 	done;
 
 run_pstore_crash:
@@ -111,7 +111,7 @@ ifdef INSTALL_PATH
 	mkdir -p $(INSTALL_PATH)
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		make OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
+		make OUTPUT=$$BUILD_TARGET/ -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
 	done;
 
 	@# Ask all targets to emit their test scripts
@@ -131,7 +131,7 @@ ifdef INSTALL_PATH
 		echo "echo ; echo Running tests in $$TARGET" >> $(ALL_SCRIPT); \
 		echo "echo ========================================" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
-		make -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
+		make -s --no-print-directory OUTPUT=$$BUILD_TARGET/ -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
 		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
 	done;
 
@@ -143,7 +143,7 @@ endif
 clean:
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		make OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
+		make OUTPUT=$$BUILD_TARGET/ -C $$TARGET clean;\
 	done;
 
 .PHONY: all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean
-- 
2.7.4

