Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802272-2-13762397351825082863
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
    t=1521802271; b=EViSI1hE/vKPByQcAE6DVoOP329q9ht2RddG8Z8pCu8jOQx
    mxzz3vkYHx8r6Fg9uwBicmljEL9vqnqJKkh7JyfKgPyCFA5cW0ZLXpjCjMPKAS5p
    4yz4TCu3kVel4rTCodsk6V1UiroE32W7yo3yfKcKp4YGSHbyMmz2X5RNyfWT2YLQ
    +W6/huwaY6i9H2hBk8ajccZBSsPog+WPEL7Yrkp8l3i9gm1WzJ8CDEfTzYyd/IzZ
    ilq1tG0KSA82PqCab+BXCS+bVVTLRE2mGXBDlDMbgok1K/Kzi3RkN3sWMUECd6sW
    vQqhGY2ewnBZ07nsyviSPt5jB6JZwgOZKBjCgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802271; bh=tKbOJUsbBgLqY7+wffes6ha7BP
    BAoz0iFUg08/FJjxo=; b=XAbKhQ6WmUyCXI7lAUHYn3MJ7x48BLgYdFvmlpT+5q
    +A3JM4kGUpwGn6ujhzspqUfuT1+VwmhdJgZR+qXw3Iher80JCIpMtGp+P9xOY+/A
    kwqeYfsVVB5aubOpux9dMoLExXB3A89oCapvSdtkoCGwvZuZLXzwa8rhSXHUNePy
    Yl7ylIidos70fcht/jA6S+kgfLtTmrThveuRtNJHeIFh+pnRaVvsKvNTgES+KJl5
    aD64YB3i9mws3/JiA2gXqzKzMlvyQsf/P9MdhBLnYiSJzvGRF8Y0Gvv1cQ/SIsRi
    MdzFf63Vb2M//i6thnKJv85C5j7SmK1dV0ttuCTM79xQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S933314AbeCWKOa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:14:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45206 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933313AbeCWKO3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:14:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolai Stange <nicstange@gmail.com>,
        Rabin Vincent <rabin@rab.in>, Abel Vesa <abelvesa@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 24/97] ARM: 8668/1: ftrace: Fix dynamic ftrace with DEBUG_RODATA and !FRAME_POINTER
Date: Fri, 23 Mar 2018 10:54:11 +0100
Message-Id: <20180323094158.974629575@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
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
