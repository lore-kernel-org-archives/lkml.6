Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804331-2-12190661315683110761
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
    t=1521804331; b=g82huK/gpvMDyHGrTVTlZPzMOrTV8X8x5RRPr07agkP5zwS
    P3PdCbqfR1JVWZ0Je8wkFF3QvTlq3EmKxY7lZnWQ18qFnmy+Xju1k5B2DzuP+Z6o
    xrVKzgrIcBbmC0zPbJZFRsBamSfShzXMxE/jojla/CyHWBK1JoU4dPHa6xEUPkk+
    TriIs5Rqg0aQd5cgUZKBiO522yJrSSbNxZKQelZMD38GFIqOBPaYflTNXng/9YUg
    Wjiso5iCeR+MN68++yC/X3KkdQfhy7iyeBndROmT3m/1ZzwDmytZK+m964x1Vq0v
    CzII8NhzgEOGUuxapLQkSZDnTSANmVTdJggMfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804331; bh=FIpWorFPzFRCH6IfhuNjXJ8a2U
    UtJXjj1MsJ2vIoMBY=; b=vppPeYLrzfeMWApERKCmRpTR9w5LV7nep4jR5501PS
    9hYMui60nDRbkyqm4P5EChZGAS6AL/nCcoe53QhzYzoBr3SXaf5h5DdkGPziuMpD
    9/743Fj5cV5O8ZV9+47/jP8kgFnZh/Id+L2HOMj6WUXo8i+iKJ5Lwjs8mO5De6qM
    27an3Le4sJxeR+Q5uns0yhBOq6hpqP/RGKMhzUjUT46wL+Ypo9T372dsgIP5UzGN
    ffmvpT1L3YzxV9Kt/00RHz9ZPseoekTecnevHdziHs89bCwAX+rBU4OJQMK8w0Wj
    myVQ7OrRkTtUvuF1f6o1jX7q/BU5/cWTwxrO9qoR1nlw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755281AbeCWKHb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:07:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755013AbeCWKH3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 062/177] tipc: check return value of nlmsg_new
Date: Fri, 23 Mar 2018 10:53:10 +0100
Message-Id: <20180323094208.070539976@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit 78302fd405769c9a9379e9adda119d533dce2eed ]

Function nlmsg_new() will return a NULL pointer if there is no enough
memory, and its return value should be checked before it is used.
However, in function tipc_nl_node_get_monitor(), the validation of the
return value of function nlmsg_new() is missed. This patch fixes the
bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/node.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2094,6 +2094,8 @@ int tipc_nl_node_get_monitor(struct sk_b
 	int err;
 
 	msg.skb = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg.skb)
+		return -ENOMEM;
 	msg.portid = info->snd_portid;
 	msg.seq = info->snd_seq;
 
