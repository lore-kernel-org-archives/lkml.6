Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415343-2-8985692739608219950
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415342; b=OJE6hXct42Eb+3ErklJyrMuia5fplggqGHnLdHTHiTZ7l0a
    Bc1g8gD2mtINCfyipLGbWXE7Ov6cfs6vbL6c4kGu6VstiRV9JyFPv2ZL63ljfqil
    JlKhMMPE2ThZ55i72sXwWNQfrYFY5BGOVTui6H+xNvU00b77OnlOXlgDF3yTNpD2
    pUVoqg58xbtchSaZjiLlerNr27sNhtTfixlekQPXMqPRsnWU/g9DktuXulq8+SEv
    VooYNH41lO1BB/Qqm5ygmKDtDwJP3OQuJoV7b3KShTE903w0TFGt5v98DgeKrn3M
    AgO98mhIHM7S5Lhw20AdJAJVQRB5xYfnJaOwW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415342; bh=VJmOZUBfvFGAQzSve61bppyzwh
    eDFFwRWqkvDnkW/q8=; b=W5Oran7HAP+8IfDWPybBUcvHARmoCjshqVPgWvc14S
    JMoaJWTFLFRTitwDX3yjtSRiegNTuWTjlem72eb+0rkZXTAczbjfPLSkNUgg0GHK
    rVuh1SQBQuVZrAdJ8hfYjHBJ7zAz5PCswm++SG9ZcjxLG1nBxfobqxLWL8vHK14h
    wlyEyt25+H54Fwtie9tAmxUWAmqyVXeEh7j7YP3lYFiaMs/bbS2q6KcNmi4zUmCV
    ufkx1qrsjKxd40FVl17SxSGn54jwVJiwPTHMGnovUGKK2pvxYAwKjDHJXJTtKJWt
    1TO2cBdbtG2qY+8BOyfs/91gyxHERf/T0Lt1gRMYQv9Q==
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
        id S1754434AbeBWTsp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:48:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934074AbeBWSrB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:47:01 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.9 106/145] arm64: define BUG() instruction without CONFIG_BUG
Date: Fri, 23 Feb 2018 19:26:52 +0100
Message-Id: <20180223170738.491334547@linuxfoundation.org>
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

commit f13d52cb3fad03c237572be2ee691e1fe2d1d7bb upstream.

This mirrors commit e9c38ceba8d9 ("ARM: 8455/1: define __BUG as
asm(BUG_INSTR) without CONFIG_BUG") to make the behavior of
arm64 consistent with arm and x86, and avoids lots of warnings in
randconfig builds, such as:

kernel/seccomp.c: In function '__seccomp_filter':
kernel/seccomp.c:666:1: error: no return statement in function returning non-void [-Werror=return-type]

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/bug.h |   35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

--- a/arch/arm64/include/asm/bug.h
+++ b/arch/arm64/include/asm/bug.h
@@ -20,9 +20,6 @@
 
 #include <asm/brk-imm.h>
 
-#ifdef CONFIG_GENERIC_BUG
-#define HAVE_ARCH_BUG
-
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 #define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
 #define __BUGVERBOSE_LOCATION(file, line)				\
@@ -36,28 +33,36 @@
 #define _BUGVERBOSE_LOCATION(file, line)
 #endif
 
-#define _BUG_FLAGS(flags) __BUG_FLAGS(flags)
+#ifdef CONFIG_GENERIC_BUG
 
-#define __BUG_FLAGS(flags) asm volatile (		\
+#define __BUG_ENTRY(flags) 				\
 		".pushsection __bug_table,\"a\"\n\t"	\
 		".align 2\n\t"				\
 	"0:	.long 1f - 0b\n\t"			\
 _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
 		".short " #flags "\n\t"			\
 		".popsection\n"				\
-							\
-	"1:	brk %[imm]"				\
-		:: [imm] "i" (BUG_BRK_IMM)		\
-)
-
-#define BUG() do {				\
-	_BUG_FLAGS(0);				\
-	unreachable();				\
+	"1:	"
+#else
+#define __BUG_ENTRY(flags) ""
+#endif
+
+#define __BUG_FLAGS(flags)				\
+	asm volatile (					\
+		__BUG_ENTRY(flags)			\
+		"brk %[imm]" :: [imm] "i" (BUG_BRK_IMM)	\
+	);
+
+
+#define BUG() do {					\
+	__BUG_FLAGS(0);					\
+	unreachable();					\
 } while (0)
 
-#define __WARN_TAINT(taint) _BUG_FLAGS(BUGFLAG_TAINT(taint))
+#define __WARN_TAINT(taint) 				\
+	__BUG_FLAGS(BUGFLAG_TAINT(taint))
 
-#endif /* ! CONFIG_GENERIC_BUG */
+#define HAVE_ARCH_BUG
 
 #include <asm-generic/bug.h>
 
