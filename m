Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161966-5-15178373271671991158
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161966; b=DCC6PKn26x0bA1WMLCthfDB4oO7NSnfanO5lpmrSYvLCj3M9s+
    vjspewi5JKVG8WxGZvfuZCMu/T/MRoMsQPDl3BiXoL2J0ytghwTp9QTKgtuSd/qV
    QQpoMcnRzEA+jSCu50N2rMY1cPIEVrhtMKIXexRc+f7gN6sQvH8Smr/fp3R4OhPl
    q8i2xf00YvvkOP11tgGcBqfdf/YVYA1oaYjT4sbgHjEuO1PI/UEHRUtj8j3lUCy7
    kEhFLdhWCPPLBsUZogcdC8YrqGmZZUGR7EEHNMTuKE31xcqQR97iEWm8qxhE1q+n
    gsgnRlf30qrHZ6wZJaEccJVK6o/mvFbCok+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161966; bh=9RGM30gUeihNB/BzIbcuz+VaLzziBZ
    RllangRzAHBvc=; b=HR0eQo4tCs8NuKu85FU//lMqS38pJVqnbn8E1yuw1I6VwZ
    THwfOdx7XL+h9rCqiqprMZ/4D6kgnmFc3SycjS2Vu6dbgLIGRfanP01aXRvQjqdF
    CQHtQCpLgn7JDw+srmywoBmXIJApLq53yf8AtD7NE0BFkbkBcORtbh3bJwrUj8kT
    9rmN7qf77Rfk20SjCMZgbK0z4Vthm0tokN96tCAIR5G7ttvKBs4Pi2a4QFuJazsY
    2fGTF2KLL89mqbJSX4jIcq2ISNmnryHG5XPP5pMIO+4Oa505VyW0lizaLXctXH0a
    WwKgp0n9CFuwrSpkxkDLIVorFj81m0nUWeGAhe6Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=gRK3/lZV x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=gRK3/lZV x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfE1IXas+e1lUVzU/+f97RDU8mhCOeSkKqZwg5JM4pJzwxgW9Y8WbDBH18/WHCuDMi1XoEZKCkfiIwqVS47iPd6LNOJlJNnD9boFREKy6TJGu8rfVT0fH
    XJ+38F7FxYIbplo/GKA77373CXPzBL+NKmeuKO0lDjrcX/TbWa14QJ9XZjgKITMZgFW82t3oKwj3DAdCN3+s5FuvfpZrRDae548WARXMxTTDCgzX/Olr7OLk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=sozttTNsAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=hk8TwJGeaQrKFd6_F3cA:9 a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967399AbeEXLjY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967319AbeEXJtI (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 26/96] usb: dwc3: omap: dont miss events during suspend/resume
Date: Thu, 24 May 2018 11:38:09 +0200
Message-Id: <20180524093607.076046076@linuxfoundation.org>
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

From: Roger Quadros <rogerq@ti.com>

[ Upstream commit c49f63055e252810e5d6c83a4943b18db16b3cd8 ]

The USB cable state can change during suspend/resume
so be sure to check and update the extcon state.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-omap.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -598,9 +598,25 @@ static int dwc3_omap_resume(struct devic
 	return 0;
 }
 
+static void dwc3_omap_complete(struct device *dev)
+{
+	struct dwc3_omap	*omap = dev_get_drvdata(dev);
+
+	if (extcon_get_state(omap->edev, EXTCON_USB))
+		dwc3_omap_set_mailbox(omap, OMAP_DWC3_VBUS_VALID);
+	else
+		dwc3_omap_set_mailbox(omap, OMAP_DWC3_VBUS_OFF);
+
+	if (extcon_get_state(omap->edev, EXTCON_USB_HOST))
+		dwc3_omap_set_mailbox(omap, OMAP_DWC3_ID_GROUND);
+	else
+		dwc3_omap_set_mailbox(omap, OMAP_DWC3_ID_FLOAT);
+}
+
 static const struct dev_pm_ops dwc3_omap_dev_pm_ops = {
 
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_omap_suspend, dwc3_omap_resume)
+	.complete = dwc3_omap_complete,
 };
 
 #define DEV_PM_OPS	(&dwc3_omap_dev_pm_ops)
