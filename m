Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03458C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5B021900
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550532251;
	bh=I6fF2a34BugTTiZ8oGrSZOnvBIMJK2lW3I4eTG/Vscs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uUHYaKIfKpKry0akYiK59xuhp6l0A9VY9Sr7W40BjZquFbZunv76kxxp4OBJrg2Sf
	 CmI8PcONiD6wlb9NUOrJWviUgomwgZ7mEDTIDMA+mq4HQPyTiOE52157HVOP5tmNTs
	 ZIOzZpGxHhOIfrGvXta0nIQnZgdySuWAw0+QnkPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfBRXYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:24:05 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51507 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727464AbfBRXYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:24:05 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D34FC32FB;
        Mon, 18 Feb 2019 18:24:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Feb 2019 18:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=wasUhckRRwTncBVgrgQrKvaKFiFeouSK0zO9OtZYhFI=; b=yblAlgZn
        ihQXtnigyXi9F08dbJa3yzakSWETwT2MdTcwr2/s3wB7Z0ZVLroeZCm4b2MHnNwK
        Rq/3sXCEynHBhlp+rVULogpaoPScmRGxbsIlo2UnBLwudVJ+TqoACSBexKpfToZ+
        n0mbRDgPe1icwVbCdciXc6PRaHX9SvVjlfl0RyEaiVoxdNxGMo1G3AR/DVlCL29l
        AReCzPKGb8qcppr6/ROSbsvTZa+D0/zsAWsum9jEagiA13HxeZ8rtD5KMChhqu2B
        +YOmqL6SKCQjgazmMyF+3hbFwGt48PTVqFB9fI/wDUySxr1Tl+1yJ4e8vgU5LH2F
        AfJDLk3UOS6dEg==
X-ME-Sender: <xms:kz5rXDS6W2a9H4_fY8Rf_iYL3qyDRQrkWSOfOIeDq1ADIfDcqPAztA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtddvgddtjeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvddurdeggedrvddtvddrudeftdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:kz5rXApABgdSWryWNuMdxC_--wVs-IM91vIipVOo1giXEzcoF76IOg>
    <xmx:kz5rXBpRRsKwUQtiaFdOhhvcOLfDCC5b8CVt3GKX4aTsw91lqjkVhQ>
    <xmx:kz5rXL02jgOTVe125mcPrVeILFDTio_HiuZ2y2hteDQwlGt0hKRi5g>
    <xmx:kz5rXLcXQpfhpzmqq-7Ld5whjOrhJn6oC9-4G5Dtd-0InbIunOgGwA>
Received: from eros.localdomain (ppp121-44-202-130.bras1.syd2.internode.on.net [121.44.202.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8760D1026E;
        Mon, 18 Feb 2019 18:24:00 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] lib/string: Enable string selftesting
Date:   Tue, 19 Feb 2019 10:23:03 +1100
Message-Id: <20190218232308.11241-2-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218232308.11241-1-tobin@kernel.org>
References: <20190218232308.11241-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have a test module but it is not tied into the kselftest
infrastructure.  In preparation for adding string manipulation functions
and testing we should enable kselftest to utilize the test module.

Enable string testing via kselftest infrastructure.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 lib/Kconfig.debug                     | 14 ++++++++++++++
 lib/Makefile                          |  2 +-
 lib/test_string.c                     |  4 ++--
 tools/testing/selftests/lib/Makefile  |  2 +-
 tools/testing/selftests/lib/config    |  1 +
 tools/testing/selftests/lib/string.sh | 19 +++++++++++++++++++
 6 files changed, 38 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/lib/string.sh

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4df5b24d75e..0dca64c1d8a4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1802,8 +1802,22 @@ config ASYNC_RAID6_TEST
 config TEST_HEXDUMP
 	tristate "Test functions located in the hexdump module at runtime"
 
+config TEST_STRING
+       tristate "Perform selftest on string manipulation functions"
+       default n
+       help
+        Enable this option to test string manipulation functions.
+	Currently this only tests memset_{16,32,64}.
+
+	If unsure, say N.
+
 config TEST_STRING_HELPERS
 	tristate "Test functions located in the string_helpers module at runtime"
+	default n
+	help
+	 Enable this option to unit test code in lib/string_helpers.c
+
+	 If unsure, say N.
 
 config TEST_KSTRTOX
 	tristate "Test kstrto*() family of functions at runtime"
diff --git a/lib/Makefile b/lib/Makefile
index e1b59da71418..9c30e1fee27f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -39,7 +39,7 @@ obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
 	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o reciprocal_div.o \
 	 once.o refcount.o usercopy.o errseq.o bucket_locks.o
-obj-$(CONFIG_STRING_SELFTEST) += test_string.o
+obj-$(CONFIG_TEST_STRING) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
 obj-y += hexdump.o
diff --git a/lib/test_string.c b/lib/test_string.c
index 0fcdb82dca86..a9cba442389a 100644
--- a/lib/test_string.c
+++ b/lib/test_string.c
@@ -111,7 +111,7 @@ static __init int memset64_selftest(void)
 	return 0;
 }
 
-static __init int string_selftest_init(void)
+static __init int test_string_init(void)
 {
 	int test, subtest;
 
@@ -137,5 +137,5 @@ static __init int string_selftest_init(void)
 	return 0;
 }
 
-module_init(string_selftest_init);
+module_init(test_string_init);
 MODULE_LICENSE("GPL v2");
diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index 70d5711e3ac8..2ee4559b277e 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -3,6 +3,6 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh
+TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh string.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index 126933bcc950..2032402ad409 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -1,3 +1,4 @@
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
+CONFIG_TEST_STRING=m
 CONFIG_PRIME_NUMBERS=m
diff --git a/tools/testing/selftests/lib/string.sh b/tools/testing/selftests/lib/string.sh
new file mode 100755
index 000000000000..99024b6f3a6a
--- /dev/null
+++ b/tools/testing/selftests/lib/string.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Runs string manipulation tests using test_string kernel module
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+if ! /sbin/modprobe -q -n test_string; then
+	echo "string: module test_string is not found [SKIP]"
+	exit $ksft_skip
+fi
+
+if /sbin/modprobe -q test_string; then
+	/sbin/modprobe -q -r test_string
+	echo "string: ok"
+else
+	echo "string: [FAIL]"
+	exit 1
+fi
-- 
2.20.1

