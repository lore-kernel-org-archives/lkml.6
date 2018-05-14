Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526280839-2-14484229457577174292
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526280838; b=cFEHhgMQFX/g7MJhjge6jg8XSjhLomGLZqSxLXTcoYDzpzTh4E
    iguKPHRuAhwrF8k1aCXFnVd3tq+KZM29TSgN28GvqCzLT9ujo6wWgiEgpOZCGm2X
    w3oYULUd41mQnmxY3jwLkSEo/KR41shRPJtKCnUU8V9/+Qcd+NM0Jognxp8ncOBz
    VMWOB6FMkMHm/csp3JYaZPZVMxJzDnhiH1g1ZdGWCCi2DgVzjSz7eSdeDwXMokuY
    Z9jGsxa2gbqbYxTQaT2cIz7htT/2bNQPnbxJ9uH4o4o4YiJ6o+2WQiwnVQ6EHSwn
    /eLbnofCZapieXeA1rpTjusSBMeQx65TL3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526280838; bh=PR1dZwTPxRPGfNtiH+ZTzPhrJ/sAL7
    WgYLqSXd1OKjE=; b=lus1XDziTrrwh5OTxP/HkXaEeCjQuCEPMTM0zqYgqkqOzo
    gyiTzAtEN8g3YFeMPn6NDJPuiIDv4DuZYW2zjKSKsKDYVGKDQtIiWfnxzyJz3jdk
    htUBzcrcx0vum9BZXCd0zhS34WvMul23+yoZJ2m2l0r8xH9jSzkfJ50paH3zg2yl
    bumPEXr9cBWkLbJ43czdJnQ4xdb4RlFJWR+VdyNLC0rM5HRJ2p7SYWUk5O6K4SiX
    vmTRjPlr2qB42TCcL9dAVQuSSl6HrF0nBxrP9ouE6b7A9Qc6Cibw3CTuzXHZtJIW
    1nHIIAiqmIoZ4j0NazEl8XDTQnMXCxPZv/7uJTow==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=HMdgM6mw x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=HMdgM6mw x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFs/NVjE323h6TeEdp6oCLiboTS6Lt77CeMOGBX9OcGVj3Lq3VC/CtmZcH/TLXOxte7WXq4uxeajSEZ91rvl3Z1nvD2x5Xe9jxyV1LyhiSYNY0qQjDHL
    HCQNk1Tvot+RU1Ie3VEzs+B06RmcaIJVDfpiN35G79aalHXJu760gW7w4jqEoEMTLjen3YTOnFP+0Qp/RreYN2RsFWsC0LER2eMz237uBYhG1cYS0caMmXlL
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=lbnt-wCRC2kHGM_95PAA:9 a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeENGxz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 02:53:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752936AbeENGxu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 02:53:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 07/36] net: initialize skb->peeked when cloning
Date: Mon, 14 May 2018 08:48:41 +0200
Message-Id: <20180514064804.832924487@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

commit b13dda9f9aa7caceeee61c080c2e544d5f5d85e5 upstream.

syzbot reported __skb_try_recv_from_queue() was using skb->peeked
while it was potentially unitialized.

We need to clear it in __skb_clone()

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/skbuff.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -903,6 +903,7 @@ static struct sk_buff *__skb_clone(struc
 	n->hdr_len = skb->nohdr ? skb_headroom(skb) : skb->hdr_len;
 	n->cloned = 1;
 	n->nohdr = 0;
+	n->peeked = 0;
 	n->destructor = NULL;
 	C(tail);
 	C(end);
