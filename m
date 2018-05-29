Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524644-1527568703-2-14308859200060754764
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527568703; b=DPvozsHyOWrw0b38a4DdVvSGiD6RBrYQXuR7nmUunae4aPWKGl
    MPlmXagLJmfXZT+Yn9soZQpXqWyFXgUk+9B8zMRTsGMse2fF8GRcIhZWbje+MXPk
    bDAt6FqV21YRWR+lJlW2Gl2RM4eQCUDqSDukFEoGII3bJCPKg0ganBKeYisG9fze
    JNzYapmWXOgJWgjienpBQZR+jgzCKX6iJTYC11sWCQreoYUndfBbE/KSLBhFO6mM
    eGYdgjrHgNtZh7qmX/9ilNSjs3XST5zZdakMeBFFoNKiEkJV8EC56TqBhVt7RsNv
    5VdGv9uJSirK5HWGNx0pRELXbrv0AypB219g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527568703; bh=83IQe3pZmu3WcWM/FSQdDQLW0ZO5EU
    GxzWPuKx4qtNU=; b=mDNg2KKjjWC3ASSUzy7t255EHjx22mDybRuzIjuzqtaaTi
    ZR0qGnXBxgkyHIF221PA0RqHhWgLp9VEKCfWlWXpUX7JcUGhVHRh3HhOf7xzOv7M
    DHbSNM6zHCisdnG5/c4/7Azh796Fr5X3EL0sbqneqSZNLU3lb7Ao0Z4UmDxz9+i/
    rnuzx12ztmweEa944n5x4hFMf2TrvNXUPRxF3xRh70AwVRxABj602bIOpBcY9yNM
    7zkfK7oL/xcd9G1UxOd2zGIUjVpF4aFGVeUK2sWMQs7sLn7sYo9Rtoa6ozpj3LTR
    S6OhZg1JZJgWHSCLG08dZg82jjM4RiA/S/Y6feRA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=OXxBIaWA
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=jWDP+zt1;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=OXxBIaWA
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=jWDP+zt1;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAQtK/53DABqNdlOcFziIcdHxLHDRcA7zo/oanKRBbV03uR9rtKEdoroYO09iqHjO2cQWbNP3ngL+GyeXQ58Q6YnDZYN23qnbOZu8coyw1F2DM2yiAVJ
    fGHKc/qOBrwU7WgU8w0q/v39B7MNyH82nQ4+rXSVHcXHT3qxdT00PKsC/CX/5EJcs0btWCyiLY5JbJG5QhjtJf2jVm2qERDvYCvOhs4KioE0Ye1a/fR2STNy
    BvDe8Nv4txWdHAzB3itF5Q==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=agizdKYkGd8A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=knMS2wLuVtuG5UEON8gA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbeE2EiR (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 00:38:17 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37655 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754646AbeE2EiP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 00:38:15 -0400
X-Google-Smtp-Source: AB8JxZqmnCdOz27XY1Oxfj7NneqaBOpvHvwkWEMkyU0S9p1L5BewVR+AB/tBIPh3srCCQQL/3jqK6A==
From: YaoJun <yaojun8558363@gmail.com>
To: kernel-hardening@lists.openwall.com
Cc: linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: [PATCH 3/4] migrate swapper_pg_dir
Date: Tue, 29 May 2018 12:38:08 +0800
Message-Id: <20180529043808.27896-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Because tramp_map_kernel/tramp_unmap_kernel macro update
ttbr1 by add/sub offset, so we need to migrate both
swapper_pg_dir and tramp_pg_dir. Before doing that, make
tramp_pg_dir and swapper_pg_dir adjacent.

---
 arch/arm64/kernel/entry.S       |  4 ++--
 arch/arm64/kernel/vmlinux.lds.S | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ec2ee720e33e..b35425feaf56 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1004,7 +1004,7 @@ __ni_sys_trace:
 
 	.macro tramp_map_kernel, tmp
 	mrs	\tmp, ttbr1_el1
-	add	\tmp, \tmp, #(PAGE_SIZE + RESERVED_TTBR0_SIZE)
+	add	\tmp, \tmp, #(PAGE_SIZE)
 	bic	\tmp, \tmp, #USER_ASID_FLAG
 	msr	ttbr1_el1, \tmp
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
@@ -1023,7 +1023,7 @@ alternative_else_nop_endif
 
 	.macro tramp_unmap_kernel, tmp
 	mrs	\tmp, ttbr1_el1
-	sub	\tmp, \tmp, #(PAGE_SIZE + RESERVED_TTBR0_SIZE)
+	sub	\tmp, \tmp, #(PAGE_SIZE)
 	orr	\tmp, \tmp, #USER_ASID_FLAG
 	msr	ttbr1_el1, \tmp
 	/*
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 0221aca6493d..a094156e05a4 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -219,15 +219,15 @@ SECTIONS
 	idmap_pg_dir = .;
 	. += IDMAP_DIR_SIZE;
 
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	tramp_pg_dir = .;
-	. += PAGE_SIZE;
-#endif
-
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	reserved_ttbr0 = .;
 	. += RESERVED_TTBR0_SIZE;
 #endif
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	tramp_pg_dir = .;
+	. += PAGE_SIZE;
+#endif
 	swapper_pg_dir = .;
 	. += SWAPPER_DIR_SIZE;
 	swapper_pg_end = .;
-- 
2.17.0

