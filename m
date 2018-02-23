Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519420185; cv=none;
        d=google.com; s=arc-20160816;
        b=ODKMCTiz/oqaQay5sgra02YOrggZEMaxMv2ma/2gK2S72kKyCg8KnDzN0dGh4+Uzf+
         LiDfuAdOiTlVywwzhD9SkHazakBycG+UzcGeymqq/yUP6egFBCVTSfIHSaV0ycEWLaUG
         fBpfXG65u11e/8c2LO1XOOvHJoLckDWOqI64pGBcP2btzrvRI+3BL2TPG1i55k1Gk9/x
         0nvObobqCLvGfsoU3XogCZo1iA5rxyezlrTGi1+kdqsBdqmnEAFMqP0h6T42q1cE2ym4
         QwuDi6drd8E9V86Gi95QpN3UFH6a3PWsSW2UXny4nW+nGc8FZNuheSBcDnDAsg+UeEFc
         RalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=zxD032hDEg0q3J6hg2UhWFukYFGV+9FMSco53oLWH5Y=;
        b=qQqaXQiO2HBwNRqi9koHOZuNMY57JJ3iTWRtyZTUtqJoeQ55TeKnRvyhfZMc3lrSqr
         /PFx/EXv6/iWXnXa4Kj9HqR5n8TGh4XbfVbRDmsET43YlBM4gxnf6EwRMOjTzc3crE/+
         aOsSBHj75IGNRlqjJyl765WePLMJHKMwgjVIqo3uZjaeKSqdoxFc61zzS5mpBdhAkCAS
         qdlNHwjPZDmTDFjLVTCQWb1yy70hIKDGGUHtX7oyJFUGBuZqzWcyEaULOOm5MXlZnYGS
         1BJ39mX6XNCBulbmW54msGP0TSmKO6MVNz+hAzE+2T1dGbUqm7ON/D+uzHomrsccBOUo
         5Iwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gZHGcp39;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gZHGcp39;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv3lSmn5V+tYW/b2IZ5xHTVR/2pfJCI5QVWzuRVufzeXJhZDGCW+SBjGw05+ZGtIY5FyvbHAg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Brian Norris <computersforpeace@gmail.com>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE),
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] ARM: Allow this header to be included by assembly files
Date: Fri, 23 Feb 2018 13:09:20 -0800
Message-Id: <20180223210923.544-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223210923.544-1-f.fainelli@gmail.com>
References: <20180223210923.544-1-f.fainelli@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593227540099720483?=
X-GMAIL-MSGID: =?utf-8?q?1593227540099720483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Doug Berger <opendmb@gmail.com>

The constants defined in this file are equally useful in assembly and C
source files. The arm64 architecture version of this file allows
inclusion in both assembly and C source files, so this this commit adds
that capability to the arm architecture version so that the constants
don't need to be defined in multiple places.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/cputype.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index cb546425da8a..e7632f536633 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -2,9 +2,6 @@
 #ifndef __ASM_ARM_CPUTYPE_H
 #define __ASM_ARM_CPUTYPE_H
 
-#include <linux/stringify.h>
-#include <linux/kernel.h>
-
 #define CPUID_ID	0
 #define CPUID_CACHETYPE	1
 #define CPUID_TCM	2
@@ -98,6 +95,11 @@
 /* Qualcomm implemented cores */
 #define ARM_CPU_PART_SCORPION		0x510002d0
 
+#ifndef __ASSEMBLY__
+
+#include <linux/stringify.h>
+#include <linux/kernel.h>
+
 extern unsigned int processor_id;
 
 #ifdef CONFIG_CPU_CP15
@@ -326,4 +328,6 @@ static inline int __attribute_const__ cpuid_feature_extract_field(u32 features,
 #define cpuid_feature_extract(reg, field) \
 	cpuid_feature_extract_field(read_cpuid_ext(reg), field)
 
+#endif /* __ASSEMBLY__ */
+
 #endif
-- 
2.14.1
