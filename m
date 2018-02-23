Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3775223-1519415898-2-16064698872150111002
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415897; b=BLomViZ+eqysBb5wtTAWnTMEjM0ab3YFpb1wziYEMS/4H2P
    l6ji7HEdHxBIQL2EKJ2crhzbCblJJ4m4/6foDuL/OizcN0OFbaxJG2mToBw6B2oq
    Z90DokcrlpBajBeAchf2gktLLjcoWa+RzXxXSTPWPMjO2gVPbx2b7vvsj3oZcJQ/
    I4qZf6e/IJ0zSEY+x5WmPUrKoaz82yHJ5aaReszxxiFKjOt2KrGaOfHb/ELacA39
    yEPDtNZjsYUM9apfa7qzGFEM8WxmWLnAlI6QsOj9GXyQDXqZiPP8cuAMevu+LmYc
    WzWlsC9LaLZ/XTp6Klovz78w1YGgfu5PjhhY4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415897; bh=JxE1S0kcaZITK3rYd17jtbhbiP
    pLWaV6UsldkSOYrfA=; b=A6Zf6c9kqRWjVzukuAW5QamskPFASVFjFiokal0Oyo
    ml6ktlUTAST15vMmdFjFR2iNVqj0LP5LTbyL1/+TfgGh5xFFuO8XYtobjGnJJFVz
    B28uspYQKErXiBfJlt/FqpZdroS24OIwEJER0Rcsc3E7fSPpKSwMLo/Hz4oQj48V
    gvUa8buIN+Htw84+sisHS3SC13wn21dOVXiWQ7s3fiShoTPeCwdD5P5m1zwI4VDR
    L5laMB9x+nj66Mv0K2v44HYqQC+RmmpN8yNARi9PNzxBZPKZWrQsqRT7BEYPkyuG
    bJgleycL/XXM3OSSlDx2mCsgc5ymkWf3THGVnG2mSwJw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932663AbeBWSoT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:44:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42514 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933538AbeBWSoS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:44:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 042/145] usb: build drivers/usb/common/ when USB_SUPPORT is set
Date: Fri, 23 Feb 2018 19:25:48 +0100
Message-Id: <20180223170730.327049708@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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

From: Randy Dunlap <rdunlap@infradead.org>


[ Upstream commit c9d24f78268be444e803fb2bb138a2f598de9c23 ]

PHY drivers can use ULPI interfaces when CONFIG_USB (which is host side
support) is not enabled, so also build drivers/usb/ when CONFIG_USB_SUPPORT
is enabled so that drivers/usb/common/ is built.

ERROR: "ulpi_unregister_driver" [drivers/phy/ti/phy-tusb1210.ko] undefined!
ERROR: "__ulpi_register_driver" [drivers/phy/ti/phy-tusb1210.ko] undefined!
ERROR: "ulpi_read" [drivers/phy/ti/phy-tusb1210.ko] undefined!
ERROR: "ulpi_write" [drivers/phy/ti/phy-tusb1210.ko] undefined!
ERROR: "ulpi_unregister_driver" [drivers/phy/qualcomm/phy-qcom-usb-hs.ko] undefined!
ERROR: "__ulpi_register_driver" [drivers/phy/qualcomm/phy-qcom-usb-hs.ko] undefined!
ERROR: "ulpi_write" [drivers/phy/qualcomm/phy-qcom-usb-hs.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_UWB)		+= uwb/
 obj-$(CONFIG_USB_PHY)		+= usb/
 obj-$(CONFIG_USB)		+= usb/
+obj-$(CONFIG_USB_SUPPORT)	+= usb/
 obj-$(CONFIG_PCI)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/
 obj-$(CONFIG_OF)		+= usb/
