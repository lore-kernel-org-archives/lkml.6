Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B475BC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB3A20685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc9yfDry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB3A20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeKUHrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:47:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbeKUHrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:47:20 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 681DF20685;
        Tue, 20 Nov 2018 21:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542748570;
        bh=ofFYXHeP5Muox6X2e+b5ZVaxyiCF50M1b/I6aMBsktc=;
        h=To:From:Cc:Subject:Date:From;
        b=Bc9yfDryZkVNfwtIoK8t0FAFW/8gP37dVbtqB28p/Fn72vdx6kHSlqM/bMVnPPJni
         lYks9/3hmOnZh8FzceaZwxUm2f0Ht1ei1CpY07HwYELYZnOEv+g0i9N37uJtrQ+w/U
         3Z/86B7SM6j56XoDLvfoTIGq3j3QK81IS9Zs4BKk=
To:     rafael@kernel.org
From:   shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        trenn@suse.de, shuah@kernel.org
Subject: [GIT PULL] cpupower update for Linux 4.20-rc4
Message-ID: <31b25f3d-f727-a94f-83cc-3258444abf11@kernel.org>
Date:   Tue, 20 Nov 2018 14:16:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------9F3D728952903B7190E3A501"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9F3D728952903B7190E3A501
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following update for Linux 4.20-rc4 or rc5 depending on 
your pm pull schedule to Linus.

This cpupower update for Linux 4.20-rc4 consists of compile fixes to 
allow use of outside build flags and override of CFLAGS from Jiri Olsa, 
and fix to compilation with STATIC=true from Konstantin Khlebnikov.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
tags/linux-cpupower-4.20-rc4

for you to fetch changes up to dbc4ca339c8dbdd8652ce57c16bf5ef45ee4307e:

   tools cpupower: Override CFLAGS assignments (2018-11-06 08:54:16 -0700)

----------------------------------------------------------------
linux-cpupower-4.20-rc4

This cpupower update for Linux 4.20-rc4 consists of compile fixes to allow
use of outside build flags and override of CFLAGS from Jiri Olsa, and fix
to compilation with STATIC=true from Konstantin Khlebnikov.

----------------------------------------------------------------
Jiri Olsa (2):
       tools cpupower debug: Allow to use outside build flags
       tools cpupower: Override CFLAGS assignments

Konstantin Khlebnikov (1):
       tools/power/cpupower: fix compilation with STATIC=true

  tools/power/cpupower/Makefile              | 12 ++++++------
  tools/power/cpupower/bench/Makefile        |  2 +-
  tools/power/cpupower/debug/x86_64/Makefile |  4 ++--
  tools/power/cpupower/lib/cpufreq.c         |  2 +-
  tools/power/cpupower/lib/cpuidle.c         |  2 +-
  tools/power/cpupower/lib/cpupower.c        |  4 ++--
  tools/power/cpupower/lib/cpupower_intern.h |  2 +-
  7 files changed, 14 insertions(+), 14 deletions(-)

----------------------------------------------------------------


--------------9F3D728952903B7190E3A501
Content-Type: text/x-patch;
 name="linux-cpupower-4.20-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-4.20-rc4.diff"

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 1dd5f4fcffd5..db66a952c173 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -129,7 +129,7 @@ WARNINGS += $(call cc-supports,-Wno-pointer-sign)
 WARNINGS += $(call cc-supports,-Wdeclaration-after-statement)
 WARNINGS += -Wshadow
 
-CFLAGS += -DVERSION=\"$(VERSION)\" -DPACKAGE=\"$(PACKAGE)\" \
+override CFLAGS += -DVERSION=\"$(VERSION)\" -DPACKAGE=\"$(PACKAGE)\" \
 		-DPACKAGE_BUGREPORT=\"$(PACKAGE_BUGREPORT)\" -D_GNU_SOURCE
 
 UTIL_OBJS =  utils/helpers/amd.o utils/helpers/msr.o \
@@ -156,12 +156,12 @@ LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c
 LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o
 LIB_OBJS :=	$(addprefix $(OUTPUT),$(LIB_OBJS))
 
-CFLAGS +=	-pipe
+override CFLAGS +=	-pipe
 
 ifeq ($(strip $(NLS)),true)
 	INSTALL_NLS += install-gmo
 	COMPILE_NLS += create-gmo
-	CFLAGS += -DNLS
+	override CFLAGS += -DNLS
 endif
 
 ifeq ($(strip $(CPUFREQ_BENCH)),true)
@@ -175,7 +175,7 @@ ifeq ($(strip $(STATIC)),true)
         UTIL_SRC += $(LIB_SRC)
 endif
 
