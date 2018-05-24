Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906373-1527164468-2-7859453991993110310
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
    1527164467; b=jrcZcXkN8bIdquhEVcU8eYQXqgAV9dV0JMQ6Wk6kMEM/burwTR
    nZrN5X/gnd61xJjFifqHJqCh0dTv2+1iPqxzAI4JkWIIyxBV/L1IQqgISjkkAgWL
    f7U6bB8ox7/0Rz+l3B76Z1p68B5kcfm1aWoBMJiiLyweVdorvrc3F3+KGs8BJCsC
    c0SrCg9JWNtfo0sd0c4wLCTzA/FpZzFgtG0/itXKXeMDadMEMOUSUdIo79vELc2T
    AuTxzJXKbZdA2Ah63OGqw0PIuSASTaCdf5YfX7n2d5UWMMbrYguMQcKBHgmjWtZg
    Osal6c0l2wrcFjG7pLYRDbfYUo/2XmPLQqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164467; bh=8k7x3o21Hi+kMTSK07s64nfBuAzv14
    qWBGm0i60tCgk=; b=mV6+pbRf0YqDddPKQRKhETpxZBjL5737bZ2Ic1tglyOflO
    tVLk+ebGpakAlqeDbzXlbR6nogNhtXrQ3KsYB2Fs3B0VgtDX3ENI86iGn6xL+xYm
    E7zBSD6wYuNIgPygD95Up72VKEAWDdBu6LkEK4i7S82BZq8w/RU0kSCxFUhSyf5S
    y2LWL3pD86h45HJGvtfLe92rXPVttnivLhkDewtXwQ/HuaP1N2iqCefUnlwqn4Mw
    Foc8PdyLn5ArgFyD5Xm7qt53HMZLvae/mCw8ZUMQWBCoCj7f//ajibP+gZtg8ny/
    cyFeafRaTIHBYn64D9tVRANQKzk004v4jkyCEO/A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=I8E8nn3/ x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=I8E8nn3/ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfDiuR6Np450uGDV2K/08gUllcTyWn3mqR1ShPKZaSZcE4XBn6wVBTTx+n+eswBEzPBCC6OB7JDU31XwxviFmImsHko8UnjDFoXKuuj2IqrE445sBfqsn
    fstAGDxza4WnDWfw3pII+9QQOpU8VDSDx8Wz9ZgXm7TVNNV9rTLkBEgCmeU5GCnXO9DUhUaDs4kSZEDfmcCj5icJoLs5jEKgOPohflNq5ngBDSOQcWUy9THT
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=Udi51pQLigb7wLLcoy4A:9
    a=So_cmfe0yGOkP-Zr:21 a=DiLKg6yONuWM8hCT:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966177AbeEXJlW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:41:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966174AbeEXJlT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:41:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Taglang <rob@taglang.io>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 06/45] net: ethernet: sun: niu set correct packet size in skb
Date: Thu, 24 May 2018 11:38:14 +0200
Message-Id: <20180524093121.361545074@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
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

From: Rob Taglang <rob@taglang.io>

[ Upstream commit 14224923c3600bae2ac4dcae3bf0c3d4dc2812be ]

Currently, skb->len and skb->data_len are set to the page size, not
the packet size. This causes the frame check sequence to not be
located at the "end" of the packet resulting in ethernet frame check
errors. The driver does work currently, but stricter kernel facing
networking solutions like OpenVSwitch will drop these packets as
invalid.

These changes set the packet size correctly so that these errors no
longer occur. The length does not include the frame check sequence, so
that subtraction was removed.

Tested on Oracle/SUN Multithreaded 10-Gigabit Ethernet Network
Controller [108e:abcd] and validated in wireshark.

Signed-off-by: Rob Taglang <rob@taglang.io>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/sun/niu.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -3443,7 +3443,7 @@ static int niu_process_rx_pkt(struct nap
 
 		len = (val & RCR_ENTRY_L2_LEN) >>
 			RCR_ENTRY_L2_LEN_SHIFT;
-		len -= ETH_FCS_LEN;
+		append_size = len + ETH_HLEN + ETH_FCS_LEN;
 
 		addr = (val & RCR_ENTRY_PKT_BUF_ADDR) <<
 			RCR_ENTRY_PKT_BUF_ADDR_SHIFT;
@@ -3453,7 +3453,6 @@ static int niu_process_rx_pkt(struct nap
 					 RCR_ENTRY_PKTBUFSZ_SHIFT];
 
 		off = addr & ~PAGE_MASK;
-		append_size = rcr_size;
 		if (num_rcr == 1) {
 			int ptype;
 
@@ -3466,7 +3465,7 @@ static int niu_process_rx_pkt(struct nap
 			else
 				skb_checksum_none_assert(skb);
 		} else if (!(val & RCR_ENTRY_MULTI))
-			append_size = len - skb->len;
+			append_size = append_size - skb->len;
 
 		niu_rx_skb_append(skb, page, off, append_size, rcr_size);
 		if ((page->index + rp->rbr_block_size) - rcr_size == addr) {
