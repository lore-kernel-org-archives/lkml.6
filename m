Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3552852-1521221816-2-8840083287749812861
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221815; b=K2zAAFgOhhunq6w6YWMffwOyyxf5rtX0TJ6H4O00DsqSWKF
    VvlcH9hCbiQrLhLDgQCtoiZhRLG5/d9QYDyTuBcfVi4rW+zdxw3+gPmXWEUIH4/j
    0RVkQw+RcxkW5mI6n/O775Zxb5HoiFg+qrnQoyYMsG7A4pbyLLb4bEr7ZlfO0TV2
    TrnQ6sVDxi5n4B/DJOVIsOVzJx3DPCLoa8tdJxrBt7+5iBstSrAAmDw7igtX5jTr
    aj0zEwhBh0g/iO8jPGbCaGjAP1nAYrp6j3jyOOo2N6QkDROZcNe5P6kGrmegZF86
    uAJ1YtFFSYAIgJOnQh+lacuh7X/mA1ywsJ8h9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221815; bh=PlOQNxLzWVExa9qZ0qc1svfk3u
    Wr4rMEzO6YsnOy3Wo=; b=f6W/TPMDTACWvMBs2/xqjiWg9zewR7AgOt3W2+AFsn
    kloyJQx88b1l0oFEXDxYCXKopeRq4TomweVvfJGpwzr78ViX6suy8as5fBdNV0Ut
    e3fWC8/VysUT5zll0PzDir0iCd7mn8TEyiCGREYChnErD2QMEPZM+SX9OQyLSPxe
    smhycSjXnKYwQmIVLBwCSmhy+UvpPXOzAaE3S3q6Ucviijuk3ci09m4rxIqR1sxF
    gqI8/ucZAPC342pWEmQDV3uxIcr58n2nQWv45x2bO8Xg1lRoG3dPms967SFD8pTB
    0J4nmKULRO8W4+9LqPfoLgsxA6iyABQ8msWVGvAGCTgQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932544AbeCPP0i (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:26:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932450AbeCPP0g (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:26:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, jeyu@kernel.org,
        live-patching@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 3.18 15/25] x86/module: Detect and skip invalid relocations
Date: Fri, 16 Mar 2018 16:23:02 +0100
Message-Id: <20180316152233.381119508@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
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

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit eda9cec4c9a12208a6f69fbe68f72a6311d50032 upstream.

There have been some cases where external tooling (e.g., kpatch-build)
creates a corrupt relocation which targets the wrong address.  This is a
silent failure which can corrupt memory in unexpected places.

On x86, the bytes of data being overwritten by relocations are always
initialized to zero beforehand.  Use that knowledge to add sanity checks
to detect such cases before they corrupt memory.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: jeyu@kernel.org
Cc: live-patching@vger.kernel.org
Link: http://lkml.kernel.org/r/37450d6c6225e54db107fba447ce9e56e5f758e9.1509713553.git.jpoimboe@redhat.com
[ Restructured the messages, as it's unclear whether the relocation or the target is corrupted. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/module.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -167,19 +167,27 @@ int apply_relocate_add(Elf64_Shdr *sechd
 		case R_X86_64_NONE:
 			break;
 		case R_X86_64_64:
+			if (*(u64 *)loc != 0)
+				goto invalid_relocation;
 			*(u64 *)loc = val;
 			break;
 		case R_X86_64_32:
+			if (*(u32 *)loc != 0)
+				goto invalid_relocation;
 			*(u32 *)loc = val;
 			if (val != *(u32 *)loc)
 				goto overflow;
 			break;
 		case R_X86_64_32S:
+			if (*(s32 *)loc != 0)
+				goto invalid_relocation;
 			*(s32 *)loc = val;
 			if ((s64)val != *(s32 *)loc)
 				goto overflow;
 			break;
 		case R_X86_64_PC32:
+			if (*(u32 *)loc != 0)
+				goto invalid_relocation;
 			val -= (u64)loc;
 			*(u32 *)loc = val;
 #if 0
@@ -195,6 +203,11 @@ int apply_relocate_add(Elf64_Shdr *sechd
 	}
 	return 0;
 
+invalid_relocation:
+	pr_err("x86/modules: Skipping invalid relocation target, existing value is nonzero for type %d, loc %p, val %Lx\n",
+	       (int)ELF64_R_TYPE(rel[i].r_info), loc, val);
+	return -ENOEXEC;
+
 overflow:
 	pr_err("overflow in relocation type %d val %Lx\n",
 	       (int)ELF64_R_TYPE(rel[i].r_info), val);
