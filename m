Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479500-2-14266420746888866117
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479499; b=mlVXzxkEl9WoVAvvbwwZhsCSLionDNaW0HHjBgTOmd/JcymMqU
    dhuyjRbVjtaMHmfMwHIPEqDKdb8IqLPFyrqBLXJtqEA6ZHNbjDliX7wZ9Lc8iIQW
    dNueoE51xac889dL4y/CNSya7QcAmMBXSSaupA3yUOI+kblW1ugJOkl29yTSafMZ
    o6MnzyaACbkIP6D8ZKvmolpE3yWSriaBIWtkCIQrRYO8lmsZyFpgJJM1AJYtaIe/
    4GY42+NiEowwlpWOhEJVy/hN6gD3Sb7N2FGFv05VvTkUPphYRcx74nFvlclPQTqQ
    roZ73EILZaGLBNknK/5xIPKgIycVHWavUWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479499; bh=mSpXBkWj7SRpRpJFHghzTfAlkvuuv5
    fTDGzSSz+xg/E=; b=Th6b54ExKajGWBWzznc8zTg0Yx3qqhKAsVTkH6EALnuDZ6
    lKkDOdotyf3/V9CFGqT+3TmwJDjrAhYJs7uLXwkbB899H8F2xoBZXFAySIkIGC9+
    hLgt41eZ9pdpIOoLqncErjGWLxec/NAp7iyxQn2w5KmeJGJyO8jy3PiIliMSzFz2
    ki+TosDxnL8uj4EQhDejU7i+Azf+abRoKSZ5Tfzp0I0l2LfG/uo5dtSF8kSj2KIz
    700Qqu/shupqCLsFBy3yc4kr6qSgrtzveVuWO1vUtKYQVg9pEU6i0CWpvXtwfLE1
    pDhhCEEKxGs502NgCN0hhSzNLVPxIHymVNAEz7oA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHdBGja6a/YHXT4iTTWsIMH++FsT2AreH63etbeuC4pObEAVUzCBeI2EpgRxawmAAVQ9SLggW7lVPUrz9yuqXeUj/PJQYXfoCnsYcLXCN6favbMNUbih
    oxhVRjrDlAcjbSSxk4Mlmosp6sLYAGcyDNKYtnCvraS8qM61SXsmBAummTeAnTsrH+6qf/yDqsW1iVgjZ0jtmIIyH88h1e2NNaYOTv3HjMJNyR7gkgfMdh2c
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=7CeojBlomD8Mbgo6nkQA:9 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755848AbeDKSrL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:47:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755830AbeDKSrK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 084/190] l2tp: fix missing print session offset info
Date: Wed, 11 Apr 2018 20:35:30 +0200
Message-Id: <20180411183555.521533841@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: Hangbin Liu <liuhangbin@gmail.com>


[ Upstream commit 820da5357572715c6235ba3b3daa2d5b43a1198f ]

Report offset parameter in L2TP_CMD_SESSION_GET command if
it has been configured by userspace

Fixes: 309795f4bec ("l2tp: Add netlink control API for L2TP")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_netlink.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -732,6 +732,8 @@ static int l2tp_nl_session_send(struct s
 
 	if ((session->ifname[0] &&
 	     nla_put_string(skb, L2TP_ATTR_IFNAME, session->ifname)) ||
+	    (session->offset &&
+	     nla_put_u16(skb, L2TP_ATTR_OFFSET, session->offset)) ||
 	    (session->cookie_len &&
 	     nla_put(skb, L2TP_ATTR_COOKIE, session->cookie_len,
 		     &session->cookie[0])) ||
