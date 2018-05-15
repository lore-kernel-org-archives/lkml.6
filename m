Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3322034-1526421599-2-11121888346901026820
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
    1526421598; b=kK3psK5I5DXQ/cSF17Qm4qU0STy/i9P+Mara59uBGuuwDZt7wM
    BV7kuIctl3rI4nRlWnzwk9ZA6cIzrzp6yD5wyDRXoJHJegnYwDMRln/JXFqLCK7O
    /CBR027MJtCl3Hi/PWGktPlVpzO/BhSYQm4ZBFMmBlimuOoDtNmCOAO+c9MhJr9n
    0Iozk1sSqPa4oyTtms3xejU3vW3eNFoERjUS6cNamENrod0Hfbdu8to/rmmZ6oWu
    RORx3OlcxLGtjekxe8/5mjWaQ+jMlgaLID170X8yXv2v9Xw/ILCcsLWRyWgmZdDD
    3j/rwHgBrse6pNJMkpNQUyRUQDoJ9e5ebxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526421598; bh=
    pjeYh3NQPrWal+fcAZU4DZ0z+fOW9JI9c2jO3e+Ejww=; b=Gk2OYZmTY9u/q5JW
    kqwUe4XwMD3HQGw1RI20d9+7mFT+4On/DupGq7S9DXeGHb4VZP7TSBLKCq2kTMob
    dIGjMy8poR/ls/SfzeZPiPGe/t72gmNO607AAO4kRhgzYD7+7DePWHDw/EgzMLSi
    Omu+hkP0YOyhSQv7OojpteQLuZojtjX2xWo7aqkdNwtL6O/gZNIe1AfvIkgk8pt/
    UDSSGxA8Oh/uFG29W+554m/qLM+YEdUY04amE2sdwIVibmdysKIK4NkSYtrIYWNX
    fvic/MCpldsQr5mDu4iHsjBN+ooS29pzNG4p0PKj0k9V3gG5FSlZ+0XY4KqDYxxv
    O137ZQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=TJhpBSOm x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=proHg6ej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=TJhpBSOm x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=proHg6ej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNqc1SsshyxlSytekRThCJwxllq5MoDBdx+UWk39EVSKoWylJx4MH3rD2YqZqh9zSkM4LBGp3fyJnbZ2iM8+/ozXCdB5UeO1Z3PqtM/hP5cfN+RAZznM
    3bqCkCUg/1zgrEwisot/7w8mmKPEOiLjK/H81IDZlYo7/RcpXAjBFZz0aSsJCGifnhc0cy93mphiPQ4zEgp+dssHMTWN5Mb4b7O/hdPL6TANl7S7XpXCzNZ2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=P79jb94FTlEA:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=jfokmrQWVMgJXwLkNdgA:9
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeEOV7t (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 17:59:49 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37464 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeEOV7l (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 17:59:41 -0400
X-Google-Smtp-Source: AB8JxZovDnSiuEShi/Ug77M62MDPvIanFVY8tyVINOaDRCMZBkr1D1xjPVn+V0/PxDsQbMN6nfhUqA==
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
Subject: [PATCH net-next 1/2] of: mdio: Fall back to mdiobus_register() with np is NULL
Date: Tue, 15 May 2018 14:59:29 -0700
Message-Id: <20180515215930.12115-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180515215930.12115-1-f.fainelli@gmail.com>
References: <20180515215930.12115-1-f.fainelli@gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When the Device Tree node specified is NULL, fall back to
mdiobus_register(). We have a number of drivers having a similar pattern
which is:

if (np)
	of_mdiobus_register()
else
	mdiobus_register()

so incorporate that behavior within the core of_mdiobus_register()
function. This is also consistent with the stub version that we defined
when CONFIG_OF=n.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/of/of_mdio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 8c0c92712fc9..2341dbf675bf 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -204,6 +204,12 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 	bool scanphys = false;
 	int addr, rc;
 
+	/* If the Device Tree node does not exist, fall back to traditional
+	 * registration
+	 */
+	if (!np)
+		return mdiobus_register(mdio);
+
 	/* Do not continue if the node is disabled */
 	if (!of_device_is_available(np))
 		return -ENODEV;
-- 
2.14.1

