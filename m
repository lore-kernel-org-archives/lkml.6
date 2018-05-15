Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3468281-1526428719-2-9883340831122471907
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526428719; b=Z6E+wYHO3BywNwuaI+wUS35KTEA2lodrFj8xMQHNbMbN4c0uAK
    hjWVZ3wh+ZI/6pFANJWTF6TOMlnieH/YUsMizAnSXSVjr/NOwn+DYpo8kd3JO6La
    eJ8z2nBH2JP4byQci1fjnnjw99qTCRMyrV3iIap2ENEP1bFlD8L2IsEuVe/fvPq1
    6DIWb3+lpZdu7+d/NDydnK+KSGLyIyVCAqLL4FTwlCJyYgtV3f5ChINDH1/+6s+G
    aVzHL2UaDuvxtRIxW4PHlAnTjIGjX8fohj+Zy9x7di+Xd+msP/DF82V5YCS/YQka
    ELHpm55ccKxjpvn7QVIuKVh0KBem4MotIrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526428719; bh=
    hKCR8eG61zO2/w5piAHhzl2n3yhAJ7GuDzuTHZjPEqQ=; b=LXyGa1JRJO3VaJqz
    UmaJrXQ0BGvdDRx6bP1IG1uRU2BnGOFcixVotTLIc4HG2ROOpOcaXHTLyfq96ZD9
    M8qLSs5q/qQ/wcHANRW3JJVsCsDXwJH+FeEVUz6wm6DQXdCvCVBNEOMJINHqf6uK
    auOcMFhOxdq88KaN8B7kQqFrhbLe0ix364eJ0AzHW+77N6PuCBIO4tHHD4ww6+cW
    mpTG+NY5j3Uybw9mrRbRbap8O5JbW0DwXkn88kfrBhdahxYBlC47HEdUddZ0jQOf
    iBijmHYuNx6c6RefstuuiLgYp4QbuzcsAZM8NlW013V9m/R0tXqAzDS1KCaB45u6
    xvD4zg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=mPHRGVAL x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ehnOHfJw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=mPHRGVAL x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ehnOHfJw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJYYmY7eRJR5nzfAvewmZmF/nOOpAACzyR0k86y1UA2Rrr1eFfUMAYjViEygAUA2LbvIwIV+Ubped5NcNXRrZeHeHpzuD8mKGeJxskUeqoIeSWHcYOIj
    aNYl4BlTpEcFo2ETOGAfLkIgmLeA3LfMEIf17UOMW3qTscSmFCQfdfYAMnM9TXVZarAimnZalWFWyomWuGIi1xlkSBW4YRv5gvcXM7nNx8qduK5eBcvsi4Lz
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=P79jb94FTlEA:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=jfokmrQWVMgJXwLkNdgA:9
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeEOX5r (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 19:57:47 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41703 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeEOX4d (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 19:56:33 -0400
X-Google-Smtp-Source: AB8JxZo5caIYN2oN1cVWUWdYkDo30OKEEqRyGX6pdUeANd2Meg3WG/q/popMaztFEH+uFSHxixTX/Q==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        Simon Horman <horms+renesas@verge.net.au>,
        Maxim Uvarov <muvarov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-renesas-soc@vger.kernel.org (open list:RENESAS ETHERNET DRIVERS),
        linux-omap@vger.kernel.org (open list:TI ETHERNET SWITCH DRIVER (CPSW)),
        linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE)
Subject: [PATCH net-next v2 1/2] of: mdio: Fall back to mdiobus_register() with NULL device_node
Date: Tue, 15 May 2018 16:56:18 -0700
Message-Id: <20180515235619.27773-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180515235619.27773-1-f.fainelli@gmail.com>
References: <20180515235619.27773-1-f.fainelli@gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When the device_node specified is NULL, fall back to mdiobus_register().
We have a number of drivers having a similar pattern which is:

if (np)
	of_mdiobus_register()
else
	mdiobus_register()

so incorporate that behavior within the core of_mdiobus_register()
function. This is also consistent with the stub version that we defined
when CONFIG_OF=n.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/of/of_mdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 8c0c92712fc9..d963baf8e53a 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -204,6 +204,9 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 	bool scanphys = false;
 	int addr, rc;
 
+	if (!np)
+		return mdiobus_register(mdio);
+
 	/* Do not continue if the node is disabled */
 	if (!of_device_is_available(np))
 		return -ENODEV;
-- 
2.14.1

