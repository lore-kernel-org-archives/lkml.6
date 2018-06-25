Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C992C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D128026208
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSLXlgty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D128026208
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754803AbeFYWll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:41:41 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:48726 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934290AbeFYWlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:41:36 -0400
Received: by mail-yw0-f201.google.com with SMTP id r139-v6so6568318ywg.15
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=NIPEmqmnOXra8uvQ64ajNS/5EX567TxV9Xg06pgki5I=;
        b=GSLXlgty1C0zCiAPDiBXJgVxjg5Ob/4RN53OdT/fYqGw81Z5Z2e/DzZMA82UfmDBPw
         wMTDfOyrflRSK8R80krDOjY9nHUja8Y2vDFd1yIqs3xRqNo/RQMuCC9MrmHzGbL65mTT
         wwUrccK5GB7Bk1jSTp2Qlsymo80sPMEhLRB3gtJDWltIHRvPBZHrGxWfxfKpGbi7jOkc
         nR3bv8MaAW8XZ3hDc2xKCJ9t+VT6WUp5N+0oG7TVTnBqy3OBhQ2/z4bLpwoMuxoxC8qq
         ypnlViTXIdaXDxUH4QOanDngD46zjZ0knJcEsjGS4KvjEHwLk8jk9CSr+tCXm+YgidoO
         Ki1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=NIPEmqmnOXra8uvQ64ajNS/5EX567TxV9Xg06pgki5I=;
        b=RqbjkMWE4VEuITY+916oiUCWeH7BIUJxgry4B8FfM6X+ckrkFd6SUQ4w7baPtpUyG3
         tdVczBurKR3k1t7XdHsIKuGYoYbuUaA2OpopSFRhGL0NrSmgrBGHG+Dsz2pCOgZSVBBQ
         DsgJA7qG06Lo1gaXck/puIHfQsUZQMUcDU6XqwXIHizdKiLupMudOrr7kwlYS0dvATZ1
         nJuNyBzAFqB6yskBV/J01X3NGRXagSdUrBfqR+AbEPFfnxCUykM4YuwteoR0rr8odgAx
         W9eIu44to/7PmAOCY/Yg2i27UNvqv5AyALV8ipn4E9Nkyijii1OKBl8ZPCogP4KSzhVx
         F0jg==
X-Gm-Message-State: APt69E3sTigZxijWwHd+dqfnKLve5Y1YnHNdYXajvjjjEToicJ9DGZHj
        nVLAHO6Jpe7II7CIdjuNE5U196SA8tnGoA==
X-Google-Smtp-Source: ADUXVKJIgcPzismgVd98v6Lw4Ey7Z4F5fVTg6Y3w5t/9+IeZEhx42xqCTvqpqB8NdeUoxH2eZxeniLMNy/OhHQ==
MIME-Version: 1.0
X-Received: by 2002:a25:ba8c:: with SMTP id s12-v6mr4019098ybg.6.1529966495833;
 Mon, 25 Jun 2018 15:41:35 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:39:01 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-14-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 13/27] x86/boot/64: Build head64.c as mcmodel large when
 PIE is enabled
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __startup_64 function assumes all symbols have relocated addresses
instead of the current boot virtual address. PIE generated code favor
relative addresses making all virtual and physical address math incorrect.
If PIE is enabled, build head64.c as mcmodel large instead to ensure absolute
references on all memory access. Add a global __force_order variable required
when using a large model with read_cr* functions.

To build head64.c as mcmodel=large, disable the retpoline gcc flags.
This code is used at early boot and removed later, it doesn't need
retpoline mitigation.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/kernel/Makefile | 6 ++++++
 arch/x86/kernel/head64.c | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 02d6f5cf4e70..0f6da4b216e0 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -22,6 +22,12 @@ CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 endif
 
+ifdef CONFIG_X86_PIE
+# Remove PIE and retpoline flags that are incompatible with mcmodel=large
+CFLAGS_REMOVE_head64.o += -fPIE -mindirect-branch=thunk-extern -mindirect-branch-register
+CFLAGS_head64.o = -mcmodel=large
+endif
+
 KASAN_SANITIZE_head$(BITS).o				:= n
 KASAN_SANITIZE_dumpstack.o				:= n
 KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8047379e575a..49df0386098c 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -62,6 +62,9 @@ EXPORT_SYMBOL(vmemmap_base);
 
 #define __head	__section(.head.text)
 
+/* Required for read_cr3 when building as PIE */
+unsigned long __force_order;
+
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
 	return ptr - (void *)_text + (void *)physaddr;
-- 
2.18.0.rc2.346.g013aa6912e-goog

