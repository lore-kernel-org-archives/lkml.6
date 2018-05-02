Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeEBVTb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 17:19:31 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:53246 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeEBVT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 17:19:28 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org, dvhart@infradead.org
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: futex: delete RUN_TESTS and EMIT_TESTS overrides
Date: Wed,  2 May 2018 15:18:45 -0600
Message-Id: <20180502211848.22404-2-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502211848.22404-1-shuah@kernel.org>
References: <20180502211848.22404-1-shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete RUN_TESTS and EMIT_TESTS overrides and use common defines in
lib.mk. Common defines work just fine and there is no need to define
custom overrides.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/futex/Makefile | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
index 8497a376ef9d..12631f0076a1 100644
--- a/tools/testing/selftests/futex/Makefile
+++ b/tools/testing/selftests/futex/Makefile
@@ -17,14 +17,6 @@ all:
 		fi \
 	done
 
-override define RUN_TESTS
-	@export KSFT_TAP_LEVEL=`echo 1`;
-	@echo "TAP version 13";
-	@echo "selftests: futex";
-	@echo "========================================";
-	@cd $(OUTPUT); ./run.sh
-endef
-
 override define INSTALL_RULE
 	mkdir -p $(INSTALL_PATH)
 	install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)
@@ -36,10 +28,6 @@ override define INSTALL_RULE
 	done;
 endef
 
-override define EMIT_TESTS
-	echo "./run.sh"
-endef
-
 override define CLEAN
 	@for DIR in $(SUBDIRS); do		\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
-- 
2.14.1
