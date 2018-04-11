Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523473335-2-16120578073028612218
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
    1523473334; b=fyiLreM78LRJVMAZKfqF1t1U0ugt8fBs3S45koaKzGwX6o//ol
    Fh06G4mBQRifmmeeDAZucip7lDGBK71e6SeD7+4C66KJVoH1lZKBy6wEGFH5tYGz
    d7roqHCh3EJ+HJy7PycPctZoOW24PyfF05hmRxpbn+wh0PO9ddu+eZZ1iBU9amkG
    pVN3RNDg2gdc4cBqVRfC9SHETj/kSUCWeejV408lSswMeqcz+QwZ0ETnOj0+CY7F
    VOuM1Ts2K9hv+dKOjSITSj8xxBwn7Syz0DKn8au4Pei57Co8Jj48CMame+mkEWXN
    oFKPyVaBdg/EWJRmXY4KQCBiXzCChn6DEhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473334; bh=um+L26S3aRPI1ERO5jBju3AKlBaLBK
    UYe9XHhqRXFOk=; b=SpZX/xt6BmFvL2KFIkLgBai/P4FDXm/RaSuT5unLUeXEL1
    T7PNOY4gl5ig+kSi7LMJF/cUOnXvF0jmO5PRRyrBnssAicLxBuvrk9Ilyt0JYo0z
    Tt2PuzAwd1TBLILZFlFIeCw3w2kZxZKvNBIF93OMELx75Cpm3XIw2uUmXIcBxCyw
    z/7eCNcj8ralMtPETfifAIEUGcX5wALQb+/IDWb7vDMAkzDyctj4xHQNRSDaEEKW
    oCRjZZ8EEQywZZ9QN6vCNauorQ9yTGhepxMMdJUcz7BcKhBp1r8vQiv6HECGw7hS
    OwSSNGHw27i85nrOXCsvgJYvgjuIxfY3EVv0Rk2w==
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
X-CM-Envelope: MS4wfNCkYk9cjOzrqPVeoA8jEw/Czk/+g9zIlBrf1GX0XQwYeFIfmNcSuf5t4GLIeYP05NUeVg/SuK73nKERXwyjL/MZ307nKh9Ha5HqeBn6G9vATrx4KpS1
    jistDJ0GoE569nSryIAol2Zxa4hfSAKAM4HaGZrxXyfNdCj7XnxutWXeRkjGRwDyaa8J6THFpM5Dx7kTkyRAT93YY+uiFhbME0AyrRYb+k24k78ky3OLciT6
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=dq2cNPrMAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=CzBr3tW7OWP3a5FgOU0A:9 a=QEXdDO2ut3YA:10 a=UrzWRhJOTTn3oDX10iyi:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934378AbeDKTCJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:02:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934356AbeDKTCH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:02:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Mirabito <davidm@metamako.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 206/310] igb: fix race condition with PTP_TX_IN_PROGRESS bits
Date: Wed, 11 Apr 2018 20:35:45 +0200
Message-Id: <20180411183631.431217258@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Jacob Keller <jacob.e.keller@intel.com>


[ Upstream commit 4ccdc013b0ae04755a8f7905e0525955d52a77d0 ]

Hardware related to the igb driver has a limitation of only handling one
Tx timestamp at a time. Thus, the driver uses a state bit lock to
enforce that only one timestamp request is honored at a time.

Unfortunately this suffers from a simple race condition. The bit lock is
not cleared until after skb_tstamp_tx() is called notifying the stack of
a new Tx timestamp. Even a well behaved application which sends only one
timestamp request at once and waits for a response might wake up and
send a new packet before the bit lock is cleared. This results in
needlessly dropping some Tx timestamp requests.

We can fix this by unlocking the state bit as soon as we read the
Timestamp register, as this is the first point at which it is safe to
unlock.

To avoid issues with the skb pointer, we'll use a copy of the pointer
and set the global variable in the driver structure to NULL first. This
ensures that the next timestamp request does not modify our local copy
of the skb pointer.

This ensures that well behaved applications do not accidentally race
with the unlock bit. Obviously an application which sends multiple Tx
timestamp requests at once will still only timestamp one packet at
a time. Unfortunately there is nothing we can do about this.

Reported-by: David Mirabito <davidm@metamako.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -721,6 +721,7 @@ void igb_ptp_rx_hang(struct igb_adapter
  **/
 static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
 {
+	struct sk_buff *skb = adapter->ptp_tx_skb;
 	struct e1000_hw *hw = &adapter->hw;
 	struct skb_shared_hwtstamps shhwtstamps;
 	u64 regval;
@@ -748,10 +749,17 @@ static void igb_ptp_tx_hwtstamp(struct i
 	shhwtstamps.hwtstamp =
 		ktime_add_ns(shhwtstamps.hwtstamp, adjust);
 
-	skb_tstamp_tx(adapter->ptp_tx_skb, &shhwtstamps);
-	dev_kfree_skb_any(adapter->ptp_tx_skb);
+	/* Clear the lock early before calling skb_tstamp_tx so that
+	 * applications are not woken up before the lock bit is clear. We use
+	 * a copy of the skb pointer to ensure other threads can't change it
+	 * while we're notifying the stack.
+	 */
 	adapter->ptp_tx_skb = NULL;
 	clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
+
+	/* Notify the stack and free the skb after we've unlocked */
+	skb_tstamp_tx(skb, &shhwtstamps);
+	dev_kfree_skb_any(skb);
 }
 
 /**
