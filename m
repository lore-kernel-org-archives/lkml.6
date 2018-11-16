Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B41C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9502B21019
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIiU9Piy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9502B21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389085AbeKPKmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:42:33 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:33249 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeKPKmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:42:32 -0500
Received: by mail-qk1-f202.google.com with SMTP id 80so48684697qkd.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 16:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4jbZ/sQtt4fQxWMbmtuOEMeC38oh//SFf9cSPkbMqWo=;
        b=DIiU9PiyBU43QE9nNCfTyuuRWUZr5mIGvAaTH/nDG/fmmSArt5vPxNBJtFt90mp0y+
         kxTHnjVy/Vw2DS8h9mT1wIiJ3lEfZU4GEeHhMD4mWgt0hLMk9C97mhQMfUddNu+fjrLM
         TzAmiRM2/m121sD3f7Issfbaw7mHHGY5IE7eWD8yjF5fOKKsbjQTevEOBNZG37oTLtCT
         o8DtgtJMHWcmJhPBh7iX/Iksf8vgZNP/Xtyl8sKFHA6JGJfTasOi5RKcjDHxGKN3XINu
         pHb2p2zvgltw6uauf9rFvuHljqFTuxSz09w3/QUGFsT78fLiejmzQeRLeIHHgwKbiMvv
         jE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4jbZ/sQtt4fQxWMbmtuOEMeC38oh//SFf9cSPkbMqWo=;
        b=Ws0c/YyMPHZ3sfCb7YCP0GVtpi6EsWyGssUXFgI3ffdknFdtG+HX5IhkJDe/ruk6Qw
         JL+Lcd5bVI5twn9lSFU/sb7vuyAb5W0dIgEt96vpWqmnRSFuft+HfpoxtDgbXnm7620O
         f4s5tnH1OaNJV5fDIdCfUWNuT7Oy+jWg7uJgGLE+yObn5ho+wiOYUwiTIkXsbKDH0a8R
         92ZMqbzlCPqNTngNgwlJ10OxfCjoOLnUm9cbdkv+0R0bWkAIsTorz7jSK8+3bYCPPO20
         ZUpM0hPlPwdj6mZegcgR0kzVZvnPcfM69pDBz1S4w+0Kg2ol5yAWk5R9eb3+199Yyrnk
         t67Q==
X-Gm-Message-State: AGRZ1gKf3FAxYYqFo5ZMyRU6pXzn7Z16S9M9tDIZf6ybXGZmla6UKjau
        Mf156ECJHdpDjXr5kqS18CgSlxJLLzemrihvMruzRe48ZX4yd/TOdUK9MUF6DXD4fYaEw39D9pa
        Kun1FJPrTHdlQnf9xItuPXZ2s7cRiGEr295ge2/Wq7kPnlVQc1PTaKZoUoejOEA==
X-Google-Smtp-Source: AJdET5dlBAWT8XGAQQ8Qw+BYU6j+hMQc/yPoaKTlffciawef6YsgZmmKUmGrc7GVbF/3yc0ueNCsYag=
X-Received: by 2002:a37:6386:: with SMTP id x128mr1840205qkb.43.1542328341717;
 Thu, 15 Nov 2018 16:32:21 -0800 (PST)
Date:   Thu, 15 Nov 2018 16:32:01 -0800
Message-Id: <4dfc634cfcfb236883971b5107cf3c28ec8a31be.1542328222.git.sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH] perf build: fix -lbfd feature check
From:   Stanislav Fomichev <sdf@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mathieu.poirier@linaro.org, mingo@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current libbfd feature test unconditionally links against -liberty and -lz.
While it's required on some systems (e.g. opensuse), it's completely
unnecessary on the others, where only -lbdf is sufficient (debian).
This patch streamlines (and renames) the following feature checks:

