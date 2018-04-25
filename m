Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524652839-2-7849035321554551069
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
    1524652838; b=lL/x49qg+Zt41HzdXvl7EekQGs2mU3BGcynAko86nLVrYREhRo
    KHjG8JDJR2ODMhd5BEE/uhDS3BDodOmGxcLRe95fG/0Ra9CpW19+yfAIAJVBAqre
    mwQ0aKK7L4RfNfaBZZsrn09jafa/kTFRUX0O8B0bf4NznpfnR/ElbNdT02lgWjA/
    I8oFAX3/qyhxbpEqQHeOw5rJK1vlOHT7WUVBV0OLqjl6vidyt0EPP5jEHngP92ig
    kfoAhrzno1yD7NXDTehGWNPzPNnBAbCgXbGfFiT9bS+qOaKFcKm+OFl9K3LHrmLY
    emIb25xPTQ1Fbfb5InbkalnaDYk/aaER3ILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652838; bh=4U2ka1yawhmjZS9dQgYJKdlGzQnnd9
    fJzFVM0vcAUM4=; b=O6Y1suICEI9F0DK/MxgndG+dI6NFA5KboMR6rLPySXcSqn
    2E6HAKbIFaG3KG+jY9KvsG6BHke1jO1H4Py28rXMY1yzibwmy48fTphDp15gUNSi
    ZNigknKQ3mdyEt0C4E02LV1yRM0B2/7z8wovOcnYU8FlsIcwllAwcHSTsF+BlThv
    5XPzreKoRxd8pp5L7zTssLeUJXlDehOMd3Ho8mdxYhnwR0VSYH/DSO1jwd4Br4sA
    0c28Jn3Oa16JKPeDFEW1e9auSLsBV+qAp3ezeq9pnvLwXynVfOVvLBZr5B52rYqX
    zzkNGbfDdTrXVE5VuY8CJzo975qwb4ugW+j3DahQ==
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
X-CM-Envelope: MS4wfMBxqL05+6uIICaaK3+Eh+zvO/TBRpueA55cdQI4faBzG8KfMdzRH+3MSR+Geu771xMW+lJgrEJcBEX9nLVfOacajXYlzDvhmNJJ6dTDwcCdMLYAavNd
    gZABHy1MTCz6EkFdl6UcnApLRjFQbHVryJBbRF1rBu+MHwPBIGQNIrjCIdyOmuLH5EjWfJia/zKEHaH7XhKF3Xzu3jux76mIRGWUzrwuKIov7MJ7aNzGHlzt
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=gVGD3344AAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=Hb0Uqtfb04O3FyaSReIA:9 a=QEXdDO2ut3YA:10 a=xQEvYfgLW3QvObN0DhJi:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbeDYKkf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:40:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52134 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753433AbeDYKk3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:40:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Hua <daniel.hua@ni.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 085/183] igb: Clear TXSTMP when ptp_tx_work() is timeout
Date: Wed, 25 Apr 2018 12:35:05 +0200
Message-Id: <20180425103245.913696020@linuxfoundation.org>
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

From: Daniel Hua <daniel.hua@ni.com>


[ Upstream commit 3a53285228165225a7f76c7d5ff1ddc0213ce0e4 ]

Problem description:
After ethernet cable connect and disconnect for several iterations on a
device with i210, tx timestamp will stop being put into the socket.

Steps to reproduce:
1. Setup a device with i210 and wire it to a 802.1AS capable switch (
Extreme Networks Summit x440 is used in our case)
2. Have the gptp daemon running on the device and make sure it is synced
with the switch
3. Have the switch disable and enable the port, wait for the device gets
resynced with the switch
4. Iterates step 3 until the device is not albe to get resynced
5. Review the log in dmesg and you will see warning message "igb : clearing
Tx timestamp hang"

Root cause:
If ptp_tx_work() gets scheduled just before the port gets disabled, a LINK
DOWN event will be processed before ptp_tx_work(), which may cause timeout
in ptp_tx_work(). In the timeout logic, the TSYNCTXCTL's TXTT bit (Transmit
timestamp valid bit) is not cleared, causing no new timestamp loaded to
TXSTMP register. Consequently therefore, no new interrupt is triggerred by
TSICR.TXTS bit and no more Tx timestamp send to the socket.

Signed-off-by: Daniel Hua <daniel.hua@ni.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -643,6 +643,10 @@ static void igb_ptp_tx_work(struct work_
 		adapter->ptp_tx_skb = NULL;
 		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
 		adapter->tx_hwtstamp_timeouts++;
+		/* Clear the tx valid bit in TSYNCTXCTL register to enable
+		 * interrupt
+		 */
+		rd32(E1000_TXSTMPH);
 		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
 		return;
 	}
@@ -717,6 +721,7 @@ void igb_ptp_rx_hang(struct igb_adapter
  */
 void igb_ptp_tx_hang(struct igb_adapter *adapter)
 {
+	struct e1000_hw *hw = &adapter->hw;
 	bool timeout = time_is_before_jiffies(adapter->ptp_tx_start +
 					      IGB_PTP_TX_TIMEOUT);
 
@@ -736,6 +741,10 @@ void igb_ptp_tx_hang(struct igb_adapter
 		adapter->ptp_tx_skb = NULL;
 		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
 		adapter->tx_hwtstamp_timeouts++;
+		/* Clear the tx valid bit in TSYNCTXCTL register to enable
+		 * interrupt
+		 */
+		rd32(E1000_TXSTMPH);
 		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
 	}
 }
