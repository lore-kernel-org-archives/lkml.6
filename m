Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906373-1527164246-2-5587678197998349103
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527164246; b=YOez6WLr8QwUhxg1qFYndGYNeQcOD37HriGX9g6kcOkFGRWEdg
    zrMPOTLto7h8iXWEv9gh5yFLEDnxJfBZM89H0NFpVrKcxqifx5iizbXIRAPnvGfU
    cZV33hXNwakO+cjBL5RB1ONz6w7dgDetCjk8YbElC9COoXQIW7ccVgkmbAd9ubsF
    jDj89jK3vwtT79x9fXh+VfVnAlvyW3WNkuH+v/teF2yVXla5ZchFsPYPE3ISLkK7
    h3OcTayp0MZmHVMzyWnKp8nx4tqGLPTNdVLNDwUAO5TCGZyq7OUIaq3+xtfqDPbL
    uNCXKdrYwYrhJQ9kej1snWcS/hMgVtJSKDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164246; bh=u+oYDA6KUJ6qMuC7K5whXWkXqK6asa
    z8BDTk5Oual/Y=; b=lFU4I6r7ge8IVmHdC+QP3Ko/9JICX6Qrq3JUrzkZqOttPq
    TZgTI3C0U3LgdQ5kLKp1W1kdZZIHBSQqcBgvZs8OzfszwDppmHvIcoUA8q1HFbTn
    MoEwAc3VqLyDokhWfGSspww2hRqQjbWbT/2khOtlxrpJiDUJRKYskHmnHWbGSxZf
    /DU7EveEUC8FYasYfy+o71/u8jrZosPXC3OEzpRNhH9LRQoW2opEK5tuwlgg8rOt
    1rwqWCfDqKKl9K9XiRcd3mM9kmzCAjPYfJsC5/yAvZB4LAk/e2gucHBjL1R/lmm2
    6p43RZCaRSXOQ6YCoOH5cLxSOJ1o9xx75MivjpzA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=BpVkJvHn x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=BpVkJvHn x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHC5LAJeKLgaikTR7f5YaBvXS5yCL2wcfpxNzGqijM6ENJwoEaY/PlQdBUjDE3ARMt/i4fYy76D320YGfoDg3vOWGHe4GhKTyqFrcx/HDIswVXlk0kjM
    Zl9neDyjseRkstkUThUPVzv9ciVFicb+7M2jN4ojMjs9sCvPy6ZsNPc3pO0ckVUplXdx++yg/Iv1K85wuPK0ZLwK4/RlR1IVVHGNZJy/ywFwwQGY8QxdtuPR
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8
    a=CxaZg77CAAAA:8 a=JfrnYn6hAAAA:8 a=ag1SF4gXAAAA:8 a=QaSHP11GN0Wy0ChVyJYA:9
    a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=HxQw6O0h_v37Y3_G5fB_:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966072AbeEXMRV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965968AbeEXJl4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:41:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 3.18 34/45] efi: Avoid potential crashes, fix the struct efi_pci_io_protocol_32 definition for mixed mode
Date: Thu, 24 May 2018 11:38:42 +0200
Message-Id: <20180524093125.049014106@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 0b3225ab9407f557a8e20f23f37aa7236c10a9b1 upstream.

Mixed mode allows a kernel built for x86_64 to interact with 32-bit
EFI firmware, but requires us to define all struct definitions carefully
when it comes to pointer sizes.

'struct efi_pci_io_protocol_32' currently uses a 'void *' for the
'romimage' field, which will be interpreted as a 64-bit field
on such kernels, potentially resulting in bogus memory references
and subsequent crashes.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: <stable@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180504060003.19618-13-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/boot/compressed/eboot.c |    6 ++++--
 include/linux/efi.h              |    8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -365,7 +365,8 @@ __setup_efi_pci32(efi_pci_io_protocol_32
 	if (status != EFI_SUCCESS)
 		goto free_struct;
 
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
 
 free_struct:
@@ -471,7 +472,8 @@ __setup_efi_pci64(efi_pci_io_protocol_64
 	if (status != EFI_SUCCESS)
 		goto free_struct;
 
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
 
 free_struct:
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -360,8 +360,8 @@ typedef struct {
 	u32 attributes;
 	u32 get_bar_attributes;
 	u32 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u32 romimage;
 } efi_pci_io_protocol_32;
 
 typedef struct {
@@ -380,8 +380,8 @@ typedef struct {
 	u64 attributes;
 	u64 get_bar_attributes;
 	u64 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u64 romimage;
 } efi_pci_io_protocol_64;
 
 typedef struct {
