Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826091-2-11853890994233079276
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826090; b=ZDEVCiJ9zonJ70LIFexmk4+yRIsTHWvQpL02Yjot4rGVYux
    EY4xkMrxBtQX7z4RX3YH+YpEqjEB1OdI+j3hWeUcmxSiYFtjvruWJxaFiUIOkL0u
    EoYNYngCv1TllDs45aTdCwoRaNgyuDuJFO59R7OaRhxLbiKMEOwMx1vltbG2wboA
    dIdqq6IqNsd3t4xK83KVnAk6kolVJxqZQ+AB2d/WDhGIcxpKCD9L+MhDEwD9W7Vw
    vA74b9D7/MneThsngTwRWDYEf68jy7CnDNfbD4RGdJ1WQojIfU8PlWkA81E8LRF/
    /vNEV0sMSO/APUPelqy19cot8FMZGwzGutKX1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826090; bh=VAqmhnMBsXBh1ZKGuIn
    Ld/uCA77o3+rRroslSfHUkf4=; b=GA9YNKOK29AOc/3Ttna8GqozvGbfEpAaSsN
    SIjWdATRnpEsU7uqBJiWLvC3H8ek8xB7d6V7E/MBmNdr3+e6eLx/COF7Q0j5W9py
    ypmfbPEgjv5iFaRbbDCMVjQ6P1pj/nZAykwgxVTRHYDmbfMzlCpsu3f/xFAwTUre
    e3g0f8nVlkylQeb7l1oMRh4GgDHCECY6Eptpx3pao7FVFQjggq3qR9spl0FhGQxB
    kk0rxUPqHAiH87q6MSH7dcRhrsbrreKjsuR/gXJ4uxDK/wNWmpqD1m3KGJzKnAvW
    iyGE5yVY478X/CW8TfcTURbWGYBOxU11l+/Mjl5JNesMd/z0H2g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932818AbeCLD2I (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:28:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41187 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932668AbeCLDHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:42 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "H. Peter Anvin" <hpa@linux.intel.com>,
        "=?UTF-8?q?Jan-Simon=20M=C3=B6ller?=" <dl9pf@gmx.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.473532414@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 033/104] x86, asm: Extend definitions of _ASM_* with a
 raw format
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jan-Simon Möller <dl9pf@gmx.de>

commit 3e9b2327b59801e677a7581fe4d2541ca749dcab upstream.

The __ASM_* macros (e.g. __ASM_DX) are used to return the proper
register name (e.g. edx for 32bit / rdx for 64bit). We want to use
this also in arch/x86/include/asm/uaccess.h / get_user() .  For this
to work, we need a raw form as both gcc and clang choke on the
whitespace in a register asm() statement, and the __ASM_FORM macro
surrounds the argument with blanks.  A new macro, __ASM_FORM_RAW was
added and we change __ASM_REG to use the new RAW form.

Signed-off-by: Jan-Simon Möller <dl9pf@gmx.de>
Link: http://lkml.kernel.org/r/1377803585-5913-2-git-send-email-dl9pf@gmx.de
Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/asm.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -3,23 +3,27 @@
 
 #ifdef __ASSEMBLY__
 # define __ASM_FORM(x)	x
+# define __ASM_FORM_RAW(x)     x
 # define __ASM_FORM_COMMA(x) x,
 # define __ASM_EX_SEC	.section __ex_table, "a"
 #else
 # define __ASM_FORM(x)	" " #x " "
+# define __ASM_FORM_RAW(x)     #x
 # define __ASM_FORM_COMMA(x) " " #x ","
 # define __ASM_EX_SEC	" .section __ex_table,\"a\"\n"
 #endif
 
 #ifdef CONFIG_X86_32
 # define __ASM_SEL(a,b) __ASM_FORM(a)
+# define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(a)
 #else
 # define __ASM_SEL(a,b) __ASM_FORM(b)
+# define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(b)
 #endif
 
 #define __ASM_SIZE(inst, ...)	__ASM_SEL(inst##l##__VA_ARGS__, \
 					  inst##q##__VA_ARGS__)
-#define __ASM_REG(reg)		__ASM_SEL(e##reg, r##reg)
+#define __ASM_REG(reg)         __ASM_SEL_RAW(e##reg, r##reg)
 
 #define _ASM_PTR	__ASM_SEL(.long, .quad)
 #define _ASM_ALIGN	__ASM_SEL(.balign 4, .balign 8)
