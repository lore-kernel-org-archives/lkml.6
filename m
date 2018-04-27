Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-288473-1524837735-2-8136646396104940787
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524837734; b=gj4VeYFBjOKuCHAUOoyo6loaJRp+kYKcKF+2lb8RR93zie0W/a
    EI8DMiOJX4+0oR7oXtIDMXl/VQp7qPQF/siMUaNfOxUtyidAgt4O0CvD7b5zORFY
    +pHyx3fQF7X9WbDOva1V+Ds7a6A7dexXH08O6EWttguOQlw+s+S/ehVu9JnEpE0a
    bvq5ApkgeREpq4WL59+9jS94cfaOMt8v20TnD4U5Yn8MoBsuPRUdRp+C2cWLEC7m
    9Y/wCQMXuwsVL9yfAZc7GF4+90gEVNtW9KJd+xMkHKO3RFjtItDOgPOKeMuz9Gxu
    tdLt5rjG7aJqc+cKg/P00DsvibOusFdJ4azg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524837734; bh=o/G6jrhxtDKQLxf0mRz6jbVe134+Iy
    AcV4wcYRsgOhk=; b=DHCuCqj12+Dum3TBPSdqHh9N1jUaLR5/VY1wgaW57hwDBf
    CLbMC/4L9MDypJCTdqL1Imlo0rDJEww90OWJtO7a+N4h8vxifWdPWFN5Pp41KFkG
    +Jazy7Qvaml/LRYLtoXH3HJyMGTe6z/TXBMZ628Cx7chUXiRwNXhRSkeH2HfU8fS
    pBbFNlnkXug9ceak4PWs764N+FzSoEYK4OgXfOWoO647AKXaNmF1Ve16zUwlfUIr
    PJH8bTX6LVzxs2DJGQ2Q43WJUxardm3lqRnpoFlyY6TxWkTmE5AG1/5FwEWzzk/M
    hsI9uvKwZeDVElJIZylNxUsPM47OBrI/d6VHXzDQ==
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
X-CM-Envelope: MS4wfNfgUqzFq7rLjMWLqAWN2eHL7T4mWaLbTmRIRQ/lfEmiXxy4JNFu/lZAlmVzotoRPjIAl+LgS+imbTs0xpkiG2Mqns3IF/nZZRFPUim7Zb2J34ZHdukE
    qkqeBYtvb7vw6wIm08Uv7jLJnv3dAGlIBDRa/LRnmRJu4fC/vT75qjMx5KnbDQ4oaBLWVBQ8i8Ty8pTKkTTkWpH8fPAv/jNwWI7evVYP6YQ4StQS99N2u65e
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=0FD05c-RAAAA:8 a=t7CeM3EgAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=kKS-bE2akbXBnjzK24sA:9 a=QEXdDO2ut3YA:10
    a=l1rpMCqCXRGZwUSuRcM3:22 a=FdTzh2GWekK77mhwV6Dw:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932994AbeD0OCI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932892AbeD0OCG (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:02:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398E321897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 42/50] tipc: add policy for TIPC_NLA_NET_ADDR
Date: Fri, 27 Apr 2018 15:58:44 +0200
Message-Id: <20180427135658.158521318@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit ec518f21cb1a1b1f8a516499ea05c60299e04963 ]

Before syzbot/KMSAN bites, add the missing policy for TIPC_NLA_NET_ADDR

Fixes: 27c21416727a ("tipc: add net set to new netlink api")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jon Maloy <jon.maloy@ericsson.com>
Cc: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/net.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -44,7 +44,8 @@
 
 static const struct nla_policy tipc_nl_net_policy[TIPC_NLA_NET_MAX + 1] = {
 	[TIPC_NLA_NET_UNSPEC]	= { .type = NLA_UNSPEC },
-	[TIPC_NLA_NET_ID]	= { .type = NLA_U32 }
+	[TIPC_NLA_NET_ID]	= { .type = NLA_U32 },
+	[TIPC_NLA_NET_ADDR]	= { .type = NLA_U32 },
 };
 
 /*
