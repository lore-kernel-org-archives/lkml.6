Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-811314-1526502034-2-16949975473746834071
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526502033; b=QyeLwjBS43YdDssfi/UDdANPbyGTinfAKwpK+HILouakeclCs4
    Zr9m4pJfCEa611Hpb7bK6LnunOftPHYshpzx8sVtpJ9qixNss70iloc0sNdlDMre
    X/D8aq/ej6LqlOUqVahTrrzIvDL43pJz9BdMJJC6modIaLlcP6DDmX4ncrV88+LO
    p74wijRg/RpZwOPzsG6DtlPOb8FuPKRDIDkExXlULqBlc0qRT/FqNR7ZD54crqUE
    c91LmSi0PS7zttkUSoXGNLML1bNmOYQBo4rq+m+QiPY5nMOSXFWPf75KS6CTsnpv
    uk2Ee4GkG6Yg/jAsFwZ+LKyGFGW5N7UBZOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526502033;
    bh=cNT14H8AHJLXAGOYn1ACRWsh5AGbwD2PLZfHQHGYMpQ=; b=R4ksWqtnDnoU
    gjglcelbd9C0uBUlOsKNDos9PKnOlERoHDREL/A5O/37mIDfjyuSXwlLa+JQhVFF
    wZv03q9YgPZ+X5YTLTUZuIpLPDmfyh9ULPFkBl3ZLAWtAPmubbumJK3NTBc0lsyv
    YT3FCyND93QRjC36AbFqdyiUM/t/ZcfMgEyN+/DgDNqveRxA4u7nzxDdc7yJpNl7
    C6zRobebEwkbEJTVxK+AYZHSutURHubVpjMd69Rh0yS9HhsI4LSOs43hLksb+tg+
    2IhfCm65NveC5AUmtWM4tDfmOcN5htq26uPoFSDxtghf/7nT7XmMyvYS0JqZUh1f
    kv/qBBrEJQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=cogentembedded-com.20150623.gappssmtp.com
    header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=h6XBXcBS
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=aDbdkgbX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=cogentembedded.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=cogentembedded-com.20150623.gappssmtp.com
      header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=h6XBXcBS
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=aDbdkgbX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=cogentembedded.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBfY7xJzsh578tDGaTnITFFrbKPEBvnC2fQqpUaTFnJFgrXEnpno+qm12+JIR4YFa5L8iZVhI0jARsLzOwaJDwJWv4xSqc+061LxCZGO7mfZQpj5yeX/
    fSK0WVUhiGYn8u103rQIKXDeu5ybwCICF/RxOMhM6bKRGLApVWQIgDrzb7kOK9JsPK89XY2bX/XD4gORTkSG7bOPDOc/P7SLLYuKCWO0KvXcQPgrSoSXtoYu
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=AMTvMMonAAAA:8 a=VwQbUJbxAAAA:8 a=oo5O5SFQ64zgib0ELXAA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=p5oU-coMHzOM5oT1KbOf:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeEPUUK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 16:20:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38083 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeEPUUI (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 16 May 2018 16:20:08 -0400
X-Google-Smtp-Source: AB8JxZpuBXKL+2+uKr5L7CAr36/V1xv5q2ZWTjDO4AtF6nYj5zgUvoJg5Zb6O+VhZiUihD19daEuNg==
Subject: Re: [PATCH net-next v2 2/2] drivers: net: Remove device_node checks
 with of_mdiobus_register()
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Fugang Duan <fugang.duan@nxp.com>,
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
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <72171a45-3c50-6550-9798-d13df72628ea@cogentembedded.com>
Date: Wed, 16 May 2018 23:20:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180515235619.27773-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

On 05/16/2018 02:56 AM, Florian Fainelli wrote:

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
[...]

> diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
> index ac621f44237a..02e8982519ce 100644
> --- a/drivers/net/dsa/bcm_sf2.c
> +++ b/drivers/net/dsa/bcm_sf2.c
> @@ -450,12 +450,8 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
>  	priv->slave_mii_bus->parent = ds->dev->parent;
>  	priv->slave_mii_bus->phy_mask = ~priv->indir_phy_mask;
>  
> -	if (dn)
> -		err = of_mdiobus_register(priv->slave_mii_bus, dn);
> -	else
> -		err = mdiobus_register(priv->slave_mii_bus);
> -
> -	if (err)
> +	err = of_mdiobus_register(priv->slave_mii_bus, dn);
> +	if (err && dn)

   of_node_put() checks for NULL.

>  		of_node_put(dn);
>  
>  	return err;
[...]
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index d4604bc8eb5b..f3e43db0d6cb 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -2052,13 +2052,9 @@ static int fec_enet_mii_init(struct platform_device *pdev)
>  	fep->mii_bus->parent = &pdev->dev;
>  
>  	node = of_get_child_by_name(pdev->dev.of_node, "mdio");
> -	if (node) {
> -		err = of_mdiobus_register(fep->mii_bus, node);
> +	err = of_mdiobus_register(fep->mii_bus, node);
> +	if (node)
>  		of_node_put(node);

   Same comment here.

[...]
> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
> index 5970d9e5ddf1..8dd41e08a6c6 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> @@ -3025,15 +3025,10 @@ static int sh_mdio_init(struct sh_eth_private *mdp,
>  		 pdev->name, pdev->id);
>  
>  	/* register MDIO bus */
> -	if (dev->of_node) {
> -		ret = of_mdiobus_register(mdp->mii_bus, dev->of_node);
> -	} else {
> -		if (pd->phy_irq > 0)
> -			mdp->mii_bus->irq[pd->phy] = pd->phy_irq;
> -
> -		ret = mdiobus_register(mdp->mii_bus);
> -	}
> +	if (pd->phy_irq > 0)
> +		mdp->mii_bus->irq[pd->phy] = pd->phy_irq;
>  
> +	ret = of_mdiobus_register(mdp->mii_bus, dev->of_node);
>  	if (ret)
>  		goto out_free_bus;
>  

   This part is:

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 91761436709a..8dff87ec6d99 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1843,12 +1843,9 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
>  	}
>  
>  	node = of_get_child_by_name(dev->udev->dev.of_node, "mdio");
> -	if (node) {
> -		ret = of_mdiobus_register(dev->mdiobus, node);
> +	ret = of_mdiobus_register(dev->mdiobus, node);
> +	if (node)
>  		of_node_put(node);

   of_node_put() checks for NULL, again...

MBR, Sergei
