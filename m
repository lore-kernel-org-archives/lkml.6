Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481271-2-14183423313033916522
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
    1523481270; b=rjKpKv/AEsDJDKd5TX1kAzIPVtrRwFhr9u7FkT0fRplO0U7pYU
    6UnpFXhml/hdCWcIcj+v/U51vAJW8MMuPCFLKs74PMkeOgOfkz+EoQv54+0+WQ4w
    jxZSJJ0CL1Fnkl9uamNeXDwmYOC536o6aO+LiJYhLGDsx5jilB496Pwg+i9FtFEG
    7MF7Q4oPbJm4ZdoXnUgj3cUokDjiiheEWukQBB0VBPdx1WGj6t2x65EIENEsQd30
    GLRtl5xnaJomRX1yoVA4J3jQQ6cZIxWZfQhU2NTqRA+4/uQbERNKvKP0BrEm5asj
    kbSI23uRN9kVDxu+w2W/6+YfRsM7CPXv6PGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481270; bh=3t96o9Nf0V6khg5bP3hqf9cX4crei2
    ktQ/2MoX+N3Ls=; b=J/3bPFXIpJWquz0pB9vTzCA/yoGGlZJB5kDL3nLjQbE6Ec
    1jgFauNa6Pdbz6vkvClZKDMwm52qVrsSMitK8FoRR8D3uzYW77BcyzLb1pTCjbV7
    jVPRoSEOFUwXpN2i9IE/jU7KVx4eJUe5MOF18hHvWBqfKydvPBIOA/r+OKolzIdd
    a2EGj8jTr50NihyvwlQDZiDpzaw4hoZ6gOqs2QvIowr2A6A7c2v1U8NzHGd/KGDO
    NN5jk/YJklnaHro2ob6GUTr2cHf6M7tGLSG4ee21DbI39WPKhmoxA72AL1XgCVCP
    plwb1sBr0uH8MLAWBlmM/HgUJMRbKBIk+PmNXe7A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfG7qQNgxWGpgcrGjYSh4PNyrKiIKgI9gb8RKqKGyuT8Zs/4s6ZnowIXuFw5csr3cgJ+u7JPzs6BNK3fT6IcBE80yteITto+On20wvu+FPszJjTXF6gcM
    gu/AhqUGpMUq7fWUGEyiV6axxiZu9c/ipKn8ZnBmx5eWPq9SV0Z52BKi10UJS5ROvCKwljsz6RJHm/KMhKwNDXn5Dd0Iw8GTIbhHG43zEfRukCz/Mj8um8HQ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=6pFBrwePJe4A:10
    a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8 a=dq2cNPrMAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=K2BkGcb1y0ee7xCoLg8A:9 a=QEXdDO2ut3YA:10
    a=UrzWRhJOTTn3oDX10iyi:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754750AbeDKSlB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:41:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754698AbeDKSk7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Mirabito <davidm@metamako.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 071/121] e1000e: fix race condition around skb_tstamp_tx()
Date: Wed, 11 Apr 2018 20:36:14 +0200
Message-Id: <20180411183500.468201655@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>


[ Upstream commit 5012863b7347866764c4a4e58b62fb05346b0d06 ]

The e1000e driver and related hardware has a limitation on Tx PTP
packets which requires we limit to timestamping a single packet at once.
We do this by verifying that we never request a new Tx timestamp while
we still have a tx_hwtstamp_skb pointer.

Unfortunately the driver suffers from a race condition around this. The
tx_hwtstamp_skb pointer is not set to NULL until after skb_tstamp_tx()
is called. This function notifies the stack and applications of a new
timestamp. Even a well behaved application that only sends a new request
when the first one is finished might be woken up and possibly send
a packet before we can free the timestamp in the driver again. The
result is that we needlessly ignore some Tx timestamp requests in this
corner case.

Fix this by assigning the tx_hwtstamp_skb pointer prior to calling
skb_tstamp_tx() and use a temporary pointer to hold the timestamped skb
until that function finishes. This ensures that the application is not
woken up until the driver is ready to begin timestamping a new packet.

This ensures that well behaved applications do not accidentally race
with condition to skip Tx timestamps. Obviously an application which
sends multiple Tx timestamp requests at once will still only timestamp
one packet at a time. Unfortunately there is nothing we can do about
this.

Reported-by: David Mirabito <davidm@metamako.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1181,6 +1181,7 @@ static void e1000e_tx_hwtstamp_work(stru
 	struct e1000_hw *hw = &adapter->hw;
 
 	if (er32(TSYNCTXCTL) & E1000_TSYNCTXCTL_VALID) {
+		struct sk_buff *skb = adapter->tx_hwtstamp_skb;
 		struct skb_shared_hwtstamps shhwtstamps;
 		u64 txstmp;
 
@@ -1189,9 +1190,14 @@ static void e1000e_tx_hwtstamp_work(stru
 
 		e1000e_systim_to_hwtstamp(adapter, &shhwtstamps, txstmp);
 
-		skb_tstamp_tx(adapter->tx_hwtstamp_skb, &shhwtstamps);
-		dev_kfree_skb_any(adapter->tx_hwtstamp_skb);
+		/* Clear the global tx_hwtstamp_skb pointer and force writes
+		 * prior to notifying the stack of a Tx timestamp.
+		 */
 		adapter->tx_hwtstamp_skb = NULL;
+		wmb(); /* force write prior to skb_tstamp_tx */
+
+		skb_tstamp_tx(skb, &shhwtstamps);
+		dev_kfree_skb_any(skb);
 	} else if (time_after(jiffies, adapter->tx_hwtstamp_start
 			      + adapter->tx_timeout_factor * HZ)) {
 		dev_kfree_skb_any(adapter->tx_hwtstamp_skb);
