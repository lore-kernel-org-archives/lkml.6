Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-348652-1524840318-2-12738010508377556389
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enfrro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524840316; b=ITlz4gRJ3wEc4norNui5Fm/DNVix9f6Cj0SxIOosK0rbP9lqea
    2n6dcFSP2wtOm/6jbvZctidqK71qTpS1Kz1xb7L+qcsim/abyUwysKPSCdQyIFlI
    Wz4wj0UGpi7vdGoYPzgCWKG/c4UnMHGhaMuWoxlUPs8hlEIG6lSmRXDkTbBiL97Y
    RzovVeo+aqu71qQRVMkepgUq6pgasMry6oUb8sWAOi3TqUDIjkimBcuQW8EDS0is
    zwCy2kKzn+VtzwS6zD4XpfBueNbqfC3FSfHFH2K0Jywb/+fC8XiAtNsW//iXT/x1
    +er/E+ZEXA8xFIooBQRKxsGvu9rzMWFWmPGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524840316; bh=+lTDjlQSb87htV9LUr934oKBySe5/Y
    MgjJzwSOL5xIk=; b=VYS0YI1MlxBIul7Yt84TXeu7H96oXKysNDMrYdB9pgezlv
    GUqyOwG0cMYaqDwPvf7ps25bHnk88BS+HCeZhgosInYVCdrw5ozN7Ub7uze0yazb
    FQGR7sgd83pdwslbKfUiZOzFvIGIDU5Icb3nPXWL4DqA8EBXT1a5BsZps6DbLzDG
    9TnSGWIGeCgG1IFajDjCYNcTxZmRJqT8ifgoUmB36kO4/VJo2WIxo9XmXR9AIoQ+
    9b8iWfqLmtpSK6aiJKdOGi+oL6bqieLQdINx6QcrenAjQUi5OcQCoB05kHmUWL6b
    9iiKydxPMO+8GveqTOSZukefVaNlCl7LA9oZZ8/A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA+gdmH0UObaOEgmoEMgQwB/XljKgh1xq/se6E66Db4d0f+oEZjErmEWvpDcwP9Ub+Sh9Bp39TmANy0l0nRSwbVocEU3wLGfpUgbLelSqeY/KCuE5ZCj
    0UzFrpUwosFFH/YqBWm/WFfr0kxXzYLeuuZZ6WB/cR54l2hGtPrn2KaXE7x5T41/UuRw1mSnDC5boaOuor+oYU+2Uy3NI8vgX9pdNPZ4FzahfhaMiaVuGnTC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=3N1f0yEkSuzeJIrZNHgA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934456AbeD0OIQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934455AbeD0OIO (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:08:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EF521864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 58/80] s390: add sysfs attributes for spectre
Date: Fri, 27 Apr 2018 15:58:51 +0200
Message-Id: <20180427135735.892417405@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit d424986f1d6b16079b3231db0314923f4f8deed1 ]

Set CONFIG_GENERIC_CPU_VULNERABILITIES and provide the two functions
cpu_show_spectre_v1 and cpu_show_spectre_v2 to report the spectre
mitigations.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/Kconfig                |    1 +
 arch/s390/kernel/nospec-branch.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -121,6 +121,7 @@ config S390
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_DEVICES if !SMP
+	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
+#include <linux/device.h>
 #include <asm/facility.h>
 #include <asm/nospec-branch.h>
 
@@ -43,6 +44,24 @@ static int __init nospec_report(void)
 }
 arch_initcall(nospec_report);
 
+#ifdef CONFIG_SYSFS
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
+		return sprintf(buf, "Mitigation: limited branch prediction.\n");
+	return sprintf(buf, "Vulnerable\n");
+}
+#endif
+
 #ifdef CONFIG_EXPOLINE
 
 int nospec_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
