Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521215166-2-126109564677401834
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
    t=1521215164; b=aegXoO5pvHz9sbmQBrsgRJjFdOIl1NkmuXIszcrr5V2k+zo
    YqnE0ygyxE3AXtgRXgBkg+a3CtFW7lNnkAJXFmQ1wSZBia66mwDXMnYz9BFev/Mb
    33ta9pcYseyu0y9YeI486PpTvqpAA26MIWGq6Kh5rB9sPydCpTcCJn+JIjWWqVZi
    IElxlTdx3Cci0+Wg1Fgxv48x7C2zntwzk/ZWgbDP0BLk625TlW5B3IODY4n8UON1
    1fwx8TCE4MYLOdVHkUpS11cjCYPbjkEfgn3JSkAzpB1llAMAGMx2ChrKeoIPNE/k
    DWLey78Kuzwb/8+tXqWis4wiZV5mbYLLHjgn9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215164; bh=ce0VksM12G8yUh891HSyxjb4ZH
    sVfSi3aZ2Ob7Ru34Q=; b=ZJr+WjQbZy0Bs8f9Uq0rhe2Wecul8xQkpFEogyVA7m
    XLMA2NLa+o0HR03HAOWP05x1QxuOLYltie54ihHiEDsiYKcq0B3R827STipXpeav
    jxxAq3va7zsF5yW3fEsttAfCa0m9rguORUXBnsc3OEgBQMNCkUQU1i5Ck+PfiQOC
    W8q7u7teHCXTQmIOeglc/ibm8QKDxXLgwMrMl8LaFlzXZUA+FMJsism7hfsg0uH4
    8rClq4a3DagczPR+a7lHDV1hK0nNS6GVIUcqUKxNifHn2UXqedsDv6Xgcp60WUWg
    2Ocw6zsPEBG+GOHlG26knzhdTOlSX29/R0v5Xt28Ragw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934379AbeCPPpS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:45:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46276 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932967AbeCPPpQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:45:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 121/128] Fix misannotated out-of-line _copy_to_user()
Date: Fri, 16 Mar 2018 16:24:22 +0100
Message-Id: <20180316152342.472049392@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>


[ Upstream commit a0e94598e6b6c0d1df6a5fa14eb7c767ca817a20 ]

Destination is a kernel pointer and source - a userland one
in _copy_from_user(); _copy_to_user() is the other way round.

Fixes: d597580d37377 ("generic ...copy_..._user primitives")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/usercopy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -20,7 +20,7 @@ EXPORT_SYMBOL(_copy_from_user);
 #endif
 
 #ifndef INLINE_COPY_TO_USER
-unsigned long _copy_to_user(void *to, const void __user *from, unsigned long n)
+unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
 	if (likely(access_ok(VERIFY_WRITE, to, n))) {
