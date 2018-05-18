Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3571199-1526631809-2-1354137060223874847
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526631808; b=Lar5KYNjlgQjg4gnAgIkSq1fw1Xptk/pBucrSGZKKUpRFJzmbk
    4IN3OogYD0JPBZCb/cBMWQUbeUHJM4a7dLpqXe/3ZzenyH9gqIQE+5a5L+xBa+h0
    zpqXh4UU9IPL8NO32DJ7Cm55yHCsdT4DA8V6eXz0On0K0cp5dm7trVHIhwUPwHE1
    6BY9mQfVJxnlkKaeVKEnsrCoUvkf6W6KukJJPHM7qSAa8TiGlrkQ4E3bux+TvEL0
    ctQQSQ8o6ZbrULPD0O6rp42iSQrBD4iGNpxJD8Gone7WCLP5eoNUKPr8ETy7JJrF
    dWLAzS6m3PnKYr8T35qF75ipXjqhY170z+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526631808; bh=7A+MVNxzfAPypwBhsHsMiE/LgLnBng
    UJ3x+L8rBe5YE=; b=kcFGp6Cw7i+A9+AsoXYMIJTBCX5vYOcejBMscwiImozM9l
    U7tZyrIvkfMIaGAZD9boOgPzN0VN52ucVhJvRADUlpUXwSdHH58J+RdxX2kKcB4X
    dspFu+Uxui2nelGQ9A9icOURxrI3/k0k2TpsSetvX35DrnXkmDg0Hlv/SQDQxV0g
    Ypb1kqUFsVCAe7NfEsJ80u3z7M88yFwY5KIvIfXb5ZnHsvmfHcwame7lg7Cz22Q7
    otX14Ox+lxRFmV+dJTvCsqIfF2BCRInxSgRwiAoV3+lGEjletLf9wIFyJlyxkqKQ
    j6sV9Cc9XIvZpoh7homZAsJLdEDQbseQt7a9C2EA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=jKYpbDEx x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=jKYpbDEx x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMkQyU7zc9qPBhEVZbIBoEjZ64cKg1r7BfDyOx4GAISESb2GqxfkXeYiiY/LRuqFSvC4zriGxwYtYh5NrW/9myqYMly7WrSO9aCcjw3bkLlApEb4v/rt
    /+hu9rPsyIzAfSfLA/8y9wqDmG/uIZcfyHrRN60DyLWGAhT0jhNa/pWhAbSfzHNS5d+NLwcI6/CHNOVOd4b9exESryvGM7REF2JUkvFrOO04w9GIXidJKxf/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=X7Ea-ya5AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=G2dbtSLBsSqn76GcjF8A:9
    a=QEXdDO2ut3YA:10 a=f3QdawHiMRSDlnPgGXNW:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeERIXH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 04:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753839AbeERIWr (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 04:22:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Debabrata Banerjee <dbanerje@akamai.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 22/33] bonding: send learning packets for vlans on slave
Date: Fri, 18 May 2018 10:16:01 +0200
Message-Id: <20180518081535.982853490@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
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

From: Debabrata Banerjee <dbanerje@akamai.com>

[ Upstream commit 21706ee8a47d3ede7fdae0be6d7c0a0e31a83229 ]

There was a regression at some point from the intended functionality of
commit f60c3704e87d ("bonding: Fix alb mode to only use first level
vlans.")

Given the return value vlan_get_encap_level() we need to store the nest
level of the bond device, and then compare the vlan's encap level to
this. Without this, this check always fails and learning packets are
never sent.

In addition, this same commit caused a regression in the behavior of
balance_alb, which requires learning packets be sent for all interfaces
using the slave's mac in order to load balance properly. For vlan's
that have not set a user mac, we can send after checking one bit.
Otherwise we need send the set mac, albeit defeating rx load balancing
for that vlan.

Signed-off-by: Debabrata Banerjee <dbanerje@akamai.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_alb.c  |   13 ++++++++-----
 drivers/net/bonding/bond_main.c |    2 ++
 include/net/bonding.h           |    1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -944,6 +944,10 @@ static void alb_send_lp_vid(struct slave
 	skb->priority = TC_PRIO_CONTROL;
 	skb->dev = slave->dev;
 
+	netdev_dbg(slave->bond->dev,
+		   "Send learning packet: dev %s mac %pM vlan %d\n",
+		   slave->dev->name, mac_addr, vid);
+
 	if (vid)
 		__vlan_hwaccel_put_tag(skb, vlan_proto, vid);
 
@@ -966,14 +970,13 @@ static void alb_send_learning_packets(st
 	 */
 	rcu_read_lock();
 	netdev_for_each_all_upper_dev_rcu(bond->dev, upper, iter) {
-		if (is_vlan_dev(upper) && vlan_get_encap_level(upper) == 0) {
-			if (strict_match &&
-			    ether_addr_equal_64bits(mac_addr,
-						    upper->dev_addr)) {
+		if (is_vlan_dev(upper) &&
+		    bond->nest_level == vlan_get_encap_level(upper) - 1) {
+			if (upper->addr_assign_type == NET_ADDR_STOLEN) {
 				alb_send_lp_vid(slave, mac_addr,
 						vlan_dev_vlan_proto(upper),
 						vlan_dev_vlan_id(upper));
-			} else if (!strict_match) {
+			} else {
 				alb_send_lp_vid(slave, upper->dev_addr,
 						vlan_dev_vlan_proto(upper),
 						vlan_dev_vlan_id(upper));
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1732,6 +1732,8 @@ int bond_enslave(struct net_device *bond
 	if (bond_mode_uses_xmit_hash(bond))
 		bond_update_slave_arr(bond, NULL);
 
+	bond->nest_level = dev_get_nest_level(bond_dev);
+
 	netdev_info(bond_dev, "Enslaving %s as %s interface with %s link\n",
 		    slave_dev->name,
 		    bond_is_active_slave(new_slave) ? "an active" : "a backup",
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -197,6 +197,7 @@ struct bonding {
 	struct   slave __rcu *primary_slave;
 	struct   bond_up_slave __rcu *slave_arr; /* Array of usable slaves */
 	bool     force_primary;
+	u32      nest_level;
 	s32      slave_cnt; /* never change this value outside the attach/detach wrappers */
 	int     (*recv_probe)(const struct sk_buff *, struct bonding *,
 			      struct slave *);