-CFLAGS += $(WARNINGS)
+override CFLAGS += $(WARNINGS)
 
 ifeq ($(strip $(V)),false)
 	QUIET=@
@@ -188,10 +188,10 @@ export QUIET ECHO
 
 # if DEBUG is enabled, then we do not strip or optimize
 ifeq ($(strip $(DEBUG)),true)
-	CFLAGS += -O1 -g -DDEBUG
+	override CFLAGS += -O1 -g -DDEBUG
 	STRIPCMD = /bin/true -Since_we_are_debugging
 else
-	CFLAGS += $(OPTIMIZATION) -fomit-frame-pointer
+	override CFLAGS += $(OPTIMIZATION) -fomit-frame-pointer
 	STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
 endif
 
diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index d79ab161cc75..f68b4bc55273 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -9,7 +9,7 @@ endif
 ifeq ($(strip $(STATIC)),true)
 LIBS = -L../ -L$(OUTPUT) -lm
 OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o \
-       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/sysfs.o
+       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/cpupower.o
 else
 LIBS = -L../ -L$(OUTPUT) -lm -lcpupower
 OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o
diff --git a/tools/power/cpupower/debug/x86_64/Makefile b/tools/power/cpupower/debug/x86_64/Makefile
index 59af84b8ef45..b1b6c43644e7 100644
--- a/tools/power/cpupower/debug/x86_64/Makefile
+++ b/tools/power/cpupower/debug/x86_64/Makefile
@@ -13,10 +13,10 @@ INSTALL = /usr/bin/install
 default: all
 
 $(OUTPUT)centrino-decode: ../i386/centrino-decode.c
-	$(CC) $(CFLAGS) -o $@ $<
+	$(CC) $(CFLAGS) -o $@ $(LDFLAGS) $<
 
 $(OUTPUT)powernow-k8-decode: ../i386/powernow-k8-decode.c
-	$(CC) $(CFLAGS) -o $@ $<
+	$(CC) $(CFLAGS) -o $@ $(LDFLAGS) $<
 
 all: $(OUTPUT)centrino-decode $(OUTPUT)powernow-k8-decode
 
diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index 1b993fe1ce23..0c0f3e3f0d80 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -28,7 +28,7 @@ static unsigned int sysfs_cpufreq_read_file(unsigned int cpu, const char *fname,
 
 	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/cpufreq/%s",
 			 cpu, fname);
-	return sysfs_read_file(path, buf, buflen);
+	return cpupower_read_sysfs(path, buf, buflen);
 }
 
 /* helper function to write a new value to a /sys file */
diff --git a/tools/power/cpupower/lib/cpuidle.c b/tools/power/cpupower/lib/cpuidle.c
index 9bd4c7655fdb..852d25462388 100644
--- a/tools/power/cpupower/lib/cpuidle.c
+++ b/tools/power/cpupower/lib/cpuidle.c
@@ -319,7 +319,7 @@ static unsigned int sysfs_cpuidle_read_file(const char *fname, char *buf,
 
 	snprintf(path, sizeof(path), PATH_TO_CPU "cpuidle/%s", fname);
 
-	return sysfs_read_file(path, buf, buflen);
+	return cpupower_read_sysfs(path, buf, buflen);
 }
 
 
diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index 9c395ec924de..9711d628b0f4 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -15,7 +15,7 @@
 #include "cpupower.h"
 #include "cpupower_intern.h"
 
-unsigned int sysfs_read_file(const char *path, char *buf, size_t buflen)
+unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen)
 {
 	int fd;
 	ssize_t numread;
@@ -95,7 +95,7 @@ static int sysfs_topology_read_file(unsigned int cpu, const char *fname, int *re
 
 	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/topology/%s",
 			 cpu, fname);
-	if (sysfs_read_file(path, linebuf, MAX_LINE_LEN) == 0)
+	if (cpupower_read_sysfs(path, linebuf, MAX_LINE_LEN) == 0)
 		return -1;
 	*result = strtol(linebuf, &endp, 0);
 	if (endp == linebuf || errno == ERANGE)
diff --git a/tools/power/cpupower/lib/cpupower_intern.h b/tools/power/cpupower/lib/cpupower_intern.h
index 92affdfbe417..4887c76d23f8 100644
--- a/tools/power/cpupower/lib/cpupower_intern.h
+++ b/tools/power/cpupower/lib/cpupower_intern.h
@@ -3,4 +3,4 @@
 #define MAX_LINE_LEN 4096
 #define SYSFS_PATH_MAX 255
 
-unsigned int sysfs_read_file(const char *path, char *buf, size_t buflen);
+unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen);

--------------9F3D728952903B7190E3A501--
