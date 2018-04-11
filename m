Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523481263-2-17472490587274753364
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
    1523481262; b=RuLTmND9j1Wq8jjP4JhlXZSzrzWpTQ1MZFvZHVHaWNBJcPKRsq
    FE0Qy64uu8k7wwbQDuNoQncexyb6HUI/28yRldO6+CyGBjPqr4DnzJ1dZ5J1NV38
    q+cET+FlhHdgS9rslKhDbIji1USTNQpS3MdXRkrZ5h6NwhwE3DdN/+qysq9zV7R3
    67uh052FGp61PUu/etsoZporJDQAZsyypOQOUA+UxJhmXlft7lkhPyG2zwLtXpeq
    Bt8ioWlM0xaiFIr/lZyERkEL+gFL/K+Zh0pjldQU2fHQOKbvNirj+ATxzb7Sjn/2
    z2rCtkidClvXxF/4IyMXo/jnKQbVWul7h4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481262; bh=/wGsi19XzvdIgMejJ6J/1LR4LFaT+M
    JTRGaE2IpZVFU=; b=Q6i7f33VJG/juJS84sFp40MWh4hkGzWATRvygdZArgIeEQ
    teA5akBqNKK05/CpGyW7VVO45Xslay6v4kJIvYfZ67R13UkIVtd/F/vFaN6uuh35
    oJtnen1hBxbXxx3/BEaED1bAHsYAyHxRd1z3Kq9MVIuF9PPD7awnsbWdH9ZGnY9t
    oyF4hjth1Ungw/5wNL0ikCmoiGdt8YYJmNWMaLPbhPeeLFiwJzNpT21r/zIQOB//
    qlflXN32Mp7JBV9K4IvjDADldnN8zsc0f+cuFJ/biFxzurviKGkk5xlT0wTv94N5
    BWCl569BSQXBs4ITPj3BX6Qr9sRn7vv1utZwcN7A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFu+BeCOSH9B1cJNUxYgdOZE8cexbUFdb+4lDHpZNvhCWGT7V04KWOQ2WlT/zN09tCNP7e21lgLZL0yURhDK2tPaDjpQm4/8ZQNrudRqxwUUYKQF4bdN
    rx6U9rxNoqOu6dbJhf0esXDRF3u8o8TlT+dh4Tkb86uWuimPYzlnH4U+QtfAvIU0ZNn46TIL8qedU2CxF6+2Ui7US4uXRTiFEzJm+6h2qmSh/5Xt/jvSBr/y
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=C_IRinGWAAAA:8 a=xGAvDSoXAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=0EdAP3AoEZbcGndTsloA:9 a=Fb6FI0IV8mqSXXlh:21
    a=xMWXusudNDGyQNUe:21 a=QEXdDO2ut3YA:10 a=I9AbH5bZuplaqbmfSwNo:22
    a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754766AbeDKSlG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:41:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56670 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754698AbeDKSlE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:41:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, A Sun <as1033x@comcast.net>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 073/121] [media] mceusb: sporadic RX truncation corruption fix
Date: Wed, 11 Apr 2018 20:36:16 +0200
Message-Id: <20180411183500.589996207@linuxfoundation.org>
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

From: A Sun <as1033x@comcast.net>


[ Upstream commit 8e175b22e8640bf3a58e071af54190b909e4a944 ]

Intermittent RX truncation and loss of IR received data. This resulted
in receive stream synchronization errors where driver attempted to
incorrectly parse IR data (eg 0x90 below) as command response.

[ 3969.139898] mceusb 1-1.2:1.0: processed IR data
[ 3969.151315] mceusb 1-1.2:1.0: rx data: 00 90 (length=2)
[ 3969.151321] mceusb 1-1.2:1.0: Unknown command 0x00 0x90
[ 3969.151336] mceusb 1-1.2:1.0: rx data: 98 0a 8d 0a 8e 0a 8e 0a 8e 0a 8e 0a 9a 0a 8e 0a 0b 3a 8e 00 80 41 59 00 00 (length=25)
[ 3969.151341] mceusb 1-1.2:1.0: Raw IR data, 24 pulse/space samples
[ 3969.151348] mceusb 1-1.2:1.0: Storing space with duration 500000

Bug trigger appears to be normal, but heavy, IR receiver use.

Signed-off-by: A Sun <as1033x@comcast.net>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/rc/mceusb.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/media/rc/mceusb.c
+++ b/drivers/media/rc/mceusb.c
@@ -1370,8 +1370,13 @@ static int mceusb_dev_probe(struct usb_i
 		goto rc_dev_fail;
 
 	/* wire up inbound data handler */
-	usb_fill_int_urb(ir->urb_in, dev, pipe, ir->buf_in, maxp,
-				mceusb_dev_recv, ir, ep_in->bInterval);
+	if (usb_endpoint_xfer_int(ep_in))
+		usb_fill_int_urb(ir->urb_in, dev, pipe, ir->buf_in, maxp,
+				 mceusb_dev_recv, ir, ep_in->bInterval);
+	else
+		usb_fill_bulk_urb(ir->urb_in, dev, pipe, ir->buf_in, maxp,
+				  mceusb_dev_recv, ir);
+
 	ir->urb_in->transfer_dma = ir->dma_in;
 	ir->urb_in->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
