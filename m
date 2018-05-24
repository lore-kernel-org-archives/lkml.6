Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527160739-2-10202929753131658751
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160739; b=IPy6rKGYz45gBHrRl+6Kk7RZsXuYqjcSvIz6727XrwhfV2pccW
    WHYeE9Jth0Jed4uaUSnvsG+86h3k6i3OK8WQSKob/GNganHTFWjF9esRUmrINfUl
    aI/57ZI/tNMXkGb+J4C95BaqCmNVToNLNxp9MRZ8kS2gHHPuxJZTM0O2H5wlnW/F
    jgC89b2i22k6krHUkIqppG92eAmQuC/+jDMaAChiAPDvfCqX7KO68whM809CMSVG
    ef8AHUtInOFS5MI5ruKBhteaJiChUjwZRNjxskf1ln598Xft3x/yVHYiung9Q3mE
    BN4PRVqMZAhQL5KLBn8inbMHLev/OHJImMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160739; bh=zpMOL45XSIC9I+uunuZFCYxYMuJl4Z
    NFEzPHmnUOHJA=; b=GKALjmXee4/FwuL1KpMCALSsDD4XFEXIDSgReta1NH3t5r
    oHua91SLfI2FTzRIZhsJVB40GBp7LcBpUTwr8pj5zNp171vkwkyiwtPIoZDlwq7N
    lJsWEu4Sh5XqoRWIbA/j683jdlDKuhnpDbQreR4MpmQxbowYRbzdPG4DFwui5QO/
    P9iwJqMnwhlSIAaKqlY0t2ERiFIOM8MsePyj+D7NQSsmdRrrojx6J90Z4j3XNzdM
    jZcfzNqbCNtMP/C2aLVcQ8VvhySFdUDJI1sXrDYst5aejRhsDPgpv1+Y1GnUp7wJ
    By9+pzXG1P8Q4x8ONmVUYA6NWQQBHvA2b6rDOupQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Ms0/zhSq x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=Ms0/zhSq x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKal/GqI9jZu7o2hEgiBlqfdDm0RwY/pfBBMU+7YEJ5J+UatryibBUa0CoFoOwy5ic4SgL3+pp3cE+PWpgVvWCmYIynUyl1xh2tyIpxBs9vZfMHJsQzW
    5rPgFF9swsWUjoEo8NeLilQwd2+TCIaQXPhOH3IdlIMkD5pHqCvQ3+Jogh9dSaTgDL0dp6MnWTbc2zyxk7/jEzvtwzCyOTyydRIw2n/RhawkDE6eEhXOv9Bs
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=G8Vht56IOoz3jrsCRGQA:9 a=HWPkSav1Z8iwHe2s:21 a=ise_7HGtSiYG6tJr:21
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967972AbeEXJxE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:53:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967967AbeEXJxD (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:53:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 007/165] packet: in packet_snd start writing at link layer allocation
Date: Thu, 24 May 2018 11:36:53 +0200
Message-Id: <20180524093622.272797943@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit b84bbaf7a6c8cca24f8acf25a2c8e46913a947ba ]

Packet sockets allow construction of packets shorter than
dev->hard_header_len to accommodate protocols with variable length
link layer headers. These packets are padded to dev->hard_header_len,
because some device drivers interpret that as a minimum packet size.

packet_snd reserves dev->hard_header_len bytes on allocation.
SOCK_DGRAM sockets call skb_push in dev_hard_header() to ensure that
link layer headers are stored in the reserved range. SOCK_RAW sockets
do the same in tpacket_snd, but not in packet_snd.

Syzbot was able to send a zero byte packet to a device with massive
116B link layer header, causing padding to cross over into skb_shinfo.
Fix this by writing from the start of the llheader reserved range also
in the case of packet_snd/SOCK_RAW.

Update skb_set_network_header to the new offset. This also corrects
it for SOCK_DGRAM, where it incorrectly double counted reserve due to
the skb_push in dev_hard_header.

Fixes: 9ed988cd5915 ("packet: validate variable length ll headers")
Reported-by: syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2912,13 +2912,15 @@ static int packet_snd(struct socket *soc
 	if (skb == NULL)
 		goto out_unlock;
 
-	skb_set_network_header(skb, reserve);
+	skb_reset_network_header(skb);
 
 	err = -EINVAL;
 	if (sock->type == SOCK_DGRAM) {
 		offset = dev_hard_header(skb, dev, ntohs(proto), addr, NULL, len);
 		if (unlikely(offset < 0))
 			goto out_free;
+	} else if (reserve) {
+		skb_push(skb, reserve);
 	}
 
 	/* Returns -EFAULT on error */
