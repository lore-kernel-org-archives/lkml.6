Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826708-2-13372852926512137869
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826708; b=kqxpGTuErrvkNVe8k2hmDksgT9mGRhdp4RgHotAmKs/N/nz
    E2X/oyajDtz7Bbg2tv+SkFdODYPAMrdQtXBaXUII10VtEo/5pwk4KgirqqWzM7tH
    hSYon77rrXbm8br00qQj/dnrgq4yN3iY60ru0Ta+iNnuldTCOqNZJ3ve3xrXu/oi
    5CS0sxqQY3atyWYBcFcwHdkZ//QNR6sCc830xBb+SZXqsz2UCN4wp02YThOZ+Foh
    sSkVm5jN2lpfo1mvmxvJJKMbSgC2ZnBaezQSOfMOyG5SjKo1JPpgjnJJUXITdQqb
    Ak/JECh7iM6vd8q1qd99yNqXUrPfAAEeGzFyqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826708; bh=LMXBvNXDbth1EZpW5fd
    yNI3Guo/y3Pa2e3Z7GasYkh0=; b=p2pNz8uHCr4pbkOkLHoAQU4lTH2047ycTYJ
    NW94H3oUDQCyBmwRB50Hinn57DmxUn6pzP5b48nQrsjhGj+Q7Sh9tel2a6Di5BVF
    nFgZypJ+VEXBo1yvByb4hVl9CJlCcYAOXtmpNEnUImV//peNICc1YLTVfriISlrh
    WW+ITXmK3hXJ+5T/UZHGSLPR2VpPBTxbIAw2es9PUwwMcJSs11pjW0I4IOtrSmNs
    9qO07Wu5XCuLk+Dihca2a+lHDr7SHt3hJiJ5oH+o0nSMwmqR2CK3nLdkDgQxkPAy
    1J9JufvY2h7R4UcyOTIkV+qZ/Sj3PXyfUmISfsAYf+jxT7Y/DgA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932589AbeCLDue (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:50:34 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41049 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932587AbeCLDHj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:39 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Kees Cook" <keescook@chromium.org>,
        "Frantisek Hrbata" <fhrbata@redhat.com>,
        "Rusty Russell" <rusty@rustcorp.com.au>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Andy Gospodarek" <agospoda@redhat.com>,
        "Peter Oberparleiter" <peter.oberparleiter@de.ibm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Jan Stancek" <jstancek@redhat.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.325190716@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 016/104] gcov: compile specific gcov implementation
 based on gcc version
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Frantisek Hrbata <fhrbata@redhat.com>

commit 17c568d60af5a810208baf116dc174a2005c6c3e upstream.

Compile the correct gcov implementation file for the specific gcc version.

Signed-off-by: Frantisek Hrbata <fhrbata@redhat.com>
Cc: Jan Stancek <jstancek@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Acked-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Gospodarek <agospoda@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/gcov.txt |  4 ++++
 kernel/gcov/Kconfig    | 30 ++++++++++++++++++++++++++++++
 kernel/gcov/Makefile   | 32 +++++++++++++++++++++++++++++++-
 3 files changed, 65 insertions(+), 1 deletion(-)

--- a/Documentation/gcov.txt
+++ b/Documentation/gcov.txt
@@ -50,6 +50,10 @@ Configure the kernel with:
         CONFIG_DEBUG_FS=y
         CONFIG_GCOV_KERNEL=y
 
+select the gcc's gcov format, default is autodetect based on gcc version:
+
+        CONFIG_GCOV_FORMAT_AUTODETECT=y
+
 and to get coverage data for the entire kernel:
 
         CONFIG_GCOV_PROFILE_ALL=y
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -46,4 +46,34 @@ config GCOV_PROFILE_ALL
 	larger and run slower. Also be sure to exclude files from profiling
 	which are not linked to the kernel image to prevent linker errors.
 
+choice
+	prompt "Specify GCOV format"
+	depends on GCOV_KERNEL
+	default GCOV_FORMAT_AUTODETECT
+	---help---
+	The gcov format is usually determined by the GCC version, but there are
+	exceptions where format changes are integrated in lower-version GCCs.
+	In such a case use this option to adjust the format used in the kernel
+	accordingly.
+
+	If unsure, choose "Autodetect".
+
+config GCOV_FORMAT_AUTODETECT
+	bool "Autodetect"
+	---help---
+	Select this option to use the format that corresponds to your GCC
+	version.
+
+config GCOV_FORMAT_3_4
+	bool "GCC 3.4 format"
+	---help---
+	Select this option to use the format defined by GCC 3.4.
+
+config GCOV_FORMAT_4_7
+	bool "GCC 4.7 format"
+	---help---
+	Select this option to use the format defined by GCC 4.7.
+
+endchoice
+
 endmenu
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -1,3 +1,33 @@
 ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
 
-obj-$(CONFIG_GCOV_KERNEL) := base.o fs.o gcc_3_4.o
+# if-lt
+# Usage VAR := $(call if-lt, $(a), $(b))
+# Returns 1 if (a < b)
+if-lt = $(shell [ $(1) -lt $(2) ] && echo 1)
+
+ifeq ($(CONFIG_GCOV_FORMAT_3_4),y)
+  cc-ver := 0304
+else ifeq ($(CONFIG_GCOV_FORMAT_4_7),y)
+  cc-ver := 0407
+else
+# Use cc-version if available, otherwise set 0
+#
+# scripts/Kbuild.include, which contains cc-version function, is not included
+# during make clean "make -f scripts/Makefile.clean obj=kernel/gcov"
+# Meaning cc-ver is empty causing if-lt test to fail with
+# "/bin/sh: line 0: [: -lt: unary operator expected" error mesage.
+# This has no affect on the clean phase, but the error message could be
+# confusing/annoying. So this dummy workaround sets cc-ver to zero if cc-version
+# is not available. We can probably move if-lt to Kbuild.include, so it's also
+# not defined during clean or to include Kbuild.include in
+# scripts/Makefile.clean. But the following workaround seems least invasive.
+  cc-ver := $(if $(call cc-version),$(call cc-version),0)
+endif
+
+obj-$(CONFIG_GCOV_KERNEL) := base.o fs.o
+
+ifeq ($(call if-lt, $(cc-ver), 0407),1)
+  obj-$(CONFIG_GCOV_KERNEL) += gcc_3_4.o
+else
+  obj-$(CONFIG_GCOV_KERNEL) += gcc_4_7.o
+endif
