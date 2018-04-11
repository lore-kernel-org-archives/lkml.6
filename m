Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523472729-2-13310857158626740996
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
    1523472729; b=XHGWmmOTSxHX1ZcxLRbHnLExtPDL7lASB2D8PVKZoSrDxwxxRT
    xlesmY1HPY0qYc9dEUFIUqe7HGtUeXBxmLoWcYiA5GiU3cQquA9xyv/KMKqtT53j
    uKwmwJhVmGHmztgPBwu+xUqdWUOnkjh3TU2o9hyvMB5ZAH/UO6ZCJcczRq8cM0k1
    R2ozFgsUaAM/cW38m465DdSV2dTPFDif+Kq0KZJ9SWF6SMVBKVUQNg8NQyuDbKsy
    5IH/yxeaI7foztbrl+W4lAUCBlWryN+A+EDNY5YH8EC5PdAd/kAoZb5gTS67gcrS
    fYMFH0yFE0lw0b4vaAoTGBXjPqSkFeolWOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472729; bh=WKdrKvdKUkvm+WPKQj4tFdVaxhYEVb
    5ucHcrGoX8Vkc=; b=cQwPa7pL3Fw806MvUHSfXrEKxcdc1WoT/drwqGmtO8YbdI
    ngFi9ogVE169mPVNBVbqENWViD/0kSzmCg1PRHI70C7jw02mMPYKMEiWUtwFo9b6
    hlBT5QdDmf97rpmqhvEvECNn7on5F9OFKQd4gXQzhq5CyXDrvvQ6FmuSog6VEpOu
    tToHftpI3rQ30c+mD5a7bx4MDrysNjz3UTjIWiQn1zJW0QBroN6ETTHubouY378B
    7fRb0wAR0hOkK45ahbYUT/hXo8aiTTSktUWSxzVzMQtRpI5hYja4PE7eHdIhuIuR
    YwHvcHNvMH0sFKPrpNylwObW+lCRC9SYQlAj7Prg==
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
X-CM-Envelope: MS4wfLEWT5VbekkhE3QItUo4LVl/6HHd2/PmyvxbtqSVtlAKfB9copVuZRUyrFt9AP8zJsrZV8NR/fNvgKsf1coBadoV7/NOp3LGA8XUsGKNkJDF8qUy8fBZ
    6/UAM9Wo+17LptKKRjuvZiMeU3KBPwuq2popQgCesN1M/CNQAoDPM4uBmQEyq6zqZamp341MGHUntO8FbxIbeelZ1I2vJsxrqmH+BfIuFYLTMEgRgKGM8zsG
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=DuQaTUuJoSgA:10
    a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=P8bgakDpFLpm4VNt0N0A:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932966AbeDKSwF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:52:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33238 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932981AbeDKSwB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:52:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Miller <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 4.4 186/190] r8169: fix setting driver_data after register_netdev
Date: Wed, 11 Apr 2018 20:37:12 +0200
Message-Id: <20180411183604.418733542@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>


[ Upstream commit 19c9ea363a244f85f90a424f9936e6d56449e33c ]

pci_set_drvdata() is called only after registering the net_device,
therefore we could run into a NPE if one of the functions using
driver_data is called before it's set.

Fix this by calling pci_set_drvdata() before registering the
net_device.

This fix is a candidate for stable. As far as I can see the
bug has been there in kernel version 3.2 already, therefore
I can't provide a reference which commit is fixed by it.

The fix may need small adjustments per kernel version because
due to other changes the label which is jumped to if
register_netdev() fails has changed over time.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -8411,12 +8411,12 @@ static int rtl_init_one(struct pci_dev *
 		goto err_out_msi_4;
 	}
 
+	pci_set_drvdata(pdev, dev);
+
 	rc = register_netdev(dev);
 	if (rc < 0)
 		goto err_out_cnt_5;
 
-	pci_set_drvdata(pdev, dev);
-
 	netif_info(tp, probe, dev, "%s at 0x%p, %pM, XID %08x IRQ %d\n",
 		   rtl_chip_infos[chipset].name, ioaddr, dev->dev_addr,
 		   (u32)(RTL_R32(TxConfig) & 0x9cf0f8ff), pdev->irq);
