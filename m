Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184511-2-1363632561525986403
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184511; b=qhtyFdyozLNjC1YJX1S+MFE9VUypH/RXvIa86VltjyD2S/q
    MBL86AUTxGJvXrM1Kr4mltBmRo+vUARyQhk11Cl6AWyspO8Z/hNhzeFdCgvBqtJK
    b+rUolg89MXW6+Lv0sKIEQgzxxFtM26/sdBcVJ2qgyaE5xHKw7PQ8IKaoKXTaV6d
    peW/1UthHJJc44DwpuHZJf7HZwvoghPTe04QC15EkRpSAHFA9YkRzf+QuI3Bjj4b
    4DSos+kK1qna89reS+EKETxaknvrTyO/4wQcOZ/Td00hYzoPDz48cJfvJp4UmXPc
    B7ykBVCjqubg2fK5I4CYWVoqDpWs9/LzblrkRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184511; bh=FoqucepkZXc6edLSAXduBiFLeT
    BfGwLF6I++VpTWZAs=; b=NxSrYkd8tN7G9uEHvAIkokAS3OXm77fi9iFq4B915d
    rFQ6FE3Nu3Xj+NlwhDydPiZR9bO/QetUyPuaeFYFIzUdOtFLNbzPPXi924ibx28A
    r+dxnZaN3KcHQsFXBZHpf2g2Qx4LWjIpGNc9wMGRrMocTSe845KZ+1XXnRj0ClKY
    MjGwvgFlNeNKmvREQJSM0iK8I2BKtmJgqJM+nKnVSUcNTqcmXP3fgWrCQiqi9BcY
    J1XJqjZ/gxGb0q+ggRWaM1z9CDlCAD+gJiuHleebSzZ80octQPHo0gnwZlG1YBeA
    0J3+EoJmWO47HmyuWDHJYKgIrtOvu2urRALySN4Siw1Q==
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
        id S1753662AbeBINpg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:45:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51898 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753658AbeBINpf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:45:35 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Subject: [PATCH 4.14 21/22] kernel/exit.c: export abort() to modules
Date: Fri,  9 Feb 2018 14:40:10 +0100
Message-Id: <20180209133935.673577380@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Morton <akpm@linux-foundation.org>

commit dc8635b78cd8669c37e230058d18c33af7451ab1 upstream.

gcc -fisolate-erroneous-paths-dereference can generate calls to abort()
from modular code too.

[arnd@arndb.de: drop duplicate exports of abort()]
  Link: http://lkml.kernel.org/r/20180102103311.706364-1-arnd@arndb.de
Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/kernel/traps.c       |    1 -
 arch/m32r/kernel/traps.c      |    1 -
 arch/unicore32/kernel/traps.c |    1 -
 kernel/exit.c                 |    1 +
 4 files changed, 1 insertion(+), 3 deletions(-)

--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -790,7 +790,6 @@ void abort(void)
 	/* if that doesn't kill us, halt */
 	panic("Oops failed to kill thread");
 }
-EXPORT_SYMBOL(abort);
 
 void __init trap_init(void)
 {
--- a/arch/m32r/kernel/traps.c
+++ b/arch/m32r/kernel/traps.c
@@ -122,7 +122,6 @@ void abort(void)
 	/* if that doesn't kill us, halt */
 	panic("Oops failed to kill thread");
 }
-EXPORT_SYMBOL(abort);
 
 void __init trap_init(void)
 {
--- a/arch/unicore32/kernel/traps.c
+++ b/arch/unicore32/kernel/traps.c
@@ -298,7 +298,6 @@ void abort(void)
 	/* if that doesn't kill us, halt */
 	panic("Oops failed to kill thread");
 }
-EXPORT_SYMBOL(abort);
 
 void __init trap_init(void)
 {
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1763,3 +1763,4 @@ __weak void abort(void)
 	/* if that doesn't kill us, halt */
 	panic("Oops failed to kill thread");
 }
+EXPORT_SYMBOL(abort);
