Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1758260-1527157533-2-5371185082813084718
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
    1527157533; b=ULgUgssD80A+c7k5k7Uu9t1fHGIzV8gX3n6gAQp0e0wQSMQL29
    eREImwb2+Co2KnX7eSp1BpHx4Om8g4FOlP8PCBuW3/Kx8q5Ds91R1PJggoubJM9X
    DD5u5AEPeL2zml9KK/Skw4m4HHeun253rIUicaXlqcaM3PdzY2Lz1d4BU8WhYgHc
    11/XF1YwFE9mLADrJhr6PxVrvZotYNcc4DRTbjiGDQJm755ekENdheS4agBAv0c+
    kLtqXwsz5ZdYsLUtEt7LpNo31S46Yc4IT3KRNLjjmvlNhlf2Gx/fcec8NGeWQcMK
    dWFYtqVyKsGdetMuXoti1ZP8MFBZnCplRI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527157533; bh=7TeQD9d/pUGRNy3NwTG6SsdG/w6N1S
    FOTZlNfo5xqo8=; b=faI79aRA34WeFPju/yU1stdiYuC3HmnMY/xTGRBhYr6Kfu
    Pb5n1QxmVqZ7WIhTt42g/QG6sdaE055/bRsgAobSRiv+AzVZYNOh31RaSj1HHY8v
    eKal3fs+UC9t3c+doq4uf7H7/xHFqLA7GDGS+iv4J/d+/QoC3N8vzF+Xa2z/7Kqz
    ZgmHWZgqJk0FOQ5L2XmoDbZjCNUH+3r2zIHo7xI3olMO8TOJxQLa3hKS+UyLVayf
    Oi7SWbc65b3pxwMMVGiVKdJwHzqIE6ND3zpDBt6HZNNvwpWO1kntSlweo4gyKyMf
    nit9zndZvE3Y1r7jw4cV453Yiy6KmtQ+UVlRjdSA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=lQkETFa/ x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=lQkETFa/ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKmfd0cwnvquGaccZx1u0mDBjWyy5j4ju0mkgcaKiifWXHUp/kBuegFr+SS+kFK4aX+y84P2+YYclh2unWTIP0rUGHWZafpnpfX7RIXnCiH4OEBUx0ea
    9TjEPQFMjuKUtGlZoBZ/W/2ZJSgc8RvVPg3vKUb8L6slA1qWp7e+C4NVd2DO6N/UD3gDm5HFTBzv2jH/jBXT0GiIhNu3CXhxgJUbEEkOxuB5Ty0XqZbuDNZ4
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jIQo8A4GAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=X51Z8Hf4FAapsldMHMkA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031051AbeEXKZb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031049AbeEXKCF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:02:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Youn <johnyoun@synopsys.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Grigor Tovmasyan <tovmasya@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 073/161] usb: dwc2: hcd: Fix host channel halt flow
Date: Thu, 24 May 2018 11:38:18 +0200
Message-Id: <20180524093027.283433163@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minas Harutyunyan <hminas@synopsys.com>

[ Upstream commit a82c7abdf8fc3b09c4a0ed2eee6d43ecef2ccdb0 ]

According databook in Buffer and External DMA mode
non-split periodic channels can't be halted.

Acked-by: John Youn <johnyoun@synopsys.com>
Signed-off-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Grigor Tovmasyan <tovmasya@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/hcd.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -989,6 +989,24 @@ void dwc2_hc_halt(struct dwc2_hsotg *hso
 
 	if (dbg_hc(chan))
 		dev_vdbg(hsotg->dev, "%s()\n", __func__);
+
+	/*
+	 * In buffer DMA or external DMA mode channel can't be halted
+	 * for non-split periodic channels. At the end of the next
+	 * uframe/frame (in the worst case), the core generates a channel
+	 * halted and disables the channel automatically.
+	 */
+	if ((hsotg->params.g_dma && !hsotg->params.g_dma_desc) ||
+	    hsotg->hw_params.arch == GHWCFG2_EXT_DMA_ARCH) {
+		if (!chan->do_split &&
+		    (chan->ep_type == USB_ENDPOINT_XFER_ISOC ||
+		     chan->ep_type == USB_ENDPOINT_XFER_INT)) {
+			dev_err(hsotg->dev, "%s() Channel can't be halted\n",
+				__func__);
+			return;
+		}
+	}
+
 	if (halt_status == DWC2_HC_XFER_NO_HALT_STATUS)
 		dev_err(hsotg->dev, "!!! halt_status = %d !!!\n", halt_status);
 
