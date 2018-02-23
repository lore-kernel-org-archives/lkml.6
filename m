Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841677-1519419013-2-3682959538415390435
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
    t=1519419013; b=guPfWPt/OZlchyLKnr5TliSYV5bYFLO/SR9Cu57/5yrzN3t
    qRmnP2PVCeIT95sPfDxK8AlPPJmDmh3S02muGvKbVFFtCSzj5y0CtFmBXTQXOgr7
    KQiyoICf2LbOW9rtbYJpRIYOEabPK5JC+XYS5Y89CZjKGaGa0w855cIjAHaOFxL8
    k7mIGuEgUoPtSH1nt9tGHBFWJrAnHqIDzwkhDqmvkAbh4GzGol2h5afxRUndHt9K
    LFuwvrTu7RrnOOHzR/mNK52jzM1/XccZxDlXdt86jb8EmrYRJRpK+aVbHuJp26pc
    EQSNrhHptqpKmOISnK8ktJ5tas/LQnQOpMXIosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519419013; bh=gvQk2PCmxRCbQUNzlkMBTOY9f9
    QaMQtgQn8n71H/AnQ=; b=lRc9El+xM61s9NJUZKVlhungfKozrIBCHPNEmHl8Fq
    NtvjgkmULHliP+6Tn5z3+O1+3e9C7W1+Q5m5qKUvo6cpRLlNsuXQ5Mi6pRliplk1
    6aSgEMPAGOVl20ThamZ56S1T1TaCBFkeHv/vJi/vc2fb6JH/gor6lYfN/j1fhVGj
    q1ycRnABcMrun8UWrzHGziJFHXAz090Nx7XQx3+qRFtN5n5rPG3KgTDEbaVcgkIx
    D5dc87UmqheMyCrWotbULsiSk7D3PtwXRgwC5UP83aMD5hrVWbOHzkICZalHva+t
    /HvHb6vE7RgoimkT3bFp17HATur2p+l6UHeOfuieRw7Q==
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
        id S1752650AbeBWUtz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:49:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35196 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752519AbeBWSbU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:31:20 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 35/58] usb: build drivers/usb/common/ when USB_SUPPORT is set
Date: Fri, 23 Feb 2018 19:26:34 +0100
Message-Id: <20180223170212.359644291@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
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
@@ -90,6 +90,7 @@ obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_UWB)		+= uwb/
 obj-$(CONFIG_USB_PHY)		+= usb/
 obj-$(CONFIG_USB)		+= usb/
+obj-$(CONFIG_USB_SUPPORT)	+= usb/
 obj-$(CONFIG_PCI)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/
 obj-$(CONFIG_SERIO)		+= input/serio/
