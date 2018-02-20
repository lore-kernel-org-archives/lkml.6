Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3282151-1519144489-2-14650277236500823389
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
    t=1519144489; b=FVBBhnLxd5izohkQvJcQBgzToB/4tPXJx9KM5qSAPn1buJL
    kjXq1rtEunmeIgMHpE8CINQJPJG72baH4BmmpZNY+YFfsUVB06JUh2dktyejb7ZQ
    P611O7ven/sNuEwLna3T0Sya0/NJl2SElu1Au+QqpUyPqMHJRjSRWu3BzDl6ostB
    fffqvNlqeZslWNETwJZ+LqShmuSW6WwYyFFg7eMQGeSe4S8Lk/Dm3Rkuy6i57VZf
    cVXjx4byqgJomGwH0/4w64IA3vW0mXFZ2yNsjz2Z983+XioUrg3KKPvHp60pLM5f
    BV3yEHBb0wH3YOuKmaBCu/njMFzi3Uc0MRNm6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519144489; bh=EeaQ1YjlXRbO2NWb5l/qleNelz7rrtBRYku97LYTIgU=; b=C
    1eZysmKgDG83g+ryl7j/CN5KJpi6R84e2niAbEH9mP3q1tL/4EAgJe+iLbWKF6Ak
    V5MzkCul/FW5oj+06PKxkdPHjuap2w+XCaLx3JbA3QiW/nFR6ktI0cPrVAg4YAUs
    eikHOPW+tvrgfj3zoXcHcE1wg3KmUwmawE9weVElVHLBVwGTK3Pnnaihc7Tjy/bL
    F53r0HiM/SBwU/0ksHN/ml4KJTyQSGf51LVj4cqu64IHFXc+U+cgSug89qO1Pef3
    EojD7XivFOzd4GluVK44HyuzM8UpOIJzVMC2Itpkdq73C02tp+NP0vqdBPQ3gZlg
    t3RX0ztugXx4jTVLnbtDA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=kJXpRSlw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=kJXpRSlw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeBTQe0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 11:34:26 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:16516 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbeBTQeX (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Feb 2018 11:34:23 -0500
Subject: Re: [PATCH v2] usb: host: ehci-platform: add support for optional
 external vbus supply
To: Amelie DELAUNAY <amelie.delaunay@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern <stern@rowland.harvard.edu>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <1519131492-27913-1-git-send-email-amelie.delaunay@st.com>
 <bfaa3001-d90f-7903-17e8-90af9a03c338@ti.com>
 <2ef38200-947c-1419-1c91-f033da390f74@st.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <f2af8c41-f3d7-cffb-4e1e-2a12bc51c776@ti.com>
Date: Tue, 20 Feb 2018 18:33:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2ef38200-947c-1419-1c91-f033da390f74@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20/02/18 16:46, Amelie DELAUNAY wrote:
> Hi,
> 
> On 02/20/2018 03:00 PM, Roger Quadros wrote:
>> Hi,
>>
>> On 20/02/18 14:58, Amelie Delaunay wrote:
>>> On some boards, especially when vbus supply requires large current,
>>> and the charge pump on the PHY isn't enough, an external vbus power switch
>>> may be used.
>>> Add support for this optional external vbus supply in ehci-platform.
>>>
>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>>>
>>> ---
>>> Changes in v2:
>>>   * Address Roger Quadros comments: move regulator_enable/disable from
>>> ehci_platform_power_on/off to ehci_platform_port_power.
>>> ---
>>>   Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
>>>   drivers/usb/host/ehci-platform.c                   | 31 ++++++++++++++++++++++
>>>   2 files changed, 32 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>>> index 3efde12..fc480cd 100644
>>> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
>>> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>>> @@ -19,6 +19,7 @@ Optional properties:
>>>    - phys : phandle + phy specifier pair
>>>    - phy-names : "usb"
>>>    - resets : phandle + reset specifier pair
>>> + - vbus-supply : phandle of regulator supplying vbus
>>>   
>>
>> Can platforms have more than one regulator e.g. one regulator per port?
>>
> 
> I imagine that yes, platforms could have one regulator per port.
> Regulator consumers bindings impose a <name>-supply property per 
> regulator, so, what do you think about :
> vbus0-supply for port#0
> vbus1-supply for port#1
> ...
> vbusN-supply for port#N
> 
> And then in probe, allocate 'struct regulator *vbus_supplies' with a 
> size corresponding to 'HCS_N_PORTS(ehci->hcs_params) * sizeof(struct 
> regulator *)'.
> And loop to get optional regulator vbus0, vbus1,..., vbusN.
> And then enable/disable the corresponding regulator in 
> ehci_platform_port_power thanks to portnum.