feature-libbfd           - only link against -lbfd (debian),
                           see commit 2cf9040714f3 ("perf tools: Fix bfd
			   dependency libraries detection")
feature-libbfd-liberty   - link against -lbfd and -liberty
feature-libbfd-liberty-z - link against -lbfd, -liberty and -lz (opensuse),
                           see commit 280e7c48c3b8 ("perf tools: fix BFD
			   detection on opensuse")

(feature-liberty{,-z} were renamed to feature-libbfd-liberty{,z}
for clarity)

The main motivation is to fix this feature test for bpftool which is
currently broken on debian (libbfd feature shows OFF, but we still
unconditionally link against -lbfd and it works).

Tested on debian with only -lbfd installed (without -liberty); I'd
appreciate if somebody on the other systems can test this new detection
method.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/build/Makefile.feature |  4 ++--
 tools/build/feature/Makefile | 10 ++++----
 tools/perf/Makefile.config   | 44 +++++++++++++++++++-----------------
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index f216b2f5c3d7..42a787856cd8 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -79,8 +79,8 @@ FEATURE_TESTS_EXTRA :=                  \
          cplus-demangle                 \
          hello                          \
          libbabeltrace                  \
-         liberty                        \
-         liberty-z                      \
+         libbfd-liberty                 \
+         libbfd-liberty-z               \
          libunwind-debug-frame          \
          libunwind-debug-frame-arm      \
          libunwind-debug-frame-aarch64  \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0516259be70f..bf8a8ebcca1e 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -15,8 +15,8 @@ FILES=                                          \
          test-libbfd.bin                        \
          test-disassembler-four-args.bin        \
          test-reallocarray.bin			\
-         test-liberty.bin                       \
-         test-liberty-z.bin                     \
+         test-libbfd-liberty.bin                \
+         test-libbfd-liberty-z.bin              \
          test-cplus-demangle.bin                \
          test-libelf.bin                        \
          test-libelf-getphdrnum.bin             \
@@ -200,7 +200,7 @@ FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
 	$(BUILD)
 
 $(OUTPUT)test-libbfd.bin:
-	$(BUILD) -DPACKAGE='"perf"' -lbfd -lz -liberty -ldl
+	$(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
 
 $(OUTPUT)test-disassembler-four-args.bin:
 	$(BUILD) -DPACKAGE='"perf"' -lbfd -lopcodes
@@ -208,10 +208,10 @@ FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
 $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
 
-$(OUTPUT)test-liberty.bin:
+$(OUTPUT)test-libbfd-liberty.bin:
 	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty
 
-$(OUTPUT)test-liberty-z.bin:
+$(OUTPUT)test-libbfd-liberty-z.bin:
 	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
 
 $(OUTPUT)test-cplus-demangle.bin:
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e30d20fb482d..6287fa0ebd1d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -686,18 +686,20 @@ endif
 
 ifeq ($(feature-libbfd), 1)
   EXTLIBS += -lbfd
+else
+  # we are on a system that requires -liberty and (maybe) -lz
+  # to link against -lbfd; test each case individually here
 
   # call all detections now so we get correct
   # status in VF output
-  $(call feature_check,liberty)
-  $(call feature_check,liberty-z)
-  $(call feature_check,cplus-demangle)
+  $(call feature_check,libbfd-liberty)
+  $(call feature_check,libbfd-liberty-z)
 
-  ifeq ($(feature-liberty), 1)
-    EXTLIBS += -liberty
+  ifeq ($(feature-libbfd-liberty), 1)
+    EXTLIBS += -lbfd -liberty
   else
-    ifeq ($(feature-liberty-z), 1)
-      EXTLIBS += -liberty -lz
+    ifeq ($(feature-libbfd-liberty-z), 1)
+      EXTLIBS += -lbfd -liberty -lz
     endif
   endif
 endif
@@ -707,24 +709,24 @@ ifdef NO_DEMANGLE
 else
   ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
     EXTLIBS += -liberty
-    CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
   else
-    ifneq ($(feature-libbfd), 1)
-      ifneq ($(feature-liberty), 1)
-        ifneq ($(feature-liberty-z), 1)
-          # we dont have neither HAVE_CPLUS_DEMANGLE_SUPPORT
-          # or any of 'bfd iberty z' trinity
-          ifeq ($(feature-cplus-demangle), 1)
-            EXTLIBS += -liberty
-            CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
-          else
-            msg := $(warning No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling)
-            CFLAGS += -DNO_DEMANGLE
-          endif
-        endif
+    ifeq ($(filter -liberty,$(EXTLIBS)),)
+      $(call feature_check,cplus-demangle)
+
+      # we dont have neither HAVE_CPLUS_DEMANGLE_SUPPORT
+      # or any of 'bfd iberty z' trinity
+      ifeq ($(feature-cplus-demangle), 1)
+        EXTLIBS += -liberty
+      else
+        msg := $(warning No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling)
+        CFLAGS += -DNO_DEMANGLE
       endif
     endif
   endif
+
+  ifneq ($(filter -liberty,$(EXTLIBS)),)
+    CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
+  endif
 endif
 
 ifneq ($(filter -lbfd,$(EXTLIBS)),)
-- 
2.19.1.1215.g8438c0b245-goog

