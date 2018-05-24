Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527163122-2-16982196237082099680
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
    1527163121; b=LFIBsOwBCk7Pgy6eefAgwnJLuUXyEOG3QsBTYhGlg3q+zMGdo7
    Kho/9Fl+n9vuVrWCX8L4JMBZSq7xKuXXz5mVBEt3LvrwB4LpT+YrLx4F9FO9t64r
    khb4x071+Wp4oMsif4B+mv3ovzybe7xaYKjEEc5fLdvKlyd91uO11s1twnsQT9YA
    xjXNK+RTP85dCIMA/JcLwtJdi4lD0IqT3PumMvMakSh46g6No+Dit2gArUXgSGgP
    OB2gVsf+FE3V5lFb95QMubj8eEl1Wz8OI/ky49KyrnzS0ftc5Yl8pEpr1fkEc6BF
    tHt6BB0mLguZC08IUWiGjdh24QRynnXKBqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163121; bh=XQ2G5V4FbjFUuuZKjOYye1l3c042pn
    VZBPxzu8zsOmo=; b=Z0Ue6pzBM1J8OGTJGmKD+XRKZs8j90mBZz3tRsy0U/Bdsf
    idP7iwo2kkWEt4CyYd5Df6SEMFPj9II4aLevA8b0yNdWTkmivys2VCaeA62/tE3J
    7CoSIBdRKEDduSv4REu/nqY+eicgnrokw9ujv2dsHnyumGYKpmnpk/VSsSADEvsO
    Ax8g80z7En/4wk4WpcdmGoQNW+owFTART6Q3cXkq1+xM5v8v0tquGL+vi2tdpD3x
    /OB/rj/8DNFUCCmHzJhsQPpJTOl1/WUDyAUwEaI31kUn4nNS75m6Qi3xdch855Cz
    MB63jggJVaiwtDdwHRMVt6uqq2v/aD281eguEU2g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=VqiMA/0O x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=VqiMA/0O x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfPKI26s+FzPBfEp0mkZE+uxlJtYmozVRkINL94e0rSL7phMMBtG5iKz1gsMy0TQ5l4UNpDpG/LPX6fFC2zmRxiUVoMUxUvVLjivCEYNPRGcUqrKSXUFM
    UnjzYv0FIt7ARV+qlmaNMG/2Ed2BrnfO35CgglLZOo1RpI01C44H8rz0eqeBYQOWkx/lRP9i2xprYMHBu3AVtyDkVbVjhpee0mfDUt07JTkqN3IbfcnhP2kB
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8
    a=CxaZg77CAAAA:8 a=JfrnYn6hAAAA:8 a=ag1SF4gXAAAA:8 a=QaSHP11GN0Wy0ChVyJYA:9
    a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=HxQw6O0h_v37Y3_G5fB_:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966626AbeEXL6h (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966499AbeEXJpV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:21 -0400
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
Subject: [PATCH 4.4 62/92] efi: Avoid potential crashes, fix the struct efi_pci_io_protocol_32 definition for mixed mode
Date: Thu, 24 May 2018 11:38:39 +0200
Message-Id: <20180524093205.251485804@linuxfoundation.org>
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
@@ -364,7 +364,8 @@ __setup_efi_pci32(efi_pci_io_protocol_32
 	if (status != EFI_SUCCESS)
 		goto free_struct;
 
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
 
 free_struct:
@@ -470,7 +471,8 @@ __setup_efi_pci64(efi_pci_io_protocol_64
 	if (status != EFI_SUCCESS)
 		goto free_struct;
 
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
 
 free_struct:
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -364,8 +364,8 @@ typedef struct {
 	u32 attributes;
 	u32 get_bar_attributes;
 	u32 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u32 romimage;
 } efi_pci_io_protocol_32;
 
 typedef struct {
@@ -384,8 +384,8 @@ typedef struct {
 	u64 attributes;
 	u64 get_bar_attributes;
 	u64 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u64 romimage;
 } efi_pci_io_protocol_64;
 
 typedef struct {
