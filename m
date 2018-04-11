Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3150701-1523473562-2-17436903104847697048
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
    1523473562; b=OtXyTxFcBIkU+hEvLB4jcGM7mkW63oQjzEmkgUy4ZMK6jZVLr1
    PGf9rovO83MI71OaIEHuIwFwD9edGZQBusIiDWhFBMZzcIBN1ko31gb41/b2UzTe
    53H1vE/HbySKpchNhGIbkizpV9JPylcvAmKDVTOhBsXmiOuz+V/QbLAfX5LCAmzu
    EVbdUyriyDNy2ITvd6l/k/wiBAToQ/bHBCY8EowXRlVXnGxSt7XIFIZiAJJgD3yy
    PakOvTFYivRvn6c/CMUeNx5u81phmoGbSxcPQrvqAJpX/E9KaCnqqIUYMySIKbq4
    p9W4mAOLAIs3Fu2bemdsEYHwsOO/dm4FgeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473562; bh=/2mqvTe7bc6kzq5i3l2E9yeyc1QVEm
    nWyGYPTTspkXg=; b=XNstpU08GaPWSfWl0KICRsEIhX3Gw45wGXgDpS1kWuq2Hl
    7cJQCZiNT3H+O9u+uodPYUBf1L0/vk+O+g6jFHRTt+fSbPE4t+5UXU3AT1hrMS+I
    UD4ix2xiSFZyMYwvfckBfV349ebg0DMEuXKFHbBrrQzmLFU/UNqY5WfhZxW/qBk0
    /8vj0ynCbBfZ6xx22LKVynxsQFfv8As7oyVOVR980x7GfjeiKvjItGSINKUpVMtk
    ptOVcvdrxAksLt2m6RoeTB9JqVOcJOFF7e0wORT+TC7SL1vIKj/iGmvw2ZFC8SkA
    j/ef+XLy1jN6w0yzu7En+k+NtDYSksarG2zEUI9A==
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
X-CM-Envelope: MS4wfJtU7TPgs+4n5UUf7li0X4Go+GMXlivEUiIfn9pp4Bgc9Fvsv+1JIim5hmX2CC2nwkaiST9/7PyckN3AbeRgMwTq6lXw63bjiJgFelEWO6WTPDKGGCo7
    yQgUaqz1HbobjHGA6evCtptSb9SIMAZUeWNuAnsXGLpxWT7pA4sjj2PDo+d3XF8YEgq3L/YMeAfrxKmuIEvgEXtJolRk/He7tuxi0zd3O4RwF98Zgfw37hE6
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=eX0X6HwealoA:10
    a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=P8bgakDpFLpm4VNt0N0A:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935127AbeDKTF7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:05:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40656 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934041AbeDKTF5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:05:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Miller <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 4.9 284/310] r8169: fix setting driver_data after register_netdev
Date: Wed, 11 Apr 2018 20:37:03 +0200
Message-Id: <20180411183634.818819687@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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
@@ -8446,12 +8446,12 @@ static int rtl_init_one(struct pci_dev *
 		goto err_out_msi_5;
 	}
 
+	pci_set_drvdata(pdev, dev);
+
 	rc = register_netdev(dev);
 	if (rc < 0)
 		goto err_out_cnt_6;
 
-	pci_set_drvdata(pdev, dev);
-
 	netif_info(tp, probe, dev, "%s at 0x%p, %pM, XID %08x IRQ %d\n",
 		   rtl_chip_infos[chipset].name, ioaddr, dev->dev_addr,
 		   (u32)(RTL_R32(TxConfig) & 0x9cf0f8ff), pdev->irq);
