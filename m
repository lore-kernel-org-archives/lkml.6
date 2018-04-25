Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524652926-2-15686454166197388891
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
    1524652925; b=aHDNtAR3M4z7sk6T6ffXR6sjwFTydsPR1s+Ca2Xu+a2ovkv5vW
    zMOPI+rA0Eg47fMsLHPo6DJ99iRZLKC0ESGCMv2OE6zdpgaAfyZ9HC5Tk5C1jieZ
    WVtB+H82MDqprWFbKMHu+BYi3nvTYR98luTHGLzvXIWczM6yTxo4fNVBK6lKTnF6
    cNH25Qp05ACKImDZfQBdqalVfN4uKH7D4xCi8TFTP1nCuRHqC4PpbHOrPFXalwil
    /aWx7EnS8SoqSCcp9BWeXHo7ZPEMD8FkgqbJCbWnAvd7A9d4pVL3p7Sok7X9VMnt
    fVEe/eaIJVpnsu0Dp0vgkeSAwTUPzU6rjfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652925; bh=dIbihSTzvXHDbMUhz+N9QeJ7WMSzPd
    OuXNtHw5FF8fM=; b=X2OjaaMXaVqqakkFMuci4o+x8WVtKCGsAvGmgIhIfznXbN
    4rthLVKpl3AcWXf51YWBRbn2FuSIbAAOZZom520akX4rRP1QUDRrZ5DOHwj77Tzn
    2Uz6Pr0fy4XGZO0tE628SMuyXbA8csBMCmtD28AASOzI3yKPMkeSyXXm4UOGpYp3
    5xYLZ/7EwcVscWoO5hFEYy0jRaGVYqgphOZ9rG14X1kXHLOg/f/fTffuk08K2oU0
    kK7trP5/wrSeU43NRmo/uFeqdHx7alfSiawBHRAClHD4P6U9ETFjwVW/D5iFdfnV
    78OMrawqvrGLYhygq2cIqeNwHXRmPwlsyl2uQcsw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfN9ppuc5i3aiQuYDTBdetyTRnvWHLPZKUxySQMVwleXB2A6TZvkFPgKTwm2QRXoj3SNE0odIImbVIOPb1qP5OCtQLaBMR3a93va+h1wJwcFmFHc88ovO
    E5HlVd/e3AM/WSphg0suHAk3a0YRh8gSb66I7jEdfxQ0D7vMPEYW/ovhutOuOUi4gc6RBG/DWnnq/Q2ZZNPtFUOdwcTpPLgpPR8nqmZ4kBM9NpSbMcXkHowL
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=mzo1gerHAAAA:8 a=P8mRVJMrAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=66TFoo7zPJJTDV5F-WAA:9 a=iwh_h_oU4ntKbO9u:21
    a=zZ4-V_aC3Q132_wY:21 a=QEXdDO2ut3YA:10 a=GnAkmKsofkalbZQ5jfbZ:22
    a=Vc1QvrjMcIoGonisw6Ob:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeDYKmC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:42:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754047AbeDYKl6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:41:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ed Swierk <eswierk@skyportsystems.com>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 118/183] openvswitch: Remove padding from packet before L3+ conntrack processing
Date: Wed, 25 Apr 2018 12:35:38 +0200
Message-Id: <20180425103247.175945979@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: Ed Swierk <eswierk@skyportsystems.com>


[ Upstream commit 9382fe71c0058465e942a633869629929102843d ]

IPv4 and IPv6 packets may arrive with lower-layer padding that is not
included in the L3 length. For example, a short IPv4 packet may have
up to 6 bytes of padding following the IP payload when received on an
Ethernet device with a minimum packet length of 64 bytes.

Higher-layer processing functions in netfilter (e.g. nf_ip_checksum(),
and help() in nf_conntrack_ftp) assume skb->len reflects the length of
the L3 header and payload, rather than referring back to
ip_hdr->tot_len or ipv6_hdr->payload_len, and get confused by
lower-layer padding.

In the normal IPv4 receive path, ip_rcv() trims the packet to
ip_hdr->tot_len before invoking netfilter hooks. In the IPv6 receive
path, ip6_rcv() does the same using ipv6_hdr->payload_len. Similarly
in the br_netfilter receive path, br_validate_ipv4() and
br_validate_ipv6() trim the packet to the L3 length before invoking
netfilter hooks.

Currently in the OVS conntrack receive path, ovs_ct_execute() pulls
the skb to the L3 header but does not trim it to the L3 length before
calling nf_conntrack_in(NF_INET_PRE_ROUTING). When
nf_conntrack_proto_tcp encounters a packet with lower-layer padding,
nf_ip_checksum() fails causing a "nf_ct_tcp: bad TCP checksum" log
message. While extra zero bytes don't affect the checksum, the length
in the IP pseudoheader does. That length is based on skb->len, and
without trimming, it doesn't match the length the sender used when
computing the checksum.

In ovs_ct_execute(), trim the skb to the L3 length before higher-layer
processing.

Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
Acked-by: Pravin B Shelar <pshelar@ovn.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/conntrack.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1097,6 +1097,36 @@ static int ovs_ct_commit(struct net *net
 	return 0;
 }
 
+/* Trim the skb to the length specified by the IP/IPv6 header,
+ * removing any trailing lower-layer padding. This prepares the skb
+ * for higher-layer processing that assumes skb->len excludes padding
+ * (such as nf_ip_checksum). The caller needs to pull the skb to the
+ * network header, and ensure ip_hdr/ipv6_hdr points to valid data.
+ */
+static int ovs_skb_network_trim(struct sk_buff *skb)
+{
+	unsigned int len;
+	int err;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		len = ntohs(ip_hdr(skb)->tot_len);
+		break;
+	case htons(ETH_P_IPV6):
+		len = sizeof(struct ipv6hdr)
+			+ ntohs(ipv6_hdr(skb)->payload_len);
+		break;
+	default:
+		len = skb->len;
+	}
+
+	err = pskb_trim_rcsum(skb, len);
+	if (err)
+		kfree_skb(skb);
+
+	return err;
+}
+
 /* Returns 0 on success, -EINPROGRESS if 'skb' is stolen, or other nonzero
  * value if 'skb' is freed.
  */
@@ -1111,6 +1141,10 @@ int ovs_ct_execute(struct net *net, stru
 	nh_ofs = skb_network_offset(skb);
 	skb_pull_rcsum(skb, nh_ofs);
 
+	err = ovs_skb_network_trim(skb);
+	if (err)
+		return err;
+
 	if (key->ip.frag != OVS_FRAG_TYPE_NONE) {
 		err = handle_fragments(net, key, info->zone.id, skb);
 		if (err)
