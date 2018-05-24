Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527164022-2-3108229198325538430
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527164020; b=TM5PKgvgRxcoZs6Q4Frq8ADfFJ+Q3c7cADRny4Uq+2LeMGEAoC
    eqNusiBsp6Ye5ej8d7E+Gwk5CzeOR/JTYNfgTNCxY2DRjQrOoYoIVIN1b7ojrP8S
    g9puujwKIRvhTQtfAkYwtDKNYRDrV/7daisl8lE94p12K8L5DJT4RG1yfyuU84aU
    z5wbLjaQ1dLiDMv019ZKevb8QUhEB4a9+o7q9nbKGbi6EASy7OE9o02+nWdovee+
    CtnZ+HdcEz/DUZDQ84dSF9jTWUqJDVR3mdp1sldbhtiDJrIFmmQyJP9NhHaxN3Yn
    gjmtEWH6Q0XKFfzN2dElobQiK6NS/n8Qzp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164020; bh=3Vi99dvHBpGOAxX0T4e4VSY6uMHSwV
    wHB8sA1WSlM/E=; b=dOXon3JIyGjIckt78fKipjHJCy2si4Pee9dJcaNo0Kw4JE
    y+WL/XawzP4Zxcdwjn0ES4vKGcGrCSzenLVjnPVVzJEHz0BmT6io05I5rxn76ykE
    GgMrrge1IkcacY5ERge8ElfEBjHA8kLXlAnbammL6DGNxweL4aMXe59B2AQ9TVlY
    wbjbepz+6W0gj+CyVeknil1RDSNQeup8RM6d8eBUNnvFfKLefCJ+lqPzSCUQYNxW
    ii7RHQgy0O5y1XaGkInzz7VK3m+NOZTWtjZW2gqt90arnoCPvkp4D9Si3fu5m2Lj
    sGSSFYpZdKQyHmhrlFBTEccRZSvWIIJ+uuvjj/UQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=NSi0JenB x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=NSi0JenB x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfD5mVb/BOEeMPgQ9yzbBR5ZK3WdLzofi+aM9Qo8KmdE6AJMbAvaUia3wsmlMjShlBs6EURVy7Z+osqWj2imc0lewpFaIPvEvDwgTMPinF3DHuE4SU8Ed
    l2nK+uEAOyxAkBvaKBb5VMUg9+2e+EBDXmqh6gJTgxejyl/P8MTv3RB5hFJkyudg4/TRX2Qywp5yxIezgo7Nwh/rlT08vKjdgLSfZTaUqWG2xXyC/o+pP30v
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=9-efGfXaAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=MLiVjpLBtXPEc2nvV38A:9
    a=QEXdDO2ut3YA:10 a=76mzCeYM3W7A2q4738_3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966366AbeEXJmg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966355AbeEXJmb (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:42:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>,
        Guillaume Nault <g.nault@alphalink.fr>
Subject: [PATCH 3.18 20/45] l2tp: revert "l2tp: fix missing print session offset info"
Date: Thu, 24 May 2018 11:38:28 +0200
Message-Id: <20180524093123.172222227@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
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

From: James Chapman <jchapman@katalix.com>

commit de3b58bc359a861d5132300f53f95e83f71954b3 upstream.

Revert commit 820da5357572 ("l2tp: fix missing print session offset
info").  The peer_offset parameter is removed.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/l2tp/l2tp_netlink.c |    2 --
 1 file changed, 2 deletions(-)

--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -633,8 +633,6 @@ static int l2tp_nl_session_send(struct s
 
 	if ((session->ifname[0] &&
 	     nla_put_string(skb, L2TP_ATTR_IFNAME, session->ifname)) ||
-	    (session->offset &&
-	     nla_put_u16(skb, L2TP_ATTR_OFFSET, session->offset)) ||
 	    (session->cookie_len &&
 	     nla_put(skb, L2TP_ATTR_COOKIE, session->cookie_len,
 		     &session->cookie[0])) ||
