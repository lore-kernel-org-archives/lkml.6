Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330738-1519730555-2-10013229052191451110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519730555; b=rUOMQ8WXLlvIy9S2tgHPV6zKfVDiOwzpdkpgChf+cofF964
    AOqn7lMjxZ4t7B0Fcy6h1Ffacea0Uk1QrFXikBE3jhG1f3i/YVK4l1y/IDTEWLem
    0zSSHNPyb6LOnOIf6c8/emsZslc3uOQnrW0/Mtrl8KujuOMtjUmrUQKzWgUi0eSF
    +L5b42sDwRU3Mf/9OTIk1yAGsRWWngCoDNxGypW8EvYdgDtMrykGcApxmaXCaL1g
    V63gbVAVURB12BeSNuai/ckDx3Y4sx1Tb+EUVYMz9zPJjKS2rVZ13JCfEWrG/3pl
    cAH+XPZLLao2H2caH4XB6Akli2MSSGoMds+sxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519730555; bh=niga9aQ4TP0DEgf00tva/S+tVzhQSUsIOLU56l2yzgA=; b=T
    MHi+a56YC/BwzDbHkwMeptyjFyrTYAlqFWNT15L7Qp39uyvx2vN9mgNZflM1S9+l
    i9w/kN3Wl0sxgJ7UWLMaqZz1HG8RJVQhlUPM72O8Jz1klWW0RVF6+hSp9RXzonzA
    nKaMFPe4v7mYbVz+bsk+/3WvxhbejqzPRz9MkowGFQLFfqJk3k/VI8r5YYRE9kfb
    YjGbYiOaUXbg2OdG9TagurH62n7DMT3YNy3hrTzeWX8ySGs1Ysn34/W/16+aMbWf
    fAMUDefrXCVGEI0qr5US1iqEKZTrh9YaI3t/1Ka25DBICfWi9TuaNd/SjPGZADEV
    2ac6ynQr56s9mvL2vk/6w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=xNTjg7Kf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=xNTjg7Kf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeB0LWW (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 06:22:22 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:24032 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbeB0LWV (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 06:22:21 -0500
From: Roger Quadros <rogerq@ti.com>
To: <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
Date: Tue, 27 Feb 2018 13:22:06 +0200
Message-ID: <1519730526-22274-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the following test we get stuck by sleeping forever in _dwc3_set_mode()
after which dual-role switching doesn't work.

On dra7-evm's dual-role port,
- Load g_zero gadget driver and enumerate to host
- suspend to mem
- disconnect USB cable to host and connect otg cable with Pen drive in it.
- resume system
- we sleep indefinitely in _dwc3_set_mode due to.
  dwc3_gadget_exit()->usb_del_gadget_udc()->udc_stop()->
	dwc3_gadget_stop()->wait_event_lock_irq()

Let's clear the DWC3_EP_END_TRANSFER_PENDING flag on all endpoints
so we don't wait in dwc3_gadget_stop().

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/gadget.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2bda4eb..0a360da 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3273,6 +3273,20 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 
 void dwc3_gadget_exit(struct dwc3 *dwc)
 {
+	int epnum;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
+		struct dwc3_ep  *dep = dwc->eps[epnum];
+
+		if (!dep)
+			continue;
+
+		dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
+	}
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
 	usb_del_gadget_udc(&dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
 	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

