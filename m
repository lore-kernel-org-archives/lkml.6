Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524837534-2-11909079160643605669
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524837533; b=L8woUpmJSYLEX8IxxDYojggnCsQ4qiOWK8SS8bItY9pJC1atO/
    iuBO8CeTI+7m8Lh33eAp9qYeQOswq1WLJvtj9cCUgDvALwzdiR2zjV4rA28z0dxp
    0+ktQeyq31SLCqL65NFJizTDbjFHrj2SG+dOlWxFG0TRYSCAZsAdpVGEDduLqqVJ
    Xr5/y14PIp1TEk6sRDT947qo8nXrOr2uJmgeuIjj+W2wCOyi0d5La4j/z3KpRsuD
    Z5MyzWtARncU76ZwM5VP1ii1gJ/Ye/reisAzP1BCahrFv3L65k/A9mqzWYXsqmrB
    AHnhZVEG5EEoP6gSHGZm3KIGRHCU/VPFU9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524837533; bh=yED5QJCM8kEU406zW/RJGYA4z8K7r/
    k+Ch7xxDfh5oQ=; b=JSC7yws7jzJtyj+D7dA3u972hHAKjiVFYhvQDeypnBobXp
    sGltSvXwigmU0uWJyAyB4wQtXoiK4JtXOhQgkzN4LdXc5wSwKi8K/YbiF7tT3UZV
    Ab0d9jK/EpvzFuTWfy7+JAazBvwUPr0sRBeHamihW/cUE93hcyKdIpylWYUtppu6
    jgfrtWgYche660GVbHSOchvwK+bf5kbECi7ESy53eNr1c3rlGIA0lST/FRtwIJyT
    HgbgJ6uTCkw9IoKwKVzo7kiLWQcMaDYDL4ttGTLMQUhRV7SbiI54so37yP5mVNry
    4txaC5qvU3jU8BUtJnEX26ujjAZYlWcgd2jbjgKg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfHMGW6IWBiSTHsFwB15u7niIuj5D2lyo4kl8XtZisq+WLselQlukiKT+lelS0r7mHGJFq7a1Qj9eAn7fnAmjQAXIqVR3oY/+URzZMAaf7fPXZ19CIHfS
    G2ojY8qe2qVVvEXGJfBzEP9tPFWxbmD8wlrS2ql9APrxVdzB3W8mBZ2UUKa+3OgK0/BMkQuK79eDYrojaUDs+F2dpiXuMN6hQRooYZL5GrVSCclwflvBhw/t
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=xoXKdaVV62sOJPrrZbUA:9
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932901AbeD0N6h (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 09:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932387AbeD0N6c (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 09:58:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E401621890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4f03bdf92fdf9ef5ddab@syzkaller.appspotmail.com,
        Guillaume Nault <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 15/24] pppoe: check sockaddr length in pppoe_connect()
Date: Fri, 27 Apr 2018 15:57:50 +0200
Message-Id: <20180427135632.204591428@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit a49e2f5d5fb141884452ddb428f551b123d436b5 ]

We must validate sockaddr_len, otherwise userspace can pass fewer data
than we expect and we end up accessing invalid data.

Fixes: 224cf5ad14c0 ("ppp: Move the PPP drivers")
Reported-by: syzbot+4f03bdf92fdf9ef5ddab@syzkaller.appspotmail.com
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ppp/pppoe.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -613,6 +613,10 @@ static int pppoe_connect(struct socket *
 	lock_sock(sk);
 
 	error = -EINVAL;
+
+	if (sockaddr_len != sizeof(struct sockaddr_pppox))
+		goto end;
+
 	if (sp->sa_protocol != PX_PROTO_OE)
 		goto end;
 
