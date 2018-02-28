Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4104350-1519815750-2-16858055809047049500
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519815749; b=mvuMYL3BrG5+jqGwN+b/mF/RB1+NwIcarEPrsydLggxECFr
    13eXX7BrowT8t9QlagY9UWOvTW/WBp4iaeHChHQvEUKSLq6xPS4uarxfb/JX8cVM
    Wck7yMx+nGOfEPLyzxdaxEW3CyCpXHTmYqRsIZUQ2p/gqVueWvVCUjsI37L3rtmb
    YeS4A77LUuClcVsCn3/OqBlgsCfr3UHI1pMFbT5wd9mxJ+lpkO3vOjrgTSpypjnM
    IWSqwjb3Qf6pLukjnwb1kVYAzJEOIDrhxPtRmlG0Ar3jkIo1wmicDNNWAlpEIwFc
    rCcTJ1x1XNeKAdt7DgH8eIaCDME1H6cEvDFZCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519815749; bh=v4rEJWp3c4MqERRJuhBJnF+13BukjD4aVDVRhhNebDk=; b=T
    muKbZ5XRYXqw4FJ61UHbDH1QGWIsDTq4TrCXoGx+ip/R+Qn6SXDD02CSdHbgi1hB
    dHjJXcyxn0bjUpAACbRFP7s6X2W2fgth7WS2F03L941Lwh3BGLBl1fU6jS8ovcKx
    mnL/xRGmvMSjThLRaAIrtTjAS4otfpNPjgeLCirqRCFgFS21lpe3XafJgI5OFKIA
    LcP3UOTG802VYTWPUZ3pZvXiyARoWUJjLYWADqaQQGo77TluMAH0j9s0CQvcPREB
    wvZ9xZ22ErAaAx64CyMbmPDoT586ueL/tDS22BoZXyd8YW87QYnDLOIloYziQ4OP
    MB8/5oGw6NNoRAKpeLX9Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=RjIOHj9F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=RjIOHj9F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeB1LCN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 06:02:13 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:14970 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeB1LCM (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 28 Feb 2018 06:02:12 -0500
Subject: Re: [PATCH v3] usb: host: ehci-platform: add support for optional
 external vbus supply
To: Amelie Delaunay <amelie.delaunay@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1519393611-31367-1-git-send-email-amelie.delaunay@st.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <0d16deee-1fa9-322e-4d6d-b1b023f5b2b9@ti.com>
Date: Wed, 28 Feb 2018 13:01:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519393611-31367-1-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Amelie,

On 23/02/18 15:46, Amelie Delaunay wrote:
> On some boards, especially when vbus supply requires large current,
> and the charge pump on the PHY isn't enough, an external vbus power switch
> may be used.
> Add support for optional external vbus supply per port in ehci-platform.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> 
> ---
> Changes in v3:
>  * Address Felipe Balbi comments: reduce indentation in
>    ehci_platform_port_power.
>  * Address Roger Quadros and Alan Stern comments: platforms can have one
>    external vbus supply per port, so add support to get as many optional
>    regulator as implemented ports on the host controller.
> 
> Changes in v2:
>  * Address Roger Quadros comments: move regulator_enable/disable from
>    ehci_platform_power_on/off to ehci_platform_port_power.
> ---
>  Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
>  drivers/usb/host/ehci-platform.c                   | 52 +++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> index 3efde12..cd576db 100644
> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> @@ -19,6 +19,7 @@ Optional properties:
>   - phys : phandle + phy specifier pair
>   - phy-names : "usb"
>   - resets : phandle + reset specifier pair
> + - portN_vbus-supply : phandle of regulator supplying vbus for port N
>  
>  Example (Sequoia 440EPx):
>      ehci@e0000300 {

Sorry for not pointing this out earlier but I think patch to DT bindings
should come separately (before the driver changes) with the following subject.

"dt-bindings: usb: ehci: <subject>"


> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index b065a96..8e9f201 100644
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
> +	struct regulator **vbus_supplies;
>  	bool reset_on_resume;
>  };
>  
> @@ -56,7 +58,8 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>  	struct platform_device *pdev = to_platform_device(hcd->self.controller);
>  	struct usb_ehci_pdata *pdata = dev_get_platdata(&pdev->dev);
>  	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> -	int retval;
> +	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
> +	int portnum, n_ports, retval;
>  
>  	ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
>  
> @@ -71,11 +74,57 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>  	if (retval)
>  		return retval;
>  
> +	n_ports = HCS_N_PORTS(ehci->hcs_params);
> +	priv->vbus_supplies = devm_kcalloc(&pdev->dev, n_ports,
> +					   sizeof(struct regulator *),
> +					   GFP_KERNEL);
> +	if (!priv->vbus_supplies)
> +		return -ENOMEM;
> +
> +	for (portnum = 0; portnum < n_ports; portnum++) {
> +		struct regulator *vbus_supply;
> +		char id[20];
> +
> +		sprintf(id, "port%d_vbus", portnum);
> +
> +		vbus_supply = devm_regulator_get_optional(&pdev->dev, id);
> +		if (IS_ERR(vbus_supply)) {
> +			retval = PTR_ERR(vbus_supply);
> +			if (retval == -ENODEV)
> +				priv->vbus_supplies[portnum] = NULL;
> +			else
> +				return retval;
> +		} else {
> +			priv->vbus_supplies[portnum] = vbus_supply;
> +		}
> +	}
> +
>  	if (pdata->no_io_watchdog)
>  		ehci->need_io_watchdog = 0;
>  	return 0;
>  }
>  
> +static int ehci_platform_port_power(struct usb_hcd *hcd, int portnum,
> +				    bool enable)
> +{
> +	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
> +	int ret;
> +
> +	if (!priv->vbus_supplies[portnum])
> +		return 0;
> +
> +	if (enable)
> +		ret = regulator_enable(priv->vbus_supplies[portnum]);
> +	else
> +		ret = regulator_disable(priv->vbus_supplies[portnum]);

A newline could be used here.

> +	if (ret)
> +		dev_err(hcd->self.controller,
> +			"failed to %s vbus supply for port %d: %d\n",
> +			enable ? "enable" : "disable", portnum, ret);
> +
> +	return ret;
> +}
> +
>  static int ehci_platform_power_on(struct platform_device *dev)
>  {
>  	struct usb_hcd *hcd = platform_get_drvdata(dev);
> @@ -134,6 +183,7 @@ static struct hc_driver __read_mostly ehci_platform_hc_driver;
>  static const struct ehci_driver_overrides platform_overrides __initconst = {
>  	.reset =		ehci_platform_reset,
>  	.extra_priv_size =	sizeof(struct ehci_platform_priv),
> +	.port_power =		ehci_platform_port_power,
>  };
>  
>  static struct usb_ehci_pdata ehci_platform_defaults = {
> 

Otherwise, looks good to me. So,

Reviewed-by: Roger Quadros <rogerq@ti.com>

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
