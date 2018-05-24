Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162488-2-16164786324287850389
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162488; b=CaoBEa5u5WQlSz8B3r0UAwpcC6+eIAVkdVC/ImM8WQPtgNeuCM
    VsUC6ZxWfLSXT7/NzbQcfoffkN4/ylmqXC7ARih3nzCqM/lXx0iWoqGzoplcvI/2
    8FfRL/44wLN9ZLINCbwJuR0hNfAVn3wOzkKNSkEHsUwjEcUVpKJEVlUlhP6YZFUF
    N1SlpCtKWLNtXUWcionpqmgM5eRrjQtQOkxnqfbwvh6pBMQX6h5nYBAXT53822C7
    ojBOIPeyb8I65GuF3FdcMwPdwc9Y5muPK83HvfG3dHq02W5dqCloyBKBJP4R/Fhv
    rRbOBxcyguoa+9BEzowP8OoQWfLt9C8KF01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162488; bh=WxgXJPL5bGA81jZFpe9TiUX3NG0gvH
    +WGhE6VHjASWc=; b=GyPTGFFYzQ21JxwQBvC3LZNm57RPd41+UOkqI6NTiAsANO
    beZi4vmsOgDSGuGpbBIld9pKXNQSlPF+93xcwZ1qjijcXUqC45+KDbBFpHumrQet
    eCNOhbmvQE/e5pvooDQimA0Q/91DYGTaAU9QcQa6mLNjWTbyaMqFnFOS6nqYNg+/
    MhK2jlQkQYHt9JG+OaZlDw8WGQ8N9IabADAj3aQ08XTn6GjuuCbryKDPBjdxmmaf
    TcOOicnqMYvgZR3txHuzkKXE2Ay0vgDD5LAFjR9bzYXoGwOgbQGbqzI5bg6uRd9I
    n2x+LfDND7legNfG1CgsqPVxspSh4rNQhWTIisaw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=T/BLfUd4 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=T/BLfUd4 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIS5Gxi607/rNJlUXB5YDAxadGr/3GRUVVfIeZ8tGg2/dSArDVuWeuBgIId/ofQIobvtN8LgdlyPcFkXDw5K7jLJv1qGFgZTHyfEBjUASNPpHLc1gOir
    tsvLr2EENYjHjjOGFs/oovSfvIgWzK4ygp4LJuYnVIQ2sUe9RDTc0yMpXxTYntPWVTQB2X8i7y04luKsobGT1f1Oq7F2dquUhbFXyvzIRpcjEgg/A7Yh4Odm
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=PBCxO6vcmnX1aqa4ytEA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969275AbeEXLsB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967045AbeEXJrX (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:47:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 15/96] s390: move spectre sysfs attribute code
Date: Thu, 24 May 2018 11:37:58 +0200
Message-Id: <20180524093606.452554007@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit 4253b0e0627ee3461e64c2495c616f1c8f6b127b ]

The nospec-branch.c file is compiled without the gcc options to
generate expoline thunks. The return branch of the sysfs show
functions cpu_show_spectre_v1 and cpu_show_spectre_v2 is an indirect
branch as well. These need to be compiled with expolines.

Move the sysfs functions for spectre reporting to a separate file
and loose an '.' for one of the messages.

Cc: stable@vger.kernel.org # 4.16
Fixes: d424986f1d ("s390: add sysfs attributes for spectre")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/Makefile        |    1 +
 arch/s390/kernel/nospec-branch.c |   18 ------------------
 arch/s390/kernel/nospec-sysfs.c  |   21 +++++++++++++++++++++
 3 files changed, 22 insertions(+), 18 deletions(-)
 create mode 100644 arch/s390/kernel/nospec-sysfs.c

--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -63,6 +63,7 @@ obj-y	+= nospec-branch.o
 
 extra-y				+= head.o head64.o vmlinux.lds
 
+obj-$(CONFIG_SYSFS)		+= nospec-sysfs.o
 CFLAGS_REMOVE_nospec-branch.o	+= $(CC_FLAGS_EXPOLINE)
 
 obj-$(CONFIG_MODULES)		+= module.o
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -44,24 +44,6 @@ static int __init nospec_report(void)
 }
 arch_initcall(nospec_report);
 
-#ifdef CONFIG_SYSFS
-ssize_t cpu_show_spectre_v1(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
-}
-
-ssize_t cpu_show_spectre_v2(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable)
-		return sprintf(buf, "Mitigation: execute trampolines\n");
-	if (__test_facility(82, S390_lowcore.alt_stfle_fac_list))
-		return sprintf(buf, "Mitigation: limited branch prediction.\n");
-	return sprintf(buf, "Vulnerable\n");
-}
-#endif
-
 #ifdef CONFIG_EXPOLINE
 
 int nospec_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
--- /dev/null
+++ b/arch/s390/kernel/nospec-sysfs.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+#include <linux/cpu.h>
+#include <asm/facility.h>
+#include <asm/nospec-branch.h>
+
+ssize_t cpu_show_spectre_v1(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+}
+
+ssize_t cpu_show_spectre_v2(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable)
+		return sprintf(buf, "Mitigation: execute trampolines\n");
+	if (__test_facility(82, S390_lowcore.alt_stfle_fac_list))
+		return sprintf(buf, "Mitigation: limited branch prediction\n");
+	return sprintf(buf, "Vulnerable\n");
+}
