Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3406733-1526425261-2-8836132214279007898
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526425260; b=mAaI9jnbyyrjZGI0I9LQwmskvB+PYGlmZWFuuBhW+dJ6/ZHf3m
    WbTKKFd8LIoVp3IINEUNfrBUOsQt6EEX5q3KryTIaM4W+V2VdhAUATfouyvWbjW3
    z8ejhqijw04J8u1Aj3zIjr3HoiUctEj3/IDbcfbjlCMzBPXeowaEdMEMt1pwnKnc
    6FVcRv9++DDom3tYhal6Ud87T7BtjMGyfGXyvAbOMRLxq7nG2AFwyySVUOL/nMsF
    tY4oBjxN49CTeEwUELkJGZopcSxyii63hF2OpEzqjkZhhmkU6kTeJEer7fH4AjXK
    BGFHTGvVoYGlmc9h+gw6jcW1eHDgk1rKS+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526425260;
    bh=+YpmQosemVr59E2uwej1DDtzi2Zt31hwJpHvn9maYsQ=; b=PTpfHsUZYZWc
    9H3z8WhGnh23Yq70qiNGFyRfd50C6lD/KnraQ2aWJdWv4+O7jhA90PNRXy10DqlK
    a8BpTc4Y1oXuwZ/9EPTyUPzTYodkoRiPQ+R3kcvlKR+T2sKHG3jbtGDFCfvT4ARO
    gTYSqh2QJGWpPWGTYYj2rK0BIzd6E56DLrIvPjo7YeUx7vRGAm67r47zJULrN4EB
    EX7Y1cnMLdKAVA5E15uQeDcRSOfGZRqBzZYaLmA5cKnFxhtDWAeZkQjTR+kDu+sm
    y45XYyXPyk1mOju1tsZEtsRgduROBL6/ElmGPhq1xON1w9XVPWPJ6a6lrFhYOJQ8
    T94kS+Fb9A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=GrBGTlJ5 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=CWO1XN1I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=GrBGTlJ5 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=CWO1XN1I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIYcCUlDBt/3Wo2Jdg0fAbN7JtWXhhcHEUU4xVTb4lIesOLMq2k9LKObOJ+JPnfcD+c46IvxG0FaLik+oAwGOgZA6s3WUNMWsA0PsS43PYeG0qEyF9Ko
    CiE8BJn1Cavq2b12huU6Ujad2l14125z7TszaIqLYEyvkibUXSi6/co/mgk9QERWe1GR5pCzfd8DgsulPDQY2Ta1UIRKWSup9Cf3uEXsIkm3dikNVgloi+SD
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=P79jb94FTlEA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=tDQw1f3ByRbxPthDgiwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeEOXAV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 19:00:21 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40368 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeEOXAS (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 19:00:18 -0400
X-Google-Smtp-Source: AB8JxZoJN8wSGVzqioyPe7ldyHOyMHOddAK2JMCEwTYw2k7hphxm/oL5iVuw3kEdpkTSGM4OA3zk2Q==
Subject: Re: [PATCH net-next 2/2] drivers: net: Remove device_node checks with
 of_mdiobus_register()
To: Grygorii Strashko <grygorii.strashko@ti.com>,
        netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
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
 <1112dc66-5300-89f8-8382-ceb7a024e933@ti.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <b3073c3b-7f97-c24d-1c4f-7459a5b70f1b@gmail.com>
Date: Tue, 15 May 2018 15:59:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1112dc66-5300-89f8-8382-ceb7a024e933@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/15/2018 03:57 PM, Grygorii Strashko wrote:
> 
> 
> On 05/15/2018 04:59 PM, Florian Fainelli wrote:
>> A number of drivers have the following pattern:
>>
>> if (np)
>>     of_mdiobus_register()
>> else
>>     mdiobus_register()
>>
>> which the implementation of of_mdiobus_register() now takes care of.
>> Remove that pattern in drivers that strictly adhere to it.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   drivers/net/dsa/bcm_sf2.c                         |  8 ++------
>>   drivers/net/dsa/mv88e6xxx/chip.c                  |  5 +----
>>   drivers/net/ethernet/cadence/macb_main.c          | 12 +++---------
>>   drivers/net/ethernet/freescale/fec_main.c         |  8 ++------
>>   drivers/net/ethernet/marvell/mvmdio.c             |  5 +----
>>   drivers/net/ethernet/renesas/sh_eth.c             | 11 +++--------
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  5 +----
>>   drivers/net/ethernet/ti/davinci_mdio.c            |  6 ++----
>>   drivers/net/phy/mdio-gpio.c                       |  6 +-----
>>   drivers/net/phy/mdio-mscc-miim.c                  |  6 +-----
>>   drivers/net/usb/lan78xx.c                         |  7 ++-----
>>   11 files changed, 19 insertions(+), 60 deletions(-)
>>
> 
> ...
> 
>>           goto bus_register_fail;
>> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c
>> b/drivers/net/ethernet/ti/davinci_mdio.c
>> index 98a1c97fb95e..e720244e7f71 100644
>> --- a/drivers/net/ethernet/ti/davinci_mdio.c
>> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
>> @@ -431,10 +431,8 @@ static int davinci_mdio_probe(struct
>> platform_device *pdev)
>>        */
>>       if (dev->of_node && of_get_child_count(dev->of_node)) {
> 
> It causes build error due to "{" above.

Humpf, shame on me for not enabling that driver, thanks for catching this!

> 
>>           data->skip_scan = true;
>> -        ret = of_mdiobus_register(data->bus, dev->of_node);
>> -    } else {
>> -        ret = mdiobus_register(data->bus);
>> -    }
>> +
>> +    ret = of_mdiobus_register(data->bus, dev->of_node);
>>       if (ret)
>>           goto bail_out;
>>   diff --git a/drivers/net/phy/mdio-gpio.c b/drivers/net/phy/mdio-gpio.c
>> index b501221819e1..4e4c8daf44c3 100644
>> --- a/drivers/net/phy/mdio-gpio.c
>> +++ b/drivers/net/phy/mdio-gpio.c
>> @@ -179,11 +179,7 @@ static int mdio_gpio_probe(struct platform_device
>> *pdev)
> 
> [...]
> 


-- 
Florian
