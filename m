Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3404581-1526425135-2-3694384255253019644
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
    1526425135; b=h9C+KT6Cmggm9AP19gzXk3EDnjNpja5GoTvihoKDZKUUXvrxnE
    HV8ncRebqi2/oh3ZHSMpCeXWh9JVwOYQ6HqYziPiXNtn4UasUfZyjgY45T5pugKE
    qiNjeZz3QyZMeZtFK1BHA8SmIBHPSi8ZXwaP/vBkz+KmO5JuZOGVzn28/pCUd+kP
    clxdLbWlet/uFlOZXdg8US9T7Rxwqi3tQX5JasMerFg1Xajoh2yLBvDMdmLQw3fF
    wBt2G+hYr1JXeqtZhIXWPq3AdubH9N6/7RsoQy99RTjrGVdowQxPPu+/WKla1OAj
    A/eN++/iZWEXgeuA5aMyE0NK8EUX6n4GWUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526425135;
    bh=mcuc5E6n7mkcPzajPgUKk3X/WM+3tu3z2DLwQHnaNvo=; b=Fnu1wr9uxkzw
    Cu/7nzBqiWcOcINW4uh9AnxA270kHcNnLIRJXmPpkco4cAmSrgpuer3sql6IG2Km
    8dfqRBO+CnmcH8ElZS3c1OVwlglrW9jgj6buFku7gbK9l5YCODtxCqM1P10QPPgs
    y9jgiunFcWvW9zcWZd6JMVEto1TwXcY3h6afiKLSstBQIlfVv7qX3oNxlOPC3rbT
    7efl7dXMwF7J3THLfHXbTkRF8lMNee3bYb6fcq5c5TcatAZTm+KBxpNd7tBqei9A
    VcHZ2mA9081hPwviv+aZsq9XjJ1GuV/kNsEeUjICyV/brN0C+ZvezJPYcm7YY5xa
    226YmTf9dg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=ti.com header.i=@ti.com header.b=gY1hUSeU x-bits=1024
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=ti.com header.i=@ti.com header.b=gY1hUSeU x-bits=1024
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
X-CM-Envelope: MS4wfFSXmSc0DoXV6PsYH1pHEVokwEHZWejGTUhiAYF25oYtwaJpRVsWOPYJ6ye18ktsCtSZl5S880BaEEQ/NAy86qjx2M73P0iqQ3Ww42YCq3VVtPoH4yaV
    Y/rBIpEKDWCTSKxjWybm/3dcuZZGtyCyp4k8z+LtoW0hlR4PfiWW9f0EDcAng5v5pYWd2Qd8xhW/+i6kIilRc46X/dlJelABMw0tj4jemA7QM5XCt63JOyYf
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ZWVui-3J41lZotk3seoA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbeEOW6u (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 18:58:50 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:50584 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeEOW6s (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 18:58:48 -0400
Subject: Re: [PATCH net-next 2/2] drivers: net: Remove device_node checks with
 of_mdiobus_register()
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
References: <20180515215930.12115-1-f.fainelli@gmail.com>
 <20180515215930.12115-3-f.fainelli@gmail.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <1112dc66-5300-89f8-8382-ceb7a024e933@ti.com>
Date: Tue, 15 May 2018 17:57:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515215930.12115-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/15/2018 04:59 PM, Florian Fainelli wrote:
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
>   drivers/net/ethernet/ti/davinci_mdio.c            |  6 ++----
>   drivers/net/phy/mdio-gpio.c                       |  6 +-----
>   drivers/net/phy/mdio-mscc-miim.c                  |  6 +-----
>   drivers/net/usb/lan78xx.c                         |  7 ++-----
>   11 files changed, 19 insertions(+), 60 deletions(-)
> 

...

>   		goto bus_register_fail;
> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
> index 98a1c97fb95e..e720244e7f71 100644
> --- a/drivers/net/ethernet/ti/davinci_mdio.c
> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
> @@ -431,10 +431,8 @@ static int davinci_mdio_probe(struct platform_device *pdev)
>   	 */
>   	if (dev->of_node && of_get_child_count(dev->of_node)) {

It causes build error due to "{" above.

>   		data->skip_scan = true;
> -		ret = of_mdiobus_register(data->bus, dev->of_node);
> -	} else {
> -		ret = mdiobus_register(data->bus);
> -	}
> +
> +	ret = of_mdiobus_register(data->bus, dev->of_node);
>   	if (ret)
>   		goto bail_out;
>   
> diff --git a/drivers/net/phy/mdio-gpio.c b/drivers/net/phy/mdio-gpio.c
> index b501221819e1..4e4c8daf44c3 100644
> --- a/drivers/net/phy/mdio-gpio.c
> +++ b/drivers/net/phy/mdio-gpio.c
> @@ -179,11 +179,7 @@ static int mdio_gpio_probe(struct platform_device *pdev)

[...]

-- 
regards,
-grygorii
