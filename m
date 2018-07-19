Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78AEECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A8F20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A8F20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbeGSJdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:33:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:2621 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbeGSJdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:33:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 01:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,374,1526367600"; 
   d="scan'208";a="65829590"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2018 01:51:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8F9D436B; Thu, 19 Jul 2018 11:51:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Coly Li <colyli@suse.de>
Subject: [PATCH v1] lib: Remove 'default n' in Kconfig for tests
Date:   Thu, 19 Jul 2018 11:51:31 +0300
Message-Id: <20180719085131.79541-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems contributors follow the style of Kconfig entries where explicit
'default n' is present. The default 'default' is 'n' already, thus, drop
these lines from Kconfig to make it more clear.

Cc: Coly Li <colyli@suse.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/Kconfig       |  1 -
 lib/Kconfig.debug | 17 -----------------
 2 files changed, 18 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 031655d26dce..40bfa6ccd294 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -231,7 +231,6 @@ config AUDIT_COMPAT_GENERIC
 
 config RANDOM32_SELFTEST
 	bool "PRNG perform self test on init"
-	default n
 	help
 	  This option enables the 32 bit PRNG library functions to perform a
 	  self test on initialization.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c731ff97500c..244c08055d8e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1225,7 +1225,6 @@ config LOCK_TORTURE_TEST
 	tristate "torture tests for locking"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
-	default n
 	help
 	  This option provides a kernel module that runs torture tests
 	  on kernel locking primitives.  The kernel module may be built
@@ -1692,7 +1691,6 @@ config LKDTM
 	tristate "Linux Kernel Dump Test Tool Module"
 	depends on DEBUG_FS
 	depends on BLOCK
-	default n
 	help
 	This module enables testing of the different dumping mechanisms by
 	inducing system failures at predefined crash points.
@@ -1726,7 +1724,6 @@ config KPROBES_SANITY_TEST
 	bool "Kprobes sanity tests"
 	depends on DEBUG_KERNEL
 	depends on KPROBES
-	default n
 	help
 	  This option provides for testing basic kprobes functionality on
 	  boot. Samples of kprobe and kretprobe are inserted and
@@ -1737,7 +1734,6 @@ config KPROBES_SANITY_TEST
 config BACKTRACE_SELF_TEST
 	tristate "Self test for the backtrace code"
 	depends on DEBUG_KERNEL
-	default n
 	help
 	  This option provides a kernel module that can be used to test
 	  the kernel stack backtrace code. This option is not useful
@@ -1807,7 +1803,6 @@ config TEST_PRINTF
 
 config TEST_BITMAP
 	tristate "Test bitmap_*() family of functions at runtime"
-	default n
 	help
 	  Enable this option to test the bitmap functions at boot.
 
@@ -1831,7 +1826,6 @@ config TEST_OVERFLOW
 
 config TEST_RHASHTABLE
 	tristate "Perform selftest on resizable hash table"
-	default n
 	help
 	  Enable this option to test the rhashtable functions at boot.
 
@@ -1839,7 +1833,6 @@ config TEST_RHASHTABLE
 
 config TEST_HASH
 	tristate "Perform selftest on hash functions"
-	default n
 	help
 	  Enable this option to test the kernel's integer (<linux/hash.h>),
 	  string (<linux/stringhash.h>), and siphash (<linux/siphash.h>)
@@ -1853,7 +1846,6 @@ config TEST_IDA
 
 config TEST_PARMAN
 	tristate "Perform selftest on priority array manager"
-	default n
 	depends on PARMAN
 	help
 	  Enable this option to test priority array manager on boot
@@ -1863,7 +1855,6 @@ config TEST_PARMAN
 
 config TEST_LKM
 	tristate "Test module loading with 'hello world' module"
-	default n
 	depends on m
 	help
 	  This builds the "test_module" module that emits "Hello, world"
@@ -1877,7 +1868,6 @@ config TEST_LKM
 
 config TEST_USER_COPY
 	tristate "Test user/kernel boundary protections"
-	default n
 	depends on m
 	help
 	  This builds the "test_user_copy" module that runs sanity checks
@@ -1890,7 +1880,6 @@ config TEST_USER_COPY
 
 config TEST_BPF
 	tristate "Test BPF filter functionality"
-	default n
 	depends on m && NET
 	help
 	  This builds the "test_bpf" module that runs various test vectors
@@ -1904,7 +1893,6 @@ config TEST_BPF
 
 config FIND_BIT_BENCHMARK
 	tristate "Test find_bit functions"
-	default n
 	help
 	  This builds the "test_find_bit" module that measure find_*_bit()
 	  functions performance.
@@ -1913,7 +1901,6 @@ config FIND_BIT_BENCHMARK
 
 config TEST_FIRMWARE
 	tristate "Test firmware loading via userspace interface"
-	default n
 	depends on FW_LOADER
 	help
 	  This builds the "test_firmware" module that creates a userspace
@@ -1926,7 +1913,6 @@ config TEST_FIRMWARE
 
 config TEST_SYSCTL
 	tristate "sysctl test driver"
-	default n
 	depends on PROC_SYSCTL
 	help
 	  This builds the "test_sysctl" module. This driver enables to test the
@@ -1937,7 +1923,6 @@ config TEST_SYSCTL
 
 config TEST_UDELAY
 	tristate "udelay test driver"
-	default n
 	help
 	  This builds the "udelay_test" module that helps to make sure
 	  that udelay() is working properly.
@@ -1946,7 +1931,6 @@ config TEST_UDELAY
 
 config TEST_STATIC_KEYS
 	tristate "Test static keys"
-	default n
 	depends on m
 	help
 	  Test the static key interfaces.
@@ -1955,7 +1939,6 @@ config TEST_STATIC_KEYS
 
 config TEST_KMOD
 	tristate "kmod stress tester"
-	default n
 	depends on m
 	depends on BLOCK && (64BIT || LBDAF)	  # for XFS, BTRFS
 	depends on NETDEVICES && NET_CORE && INET # for TUN
-- 
2.18.0

