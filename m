Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1445413-1522346801-4-16881895091297167085
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522346801; b=FAsVfv4Up7OVQaGZKVlHtwGm0Eek5vJySkg5sEwGs+N8Zti8tM
    uLXI0fI6AYSOSN81aZIpmqI7PI/g+2oTKH43Cm8u1RLYshYkkt/5E3havM2HhZ3J
    bQLeTr9UNRyiU04Jz2C4uuznYjfxZBQvDftkNG7RVMb5MNMdlDcKczic9/r2JDK4
    Ayyn8CcpeKybr9JkC0gOj1kYeFgewK9451d09sJMY2z/M8jaEclnp9wIxOiuRean
    HOaajxfQCun3sSt/opV5oV4i+3kLtGQlogVVCGqptrnmhzpTlcEGRFS0VF0JA16l
    wa9M7hgcTE/hi/nKT8kCItOzg+xS0B4mKbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1522346801; bh=zImd4USYshDwspOOVSgJavQBGxj5WN
    vfiltbeUgvRx8=; b=cGm9+rOtZDnkiMQ1xrx18BA87WJnk3TK4NlOAE7JBRexXd
    OemgtHaEY8Ck5bAl+DS75c301fzvSn0uJANBPc/mPQnagRqCA3ZBuvYgN82E8s//
    l739oIh6dEB9idrZ60t56BfLnXP9KebZBepuHnWSRtqO+Hlo83T98fO1w5Z14d3j
    0jgdIsi5SNA951IKIjCzZvh9n5kjvq4tgAyH2uZsLz8H2M5oWF0GuHUuDsb7da+C
    z4qrmkBvEOiPz9+r0z58QAu5ohJkNcC6GSNLg7OQKdKDnjZT7+hLkocAAX1IXkzm
    bIUSkPzsr1fikYg+3dyHjmxziZAEEStpe5kG0IHg==
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
X-CM-Envelope: MS4wfGdtH3dW3lDv+J6ZY2B1GnntCI39o/qXEpno+MPKeDGWGWY1prx4mdCy+tH227jyWQSSncUhLxNC8kP2COzUdhCwWgoD47Qqv9mN6FxoWlWohxy467sP
    2sb0F+CshY/xz4Uleo65m9K1VCjzghhMzu4gv3V9aRTN+MN62IBRttaXuG2iFl/kb8WDNpcZS6glZ3CrFHuB8AQaxhTqutnEB0h8nFbBDAOzRSz7gCPzUG3g
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=uso7iP-VdyED5FDit04A:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753748AbeC2SGi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:06:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59704 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753376AbeC2SGh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 14:06:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 18/28] net: Only honor ifindex in IP_PKTINFO if non-0
Date: Thu, 29 Mar 2018 20:00:37 +0200
Message-Id: <20180329175735.469845568@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
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

From: David Ahern <dsahern@gmail.com>


[ Upstream commit 2cbb4ea7de167b02ffa63e9cdfdb07a7e7094615 ]

Only allow ifindex from IP_PKTINFO to override SO_BINDTODEVICE settings
if the index is actually set in the message.

Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_sockglue.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -242,7 +242,8 @@ int ip_cmsg_send(struct sock *sk, struct
 			src_info = (struct in6_pktinfo *)CMSG_DATA(cmsg);
 			if (!ipv6_addr_v4mapped(&src_info->ipi6_addr))
 				return -EINVAL;
-			ipc->oif = src_info->ipi6_ifindex;
+			if (src_info->ipi6_ifindex)
+				ipc->oif = src_info->ipi6_ifindex;
 			ipc->addr = src_info->ipi6_addr.s6_addr32[3];
 			continue;
 		}
@@ -272,7 +273,8 @@ int ip_cmsg_send(struct sock *sk, struct
 			if (cmsg->cmsg_len != CMSG_LEN(sizeof(struct in_pktinfo)))
 				return -EINVAL;
 			info = (struct in_pktinfo *)CMSG_DATA(cmsg);
-			ipc->oif = info->ipi_ifindex;
+			if (info->ipi_ifindex)
+				ipc->oif = info->ipi_ifindex;
 			ipc->addr = info->ipi_spec_dst.s_addr;
 			break;
 		}
