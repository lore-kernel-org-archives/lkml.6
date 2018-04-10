Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-843308-1523402368-2-15347707263566359301
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
    1523402368; b=gQHp/aw/1EkwrrXj9bhKwJHsfERZGlur6ZRVn/TFPB/d6EpkOi
    h1RrmcjJPHtBcvbv2njAhJEkMzIAZFk3hVMPK69zFkK6mPhgek1G7ZHuQeQv36V7
    sf6oTtvMcLu2UEo0pIiWAP2n01o9jOyGGQiPXIglaBe6LSXbMxpnr5W37yPG4Eiz
    cz9MZICFVtxdkciQAviQoptJWtwb6EABxgZ/hcmtMQY/ZBwKbeS2HZ5Zwh6cYnQs
    5NXVHyv4NDPycA0H7/wT6C1AFANt0kaTvQ0Wrj8SVi4XzPUXM19HOcJT3JOVTHZu
    taEQyvu7GqkfDhorEeGhThwGVJq7ZTSiDAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523402368; bh=PpHtFS2Sx9JusOxSs1/jpWlDF5JxKJ
    0gh2sxr4EKUT4=; b=vIGi1BLEAr1H1tGbKf8E/EjfZw0iHel48Y3N0TEY22qwQN
    KcSg4j0x7SI/wJed2oH5jBpGbuXqQDvoCFaaXcGIOdyZ1OW4OJ46U9zKfcVOcjUb
    YHbW86cqhdJs7diJEVakGg9+62yA40n6814q4TWmUhpukHuQBIbzczp3MikmVMve
    uOkFH0/UlkD5bIiqI/eDH+bmZK3JXox+JRp0oDcOt3A87P1s4wF85x5iLWm0XjlE
    SiiGEZUEGZOfhl5Gf9mWILN30hdJFWqjRSqrtDL+9j0v8KkdoB3LIvJ5UU6zxARE
    2f506jSh1dp8/UIDY68i7fEG1+RbkwUi+JzVqcFA==
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
X-CM-Envelope: MS4wfDk3kfRSRsySukkGgLOssgzIEqSjfOuBk4XLot5DCWtO8GpSWzWcVPp1hosES/fxGAXD4gTDUtZ9vUW32hAHpCP0qkfXaeo7cIkN6kbH8pXyQa9zlnAH
    aigNwllsJvrOry/mzUmtY2J64iVkqVP0EOPbbH5vVYq8zNhObudxU/67daP5XouUNQBPArQtP5o4yDPaGiB6Km02Vvk4v7dh1huj0KeWvZ4CJclQfj/RlvDV
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=RfMhqW7RfyIWFs3lHvoA:9 a=nEq7sdQvkJOcl83t:21 a=Zk-p52Gu6lFtUBGp:21
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754738AbeDJWbJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:31:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40268 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752785AbeDJWbH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:31:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 100/168] ibmvnic: Dont handle RX interrupts when not up.
Date: Wed, 11 Apr 2018 00:24:02 +0200
Message-Id: <20180410212804.512329940@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Fontenot <nfont@linux.vnet.ibm.com>


[ Upstream commit 09fb35ead58cd557aa9b20576d15816bc91a4deb ]

Initiating a kdump via the command line can cause a pending interrupt
to be handled by the ibmvnic driver when initializing the sub-CRQ
irqs during driver initialization.

NIP [d000000000ca34f0] ibmvnic_interrupt_rx+0x40/0xd0 [ibmvnic]
LR [c000000008132ef0] __handle_irq_event_percpu+0xa0/0x2f0
Call Trace:
[c000000047fcfde0] [c000000008132ef0] __handle_irq_event_percpu+0xa0/0x2f0
[c000000047fcfea0] [c00000000813317c] handle_irq_event_percpu+0x3c/0x90
[c000000047fcfee0] [c00000000813323c] handle_irq_event+0x6c/0xd0
[c000000047fcff10] [c0000000081385e0] handle_fasteoi_irq+0xf0/0x250
[c000000047fcff40] [c0000000081320a0] generic_handle_irq+0x50/0x80
[c000000047fcff60] [c000000008014984] __do_irq+0x84/0x1d0
[c000000047fcff90] [c000000008027564] call_do_irq+0x14/0x24
[c00000003c92af00] [c000000008014b70] do_IRQ+0xa0/0x120
[c00000003c92af50] [c000000008002594] hardware_interrupt_common+0x114/0x180

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2484,6 +2484,12 @@ static irqreturn_t ibmvnic_interrupt_rx(
 	struct ibmvnic_sub_crq_queue *scrq = instance;
 	struct ibmvnic_adapter *adapter = scrq->adapter;
 
+	/* When booting a kdump kernel we can hit pending interrupts
+	 * prior to completing driver initialization.
+	 */
+	if (unlikely(adapter->state != VNIC_OPEN))
+		return IRQ_NONE;
+
 	adapter->rx_stats_buffers[scrq->scrq_num].interrupts++;
 
 	if (napi_schedule_prep(&adapter->napi[scrq->scrq_num])) {
