Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELu6A/5VBR/eRWL296+zCIYjXP2b61ZwBzgu14VjvKkDYdl5z3GWQimC8bm+H7Im82ZoFUQ5
ARC-Seal: i=1; a=rsa-sha256; t=1522056831; cv=none;
        d=google.com; s=arc-20160816;
        b=oo4FAJZZGwHDXZEX2tOATr5DclbMVBxVCG6lIc0z7qo//iRMhLLFljIIYv4RcuRHmQ
         bCg/xSFmln44bmX/7N5cnoX8rHBCspDOlA3GNGL7Q00MU85CLD5RGqW9s2bRaCRukIaG
         EWJlvq5wRFWMPFdgx52Qe3sU77LjDSIoF+fcnyO2pzZKfPLzVuaibm81PhdjzGKERyIG
         J38Mgiep6aADoNyYJyBi5wRT8b7jE6na/597wUmHVQJUjMFPOBaYZYNvivmWhyUyL2Xg
         HnA+fFDkcM7tDAPCDyFjDRHvJgbAlYGu2AcP6Tykgp3LkKyaVocZ68ZIb5+s4fUQCwHH
         78Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iTBhomk9QmFfPv0jhj6S6K/YTBjCTUiZ5o5BzKwNcSw=;
        b=FkJ/ynOk1tYPPAvoJBUI9OXm62Cp1RayN5sE05suhmUeoJsbgkqMNlfjoaOCIaDlPQ
         0ZkLILgwP2nl7n20lGKp+gq60uYYJlu3MpOUOHxEedH52/YcBUUIpM5ORE/nd9TTaaVl
         ctqydxws1ssMBVVZRaKyI9L+LvbeMftZa8qZaoTRiFbKrV/IrZEE+sxVtJPnh9AFfw1e
         3foQnJH29PZghIQkAApFFUzVcmwVQE8ZYuwmoi12wTfvftQsTfiSxwmiEwzt0xe9u96P
         CI8LcOSIyNDIFhxjsh9Jg+ocwW0Bu58/bwUJ1SrdBOiT3LJtyTAI+GL30D45koNQzpkh
         PqOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbeCZJde (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 05:33:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:43809 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751938AbeCZJdU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 05:33:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="36851597"
From: changbin.du@intel.com
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH 4/4] selftests/bpf: fix compiling errors
Date: Mon, 26 Mar 2018 17:23:28 +0800
Message-Id: <1522056208-4004-5-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
References: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595992264368569998?=
X-GMAIL-MSGID: =?utf-8?q?1595992264368569998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Changbin Du <changbin.du@intel.com>

This patch fixed below errors of missing head files.

tools/testing/selftests$ make
...
clang -I. -I./include/uapi -I../../../include/uapi -Wno-compare-distinct-pointer-types \
	 -O2 -target bpf -emit-llvm -c test_pkt_access.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf//test_pkt_access.o
In file included from test_pkt_access.c:9:
In file included from ../../../include/uapi/linux/bpf.h:11:
In file included from ./include/uapi/linux/types.h:5:
/usr/include/asm-generic/int-ll64.h:11:10: fatal error: 'asm/bitsperlong.h' file not found
 #include <asm/bitsperlong.h>
         ^
1 error generated.
clang -I. -I./include/uapi -I../../../include/uapi -Wno-compare-distinct-pointer-types \
	 -O2 -target bpf -emit-llvm -c test_xdp.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf//test_xdp.o
In file included from test_xdp.c:9:
In file included from ../../../include/uapi/linux/bpf.h:11:
In file included from ./include/uapi/linux/types.h:5:
/usr/include/asm-generic/int-ll64.h:11:10: fatal error: 'asm/bitsperlong.h' file not found
 #include <asm/bitsperlong.h>
         ^
1 error generated.
clang -I. -I./include/uapi -I../../../include/uapi -Wno-compare-distinct-pointer-types \
	 -O2 -target bpf -emit-llvm -c test_l4lb.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf//test_l4lb.o
In file included from test_l4lb.c:10:
In file included from /usr/include/linux/pkt_cls.h:4:
In file included from ./include/uapi/linux/types.h:5:
/usr/include/asm-generic/int-ll64.h:11:10: fatal error: 'asm/bitsperlong.h' file not found
 #include <asm/bitsperlong.h>
         ^
1 error generated.
clang -I. -I./include/uapi -I../../../include/uapi -Wno-compare-distinct-pointer-types \
	 -O2 -target bpf -emit-llvm -c test_tcp_estats.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf//test_tcp_estats.o
In file included from test_tcp_estats.c:35:
In file included from ../../../include/uapi/linux/bpf.h:11:
In file included from ./include/uapi/linux/types.h:5:
/usr/include/asm-generic/int-ll64.h:11:10: fatal error: 'asm/bitsperlong.h' file not found
 #include <asm/bitsperlong.h>
...

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 tools/testing/selftests/bpf/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5c43c18..dc0fdc8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -10,7 +10,8 @@ ifneq ($(wildcard $(GENHDR)),)
   GENFLAGS := -DHAVE_GENHDR
 endif
 
-CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) -I../../../include
+CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) \
+	  -I../../../include -I../../../../usr/include
 LDLIBS += -lcap -lelf -lrt -lpthread
 
 # Order correspond to 'make run_tests' order
@@ -62,7 +63,7 @@ else
   CPU ?= generic
 endif
 
-CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi \
+CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include \
 	      -Wno-compare-distinct-pointer-types
 
 $(OUTPUT)/test_l4lb_noinline.o: CLANG_FLAGS += -fno-inline
-- 
2.7.4

