Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-97583-1526468575-2-10255149275898002943
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: cc='UTF-8', plain='windows-1252'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526468573; b=j1EfD2oMCTFCSte6SxlXtLq/gaB+Mt1e5MQA70b3+6UTDC1JVZ
    iWuw3w+dmsfTcR2RP7qhgoUzRTXd6DyfQF/bocWy1YyhTSodrEYZiZ3bYUfg0G2O
    1RK6rg9ddyilL5lzXby65fxphfzEFppHGuMRDwu65QQwUeZhaRgRZ3HPSbACvCEi
    trMxUE77yoJS+EPHcSNzUtdyq2P4LBCkFHtSoOlNlCxBvkntoW1lj/WFMAeCQ1Pb
    9bt5jbpaH3EZwNBTZNrAXc9Ll9r1zBfn07ai6vJtFCC3l4Ejkojfw+Pu0ey9pGdb
    TAQvrFne2L1sxDF+HKNZXsKb/LJ0JEBIz16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526468573;
    bh=I442eJmq6XV1/ATKPE9CEH8DQx6b5bfP8WhWBf6lIXk=; b=BxV6T/wwVHbb
    /XW3tt9Br70XhJx+y/FRPDDJPSCB0+euG0h1eG2bzZY+P4EOteiwuvbBogGcETJn
    n4p5Nne/JHqNz4uG72f0jTz2qVT3lyLvHztmEH0j8ZJh+MGuszclzLRjDkSzGiHC
    cqH4IqHGW1RTOUI0Fm2tLEPoiE5krucqCcRfP4p7ao0a0AUJVOZXJwoaIEGBOhKY
    2eGZRAGIa6Nv6MjheA6WqkUqZxydD5okNGxtB+oqO44bm+V7ItLXdcA469Hv2N3j
    HesS3BZAMjb/M1oTWgj40lNf31B63x3Yzu/qdOF4PZp9fa2aMpkAvwgOXMVuzlL9
    iAN2ccMOqg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=synopsys.com header.i=@synopsys.com header.b=VHUv7iS+
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=synopsys.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=synopsys.com header.i=@synopsys.com header.b=VHUv7iS+
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=synopsys.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAZMcLtrt28qZYeqASvbjfrHS0d632jRXN4Qolfk3J/l+4tOu2mAyM/8ZxR5KrWLxG8P6QxCGdtbWyA9Gva1gMhghRGdqzmFc9deInXYXmNtRt+BBL2X
    iXci8CCVbuRp0WPZhyvfQdZSyfK04VMtih0JYpbo3S8uoxCfFwWPtSWH1PsTsbNbTVXKJWmxohivt4RbQniPh5FH7QpNvfPusv+wnTyxxbd14uciGEGTSuxq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=BdpWvAPuaVwA:10 a=N659UExz7-8A:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=jIQo8A4GAAAA:8 a=VwQbUJbxAAAA:8
    a=-DUO0aFTfY6Q21br10gA:9 a=pILNOxqGKmIA:10 a=x8gzFH9gYPwA:10
    a=Lf5xNeLK5dgiOs8hzIjU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeEPLBl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 07:01:41 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:47184 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeEPLBi (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 16 May 2018 07:01:38 -0400
Subject: Re: [PATCH net-next v2 2/2] drivers: net: Remove device_node checks
 with of_mdiobus_register()
To: Florian Fainelli <f.fainelli@gmail.com>, <netdev@vger.kernel.org>
References: <20180515235619.27773-1-f.fainelli@gmail.com>
 <20180515235619.27773-3-f.fainelli@gmail.com>
CC: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Fugang Duan" <fugang.duan@nxp.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Jose Abreu" <Jose.Abreu@synopsys.com>,
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
        =?UTF-8?Q?Niklas_S=c3=b6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        Simon Horman <horms+renesas@verge.net.au>,
        Maxim Uvarov <muvarov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RENESAS ETHERNET DRIVERS"
        <linux-renesas-soc@vger.kernel.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)"
        <linux-omap@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
        <devicetree@vger.kernel.org>
From: Jose Abreu <Jose.Abreu@synopsys.com>
Message-ID: <2a70eb7c-7fc9-8bf6-a06a-87b4901d66ae@synopsys.com>
Date: Wed, 16 May 2018 12:01:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180515235619.27773-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.35]
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16-05-2018 00:56, Florian Fainelli wrote:
> A number of drivers have the following pattern:
>
> if (np)
> 	of_mdiobus_register()
> else
> 	mdiobus_register()
>
> which the implementation of of_mdiobus_register() now takes care of.
> Remove that pattern in drivers that strictly adhere to it.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/net/dsa/bcm_sf2.c                         |  8 ++------
>  drivers/net/dsa/mv88e6xxx/chip.c                  |  5 +----
>  drivers/net/ethernet/cadence/macb_main.c          | 12 +++---------
>  drivers/net/ethernet/freescale/fec_main.c         |  8 ++------
>  drivers/net/ethernet/marvell/mvmdio.c             |  5 +----
>  drivers/net/ethernet/renesas/sh_eth.c             | 11 +++--------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  5 +----

For stmmac:

Reviewed-by: Jose Abreu <joabreu@synopsys.com>

Thanks and Best Regards,
Jose Miguel Abreu

>  drivers/net/ethernet/ti/davinci_mdio.c            |  8 +++-----
>  drivers/net/phy/mdio-gpio.c                       |  6 +-----
>  drivers/net/phy/mdio-mscc-miim.c                  |  6 +-----
>  drivers/net/usb/lan78xx.c                         |  7 ++-----
>  11 files changed, 20 insertions(+), 61 deletions(-)
>

