Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3069549-1524576618-2-6555636639802630336
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524576618; b=F//UkRK327S6GHvsiMIqaEiu6MLgobsDDsb/hspyxkhfMAebS1
    NV0khbkKp9HFI5k+9JGhrCER2H4YXbkJJtHN2pT/IAqytaoov4Mshdj1knYeAt+U
    Nl1BHvEQP1ltU/eyPInNtidn6etAk4mN25AZbgo9X171xSV1e+WPaZIvN/scA2i9
    ugN3/1j5o5clgS8D+5qxmbS8d66jyuEVYGdYNKN4/U9fE42wMz71ioZKW78btFjn
    1NPbbJ/ALN11f9VlIQp7BEpicfxoJOVki4VC8iuhBodY2GpmdbqFTC4h55TujGnp
    Z11cb9DZFpbv6UgXtGuy9gW+deN0TRmuHmPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524576618; bh=Eq6Sh3ZdWLrRw/nbDnDdVLvYohEkC2
    iCvz73Nse3LsE=; b=Bf4QAK5TqjPnQo2Fa8HPB4qEFTFXvGqyUA5CRAlwhc95Ho
    Ct4LzTr1vTz2NFzq/lCFBlxi6dCPZmKKk4TuuCnIoMPHiIHSUu+q57KG4CUbMbxW
    bfyNEphA3WXKZ+k1JWCHqH6viXVNjuUHajr6qeNhgHPhnLIEgwSB3cwQRFEcUoze
    PiS12fRt5sEk3hQic/1z5cPZ/qwLD8K3dbCifOQuqg7LS0rmqGPma5prpiVwbCRS
    q5CA60rL6uDJWS2yeC/p7RGhgEOaP00Gs2ennSjg1ZUHZvWoERzp5vUldgcHDqR/
    U69o2r9/rMpFojWlxGD/DSAFNQ/fGLghbFfuPckg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uFS95n6J x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LBgHoFgr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uFS95n6J x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LBgHoFgr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIEfZGv8iw+5jdOjtSnq/mHA2UHXPiBSzyhVVlI9FBbKm5pn09WGEtbj3VMszrxSxTSgAuwWaownwTsXIr/ujgMTZ6LZqbV7BNTIHB81vvhu3qq1JLJd
    i/j72o0XymHBvpmiuYsSRVKn9Z+q26nnKxCw1KX2TTFsTb/pBi40BpR6J+rm11C/mq4CL0f9azdhnKCYljxcUH5BaN83lODf4FCIsd++0m5mFfRSgf01MqUJ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=UWLGKgljVrAA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=w9j5uuQj-3BbXOR1XwgA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933977AbeDXNSF (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 09:18:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35153 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933839AbeDXNSD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 24 Apr 2018 09:18:03 -0400
X-Google-Smtp-Source: AIpwx49nkKBrPFJwjKOVtzNdBFxh6d9T6MN2ezrrn8AzGOCgwq9C4W0LyJfUmVL/VoqC8UrwksNKGg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Kappner <agk@godking.net>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] usbnet: ipheth: fix ipheth_tx()'s return type
Date: Tue, 24 Apr 2018 15:17:58 +0200
Message-Id: <20180424131800.4862-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/net/usb/ipheth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 7275761a1..53eab6fb9 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -413,7 +413,7 @@ static int ipheth_close(struct net_device *net)
 	return 0;
 }
 
-static int ipheth_tx(struct sk_buff *skb, struct net_device *net)
+static netdev_tx_t ipheth_tx(struct sk_buff *skb, struct net_device *net)
 {
 	struct ipheth_device *dev = netdev_priv(net);
 	struct usb_device *udev = dev->udev;
-- 
2.17.0

