Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2767829-1527632359-2-2343413431989324810
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527632358; b=NtnFbG/ZpcvX+I3+6v2+IE38m62HJyTCuCd1zK/9gJUt2CAg9/
    zYdKXoCwQOTV0ikpXNJmNe4HuFybzo/CVNggSeKgtfp+gImQkzEgZxcXUohBN0xb
    WRjHc1MyyTz7jZ9aSL4XblyAqXK5D0Bu5v95+kVGY3YhI+/DTJvsKY7R4QjRk0H1
    NAo7KXc6Xvhs/TAc2sWHcSfpztExO7rK1AIcnQ/IRmrYJGEGcSLTSvNfpKXCcHmW
    a1cHF3vdN2wLsbSeaJGjGTM1e5wXwvrC5GO0XVxiIA8fdwdYx5JNDcCOSmqtPWuL
    HvtdFkVV5aP+KumK1KfRkYUpVcBDC5sgHxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527632358; bh=
    3Onmr25dSz8ZQ73uJeO5gQYDVwNXRukF6Ht8jmOe+V4=; b=gGGvh4JnG8xnFoHr
    P2FAKE/xFIjsrSwh487YYusn6GIfDkUFodQ8OlgiWoudeOVQlMo5uhgyLhjLCsx/
    KjqJl3gfPfAZsYU6Azw5ThxZEBgvucQ4h+aF5DbI7mUSwtaJNd4uxzubfT6so2BB
    w6exLdbnDdZbDmzaYdGTRwm2zlaDCEtDnb4f2HqnDW0LnhvIeSaybCfWfpHLnu4q
    cIRtehflKFpDaZpnXqJT/znke5rICDDS7VQmmBUoP6Q+otnulmvXGm4KY8x82w9I
    x/AG5uwyEJT3z8RbWcRDeslJrIDfL7hXdeHfPncmyNwxCJuhF8/ShgZnpQ7FuA1j
    xUj++g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
    header.i=@google.com header.b=vI5HpMsU header.a=rsa-sha256
    header.s=20161025 x-bits=2048;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=bz7symlI;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
      header.i=@google.com header.b=vI5HpMsU header.a=rsa-sha256
      header.s=20161025 x-bits=2048;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=bz7symlI;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNDN+upR2uGh1XlGnBok9kaODs81ik6S43M+RQJvC/HUiT7AqGaV4x45mHh/vIW9jE8gvaFZJraNcfKNFWxg/auepwtvU6ekH6qgZBPASwLWBqti51Th
    rUpatsrL64W8gwfvQ6JBci+iYnAoaoFWf4Ktvyq3ipxUmklJLHaVlxs5/r8J0H1jiA8lCE5Z2Umhtr+wPoMOEJMa+on12TN4RQmebD0qf01Xg04yyXmZ7fi/
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=pcL2f5jsCN8nnjY0vk4A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967897AbeE2WSw (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 18:18:52 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43983 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968203AbeE2WSO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 May 2018 18:18:14 -0400
X-Google-Smtp-Source: ADUXVKIa4PTBoXkbyzG0EB8pFFPhllkHTtiNYU9v48K5NoN90Cht/c5WcWrtv/Sg3whys8FFwfox8A==
From: Thomas Garnier <thgarnie@google.com>
To: kernel-hardening@lists.openwall.com
Cc: Thomas Garnier <thgarnie@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 24/27] x86/mm: Make the x86 GOT read-only
Date: Tue, 29 May 2018 15:15:25 -0700
Message-Id: <20180529221625.33541-25-thgarnie@google.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180529221625.33541-1-thgarnie@google.com>
References: <20180529221625.33541-1-thgarnie@google.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The GOT is changed during early boot when relocations are applied. Make
it read-only directly. This table exists only for PIE binary.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e373e2e10f6a..e5b0710fe693 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -314,6 +314,17 @@
 	__end_ro_after_init = .;
 #endif
 
+#ifdef CONFIG_X86_PIE
+#define RO_GOT_X86							\
+	.got        : AT(ADDR(.got) - LOAD_OFFSET) {			\
+		VMLINUX_SYMBOL(__start_got) = .;			\
+		*(.got);						\
+		VMLINUX_SYMBOL(__end_got) = .;				\
+	}
+#else
+#define RO_GOT_X86
+#endif
+
 /*
  * Read only Data
  */
@@ -370,6 +381,7 @@
 		__end_builtin_fw = .;					\
 	}								\
 									\
+	RO_GOT_X86							\
 	TRACEDATA							\
 									\
 	/* Kernel symbol table: Normal symbols */			\
-- 
2.17.0.921.gf22659ad46-goog
