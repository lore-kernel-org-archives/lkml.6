Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523480010-2-10261161459139877576
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
    1523480009; b=EkA+2kjNOGG8dxbm2jsmLaX8YxWhwDTXH6ID0EKjLEulDlcq18
    b8O7WNl/LOaotcgZW7d/bDF+ope6fz1InJgTgYvw0gt9JnzrK2YSu2AOHkMmWX3E
    RcLiroQ9pHTsMdxWGvR9+zqwZUKIFzwh96XgV5BhAr6lv+A6i3jJsCwR0wwe/w+s
    Aog4W7iH29ryMy3MPwvQ8rigvcrm0/DEwHKWJhHxEZmtR687DdeE9ixVZxrPTneW
    Usa/nbhPXizsH1iwSW0xEB9msW1O7k2FV5Ls54skmM85E9q6njbaVpA8TVpDgmKD
    P84gy2c5AbxZLs3Ren+CPRYz/RE9vFKk10aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480009; bh=McfO7NQFAh+tUlp9BDdPLAwvDyGtvh
    7ECyU80YpI+3Y=; b=ghNBteieUYj0MPc/Z/arlrODMDbsxRLsnaQeqFo0ZhFb1o
    UngxIzS2R+Bz+9bq/mpdp9Onk27baFo/CdZ8VBPUCmNKwvRocgHQaM9qEownYfIs
    Wgvu3BsL1ck5xvugb+m0jOtGJToVvoHnppOxr2nRRZ0/Y8F5qLO4WuH8DngGfAeB
    midW46Kme0brVmSZ1x+hp/v+EO2jQ6dx1zKSkFwmBvaooqN4rOlGZenHu0vQVS/O
    hbbI5SSdL0VRxMhsOf/iFh4t9YkcEqYNzjRt1Q8VjTIaO47+lYBL1ndpjP8laPyr
    6S4vSE6qzF1/8rVaCMJPzBMr3Hfh3V+VyAp1WK4w==
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
X-CM-Envelope: MS4wfDYaxFmaM2+uB2innzdIc+V1jcoD5D7JlodzrjTP2ssSUih8uuEoX04X4N/OHK9ZyVxs2dfMuJUn2jhWrBNxHoixd2zZXONYCzhK/0GDLoHEVlyQfitH
    Seo0RwZk4pCmEteORyZp+5n66F97kWMP6SGo1EWiGo+zWhvK0l5oxGK4fM3b+5hiu2qS9iNavRzyVUnP78s4+61HWnEx6gtWCWMmZYPOmZIpm/RQvuuus6rp
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=lVxO5aKw9bYQSbul2mYA:9 a=lPWsgBELtqcGqVPg:21 a=uQEfqhBxCgxr_Wf7:21
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755485AbeDKSpR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:45:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755480AbeDKSpP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ihar Hrachyshka <ihrachys@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 042/190] arp: honour gratuitous ARP _replies_
Date: Wed, 11 Apr 2018 20:34:48 +0200
Message-Id: <20180411183552.596346496@linuxfoundation.org>
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

From: Ihar Hrachyshka <ihrachys@redhat.com>


[ Upstream commit 23d268eb240954e6e78f7cfab04f2b1e79f84489 ]

When arp_accept is 1, gratuitous ARPs are supposed to override matching
entries irrespective of whether they arrive during locktime. This was
implemented in commit 56022a8fdd87 ("ipv4: arp: update neighbour address
when a gratuitous arp is received and arp_accept is set")

There is a glitch in the patch though. RFC 2002, section 4.6, "ARP,
Proxy ARP, and Gratuitous ARP", defines gratuitous ARPs so that they can
be either of Request or Reply type. Those Reply gratuitous ARPs can be
triggered with standard tooling, for example, arping -A option does just
that.

This patch fixes the glitch, making both Request and Reply flavours of
gratuitous ARPs to behave identically.

As per RFC, if gratuitous ARPs are of Reply type, their Target Hardware
Address field should also be set to the link-layer address to which this
cache entry should be updated. The field is present in ARP over Ethernet
but not in IEEE 1394. In this patch, I don't consider any broadcasted
ARP replies as gratuitous if the field is not present, to conform the
standard. It's not clear whether there is such a thing for IEEE 1394 as
a gratuitous ARP reply; until it's cleared up, we will ignore such
broadcasts. Note that they will still update existing ARP cache entries,
assuming they arrive out of locktime time interval.

Signed-off-by: Ihar Hrachyshka <ihrachys@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/arp.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -658,6 +658,7 @@ static int arp_process(struct net *net,
 	unsigned char *arp_ptr;
 	struct rtable *rt;
 	unsigned char *sha;
+	unsigned char *tha = NULL;
 	__be32 sip, tip;
 	u16 dev_type = dev->type;
 	int addr_type;
@@ -729,6 +730,7 @@ static int arp_process(struct net *net,
 		break;
 #endif
 	default:
+		tha = arp_ptr;
 		arp_ptr += dev->addr_len;
 	}
 	memcpy(&tip, arp_ptr, 4);
@@ -839,8 +841,18 @@ static int arp_process(struct net *net,
 		   It is possible, that this option should be enabled for some
 		   devices (strip is candidate)
 		 */
-		is_garp = arp->ar_op == htons(ARPOP_REQUEST) && tip == sip &&
-			  addr_type == RTN_UNICAST;
+		is_garp = tip == sip && addr_type == RTN_UNICAST;
+
+		/* Unsolicited ARP _replies_ also require target hwaddr to be
+		 * the same as source.
+		 */
+		if (is_garp && arp->ar_op == htons(ARPOP_REPLY))
+			is_garp =
+				/* IPv4 over IEEE 1394 doesn't provide target
+				 * hardware address field in its ARP payload.
+				 */
+				tha &&
+				!memcmp(tha, sha, dev->addr_len);
 
 		if (!n &&
 		    ((arp->ar_op == htons(ARPOP_REPLY)  &&
