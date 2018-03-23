Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804231-2-2138324528921102030
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
    t=1521804230; b=R8YP50ttZdj1Q5Wdjl6bmjmnzToHrNMyTb9vOzf/qS3FXRy
    iqokFilgbDFUywGLK8uanmZmpbY+a5Q/jHr7efygpE4opvY8PePiRDUwqdzBYfaA
    9M+RiWfpJBFAncU9wEJwlZ04hmTNK5hvdQ6BzXJhRISlmUturAUFVVSBI9lttOVG
    ld6/KjRNsDYDuEYAAFVJXpelUg9eyryejq7TxqayebIzGuWdV9/ErIcJkuFTU6Qg
    cgH2TY6VtGqPrIBTsq4erNhLlW60ShrFfUV6HPeg5QrN0D7agVj8RZp1TFJUQYnw
    q+v0g+QjWiymvK5Uv1vXL3R2ltP36uz246qyV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804230; bh=HrWLyeU8QebQknu7kXnZeNaug+
    h9GUABWxv+xrBh5sQ=; b=oONpVQT1dwbAK7NNG5wOu3vQ2+kEm5YSCn8SQRzSiN
    3C/gqmIQRY/4ThfIyyrFjOEEJljGA+Lw6FyR7907UdaSg7Gz79BIDsDF5qkJpCaI
    SfoLxeisMu/nUG/ey8Z8IRQ3KrO3W5kM/H8+JoAdiV/51icymKo6sC3Y7JMLgsYB
    T83M6ViHEnK1A5m3fR1IifW2Av12fXr6yEX4ZHlLV7xQtgZqr9OBKninzieqAO38
    /HI0ijRShI1Dh2Qo7j4gh4w1MGJmspcneVpMbyGy5bkSAxr34z8/uyTNIJLWLSPN
    +uhvWb3Ymx3FZj8B32TlckZoaSU5LkrJ21XUXUcWeVow==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755423AbeCWKIB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:08:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41460 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755416AbeCWKH4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Dave Jiang <dave.jiang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yinghai Lu <yinghai@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 086/177] x86/KASLR: Fix kexec kernel boot crash when KASLR randomization fails
Date: Fri, 23 Mar 2018 10:53:34 +0100
Message-Id: <20180323094209.091700840@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baoquan He <bhe@redhat.com>


[ Upstream commit da63b6b20077469bd6bd96e07991ce145fc4fbc4 ]

Dave found that a kdump kernel with KASLR enabled will reset to the BIOS
immediately if physical randomization failed to find a new position for
the kernel. A kernel with the 'nokaslr' option works in this case.

The reason is that KASLR will install a new page table for the identity
mapping, while it missed building it for the original kernel location
if KASLR physical randomization fails.

This only happens in the kexec/kdump kernel, because the identity mapping
has been built for kexec/kdump in the 1st kernel for the whole memory by
calling init_pgtable(). Here if physical randomizaiton fails, it won't build
the identity mapping for the original area of the kernel but change to a
new page table '_pgtable'. Then the kernel will triple fault immediately
caused by no identity mappings.

The normal kernel won't see this bug, because it comes here via startup_32()
and CR3 will be set to _pgtable already. In startup_32() the identity
mapping is built for the 0~4G area. In KASLR we just append to the existing
area instead of entirely overwriting it for on-demand identity mapping
building. So the identity mapping for the original area of kernel is still
there.

To fix it we just switch to the new identity mapping page table when physical
KASLR succeeds. Otherwise we keep the old page table unchanged just like
"nokaslr" does.

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Dave Young <dyoung@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yinghai Lu <yinghai@kernel.org>
Link: http://lkml.kernel.org/r/1493278940-5885-1-git-send-email-bhe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/kaslr.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -460,10 +460,17 @@ void choose_random_location(unsigned lon
 			add_identity_map(random_addr, output_size);
 			*output = random_addr;
 		}
+
+		/*
+		 * This loads the identity mapping page table.
+		 * This should only be done if a new physical address
+		 * is found for the kernel, otherwise we should keep
+		 * the old page table to make it be like the "nokaslr"
+		 * case.
+		 */
+		finalize_identity_maps();
 	}
 
-	/* This actually loads the identity pagetable on x86_64. */
-	finalize_identity_maps();
 
 	/* Pick random virtual address starting from LOAD_PHYSICAL_ADDR. */
 	if (IS_ENABLED(CONFIG_X86_64))
