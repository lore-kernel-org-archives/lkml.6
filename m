Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2707851-1524408552-2-6981602164687947715
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
    1524408551; b=kOQDqEsRcEFC/9AGHEX1jjsH/3GIv0QKZDIsqJ/cP+9+r0DCiS
    L9p14FVFT2ozIQE6KO5kb1HJE0UAdPz70anTk9aKcQE3/vY8VWBjkBTEIacDQIEg
    bbIXk+bGaaWyv1lU/fo1+a4hMoppEfGRNqJo27YOug43rfyKyfEQQEe5pBPC+S/j
    wEv1ufIDY4i6CEQf6JVYZYlkQa0qgKMrCAsTHBHSlSva+3ImxN+6jhZoE09lG7Lu
    iyslbH0HvncdJOgqjVOI13+DrQLhLiVW76kSdvrr20+0tKOtmMisfTvhsCCYQJUv
    KPUlk8aekY/+SRe7zY6ar7PMp20uQKxl4zOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524408551; bh=SlJhF6G9JpoB0bKmwyjsvfA1RaQzZ6
    Lel4ZFB1TzoN8=; b=kTl/zUh76rax9mwUhiJERlnRgTRWKvNFSOKvRc6YDUJFvI
    dNejXMa+atinC2jAy/QL8KkHTFRYAqzhGxPqDt7N2xO+1w/wO2SPF91+Jlrr94tj
    xM+mqUhm9wnW632xc89+YshmigIKGaPSiCuUYo6Olc1emG2lEv6HP0TVDKxJSIDt
    YHW0/hb79a0f6le3UnTSpxq9k3TgA1nUoimABU7w5HWFN5wKgky6QXmrIs6RzJtS
    xg5Xj1EbrDe96mADE6H2N7ahMAVYmwvFIs01dmab1s0WK6LOycN9M9QxBG2ZQNoH
    PZfkdq2kzNvc+q4gG4oclnEQHkC07MV7o9EJOX/A==
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
X-CM-Envelope: MS4wfPtrvn+U1KIM3LRMWWINhv1Qb3i87WyRDaRl6FYXclajgI5t3vhpc2sb6CueQxqbvxWLjyiW53mlyn3P6RvBLZn3Zpp5bhy5XvIqW09oYQZO4hc9uu7Z
    9iQJi8SmmJMI2P7C/JQ7XCrQxM8hbMXgOHjogn+JQWJ0/sViQMq3XLOsMlT8MKJiS/wUGHqq3toG9PHTBO5Qc3MG+AMKflfAslANSHAPQw/dmBDf1gCHxMAX
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=LpQP-O61AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=xCA6M9RBPztMd-TT8aIA:9
    a=iWGs7ug4uUsenJFK:21 a=2lnvoIu1zlh_getn:21 a=QEXdDO2ut3YA:10
    a=pioyyrs4ZptJ924tMmac:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754709AbeDVOs4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:48:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57028 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932178AbeDVOPt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:15:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tejaswi Tanikella <tejaswit@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 17/97] slip: Check if rstate is initialized before uncompressing
Date: Sun, 22 Apr 2018 15:52:55 +0200
Message-Id: <20180422135305.584991855@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
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

From: Tejaswi Tanikella <tejaswit@codeaurora.org>


[ Upstream commit 3f01ddb962dc506916c243f9524e8bef97119b77 ]

On receiving a packet the state index points to the rstate which must be
used to fill up IP and TCP headers. But if the state index points to a
rstate which is unitialized, i.e. filled with zeros, it gets stuck in an
infinite loop inside ip_fast_csum trying to compute the ip checsum of a
header with zero length.

89.666953:   <2> [<ffffff9dd3e94d38>] slhc_uncompress+0x464/0x468
89.666965:   <2> [<ffffff9dd3e87d88>] ppp_receive_nonmp_frame+0x3b4/0x65c
89.666978:   <2> [<ffffff9dd3e89dd4>] ppp_receive_frame+0x64/0x7e0
89.666991:   <2> [<ffffff9dd3e8a708>] ppp_input+0x104/0x198
89.667005:   <2> [<ffffff9dd3e93868>] pppopns_recv_core+0x238/0x370
89.667027:   <2> [<ffffff9dd4428fc8>] __sk_receive_skb+0xdc/0x250
89.667040:   <2> [<ffffff9dd3e939e4>] pppopns_recv+0x44/0x60
89.667053:   <2> [<ffffff9dd4426848>] __sock_queue_rcv_skb+0x16c/0x24c
89.667065:   <2> [<ffffff9dd4426954>] sock_queue_rcv_skb+0x2c/0x38
89.667085:   <2> [<ffffff9dd44f7358>] raw_rcv+0x124/0x154
89.667098:   <2> [<ffffff9dd44f7568>] raw_local_deliver+0x1e0/0x22c
89.667117:   <2> [<ffffff9dd44c8ba0>] ip_local_deliver_finish+0x70/0x24c
89.667131:   <2> [<ffffff9dd44c92f4>] ip_local_deliver+0x100/0x10c

./scripts/faddr2line vmlinux slhc_uncompress+0x464/0x468 output:
 ip_fast_csum at arch/arm64/include/asm/checksum.h:40
 (inlined by) slhc_uncompress at drivers/net/slip/slhc.c:615

Adding a variable to indicate if the current rstate is initialized. If
such a packet arrives, move to toss state.

Signed-off-by: Tejaswi Tanikella <tejaswit@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/slip/slhc.c |    5 +++++
 include/net/slhc_vj.h   |    1 +
 2 files changed, 6 insertions(+)

--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -509,6 +509,10 @@ slhc_uncompress(struct slcompress *comp,
 		if(x < 0 || x > comp->rslot_limit)
 			goto bad;
 
+		/* Check if the cstate is initialized */
+		if (!comp->rstate[x].initialized)
+			goto bad;
+
 		comp->flags &=~ SLF_TOSS;
 		comp->recv_current = x;
 	} else {
@@ -673,6 +677,7 @@ slhc_remember(struct slcompress *comp, u
 	if (cs->cs_tcp.doff > 5)
 	  memcpy(cs->cs_tcpopt, icp + ihl*4 + sizeof(struct tcphdr), (cs->cs_tcp.doff - 5) * 4);
 	cs->cs_hsize = ihl*2 + cs->cs_tcp.doff*2;
+	cs->initialized = true;
 	/* Put headers back on packet
 	 * Neither header checksum is recalculated
 	 */
--- a/include/net/slhc_vj.h
+++ b/include/net/slhc_vj.h
@@ -127,6 +127,7 @@ typedef __u32 int32;
  */
 struct cstate {
 	byte_t	cs_this;	/* connection id number (xmit) */
+	bool	initialized;	/* true if initialized */
 	struct cstate *next;	/* next in ring (xmit) */
 	struct iphdr cs_ip;	/* ip/tcp hdr from most recent packet */
 	struct tcphdr cs_tcp;
