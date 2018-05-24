Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161029-2-11438321663501628406
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
    1527161028; b=ECnq721iSO3Ivv6bM7cETyWKyPBaFydG6bczxQ6yVe07vm38w1
    PUQlUoe08aEWZ2PhJcRFmxHPF+LciA1iGyI1QdlIu1jB7LEgt2QkNVyrmMNkyzB4
    FGGCU4FcRfRN526JTKRsHQRZ1iTxENL6lepZ/Hn1uiSdTYe6+ieNhHCaNRqwNs/h
    uWM8hLtewFUnNSqneKjWZJSx58TFV/LZTWpbhnf0zyaL0jOFTh30j42sB3wW7+ee
    R1f4qUc2ioSj/q3M8YeyqPBMUdqIQD4cxQvAW8h6adO9F7ejSwxX+Fx0jc6CXZa5
    cWm+ne0N83aNxWCA0uWYZBtGPQ8tpOdDTEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161028; bh=cXmjA84Xqhe4IEjfZFByvU/EepibEA
    oeF1MVkxAJ7A0=; b=J04qcQHuScSSFL0AcyIwpFPY8z8q61d1YQAlVAlaBHf+sL
    NqQa9TQzPhunjOQUN9IBEF5hmkj0QabeEyvUeK8Vw3nW84obysgZZKIosbun5Eiq
    OzqjaWxvEnvRWbAMqpFNRxVDRNorxK8CivbK39/BX/3Wa4VYmuiyqYir765zUgBP
    g6RD4PeZPz+KKIQ0mbeXY4At71Qqul+lxRgcWXPWNDu3McHvyY5UoImxAbPQV2nW
    Xnaix0DFvmLvzQlbm8o9lWVirtNogIv3UnYRDuvfn41OUzjKjPum38LTLDWevAlI
    pwhn2pnH9Tz+HxPEoTQ9nF9AH4KEmG7M9g9SyTxw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=mJvqUwCP x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=mJvqUwCP x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfIpkFf3Cfuo2xwqdh6liG8hKogi3LRzW2H0Rr60o6Ibih+OaIGPHo8CyjtVJK9fTKEFHnXaSlqp/8Ff5GFuScS/2poG5FIZekwQwv6/PoXCts/m333N1
    /QgHtgJPeG8O1ScVnAo32zIFOeU+jI87YpJI301sa26BqYxmX1o2nTCf8BBAs5XtvDfTpDlilp6OzxVh585m7nBTR0qlW/758daX0xWD5XPHVsfHa6f5OWDR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jZVsG21pAAAA:8 a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=AxzKcX321s9ekVS4_5EA:9 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967862AbeEXLXq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967807AbeEXJwG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 021/165] hv_netvsc: avoid retry on send during shutdown
Date: Thu, 24 May 2018 11:37:07 +0200
Message-Id: <20180524093622.835733732@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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

From: Stephen Hemminger <stephen@networkplumber.org>

[ Commit 12f69661a49446840d742d8feb593ace022d9f66 upstream. ]

Change the initialization order so that the device is ready to transmit
(ie connect vsp is completed) before setting the internal reference
to the device with RCU.

This avoids any races on initialization and prevents retry issues
on shutdown.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c |   24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -850,13 +850,6 @@ int netvsc_send(struct net_device *ndev,
 	if (unlikely(!net_device || net_device->destroy))
 		return -ENODEV;
 
-	/* We may race with netvsc_connect_vsp()/netvsc_init_buf() and get
-	 * here before the negotiation with the host is finished and
-	 * send_section_map may not be allocated yet.
-	 */
-	if (unlikely(!net_device->send_section_map))
-		return -EAGAIN;
-
 	nvchan = &net_device->chan_table[packet->q_idx];
 	packet->send_buf_index = NETVSC_INVALID_INDEX;
 	packet->cp_partial = false;
@@ -864,10 +857,8 @@ int netvsc_send(struct net_device *ndev,
 	/* Send control message directly without accessing msd (Multi-Send
 	 * Data) field which may be changed during data packet processing.
 	 */
-	if (!skb) {
-		cur_send = packet;
-		goto send_now;
-	}
+	if (!skb)
+		return netvsc_send_pkt(device, packet, net_device, pb, skb);
 
 	/* batch packets in send buffer if possible */
 	msdp = &nvchan->msd;
@@ -951,7 +942,6 @@ int netvsc_send(struct net_device *ndev,
 		}
 	}
 
-send_now:
 	if (cur_send)
 		ret = netvsc_send_pkt(device, cur_send, net_device, pb, skb);
 
@@ -1308,11 +1298,6 @@ struct netvsc_device *netvsc_device_add(
 
 	napi_enable(&net_device->chan_table[0].napi);
 
-	/* Writing nvdev pointer unlocks netvsc_send(), make sure chn_table is
-	 * populated.
-	 */
-	rcu_assign_pointer(net_device_ctx->nvdev, net_device);
-
 	/* Connect with the NetVsp */
 	ret = netvsc_connect_vsp(device, net_device, device_info);
 	if (ret != 0) {
@@ -1321,6 +1306,11 @@ struct netvsc_device *netvsc_device_add(
 		goto close;
 	}
 
+	/* Writing nvdev pointer unlocks netvsc_send(), make sure chn_table is
+	 * populated.
+	 */
+	rcu_assign_pointer(net_device_ctx->nvdev, net_device);
+
 	return net_device;
 
 close:
