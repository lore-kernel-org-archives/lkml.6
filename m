Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523473771-2-15631185534918580441
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
    1523473770; b=w5rmsALxMcQnqUU9gYjdTT1P7VTX6xnVdWsRb5kWl84p10546k
    slDxueNgcD5wFkPXlnedeUMCtFv9tcuUFI8vI9a6D5BrJFHDulu/RNwYqnrSA4QP
    rHTSCY8XmuDSSTptgxltum57m5VCVj1sotH0+B93eaUu1y/W7ru5yysBKRebakQ6
    x/95Yh3ACxBo/+Ikv10DpnwYHxRx3SLNHRywpGCrpgxHoX0WH5j05MgfFaeCNJ5t
    NvOqH4GSNV6PVfm4vai3FfpAMJzid8RlqlLUAWzX0UM16qky2NSSQ/8Br8UtqDAq
    WM1kbeJUQoTKGJBVteTCpQ+LhfoHnJJp0duQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473770; bh=q6XgCdl1ULmY6+1FreyI1OvY+JD+IT
    WuaCkPO7lfa5w=; b=tsezsnWoEREgkLIQQ5WTDWGYUtkiS5XmqWIuOVeItANX41
    p9nbkxSIL1mw8YJMZlcjMLWbwCc3LiuiMklzeFSd8+3+hsv995cpVQ3k1wgJ9Ltl
    bVxobKkkEw8p3f/zsMxs9WY8EixZpaJgq719MihqSJKQ6AETvP6xZdmJ//qASX9Z
    F50yTD5WTtKxSfrlyBEdP02P6M+0Q8pPhFVQ0CpmWja6xdkLlilk9SgbzTJM/pcy
    0oqgfx8bfNdsa4RinBbKMAywgwpiWobWL1ZRqeWVA85/fA3wNHRBSYyPigimoaew
    26CUEcAAzIvwjbjHQalVis5R3A5g0LyncMrMVNVg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK0kJyHgQ90mULl4btqRlmFSDwK/QMowPk9IK0psRxo1+leIU21nO3J/efT0XPEl/3qqGt8wS9yZ3kwqy2pB+IKWueUFQZdcRZwPnbnYN8moDa21ZLzS
    RLYDwQSy4SUoct1nf5UTV9yraxLUmSQEb+DcD0EI3iimuc7t/tEYLFI5ZQkn2OZygfoJDmEejH0qf+AvVODRMORoSfdGPWIIOMbiP8JNoLY3m2XHITlIhGQT
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=FOH2dFAWAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=onqfME7SEjK7dH_x2_EA:9
    a=QEXdDO2ut3YA:10 a=i3VuKzQdj-NEYjvDI-p3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755101AbeDKTJN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:09:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40898 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935289AbeDKTGo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 308/310] strparser: Fix sign of err codes
Date: Wed, 11 Apr 2018 20:37:27 +0200
Message-Id: <20180411183635.796273558@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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
@@ -59,7 +59,7 @@ static void strp_abort_rx_strp(struct st
 	strp->rx_stopped = 1;
 
 	/* Report an error on the lower socket */
-	csk->sk_err = err;
+	csk->sk_err = -err;
 	csk->sk_error_report(csk);
 }
 
@@ -422,7 +422,7 @@ static void strp_rx_msg_timeout(unsigned
 	/* Message assembly timed out */
 	STRP_STATS_INCR(strp->stats.rx_msg_timeouts);
 	lock_sock(strp->sk);
-	strp->cb.abort_parser(strp, ETIMEDOUT);
+	strp->cb.abort_parser(strp, -ETIMEDOUT);
 	release_sock(strp->sk);
 }
 
