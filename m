Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520825444-2-4096348717885578232
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825444; b=h/S9YJNNeAlfbJN4Ypsm2DdtfKj6yE510N3+tYxVaY2dgCw
    l/bM2PuUq6awmmgz7GuhSzXJDv3bU4b/3+qx7E6nywVImnCyANHDKCxPyZjK8/Ne
    PN4GEEKtR1c34P9inQ3nsKkawyShw4sg4wuZrS70E89tCf9L9uAWL9ltP6fjsLVn
    5tJ4BzyhrkkC23O82sq5HLpJb92+7TUdOpNFojl/iP1tqlQiCA4A/stBXqWjjB2p
    gpqIpdX95EM4fWTaJ+HL87Fl3gDDwsrCS/aKnTG+esU7SPPX+r57XuTKdkLnnSzE
    XSjTyVfdlAPyiNx0NqgIQmylM0ROgJrBSOjJi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825444; bh=Ik+m+FECIRnTTQjR+6g
    Gw5aCbQmNvr4TGN+wVOKCT+Q=; b=TPlhxYyupOaEtckHhw2hocF/R+UgSXvfXM9
    pBFtpCRea5oyv2R33cBfmCOI83jiyPqtTEuXg91obmFZutuWztSPk0pLpezKjiez
    7dqdrR5XNXlVlRbNH8b0pbmw+7ACMfCFNWU0r82WxdTSM5Dw6bnJKqbABu1db+TC
    iN8XAO5PTED74Ruz5zb8n3jNs2+YwDONZXlWWlaqljNNQhAwvU05916Yux3EtqaH
    XRidVN8iUdvz/m3R9v+MC9q8hOIdIaCmNoopAGTAMg3M8qqt2PqDT5j1wjqAjXBl
    /pHQEiMhCebrsejcYOnFUx/yv7IDLSOzFjo4fAZPyCfAnudxnFw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeCLD3d (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:29:33 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42799 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932958AbeCLD3c (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:29:32 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Brian Gerst" <brgerst@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Andy Lutomirski" <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.471373128@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 19/76] x86/asm: Make asm/alternative.h safe from assembly
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit f005f5d860e0231fe212cfda8c1a3148b99609f4 upstream.

asm/alternative.h isn't directly useful from assembly, but it
shouldn't break the build.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/e5b693fcef99fe6e80341c9e97a002fb23871e91.1461698311.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/alternative.h | 4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_X86_ALTERNATIVE_H
 #define _ASM_X86_ALTERNATIVE_H
 
+#ifndef __ASSEMBLY__
+
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/stringify.h>
@@ -251,4 +253,6 @@ extern void *text_poke(void *addr, const
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
 
+#endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_ALTERNATIVE_H */
