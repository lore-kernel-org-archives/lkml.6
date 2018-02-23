Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415055-2-10167980672713414795
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
    t=1519415054; b=uDxi7B2ORrINsGgxAtGdKkCgCN8ISOMVfX0/7J8rFzJRcCi
    VoqjYTJS+JcVhDJO5CFvh/w6mNFT961ipL2uO2Vab4vWRzu6dV/ZcyqVkYuhSUtA
    yV/RfHzqK88efCwwD3R7X5M3rETq2sZ6dHmPV4Z+CKRP6k8dhl5K3E6fia4OYtUF
    P9crFWQvIUb/BV6A09306d1ywhV/Dhnf+m7DebpUuVlHh8xQKEbw9QX3loh4AURx
    ucn4WB6aq03QxRSy9qCfjxSEgQqtUDZZ4PXoKWhXZSNK9N617i2Ve5kPV3E1XXpr
    6rpE18tDPbJg1bKqxZ8wIMd/gwp1gSAlEL24Kxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415054; bh=R/FfRPFqamtUOYaVfKMkwljKsa
    0EXhQYXRcporGt6Ww=; b=dAWkb5eiXzKFnC8oz3vR4XFMHhn6D+QNN/2JCh+oyt
    qQZXs+o7C9bxiVNMgXDtsnafGMG52gLQLkdThA8e3MPgTEKsLH1EazbFJkgd4FnR
    B4uB1em6PIJcnjTZbFLJOXddcd7jZlTMHVcK5+rdU4Ur/7nbVM3fasPNp5qiYhqx
    woJO4fJZ3g7Sjy172RQeZG2qtedWzoblC7VLAYHArQ/QxYO/siUgzxtsHk4tfVrT
    dtAAb0m62ZhBIiYHfEUX1imBEUxM7p089es4YtiKEd+21jUXPseXHZz2hFX2KmV3
    xPUvpyW2IUfo1H/cltFCITbPVcxwE10yB6vO672ZHuaw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754821AbeBWTn6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:43:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934385AbeBWSsZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:48:25 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 136/145] binfmt_elf: compat: avoid unused function warning
Date: Fri, 23 Feb 2018 19:27:22 +0100
Message-Id: <20180223170742.299355660@linuxfoundation.org>
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

When CONFIG_ELF_CORE is disabled, we get a harmless warning in the compat
version of binfmt_elf:

fs/compat_binfmt_elf.c:58:13: error: 'cputime_to_compat_timeval' defined but not used [-Werror=unused-function]

This was addressed in mainline Linux as part of a larger rework with commit
cd19c364b313 ("fs/binfmt: Convert obsolete cputime type to nsecs").

For 4.9 and earlier, this just shuts up the warning by adding an #ifdef
around the function definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/compat_binfmt_elf.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -51,6 +51,7 @@
 #define elf_prstatus	compat_elf_prstatus
 #define elf_prpsinfo	compat_elf_prpsinfo
 
+#ifdef CONFIG_ELF_CORE
 /*
  * Compat version of cputime_to_compat_timeval, perhaps this
  * should be an inline in <linux/compat.h>.
@@ -63,6 +64,7 @@ static void cputime_to_compat_timeval(co
 	value->tv_sec = tv.tv_sec;
 	value->tv_usec = tv.tv_usec;
 }
+#endif
 
 #undef cputime_to_timeval
 #define cputime_to_timeval cputime_to_compat_timeval
