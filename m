Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/p7W06fcZwgnJxUZxdZJjceVUq9KUioaabunSl48sMddfeyoXH7UQT5dbIfo9PG1YY6zFX
ARC-Seal: i=1; a=rsa-sha256; t=1522120962; cv=none;
        d=google.com; s=arc-20160816;
        b=AMgkkmYjs6r/puLo7/E6fxd7FM27HXKIcko7mp1hTovBwuvwbi4tcoo5CZhaincU36
         4dE7S3KnYy0uz7I+w4Yju7ChqcVX7vymXpi7hLJpTcayWNH4G6IyLwQcdKAy7AmR/MTo
         pYd/hNZiIUUeZDicl8GRCIeBajc57ICJonrSstcP/6pWB4x45p1WKm6KAY3YHFQnzyFx
         TM8trgb6teWKHBsiRbIC0Fov6xXY8oKpsXEfG65/y8TUpVmLWzuMPhCb49VtvYp45dWc
         dTfWrcJCXESPUQ39cJjhIA6NbbZMVIdEIbmEkaQdiGK4+HBaxUoJre39ZmnV6HWus1VM
         MIUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WOxbaoN+7cC96I1++eLbmKbUdBXDgCRDJulouqhqv/Q=;
        b=taQT3gOnRQEVYnCUZ0N5eV077HRQ4jh1TpvP65I4OjJfXQKpWmoUK0z3tBeX7+7hyz
         +Ah6g/VkfO+oO8SfD9KKK1peGkO2K0EyMzf7x9YSkP6GPEgig2PWaZS9neIdwX/kFRuO
         hosy+5sjq2LYgQxa6p2wZU7nShLC/uTC0WCWWMaY42jYHBjNRwiRjIoEqxPMpd5J8FVZ
         UCnoeuNHvG6QWGHhUcgct1aU5nI+jh4qE3AbjtcKlJ4KMn707MsBml3Gs9OcxFbVz1WJ
         xZ50Q/a7myzcDo4Yi06KgEgUwXEdplsNjEEFDf0MtZdEG+jMf4CoG2DEbr7/+6DDWCSo
         tb6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeC0DVT (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 23:21:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:63675 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751489AbeC0DVR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 23:21:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="215125677"
From: changbin.du@intel.com
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH v2 1/4] selftests/Makefile: append a slash to env variable OUTPUT
Date: Tue, 27 Mar 2018 11:11:31 +0800
Message-Id: <1522120294-24926-2-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522120294-24926-1-git-send-email-changbin.du@intel.com>
References: <1522120294-24926-1-git-send-email-changbin.du@intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596059510890150071?=
X-GMAIL-MSGID: =?utf-8?q?1596059510890150071?=
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

