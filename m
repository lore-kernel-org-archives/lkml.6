Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521804853-2-4837063463087771692
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
    t=1521804852; b=FdU4C7dLg6DtJjZpKI48kxrydusp1xTkLAxU7f/ZLOWBNFs
    PvCrRpeEIZRO+Y9lbx1Ca3x3vSpT626U7WWzJXLyQ2R7R80DHg/fIv22p0b7h8Ki
    E8d+UFnQn1BW473yqdH90Ce91mnj6mf9daFcM0jeGc68/mSY67UPqb8eFUeaC38t
    4SRZTEeqOX02w8+XggCM8HV9io5TwOVDj/XMIBk5xB53le/p+ko425GK2MQYQfof
    FXmYwZU126RUSxQSpJLKKysAwdD9O/84e5k1EkVA1o+RBuW7ERGUYTT2uZsJdMNF
    ulCqtjUTULRjXlRoEoraSLW7vVRn/5yTDpTJziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804852; bh=aXyUtHhLeiW++zmqrfoFsq0ipU
    fU4x3NBAKGBGsrb0c=; b=q/vK1of0uuGndhIYqk8Igrev63sWWLtlByU3azoYl7
    sATtMqhRlv62wj8TXoRI0/mUPC8l7yHd76dFyWbYNTDC9RoFz0vXUqDNkiCc+dnR
    R8XAgRWxK37xH9vVhc8+vTb4OxnsHfi/LIr2CpA14+jPZonnN+S4h3HvcNDfIk4T
    PiC0li3vSVlW7obt+Uh9MxbbrCdLWiry78NHNB0VKEKsE8xJg05AlGVKtgCmz5GZ
    SPa7PlYKq+q3Gs8fR1joXpeM6U8f8d1kQXI8SlUjShpfbL5a9dufIjrT/SkWAqGR
    sdF44cG/S2sSYD4ycXInlxXcYnKKB9iRyfrhGCa732iw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1754487AbeCWKF1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:05:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39664 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754935AbeCWKF0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolai Stange <nicstange@gmail.com>,
        Rabin Vincent <rabin@rab.in>, Abel Vesa <abelvesa@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 036/177] ARM: 8668/1: ftrace: Fix dynamic ftrace with DEBUG_RODATA and !FRAME_POINTER
Date: Fri, 23 Mar 2018 10:52:44 +0100
Message-Id: <20180323094206.748370378@linuxfoundation.org>
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

From: Abel Vesa <abelvesa@linux.com>


[ Upstream commit 6f05d0761af612e04572ba4d65b4c0274a88444f ]

The support for dynamic ftrace with CONFIG_DEBUG_RODATA involves
overriding the weak arch_ftrace_update_code() with a variant which makes
the kernel text writable around the patching.

This override was however added under the CONFIG_OLD_MCOUNT ifdef, and
CONFIG_OLD_MCOUNT is only enabled if frame pointers are enabled.

This leads to non-functional dynamic ftrace (ftrace triggers a
WARN_ON()) when CONFIG_DEBUG_RODATA is enabled and CONFIG_FRAME_POINTER
is not.

Move the override out of that ifdef and into the CONFIG_DYNAMIC_FTRACE
ifdef where it belongs.

Fixes: 80d6b0c2eed2a ("ARM: mm: allow text and rodata sections to be read-only")
Suggested-by: Nicolai Stange <nicstange@gmail.com>
Suggested-by: Rabin Vincent <rabin@rab.in>
Signed-off-by: Abel Vesa <abelvesa@gmail.com>
Acked-by: Rabin Vincent <rabin@rab.in>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kernel/ftrace.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -29,11 +29,6 @@
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-#ifdef CONFIG_OLD_MCOUNT
-#define OLD_MCOUNT_ADDR	((unsigned long) mcount)
-#define OLD_FTRACE_ADDR ((unsigned long) ftrace_caller_old)
-
-#define	OLD_NOP		0xe1a00000	/* mov r0, r0 */
 
 static int __ftrace_modify_code(void *data)
 {
@@ -51,6 +46,12 @@ void arch_ftrace_update_code(int command
 	stop_machine(__ftrace_modify_code, &command, NULL);
 }
 
+#ifdef CONFIG_OLD_MCOUNT
+#define OLD_MCOUNT_ADDR	((unsigned long) mcount)
+#define OLD_FTRACE_ADDR ((unsigned long) ftrace_caller_old)
+
+#define	OLD_NOP		0xe1a00000	/* mov r0, r0 */
+
 static unsigned long ftrace_nop_replace(struct dyn_ftrace *rec)
 {
 	return rec->arch.old_mcount ? OLD_NOP : NOP;
