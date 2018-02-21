Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474421-1519217314-2-8588933638219579529
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
    t=1519217313; b=awDpA5LPCtrO5qYqefZPh3vMoLxM3oM7HjYxe7dqfU+TORx
    mR7CSg+/V1HWUmarDAibfZGXNzJhTaQ/d8iWZzCN4htUm3/JfhHnjJYeIq9enl0g
    FTLXT9fTcZZ2eiS10gTkXkRnANG3R8EsXdsAad74HqraR9vCJtLLNiZzJeqRO+zO
    8aiezgYdB+U/YLApfR3vPucppv+eRiTqIHcUcc0Z4tAhUYbj3wJZpnFwAD/jfF+B
    e3fmfJc7LSXOje7areE1lMNDz558C9cWzZG+R9O0VtXKzZ5JPqpnG9Nse5qkL7aQ
    TMcch+dIyCtDLBbVGsN4GUeN7JcbzDTD87rbzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217313; bh=GKBUQ1kCT4cMQpI0kc5H79F6ZQ
    2K6kDWTpn+F2gX7Fc=; b=jUGgbnoGRIw3qVML7mYyzcHZW9G5GyzNWIVsyE0rho
    Svm/vTYerehn/1KNe7Jad5BJFrEbQ2QrrsKzAPBh9iBFRqPJV4agUTUCXhORbYD0
    nI4Yl05DQtHXqNs3POyL4SEFv+uFYpP/+A1KJKj7NmyAE8p5qKLEqxhNxEvMgUgZ
    nuie6Fb9m/A1eNdIvPohmX0T7mucD+gO7UdsK0QRzl1ypUhj3ObkACPEUTGW2eBe
    ik/Xl9+iNPfifSG/FSGBz4HGtU486KOtbjPrkSg8QUyEU18a0vyOU41wYyucphRw
    4b9NkmxsVKqSGRuwu58+MAizip7E+wfXflOXfTmIZzUw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934009AbeBUMrp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:47:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59872 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933929AbeBUMqd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:46:33 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 4.4 29/33] x86: fix build warnign with 32-bit PAE
Date: Wed, 21 Feb 2018 13:45:12 +0100
Message-Id: <20180221124411.086079188@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
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


I ran into a 4.9 build warning in randconfig testing, starting with the
KAISER patches:

arch/x86/kernel/ldt.c: In function 'alloc_ldt_struct':
arch/x86/include/asm/pgtable_types.h:208:24: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
 #define __PAGE_KERNEL  (__PAGE_KERNEL_EXEC | _PAGE_NX)
                        ^
arch/x86/kernel/ldt.c:81:6: note: in expansion of macro '__PAGE_KERNEL'
      __PAGE_KERNEL);
      ^~~~~~~~~~~~~

I originally ran into this last year when the patches were part of linux-next,
and tried to work around it by using the proper 'pteval_t' types consistently,
but that caused additional problems.

This takes a much simpler approach, and makes the argument type of the dummy
helper always 64-bit, which is wide enough for any page table layout and
won't hurt since this call is just an empty stub anyway.

Fixes: 8f0baadf2bea ("kaiser: merged update")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/kaiser.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/kaiser.h
+++ b/include/linux/kaiser.h
@@ -32,7 +32,7 @@ static inline void kaiser_init(void)
 {
 }
 static inline int kaiser_add_mapping(unsigned long addr,
-				     unsigned long size, unsigned long flags)
+				     unsigned long size, u64 flags)
 {
 	return 0;
 }
