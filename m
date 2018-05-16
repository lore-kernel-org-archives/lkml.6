Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3468281-1526428994-2-9900767209923210412
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526428994; b=VcdyF3mWmNwwOE+q7km9Uv3lvVyeocrZ/YsVzi5RDzBq9BpR5d
    sv6SnOCV4gRWhirDd+WVAsPFj8WY50/HaW2mPujG0yQziMWQ5tc7SWtyPk0Q0AHD
    tRptLDpsZxOFbX6sEHEH2DE4tcUqbdFXgCMZw5X3lbkSrjTGBvGeQ0FH+irfJt8q
    APj7wZqgzKjSUA5LXy1FTMFfz0PVaoUjIoNrXh6ZW+nKgiIPrcgc9ihli4gjLRwJ
    XCDCNux1MH7K0y66dnIBMjgOYy+kqq5Fn6LCJHbkYVDdCueLKPFQH13EakNtcRTw
    3xBu1r18yq9sBqcRrX0ZaQNmdZwPeOo/+69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526428994;
    bh=oHiWF9EJREaVQ727IUUM7u4jcqCmPsLJ9oUdLHvwHBg=; b=FypFR8CHYaZW
    SnF5nBrq8G3xRGIT+wXB4G/sv4jbPR/9r9cWWy1klWGxpBlwuCx05MbA+wJmQ5e+
    P6h4k9wdXAj5AfRxiGT6t9A8vytm0XyAZXw+Yco+eyh5FUuZJ40XA+DyclQNAgDR
    PuFA3RN6uRUTVXnYiAgHWjtHAqJZrZ5Q9kkY52uLNrVXMdvJR5LE2vprRyzgLhf6
    kI6C97CDOIDo6q1U8tiWfJwOtxniUBQlA2uxgo1GDKQhRAvqbGoMzceKYRa8kJ2N
    yR/RtnxqtFHs4ClJMKgmgwtzyZkWoqgdrqdoeKrSZ+wubAVbahGnOPUfQwnmGpjM
    KS1qeT+ZDw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=ti.com header.i=@ti.com header.b=g/cc4QVo x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
    header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=ti.com header.i=@ti.com header.b=g/cc4QVo x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
      header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOGz/B/azGRfinAaQDq4JIOSfWB1kFEWoLvGI1SHCsQML5kaeujewlJHBTkj/wbN85q20BeRFqwl8Q92SlhoG1oXSWeesEPhGQRkM/oLjkE3vq7BHAHy
    0s1C/d0+ETYZgDo72jiFDPPxdKJRHiJxuPyARNyb9NnnZ64zr/JiWTQYK73PZdSs5hNJy9mCsLVEdOhizfzZL51+B+/fEqnGR5PDGBKStgxPhskPQ9lG9SJi
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=fIm9xsr7WG9_Cl8JenEA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=aeg5Gbbo78KNqacMgKqU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeEPACr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 20:02:47 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:49191 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbeEPACo (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 20:02:44 -0400
Subject: Re: [PATCH net-next v2 2/2] drivers: net: Remove device_node checks
 with of_mdiobus_register()
To: Florian Fainelli <f.fainelli@gmail.com>, <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
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
References: <20180515235619.27773-1-f.fainelli@gmail.com>
 <20180515235619.27773-3-f.fainelli@gmail.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <f965090d-fd1c-9507-77f6-878e08dd2fb6@ti.com>
Date: Tue, 15 May 2018 19:01:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515235619.27773-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/15/2018 06:56 PM, Florian Fainelli wrote:
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
>   drivers/net/dsa/bcm_sf2.c                         |  8 ++------
>   drivers/net/dsa/mv88e6xxx/chip.c                  |  5 +----
>   drivers/net/ethernet/cadence/macb_main.c          | 12 +++---------
>   drivers/net/ethernet/freescale/fec_main.c         |  8 ++------
>   drivers/net/ethernet/marvell/mvmdio.c             |  5 +----
>   drivers/net/ethernet/renesas/sh_eth.c             | 11 +++--------
>   drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  5 +----
>   drivers/net/ethernet/ti/davinci_mdio.c            |  8 +++-----

for drivers/net/ethernet/ti/davinci_mdio.c:
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

>   drivers/net/phy/mdio-gpio.c                       |  6 +-----
>   drivers/net/phy/mdio-mscc-miim.c                  |  6 +-----
>   drivers/net/usb/lan78xx.c                         |  7 ++-----
>   11 files changed, 20 insertions(+), 61 deletions(-)

-- 
regards,
-grygorii
