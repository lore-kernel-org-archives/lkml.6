Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804600-2-3555588498481619176
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804599; b=GVdGzrZHIa4dJy8jqcxlMdXsoer2EqhBhpW9ib54R4/fgAu
    0lKd8/95IcnY05Bm0sCsRDZNbRHZwGxPAx3GGAy0oNskWpVEbhE7V6+2CeQy2kCG
    rHNgs0l5+DY6rwl+gq9zoUaHrfC6tZZrIiUy+i/nQsCQQdKgzc/qP9gNIExm291c
    1ezBkAuTaXPboG0MSKuQBR5yL5C+X5CaUHExRxgj1bkYxq+LdIX76E16vNNwWj+H
    +5UtidJEKpkb9sG5KXV63eJVkYdiCoFVl663O/uC9Q0Q6hDIJlWbyLxtNnjYbIOV
    W4Eu+AT8OnsycXNyh5GtJziKu0ENHPSyoRNkkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804599; bh=gz+85UwX+/SdPs+SklBIUx0AWo
    gg6ovnEXLqmer2ufs=; b=TV6R7u9bbZz9YnoE7bK5TN68M0KAC/nR87O7lkM9G5
    8xrnDIexE0WhCfEey0ynAXD7M/u5oLM544PyIkFkr5A8B86GMgQLnF2eBmQdAegd
    xtku4jjVI1ehb9LSMhdJ+/xuaId0xJQHWeFtuabHm9HW9q+uQzPr7V2jSHhN+ylA
    QMq6rlUShZt/ftx5iFWALjvoxIlIgGv2sh82zrigJWr/epY7sOyW88B1TsCgGFJg
    +INh7bnD+S7fMrUIbkYtLfHTgdh2Wha7tef1DRc5E+b84f1Kr+RG2Yllik/9keNR
    EA3qk4IChU3hZZFHEYevJ2jx9e3HHIuW4DOwDeculxeA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932065AbeCWKG2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:06:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755207AbeCWKG0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bernd Faust <berndfaust@gmail.com>,
        Sasha Neftin <sasha.neftin@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 042/177] e1000e: fix timing for 82579 Gigabit Ethernet controller
Date: Fri, 23 Mar 2018 10:52:50 +0100
Message-Id: <20180323094207.068629627@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Bernd Faust <berndfaust@gmail.com>


[ Upstream commit 5313eeccd2d7f486be4e5c7560e3e2be239ec8f7 ]

After an upgrade to Linux kernel v4.x the hardware timestamps of the
82579 Gigabit Ethernet Controller are different than expected.
The values that are being read are almost four times as big as before
the kernel upgrade.

The difference is that after the upgrade the driver sets the clock
frequency to 25MHz, where before the upgrade it was set to 96MHz. Intel
confirmed that the correct frequency for this network adapter is 96MHz.

Signed-off-by: Bernd Faust <berndfaust@gmail.com>
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3528,6 +3528,12 @@ s32 e1000e_get_base_timinca(struct e1000
 
 	switch (hw->mac.type) {
 	case e1000_pch2lan:
+		/* Stable 96MHz frequency */
+		incperiod = INCPERIOD_96MHz;
+		incvalue = INCVALUE_96MHz;
+		shift = INCVALUE_SHIFT_96MHz;
+		adapter->cc.shift = shift + INCPERIOD_SHIFT_96MHz;
+		break;
 	case e1000_pch_lpt:
 		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
 			/* Stable 96MHz frequency */
