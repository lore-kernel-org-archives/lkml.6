Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3468281-1526428601-2-10265758061824279104
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
    1526428600; b=Kg5Ds/ioLt4VcsJxTafQhY2V9RyZZFk+nlV7hXPqcGNlgGzDiX
    IO563QNJKvsd+NDE54OtvFkDBAaY7k/esiIv8EDv7TwgrbIfgV9/avCDZ8uXG4YS
    +GTcr5l5+f7XwzGziezgHIqzns93CbFMky/O63Bc9YSTJ1tzXI7sRhX0uPhXrVGH
    A6AmFaQU0qP63cOlEMwRPSbratOzRhB/I1OjiWs/Hh9826pT6Kzw3dYZSxbwhdN6
    bOeGDMJAgUwd3fQhxIlAm9S4vGYDTd6w6HQEywKIzQBX+PeECpAwJtYxyg7aldAU
    aZXlZ7Gz1Ou6e5F63c9dRVk3PKCe8LEUru7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526428600; bh=NOUkjKE5KLZVf1zdKA+IaVDwbA0UO4
    yVsgUgFmudhvo=; b=Qon5+bQgujeCQLne93Sc0HMGJy7vhJpZMUeuImK5L9ZF9o
    2V0+q0r8S3W7fJMizX428CzwXYoNNvBm8ZFJj307lDGjUA3tNeVhj6Gemadjgare
    yKlXwMW5y9AAr3dCPUNrONDvg5OKsrXFum7tkaaDV9TnoN+HKow2Dt4x4Moi5jz4
    /bpbEbDn4ztPauPwQUSDzYY5bdSfA8gppvOoKnJFApu7X23CI/D225YH3IfD/OiE
    3EN1Da45c2slHWzezfkTtG0RGzC7E3KKDvZ+QZpSMVvZlds+36u50lyX06VDCuYX
    j1E5g1hQcy+mtrROXp3OradHhvFum+68rCCF+i4w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=EbIB6h1A x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=MSygaFRw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=EbIB6h1A x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=MSygaFRw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPDQsiwsI1S+NtsvkD8KTRr/lEVaLO+LDrOocFkXpp4T1ghv21aJpqMm/IZzAqNPG+iolKet3mPPlvGXT7NJ1EGCeAAkjEmwFgFgr6pp6+6g0iaYLzNV
    3Y4c0G2luW4c5Ycxl2PZgz0vaMDJbDXZrlB1ARiYASyUnY76oFcnlYgFdtwwMjIiqhlUgxqAKPPwNiBE24Tf24bjQjUj9MTjgfR+FVqRyDUWfS+QB2DrGxaN
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=P79jb94FTlEA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=Xdunx2OK0XOFyVAUE3MA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEOX4d (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 19:56:33 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43220 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeEOX4b (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 19:56:31 -0400
X-Google-Smtp-Source: AB8JxZrxunb7c8o6PKYAkjK1/0jCylgVoGpHzk5cWVXyjde/eyiYqtrBdORXnit37Ag22wJaqWbv0w==
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
Subject: [PATCH net-next v2 0/2] of: mdio: Fall back to mdiobus_register() with NULL device_node
Date: Tue, 15 May 2018 16:56:17 -0700
Message-Id: <20180515235619.27773-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

This patch series updates of_mdiobus_register() such that when the device_node
argument is NULL, it calls mdiobus_register() directly. This is consistent with
the behavior of of_mdiobus_register() when CONFIG_OF=n.

I only converted the most obvious drivers, there are others that have a much
less obvious behavior and specifically attempt to deal with CONFIG_ACPI.

Changes in v2:

- fixed build error in davincin_mdio.c (Grygorii)
- reworked first patch a bit: commit message, subject and removed useless
  code comment

Florian Fainelli (2):
  of: mdio: Fall back to mdiobus_register() with NULL device_node
  drivers: net: Remove device_node checks with of_mdiobus_register()

 drivers/net/dsa/bcm_sf2.c                         |  8 ++------
 drivers/net/dsa/mv88e6xxx/chip.c                  |  5 +----
 drivers/net/ethernet/cadence/macb_main.c          | 12 +++---------
 drivers/net/ethernet/freescale/fec_main.c         |  8 ++------
 drivers/net/ethernet/marvell/mvmdio.c             |  5 +----
 drivers/net/ethernet/renesas/sh_eth.c             | 11 +++--------
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  5 +----
 drivers/net/ethernet/ti/davinci_mdio.c            |  8 +++-----
 drivers/net/phy/mdio-gpio.c                       |  6 +-----
 drivers/net/phy/mdio-mscc-miim.c                  |  6 +-----
 drivers/net/usb/lan78xx.c                         |  7 ++-----
 drivers/of/of_mdio.c                              |  3 +++
 12 files changed, 23 insertions(+), 61 deletions(-)

-- 
2.14.1

