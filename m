Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2493035-1519118855-2-5180902415650271589
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519118855; b=eS9ppVHQXm8sA5ktZNLOAb21+ebYaDDJ5LvT2HqFH61bLl9
    1aLc7Q780Tiym+fKgwqcm2FBtrcfb5bDj1R2G5viFinr739Gp4+hUDfCSBp+NKKb
    Q06phjtC9Qn2gK2EgUlrnOumUbwiQ3UIaAC1x8M/bEVdl4rVYOUU879dfDMPlfb2
    RLxHJwBCczFmD5PDROdfjS4zODOdm/6oe4JDLbV+1GA9Of7WUeSSUSwsQW/L7xEw
    mcNyisFckjnzuO2iKe0LdKft1fwHlO2XcwWZyrYeXJBX6z/TxvZDSEUeYUbgOZos
    W3zLwo6Ikmz5VPA1eUPc9GInCM1CoYt82sPqxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519118855; bh=YkrqWYL2UyHEmoqhYe37CAj/MNdy2BUPlobwpEKITfU=; b=u
    1BaOkHPHgRAGonqn/Dto/QSAjYeVmW5Fncx44PcAtUtGfQBpkKsl6NucTISQNNg1
    IhpG/aJtrek8ckNSS4Zw/9xQzevTCyUnGLjZaHu1F6wEyaRFiNo55JZqSXuAvHfb
    hBJILFd43KaJh3cHNKigDXS04bax4HZMriDcv+aPzVOgLLmH4eKOHIbj3lEyfVZk
    GOF0aXmsTVCdaTN7rtBidMbP4TSWDDULCr4yLVGuZ5/PzzQwAt+bLbfOOHWWAOUu
    EN/Fy3UoPqVwV3FBZhn4N754NQAP6XugkPYRBMkk+QlITm9ocZ+XufKSiRW4eiUT
    /tJDNFPCbTzs9b4o6UoHw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=fYpj3KAB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=fYpj3KAB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750979AbeBTJ1d (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 04:27:33 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:39447 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeBTJ1b (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Feb 2018 04:27:31 -0500
Subject: Re: [PATCH] usb: host: ehci-platform: add support for optional
 external vbus supply
To: Amelie Delaunay <amelie.delaunay@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern <stern@rowland.harvard.edu>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1519117905-12095-1-git-send-email-amelie.delaunay@st.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <9f1f49a0-4afd-a7f1-53bd-18f72abd4753@ti.com>
Date: Tue, 20 Feb 2018 11:27:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519117905-12095-1-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 20/02/18 11:11, Amelie Delaunay wrote:
> On some boards, especially when vbus supply requires large current,
> and the charge pump on the PHY isn't enough, an external vbus power switch
> may be used.
> Add support for this optional external vbus supply in ehci-platform.

Isn't this generic enough to be done for all *hci-platform drivers?

And if this is a VBUS supply to the port, the root hub driver should be controlling it
based on port power on/off commands to the port right?

> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
>  drivers/usb/host/ehci-platform.c                   | 23 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> index 3efde12..fc480cd 100644
> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> @@ -19,6 +19,7 @@ Optional properties:
>   - phys : phandle + phy specifier pair
>   - phy-names : "usb"
>   - resets : phandle + reset specifier pair
> + - vbus-supply : phandle of regulator supplying vbus
>  
>  Example (Sequoia 440EPx):
>      ehci@e0000300 {
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index b065a96..76cc781 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -29,6 +29,7 @@
>  #include <linux/of.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> @@ -46,6 +47,7 @@ struct ehci_platform_priv {
>  	struct reset_control *rsts;
>  	struct phy **phys;
>  	int num_phys;
> +	struct regulator *vbus_supply;
>  	bool reset_on_resume;
>  };
>  
> @@ -99,6 +101,15 @@ static int ehci_platform_power_on(struct platform_device *dev)
>  		}
>  	}
>  
> +	if (priv->vbus_supply) {
> +		ret = regulator_enable(priv->vbus_supply);
> +		if (ret) {
> +			dev_err(&dev->dev,
> +				"failed to enable vbus supply: %d\n", ret);
> +			goto err_exit_phy;
> +		}
> +	}
> +
>  	return 0;
>  
>  err_exit_phy:
> @@ -119,6 +130,9 @@ static void ehci_platform_power_off(struct platform_device *dev)
>  	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
>  	int clk, phy_num;
>  
> +	if (priv->vbus_supply)
> +		regulator_disable(priv->vbus_supply);
> +

If we disable the VBUS here, which is being called during ehci_platform_suspend(),
how can we expect remote wakeup to work?
This is unconditionally powering down the port.

>  	for (phy_num = 0; phy_num < priv->num_phys; phy_num++) {
>  		phy_power_off(priv->phys[phy_num]);
>  		phy_exit(priv->phys[phy_num]);
> @@ -247,6 +261,15 @@ static int ehci_platform_probe(struct platform_device *dev)
>  	if (err)
>  		goto err_put_clks;
>  
> +	priv->vbus_supply = devm_regulator_get_optional(&dev->dev, "vbus");
> +	if (IS_ERR(priv->vbus_supply)) {
> +		err = PTR_ERR(priv->vbus_supply);
> +		if (err == -ENODEV)
> +			priv->vbus_supply = NULL;
> +		else
> +			goto err_reset;
> +	}
> +
>  	if (pdata->big_endian_desc)
>  		ehci->big_endian_desc = 1;
>  	if (pdata->big_endian_mmio)
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
