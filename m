Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162691-2-9832911974567083641
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
    1527162690; b=krQWVziJs4lx6qp1ERJBX0xalLsmF8CnmpmtI729dYdxHTuuzc
    aNTf2MdgfWZF3BMrGKiFl9hMCAMKXtCnA7q2H8SlZL6Aki71sUI2jUXU3a7reUDB
    UySfoHTTji4S2uj573vXfSvH9T8wL4GrwiO0l+mddwEttm8dGuubl+uqOQswTzEO
    d1a/f9QpJ+wh9B0xjp77fQKo/mmqyLHSuE+Qb+a4Ec5FhuMshQyztHiie7EwAZ/U
    cQY0RmA26X8WwJ1jfO4ofIo0hM3flS8eewOu2X2+dKSHA2S6+DfWoDzYYVGGN+Dr
    Gijy6NqRKpXyPQJjInyTrC5Oa8nPjLPpT3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162690; bh=dF6WCsOd0HyTXb8xze2Am+TBMpURpv
    +e0a6Fq/o8r3I=; b=Dh6Y+hk3gee0b0ooVSRYiKi4AkjtF+HKkrijSy2kkRwgyV
    xSjZz/K2LLjQPAku/HhvKiQ7W/3jO2i5dRNBXBGz4YVchiNtn1LUX4euKu21KxR9
    W78oDRNEeCnlwmnfT8Pk8fb4gaviD67Dc6bdVrplHWIFePKqnoZLZMDhJe9Ruzo7
    BFc8Yq8eCBKhafvjrqBBc4TEcaW0uwh7AwhiqCzwoevjCdbGIGn8200GATZa6gM5
    dvl7e8XhaOjtAAz8DkS270Fw70967mbWoEYXy0lPCbTNnY1Vkp2ELmL8YFfGpkcq
    1mzL1L9GEyFlFORUvTjk4nmzWBoN+Vpj/KwnYYQw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=aiOkgTOE x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=aiOkgTOE x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKO4VN20cg8SN2cYnmyY0a8wZfrWnMrWaLeQ6QueBlIb/vaba/Hj29DU4zjmpSWFWt5Ueleskdw3ZJOUuzALnVPDVhJh5u9ylMJLhkwwf/45yAPauW9B
    XZGypdzUZleXtVy5LLwfGrJ1x9dwDKyqVTfqwCDjeZm0laIcYu+GS5npkZLvl6q+k1c8R25A0eNdF74vr00yPcU1PxT6Ori0FULm5Y59B/GMH+IRVHeaGtLK
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=PBCxO6vcmnX1aqa4ytEA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966967AbeEXJqt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966955AbeEXJqp (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 81/92] s390: move spectre sysfs attribute code
Date: Thu, 24 May 2018 11:38:58 +0200
Message-Id: <20180524093207.033541347@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -49,6 +49,7 @@ obj-y	+= nospec-branch.o
 
 extra-y				+= head.o head64.o vmlinux.lds
 
+obj-$(CONFIG_SYSFS)		+= nospec-sysfs.o
 CFLAGS_REMOVE_nospec-branch.o	+= $(CC_FLAGS_EXPOLINE)
 
 obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
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