Looks fine to me but we need to get Alan's opinion if this is worth the effort.
If there isn't a single platform needing it we could probably do without it
but the DT binding must be scalable to add this feature in the future.

And what if it is ganged power? i.e. one regulator for more than one port.
Probably they all can point to the same regulator instance and it should work.

> 
>>>   Example (Sequoia 440EPx):
>>>       ehci@e0000300 {
>>> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
>>> index b065a96..05be100 100644
>>> --- a/drivers/usb/host/ehci-platform.c
>>> +++ b/drivers/usb/host/ehci-platform.c
>>> @@ -29,6 +29,7 @@
>>>   #include <linux/of.h>
>>>   #include <linux/phy/phy.h>
>>>   #include <linux/platform_device.h>
>>> +#include <linux/regulator/consumer.h>
>>>   #include <linux/reset.h>
>>>   #include <linux/usb.h>
>>>   #include <linux/usb/hcd.h>
>>> @@ -46,6 +47,7 @@ struct ehci_platform_priv {
>>>   	struct reset_control *rsts;
>>>   	struct phy **phys;
>>>   	int num_phys;
>>> +	struct regulator *vbus_supply;
>>>   	bool reset_on_resume;
>>>   };
>>>   
>>> @@ -76,6 +78,25 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>>>   	return 0;
>>>   }
>>>   
>>> +static int ehci_platform_port_power(struct usb_hcd *hcd, int portnum,
>>> +				    bool enable)
>>> +{
>>> +	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
>>> +	int ret = 0;
>>> +
>>> +	if (priv->vbus_supply) {
>>> +		if (enable)
>>> +			ret = regulator_enable(priv->vbus_supply);
>>> +		else
>>> +			ret = regulator_disable(priv->vbus_supply);
>>> +		if (ret)
>>> +			dev_err(hcd->self.controller,
>>> +				"failed to %s vbus supply: %d\n",
>>> +				enable ? "enable" : "disable", ret);
>>> +	}
>>> +	return ret;
>>> +}
>>> +
>>>   static int ehci_platform_power_on(struct platform_device *dev)
>>>   {
>>>   	struct usb_hcd *hcd = platform_get_drvdata(dev);
>>> @@ -134,6 +155,7 @@ static struct hc_driver __read_mostly ehci_platform_hc_driver;
>>>   static const struct ehci_driver_overrides platform_overrides __initconst = {
>>>   	.reset =		ehci_platform_reset,
>>>   	.extra_priv_size =	sizeof(struct ehci_platform_priv),
>>> +	.port_power =		ehci_platform_port_power,
>>>   };
>>>   
>>>   static struct usb_ehci_pdata ehci_platform_defaults = {
>>> @@ -247,6 +269,15 @@ static int ehci_platform_probe(struct platform_device *dev)
>>>   	if (err)
>>>   		goto err_put_clks;
>>>   
>>> +	priv->vbus_supply = devm_regulator_get_optional(&dev->dev, "vbus");
>>> +	if (IS_ERR(priv->vbus_supply)) {
>>> +		err = PTR_ERR(priv->vbus_supply);
>>> +		if (err == -ENODEV)
>>> +			priv->vbus_supply = NULL;
>>> +		else
>>> +			goto err_reset;
>>> +	}
>>> +
>>>   	if (pdata->big_endian_desc)
>>>   		ehci->big_endian_desc = 1;
>>>   	if (pdata->big_endian_mmio)
>>>

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
