Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523400099-2-9862226961888433129
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523400098; b=GZV+53b5CxAuxUALNiJaH8jbC+qcqL5ooeOMdj11M6GI7DXW3r
    NSid5zefQxyMrZIZfTNsYRWPUxbXBneLiv6eN12xHRuJAsN2ybPp9XfAVJheA6qY
    zFoLQevkqE2KkBARZ9BkgcBMlL1EL6l/4/y8Xln5akxS4OoOjNYob3D5+16xLlTF
    z/qwmjcwuzyM2369KxKfIrql6Kr1TJ5I0hhN1/8SAb7H2mybIJJ4svGFPKx0v7xz
    ll3JhV4zVtQkdCEBYm/ANUMeM5sNCJIkwY5/6mVtP3EzgVSpA0NURjZ0b1MtsfIw
    kJzoDDMXSCut1YEh5zzQ8yQL6zU09d/sYJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400098; bh=DpQmsxTQuG65e66D/L0ObDgQfLaQNH
    0Pw62xpNMNGNM=; b=ePsZGw8S0GHrmeM7iREECms+gYvXJ6ejCW7V3FPsHWIIBK
    8594+yLuWxGT4c/mQItmww79PqVFRJzCRIPIOXYoovijcto5eoAfF84f89c611w6
    FMYIVmX2+TF6X1s5bPbJ9yHDQ+i+aWJ6D8VM3DA9u8UBW6ny+Y424299ik/oE7sP
    TRHPlaLFieZceo+KilZteC/c3jCwDaTsiRdvuUMCpt/uig/tFgIaw4FnkhwcwKhc
    Fo8yaPq+ZdpFu1+LUHnXi8/ciSTVCwOZXhITNZYI05gFBHfHydeBKXerMjEmgpON
    I6a/HuXNGfXFtX7Nnm4XWPxjSMsDDqW0c7BuW+9w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFqMuxgGeXlSTWimlqUsltr4+CP51+HlspBxoThdmjFEg9o7RKNGLvwBpcHhCOrHFWDLFvXsmPUH7JK3jc+FvrBhp42dHYMNzJ2kibf8HdCYpPzVtDjg
    tw/GmIAwgDS4y1o7RI1Zd5XJBZW4ugSjF6HOaSH7fq2DKLTK0roWR8wLdL8EDefJoPK7xtO7Zp/o5aZQ4FAZpheITXu0EbgbEQLRa0/1Je0YkhwuvOalj92V
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=FOH2dFAWAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=onqfME7SEjK7dH_x2_EA:9
    a=QEXdDO2ut3YA:10 a=i3VuKzQdj-NEYjvDI-p3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932722AbeDJWkS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:40:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932691AbeDJWkQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:40:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 131/138] strparser: Fix sign of err codes
Date: Wed, 11 Apr 2018 00:25:21 +0200
Message-Id: <20180410212917.448177033@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Watson <davejwatson@fb.com>


[ Upstream commit cd00edc179863848abab5cc5683de5b7b5f70954 ]

strp_parser_err is called with a negative code everywhere, which then
calls abort_parser with a negative code.  strp_msg_timeout calls
abort_parser directly with a positive code.  Negate ETIMEDOUT
to match signed-ness of other calls.

The default abort_parser callback, strp_abort_strp, sets
sk->sk_err to err.  Also negate the error here so sk_err always
holds a positive value, as the rest of the net code expects.  Currently
a negative sk_err can result in endless loops, or user code that
thinks it actually sent/received err bytes.

Found while testing net/tls_sw recv path.

Fixes: 43a0c6751a322847 ("strparser: Stream parser for messages")
Signed-off-by: Dave Watson <davejwatson@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/strparser/strparser.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -60,7 +60,7 @@ static void strp_abort_strp(struct strpa
 		struct sock *sk = strp->sk;
 
 		/* Report an error on the lower socket */
-		sk->sk_err = err;
+		sk->sk_err = -err;
 		sk->sk_error_report(sk);
 	}
 }
@@ -458,7 +458,7 @@ static void strp_msg_timeout(struct work
 	/* Message assembly timed out */
 	STRP_STATS_INCR(strp->stats.msg_timeouts);
 	strp->cb.lock(strp);
-	strp->cb.abort_parser(strp, ETIMEDOUT);
+	strp->cb.abort_parser(strp, -ETIMEDOUT);
 	strp->cb.unlock(strp);
 }
 
