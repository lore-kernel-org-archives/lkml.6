Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-436143-1526283823-2-3924236014499711087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526283822; b=T3cbWqGuMQgxHnudi70A2bOWsBwJmdSgPQS2rHVn7+Y2ehFVEn
    ckIs17dnqEsd97E6iMYrBfXwhVZn94v0slFx/4jQnYzGLovO+88ctUJaEupmkxJV
    ugb5etUCj27I8U2ucRzZNPET7EDy8JLU2V/guyWIJ1dqjc6WzJGbzvVKzxds7WoL
    UdQFfYX78XZgxmisSa1tmHe6FCFbuxsemzI/O6ZxnEsHpn28ynd/mpeUNJzdMiTQ
    3LM3FLRXtL7I83OlKAKARQe9s2itWgk7/uv8U2bI/sUkrmEaZX/nLazy/rOoyKLj
    HOpchNER0MKwmtIRuEsf8a0FDYk56etwTG1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:message-id:cc:reply-to
    :in-reply-to:references:to:subject:mime-version
    :content-transfer-encoding:content-type:sender:list-id; s=fm2;
    t=1526283822; bh=a2s9RlPtMN0Ojh20x8yg4zFCtKHhQKIMUzuO4PyaG64=; b=
    De4PmcouYpxJ+H5p4ZVxIhVS7bO7fvOhOk8/jK6aqDF8DKdXuqW+/KqpLsvMmFoy
    I3Ge2UvLIi2gbHsNRK0NJTsj8LVwfizBew3c6K7qZnf/emp/PX0rbSdKyWKcsS+o
    HGlhPFR0AsmXPGxWwndNCJx9EjrbXlsfoAn+r8xAWb521DE4BxRlz/pwShFE8G2+
    I6fIpeLd5Z2c8JhFFjcsDryfJ8f7joXW646xxj+1AeR4TSS6zzAHRlLMb1BVvRwo
    TNSy0kxoQW5qMhfxaltXoX4V6s8Q8Y8CJTJeFDQILT+tmXs2zioW0413XfVeZTU1
    vjcWkIBHEh2e90UNXRN4Tw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=zytor.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=zytor.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOQNviREOpqNP0hQqaSYRBC4G9XYEoTloRSidUJ/VBO4vr7FVr+Ou/gcFwnEgpQvit3Uo6y4YiCZ0uqLAIbAgvTO3j9DQDy/BRlPb3g/JjPh+mweZq9n
    olHhSw90SXvkc63QAcxijCEnkL7dBiPu/FTtz0YFREQNZhM5rxJ87T9M8+/oGCXzw60TvlV7e9bV01J+O9c1KXHHmhZ/7wbS9RYQMfbvQyUtAlFf+0K9EzpT
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8
    a=CxaZg77CAAAA:8 a=JfrnYn6hAAAA:8 a=QaSHP11GN0Wy0ChVyJYA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=HxQw6O0h_v37Y3_G5fB_:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeENHn0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:43:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33219 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeENHnY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 03:43:24 -0400
Date: Mon, 14 May 2018 00:42:55 -0700
From: tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-0b3225ab9407f557a8e20f23f37aa7236c10a9b1@git.kernel.org>
Cc: hpa@zytor.com, matt@codeblueprint.co.uk,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        tglx@linutronix.de, ard.biesheuvel@linaro.org,
        peterz@infradead.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, matt@codeblueprint.co.uk,
          hpa@zytor.com, tglx@linutronix.de, hdegoede@redhat.com,
          stable@vger.kernel.org, ard.biesheuvel@linaro.org,
          peterz@infradead.org, mingo@kernel.org,
          torvalds@linux-foundation.org
In-Reply-To: <20180504060003.19618-13-ard.biesheuvel@linaro.org>
References: <20180504060003.19618-13-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Avoid potential crashes, fix the 'struct
 efi_pci_io_protocol_32' definition for mixed mode
Git-Commit-ID: 0b3225ab9407f557a8e20f23f37aa7236c10a9b1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Remote-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        T_DATE_IN_FUTURE_96_Q autolearn=ham autolearn_force=no version=3.4.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on terminus.zytor.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  0b3225ab9407f557a8e20f23f37aa7236c10a9b1
Gitweb:     https://git.kernel.org/tip/0b3225ab9407f557a8e20f23f37aa7236c10a9b1
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Fri, 4 May 2018 07:59:58 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 08:56:29 +0200

efi: Avoid potential crashes, fix the 'struct efi_pci_io_protocol_32' definition for mixed mode

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
---
 arch/x86/boot/compressed/eboot.c | 6 ++++--
 include/linux/efi.h              | 8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 47d3efff6805..09f36c0d9d4f 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -163,7 +163,8 @@ __setup_efi_pci32(efi_pci_io_protocol_32 *pci, struct pci_setup_rom **__rom)
 	if (status != EFI_SUCCESS)
 		goto free_struct;
 
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
 
 free_struct:
@@ -269,7 +270,8 @@ __setup_efi_pci64(efi_pci_io_protocol_64 *pci, struct pci_setup_rom **__rom)
 	if (status != EFI_SUCCESS)
 		goto free_struct;
 
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
 
 free_struct:
diff --git a/include/linux/efi.h b/include/linux/efi.h
index f1b7d68ac460..3016d8c456bc 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -395,8 +395,8 @@ typedef struct {
 	u32 attributes;
 	u32 get_bar_attributes;
 	u32 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u32 romimage;
 } efi_pci_io_protocol_32;
 
 typedef struct {
@@ -415,8 +415,8 @@ typedef struct {
 	u64 attributes;
 	u64 get_bar_attributes;
 	u64 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u64 romimage;
 } efi_pci_io_protocol_64;
 
 typedef struct {
