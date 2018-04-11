Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479549-2-17022655779811084130
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
    1523479548; b=iPhEmqDZZPnb8yGft3xEWd0uVswIic6bNt03/rWidY3mZ+i11s
    TZuerb1dnyeEK5bjiF2ooYm9Xn4jqXGOBoSYdB4Brg+2hFX5iUYueE4MQC147OaF
    T/3tTHvB4S+QWsG7j4Cs9ILyLUZ8gCi1eEgPmnl65hhiRDaB8oFQiDt720dgfGiS
    2jvV7phuVO8AyEn5qrUdo+tWZsb6s0vGbj3xbXSZ8QX6Wgr4s/mIGQu7HDmiRbGE
    prr12/ERIdyqOIAs81TIWH3EnX6iOo3SBJ/U5FC4aGAC9fpGozhQOuZi6NuKuWeq
    A5GQ86u/8OApcV6a6DlpLQ7cDInrXLQiucQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479548; bh=SWQl/+KrwP7CKG4erUNHUWPEHU3H18
    pCh9yjPNjkM9o=; b=OkyPjy0eCdFSW7jmrkEQ1I13WkEIU0i9yalJQzijsgREWo
    tU+FnMTSU85ajTtk1NW4a6Xhp7PctJ3t6aepAy1/HETsHtCjM9LEOvcLSp5TIpj3
    hOR9dDTT7GWriwmKO/G/8XOq5y1s9a/WJ/RW5crf/6t0QKi/xyyU8TPWldLjI5yA
    oBsstacrMIZXo9hRMjmUgv1ek+bCFD5E23wcdxBzcn6wFDvGJzBrEhYetFkOEK2s
    SF06i7LbTkBuNeccwIuuDI6qFNJTB3U4NIe5sQrLGjNe5gALI3U42w6Wh1gyBa5P
    Ug++CYlRrAEDFTIcDjBZlCxG3XbvYkKKUsuc0cAg==
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
X-CM-Envelope: MS4wfB/d3S5QF1naE+fVz/KCJIHdkQT5TR3Zm9nPt+qO24HiAhNXImvQqV+c1hyAzNL/3QOeJM0wMWUsWYGuciik1po9ejSTIonfzp+cc5aRf0LJjJTcGQkE
    FF3+OPNTDEqXDYv4a3IRBuDeJPzmob+HCwa9SDH+QdFbxq+ur0/DsAGuwCL6vRdiHh8sM/ZZpby1I8VVdzIOMgqo2X6XpB9Jqs+sO8Wjagt2SpNc8iThWvGS
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=8QyaLQAlnL_XF40ULzwA:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755812AbeDKSrA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:47:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755811AbeDKSq7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:46:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lin Zhang <xiaolou4617@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 080/190] net: llc: add lock_sock in llc_ui_bind to avoid a race condition
Date: Wed, 11 Apr 2018 20:35:26 +0200
Message-Id: <20180411183555.243503151@linuxfoundation.org>
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

From: linzhang <xiaolou4617@gmail.com>


[ Upstream commit 0908cf4dfef35fc6ac12329007052ebe93ff1081 ]

There is a race condition in llc_ui_bind if two or more processes/threads
try to bind a same socket.

If more processes/threads bind a same socket success that will lead to
two problems, one is this action is not what we expected, another is
will lead to kernel in unstable status or oops(in my simple test case,
cause llc2.ko can't unload).

The current code is test SOCK_ZAPPED bit to avoid a process to
bind a same socket twice but that is can't avoid more processes/threads
try to bind a same socket at the same time.

So, add lock_sock in llc_ui_bind like others, such as llc_ui_connect.

Signed-off-by: Lin Zhang <xiaolou4617@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/llc/af_llc.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -309,6 +309,8 @@ static int llc_ui_bind(struct socket *so
 	int rc = -EINVAL;
 
 	dprintk("%s: binding %02X\n", __func__, addr->sllc_sap);
+
+	lock_sock(sk);
 	if (unlikely(!sock_flag(sk, SOCK_ZAPPED) || addrlen != sizeof(*addr)))
 		goto out;
 	rc = -EAFNOSUPPORT;
@@ -380,6 +382,7 @@ static int llc_ui_bind(struct socket *so
 out_put:
 	llc_sap_put(sap);
 out:
+	release_sock(sk);
 	return rc;
 }
 
