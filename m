Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-807177-1523400256-2-15430967151580635450
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
    1523400255; b=n1DlLXcR/Dj9p3R89Bq6+pDp0isBausZ11hdjztolVmFPa8GBl
    oQIcTElzrQz4QteUZi/wBAzevS+SUE7XrBia5uS1M8zQNOW04x5C0bgqBuVIFjaD
    qv6LmDow8XEo3mYghVtU5lZ9ikKLxomqtQi+mYVg2ADZXtm4/pY5rJJVx6d53c7l
    4fQwapoQy26+/t+0XEysoep3hcH3r2mttaXb2v5tNuvEyXEtrj2FHquiOLp9H7E1
    joS16CiDrRQYFSvN0HFv/JUhDAmCKmuZB6lStcyf3zaL90gP44G6vExberpXtfNN
    BxWlfF0e5QF9a4c+lXUDzKHjJ0oIhNwGcmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400255; bh=v29F7x/V4G8OVCWugBIA+yTQAH9BL/
    iebSfi61ky/d8=; b=dcIonWj0ESlwiwuHcGXxPqX/IxBiuCWQxdtTHyyD8u33mA
    Lc1szhYATujA9vijH0H0lnPVQ/Z6djhxLfDYT8A3uTzPGX1v7i3Xq1h5lPTwcejz
    orEz8EjzjHPOV+7wPmQt/aw2ZfJbKhbrtv2H3+Gdvpm9wkni9eP4TVSlcTzhHudC
    1tmUHMj2ynV3jW7WQqQnGGZIoETfrKlI7Ut1D+uivZhFNLHC54hZpQD/hGiC8Tbw
    UZQ0XdaVRlwNCOK303QvaB9EqScv8Z1Ley+h4uPoDiePdSP91ypIeolz26cwmXP6
    UeRq5yPzjR0tVXJUtXRB/9QTcD4liM9sS1zcZAsw==
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
X-CM-Envelope: MS4wfHA202jtFY4vZppnWfjXvScPnDuIkLDelUFvF23WsL6tnXKzsn81WIlIvZ/XQ0nO4y65YF8eQdzt7hGD7q79HsnxyoT87hWmdh4ePIafrOmF7HOI8aBZ
    RhkcgXa9VUo+r/KWmpy7OaZ39X6qBDSwCZmijxNMISHmMYKgzSZcHVJvG4vAVGsffaj4KH3SmCF8r4zFYIQeryxnLfpGSbGgKBM3HpZ5wtI/XO3hJQ3AxSpo
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=h-jsSio6AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=qkIx0ayPLVXy8fWxizoA:9 a=QEXdDO2ut3YA:10 a=cKCw3X4OOXbpJNOXdmIM:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932608AbeDJWj1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:39:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932601AbeDJWjZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:39:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Herbert <tom@quantonium.net>,
        David Lebrun <dlebrun@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 126/138] ipv6: sr: fix seg6 encap performances with TSO enabled
Date: Wed, 11 Apr 2018 00:25:16 +0200
Message-Id: <20180410212916.819488015@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
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

From: David Lebrun <dlebrun@google.com>


[ Upstream commit 5807b22c9164a21cd1077a9bc587f0bba361f72d ]

Enabling TSO can lead to abysmal performances when using seg6 in
encap mode, such as with the ixgbe driver. This patch adds a call to
iptunnel_handle_offloads() to remove the encapsulation bit if needed.

Before:
root@comp4-seg6bpf:~# iperf3 -c fc00::55
Connecting to host fc00::55, port 5201
[  4] local fc45::4 port 36592 connected to fc00::55 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-1.00   sec   196 KBytes  1.60 Mbits/sec   47   6.66 KBytes
[  4]   1.00-2.00   sec   304 KBytes  2.49 Mbits/sec  100   5.33 KBytes
[  4]   2.00-3.00   sec   284 KBytes  2.32 Mbits/sec   92   5.33 KBytes

After:
root@comp4-seg6bpf:~# iperf3 -c fc00::55
Connecting to host fc00::55, port 5201
[  4] local fc45::4 port 43062 connected to fc00::55 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-1.00   sec  1.03 GBytes  8.89 Gbits/sec    0    743 KBytes
[  4]   1.00-2.00   sec  1.03 GBytes  8.87 Gbits/sec    0    743 KBytes
[  4]   2.00-3.00   sec  1.03 GBytes  8.87 Gbits/sec    0    743 KBytes

Reported-by: Tom Herbert <tom@quantonium.net>
Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
Signed-off-by: David Lebrun <dlebrun@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/seg6_iptunnel.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -16,6 +16,7 @@
 #include <linux/net.h>
 #include <linux/module.h>
 #include <net/ip.h>
+#include <net/ip_tunnels.h>
 #include <net/lwtunnel.h>
 #include <net/netevent.h>
 #include <net/netns/generic.h>
@@ -211,11 +212,6 @@ static int seg6_do_srh(struct sk_buff *s
 
 	tinfo = seg6_encap_lwtunnel(dst->lwtstate);
 
-	if (likely(!skb->encapsulation)) {
-		skb_reset_inner_headers(skb);
-		skb->encapsulation = 1;
-	}
-
 	switch (tinfo->mode) {
 	case SEG6_IPTUN_MODE_INLINE:
 		if (skb->protocol != htons(ETH_P_IPV6))
@@ -224,10 +220,12 @@ static int seg6_do_srh(struct sk_buff *s
 		err = seg6_do_srh_inline(skb, tinfo->srh);
 		if (err)
 			return err;
-
-		skb_reset_inner_headers(skb);
 		break;
 	case SEG6_IPTUN_MODE_ENCAP:
+		err = iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6);
+		if (err)
+			return err;
+
 		if (skb->protocol == htons(ETH_P_IPV6))
 			proto = IPPROTO_IPV6;
 		else if (skb->protocol == htons(ETH_P_IP))
@@ -239,6 +237,8 @@ static int seg6_do_srh(struct sk_buff *s
 		if (err)
 			return err;
 
+		skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+		skb_set_inner_protocol(skb, skb->protocol);
 		skb->protocol = htons(ETH_P_IPV6);
 		break;
 	case SEG6_IPTUN_MODE_L2ENCAP:
@@ -262,8 +262,6 @@ static int seg6_do_srh(struct sk_buff *s
 	ipv6_hdr(skb)->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
 
-	skb_set_inner_protocol(skb, skb->protocol);
-
 	return 0;
 }
 
