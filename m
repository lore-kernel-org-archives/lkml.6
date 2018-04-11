Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479576-2-11205705016107754552
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
    1523479575; b=SUxODExVThZdo2e5NjROr7TEbpIctD2oNAOVxTadTKBl3e20jp
    +NGwSljcJ09Dvjj/sR6+8yCEWfmzwGg25jy85TC6lAL5SS+bDBWm6yFGVihnrssK
    haRpdNHs3by/qnmxIbxVanLaOuy9e4MlGcUkyHBnt8Ct/bgBt4Kfo//2DW4J2ZOP
    6WpkfaeM781KL0Z6ziM5Q5RA2ZhuRwlZoTw/owlUn5VVD37AYG+67NgTag6H9hkJ
    NOjIcuf0HNv/mdFPsRm6+XDWUjIbRrqwfGbG6B0u3U9cTEcTAXSU+HaG3/j0FHzU
    VizwZlBccpaxw0DHbP21FOC4iRC75hG2qgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479575; bh=bG2TFzxTZauEM2JKiIpP+EbWXr7oqW
    83AckwswrtK00=; b=c198Wg2VhaagliU8Be6XELIxAXkXaCotKWaDZlZiB4uAK2
    l/dC+xmKRvkZ4uthXK/hbS8Fx5Si761K2qvf+B9GLDVpQIvw42lcn8LkKr8PlJjf
    JH0LoriVh4QVL2FJAmjouv+SDjE7wco+prB1hFmwspJ94FLAzknqsIatcvlzmnoj
    pkV5B9OQkZMWgCyWKJ3uOnfhyDSbjHEgeN/lkBd8txZF3rlkdTSksbMpCT0uAMh6
    whDt/41MffOui0ve6h4KL+U4fBgUR94SNj+FWbW2r1p6RCrQlOrE+A5hcROrRoed
    8fNee90xhC3Mlrh6xireQc68iKqRL3Gm6tv38Hbw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfIH6UI6atu+w4hMTSPJcwAewNKpP4dVXNMAvgnc9IVdJ6Qsho1FLzuXfSObXxlQcBf8DuDwvLuNCQW/jyei7E/PnuKFH4CFoGDiZUSirGaKoM2pRN3d/
    m/YceR4MUg7EvPmZ+HpdZ5uI4dcouWROsn/hvT4yizCxNyojB7ArOgUsaiQmYSZneXqlzgHcRab/kgDnpfPI42bQRmqFGrQPx/3Z3CD/hO5boKalX9B6TYFo
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Gxa0E6KgAAAA:8 a=1XWaLZrsAAAA:8 a=DfNHnWVPAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=8RoUSUakfocToMYG9PkA:9 a=QEXdDO2ut3YA:10
    a=-p7Ud3lxQmdsMy9G_OWz:22 a=rjTVMONInIDnV1a_A2c_:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756041AbeDKUp7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:45:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59074 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755778AbeDKSqu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:46:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nithin Nayak Sujir <nsujir@tintri.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 078/190] bonding: Dont update slave->link until ready to commit
Date: Wed, 11 Apr 2018 20:35:24 +0200
Message-Id: <20180411183555.096942612@linuxfoundation.org>
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

From: Nithin Sujir <nsujir@tintri.com>


[ Upstream commit 797a93647a48d6cb8a20641a86a71713a947f786 ]

In the loadbalance arp monitoring scheme, when a slave link change is
detected, the slave->link is immediately updated and slave_state_changed
is set. Later down the function, the rtnl_lock is acquired and the
changes are committed, updating the bond link state.

However, the acquisition of the rtnl_lock can fail. The next time the
monitor runs, since slave->link is already updated, it determines that
link is unchanged. This results in the bond link state permanently out
of sync with the slave link.

This patch modifies bond_loadbalance_arp_mon() to handle link changes
identical to bond_ab_arp_{inspect/commit}(). The new link state is
maintained in slave->new_link until we're ready to commit at which point
it's copied into slave->link.

NOTE: miimon_{inspect/commit}() has a more complex state machine
requiring the use of the bond_{propose,commit}_link_state() functions
which maintains the intermediate state in slave->link_new_state. The arp
monitors don't require that.

Testing: This bug is very easy to reproduce with the following steps.
1. In a loop, toggle a slave link of a bond slave interface.
2. In a separate loop, do ifconfig up/down of an unrelated interface to
create contention for rtnl_lock.
Within a few iterations, the bond link goes out of sync with the slave
link.

Signed-off-by: Nithin Nayak Sujir <nsujir@tintri.com>
Cc: Mahesh Bandewar <maheshb@google.com>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>
Acked-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2555,11 +2555,13 @@ static void bond_loadbalance_arp_mon(str
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		unsigned long trans_start = dev_trans_start(slave->dev);
 
+		slave->new_link = BOND_LINK_NOCHANGE;
+
 		if (slave->link != BOND_LINK_UP) {
 			if (bond_time_in_interval(bond, trans_start, 1) &&
 			    bond_time_in_interval(bond, slave->last_rx, 1)) {
 
-				slave->link  = BOND_LINK_UP;
+				slave->new_link = BOND_LINK_UP;
 				slave_state_changed = 1;
 
 				/* primary_slave has no meaning in round-robin
@@ -2586,7 +2588,7 @@ static void bond_loadbalance_arp_mon(str
 			if (!bond_time_in_interval(bond, trans_start, 2) ||
 			    !bond_time_in_interval(bond, slave->last_rx, 2)) {
 
-				slave->link  = BOND_LINK_DOWN;
+				slave->new_link = BOND_LINK_DOWN;
 				slave_state_changed = 1;
 
 				if (slave->link_failure_count < UINT_MAX)
@@ -2617,6 +2619,11 @@ static void bond_loadbalance_arp_mon(str
 		if (!rtnl_trylock())
 			goto re_arm;
 
+		bond_for_each_slave(bond, slave, iter) {
+			if (slave->new_link != BOND_LINK_NOCHANGE)
+				slave->link = slave->new_link;
+		}
+
 		if (slave_state_changed) {
 			bond_slave_state_change(bond);
 			if (BOND_MODE(bond) == BOND_MODE_XOR)
