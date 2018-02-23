Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415314-2-8488039788003590869
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415313; b=kNzoNzugcetDbgsk1XcpPnTMvMlsOyU5SbQEc57eyMCSRMU
    TAUvYkHvuU/a+6lxxMpB7LOHQU1HsZvN086QsR6kP6N5owT6DsZQe1D1xIsjE8Rh
    5HbgdDOnGgg65rzVjUnawASZNo2xgs316fipR274lMVFvnB+Zz2KH/Yf6Z4CNNe6
    QgE42nLfIDf2SCXj20XuDTcLlqTkY7EHQqxqK2CML5fZHHvjYV23U4japkglwKVJ
    KWyoqWgmwpFpIXzExbDtUViaYv9Qz+shsBz0V+IvczkOspmcr8eQI14kK35MSRE0
    ZHXbF4+0T/79sl9SAN8EhhS/vUYsMQ/qajixXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415313; bh=4tid4zBYHJHKN/REgCcxX5BueD
    bo1T85RXmCtZ74ELE=; b=AB9ehUhaLCgFqzgjSSRnGvQmiFXmadgZc8uiip0I2Z
    najDi5Oa/GV94B08kpMzM/yVAf6K4pMyCtireh9mWZkc7/StbSpsU2hGaHdMzRjo
    VHll5P2gCWEFoMHg7g7h88l9e5gSThJyYeSbF0ydEqbszlC6JSOhEaA5ss70WpfM
    Iq0o0XAWgguehm2IniriB/m3IhELzbyeIX1vBjNCYyicvZNpEsSNxDz8BqsCrf6g
    FHLXWLIrTed1zEZdjR9rRafxr3okHjmKFB0tl1D2rrKqFGVcdaMPb+AvnStLvFYx
    Bhj652clyUTb1/gyqLb1+oEt51WdKkMea6kl7KJs1ZVQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933897AbeBWSrL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:47:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44466 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934058AbeBWSrK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:47:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 109/145] x86/build: Silence the build with "make -s"
Date: Fri, 23 Feb 2018 19:26:55 +0100
Message-Id: <20180223170738.929953201@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit d460131dd50599e0e9405d5f4ae02c27d529a44a upstream.

Every kernel build on x86 will result in some output:

  Setup is 13084 bytes (padded to 13312 bytes).
  System is 4833 kB
  CRC 6d35fa35
  Kernel: arch/x86/boot/bzImage is ready  (#2)

This shuts it up, so that 'make -s' is truely silent as long as
everything works. Building without '-s' should produce unchanged
output.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170719125310.2487451-6-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/boot/Makefile |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -73,12 +73,13 @@ UBSAN_SANITIZE := n
 $(obj)/bzImage: asflags-y  := $(SVGA_MODE)
 
 quiet_cmd_image = BUILD   $@
+silent_redirect_image = >/dev/null
 cmd_image = $(obj)/tools/build $(obj)/setup.bin $(obj)/vmlinux.bin \
-			       $(obj)/zoffset.h $@
+			       $(obj)/zoffset.h $@ $($(quiet)redirect_image)
 
 $(obj)/bzImage: $(obj)/setup.bin $(obj)/vmlinux.bin $(obj)/tools/build FORCE
 	$(call if_changed,image)
-	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
+	@$(kecho) 'Kernel: $@ is ready' ' (#'`cat .version`')'
 
 OBJCOPYFLAGS_vmlinux.bin := -O binary -R .note -R .comment -S
 $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
