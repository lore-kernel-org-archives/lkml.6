Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161856-2-6771917476176877135
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES encaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161854; b=RVp7BKhsI7a/v/yCYpzOKqok0Tffb2y/1uPc/Ur3Nwk4L943ci
    ukb6c5xpNMDcRHIF/A5qMQirjybEEMrZNLSQiRqLJ6PQEz63LpJCx3zvxOB0y5aJ
    xcJtYUTPXEyzpW7raGbBdnXPOtUpROSZWqYR/U9AZX0o0GtD0uhWn8P882zQ4qZS
    oZDmAZI8Swbjab3/3169Fb/MYNpqWpNUobcswyeXmtRhsjSHsDSmM8D2NNbfhVkg
    tRDP7eJjdCkR9Y5veiyuiNooP2CHLkX1ry7TP+NsPvYdG6tTriyt50lrzG8TUnYO
    uH12FZ87tgbs3MEdo6AIOkGh4gTh/5sXC7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161854; bh=zIJIth2nl9Hl9hg4BDYP8AceDbnPF1
    xABA6bvoLnse8=; b=WSqefw1xL3oUSgUljEisaCi/BMQ6HR5AWfUkpXNMj4J8kq
    f6Bs2UEOQxjDjCu8Vz28TkUnC914eoTZIvRnqJURQeEZNpAQGPOjhzLtOg3dtHbP
    h1bQl/yNd/AblxLBh4syLPpbvjCiY8hMAvoPftBGC8Tbt3nCZwMXn1JWsEYemHIV
    5cBo3kCCf/ZD2gJadrEtUM5Fs59h2y1p0bK4e+6q7jAw9sM/4OHv2+dtrVrGP5ie
    c4lfYglKF5nGBxy5EyKigrsoHP24AQyFIV/com+e7MhYc2kT7O8Fc+LbVHlETz++
    WZQGqXe7M09Xp3M8yRmKrmWAICzbrOx+U2t8hFNQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=jl/DPzhP x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=jl/DPzhP x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfI+5lowSxDLgqRlQbc8w+d7lTBpC51vjhPOQnmKNeae/GRGVq9H5Frd6k2QtKyA8n+fNSxMKgKwF5EjNC9u3VLLKbdNQOsvocg0GrhUZiF4judBMV/XO
    F96Vj2rB8HhuhsPzIXYoYihlC7TtBKx1D5fmnKqCkBE2ILysxbM4N21rf0uIYhkdF0ub/AhGydaBG/WxOSXqUZWQo6zCej8LZ9/OgcyP5m39deUSU+S5Jtj8
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jIQo8A4GAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=X51Z8Hf4FAapsldMHMkA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967449AbeEXLhT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967103AbeEXJte (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Youn <johnyoun@synopsys.com>,
        Vardan Mikayelyan <mvardan@synopsys.com>,
        Grigor Tovmasyan <tovmasya@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 29/96] usb: dwc2: Fix dwc2_hsotg_core_init_disconnected()
Date: Thu, 24 May 2018 11:38:12 +0200
Message-Id: <20180524093607.227286892@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
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

From: Vardan Mikayelyan <mvardan@synopsys.com>

[ Upstream commit 755d739534f998d92e348fba8ffb0478416576e7 ]

We should call dwc2_hsotg_enqueue_setup() after properly
setting lx_state. Because it may cause error-out from
dwc2_hsotg_enqueue_setup() due to wrong value in lx_state.

Issue can be reproduced by loading driver while connected
A-Connector (start in A-HOST mode) then disconnect A-Connector
to switch to B-DEVICE.

Acked-by: John Youn <johnyoun@synopsys.com>
Signed-off-by: Vardan Mikayelyan <mvardan@synopsys.com>
Signed-off-by: Grigor Tovmasyan <tovmasya@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/gadget.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -2642,12 +2642,6 @@ void dwc2_hsotg_core_init_disconnected(s
 	dwc2_writel(dwc2_hsotg_ep0_mps(hsotg->eps_out[0]->ep.maxpacket) |
 	       DXEPCTL_USBACTEP, hsotg->regs + DIEPCTL0);
 
-	dwc2_hsotg_enqueue_setup(hsotg);
-
-	dev_dbg(hsotg->dev, "EP0: DIEPCTL0=0x%08x, DOEPCTL0=0x%08x\n",
-		dwc2_readl(hsotg->regs + DIEPCTL0),
-		dwc2_readl(hsotg->regs + DOEPCTL0));
-
 	/* clear global NAKs */
 	val = DCTL_CGOUTNAK | DCTL_CGNPINNAK;
 	if (!is_usb_reset)
@@ -2658,6 +2652,12 @@ void dwc2_hsotg_core_init_disconnected(s
 	mdelay(3);
 
 	hsotg->lx_state = DWC2_L0;
+
+	dwc2_hsotg_enqueue_setup(hsotg);
+
+	dev_dbg(hsotg->dev, "EP0: DIEPCTL0=0x%08x, DOEPCTL0=0x%08x\n",
+		dwc2_readl(hsotg->regs + DIEPCTL0),
+		dwc2_readl(hsotg->regs + DOEPCTL0));
 }
 
 static void dwc2_hsotg_core_disconnect(struct dwc2_hsotg *hsotg)
