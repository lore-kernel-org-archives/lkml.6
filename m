Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3423800-1519150254-2-17776593711183635245
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519150253; b=KmChGa2lJ37y65G5l7JFwzvaROzNWPQOZgDLMumUYEmAkLI
    njDJyGmDcYzwouBayLi+rucKqChfX4h52pMmc/PRxEcN5TaYNdKdIjdyP6FM2CHk
    1E3bhS5Bgtu7xab5Y5UaHyJGSGQDYgCcbAV+xvgzXG0xCpm9LxFi5DcI2bcsnpXs
    fgWVUwWBdw9lCkt4PGLfidkMFEWI4h/fgeX5yE0se38ARBfQzsNbO4bP4jelYBr6
    sc5Mu0UrN5yV1fSJtm1vBoYCvwiRqNkP0B0RQ0gjAlPZs+nGJzg8wDcobbHGckq2
    QJrgfN2UWzCnUneG7qJzuNtkOyMAXamRnsf2/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=arctest;
    t=1519150253; bh=4x0FWbBok7NjUIKPepn58F94pnruRoZJ7aO3ljdBMDE=; b=
    X1guQytHAI6J4ty+nWHcM4GBHdigfNuZnecQcYW6NsAanvlLRTzoG/dom38+uOfz
    T4Pd44EXqX3hrF4en4s47DaA01y19iwaVUSRr4vgPKc3r8D2Vtha2eKpbrK5JFD0
    Z9xBqOfSUz15vdrUonMLK5tAZZIH1/i810EMCzqcigWiAcH43Pk1plYLxHMGOjfo
    0jHEzaHuJPcT1elhCM1NX/IFOepWGdwzY3OBD1L8faz/kSo8Om0BfUfACUV5PmjK
    dkuzvjQAEpdwCVHfv5BNKoVu3wQ8I+2EqyliKYjsnEIcwToKYj4Bk6RNT/073b8p
    e6oI9SH2KaqxSKIVjtOPVA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753365AbeBTSKd (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 13:10:33 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:59790 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1752884AbeBTSKc (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Feb 2018 13:10:32 -0500
Date: Tue, 20 Feb 2018 13:10:30 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Roger Quadros <rogerq@ti.com>
cc: Amelie DELAUNAY <amelie.delaunay@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] usb: host: ehci-platform: add support for optional
 external vbus supply
In-Reply-To: <f2af8c41-f3d7-cffb-4e1e-2a12bc51c776@ti.com>
Message-ID: <Pine.LNX.4.44L0.1802201300400.1428-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 20 Feb 2018, Roger Quadros wrote:

> On 20/02/18 16:46, Amelie DELAUNAY wrote:
> > Hi,
> > 
> > On 02/20/2018 03:00 PM, Roger Quadros wrote:
> >> Hi,
> >>
> >> On 20/02/18 14:58, Amelie Delaunay wrote:
> >>> On some boards, especially when vbus supply requires large current,
> >>> and the charge pump on the PHY isn't enough, an external vbus power switch
> >>> may be used.
> >>> Add support for this optional external vbus supply in ehci-platform.
> >>>
> >>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> >>>
> >>> ---
> >>> Changes in v2:
> >>>   * Address Roger Quadros comments: move regulator_enable/disable from
> >>> ehci_platform_power_on/off to ehci_platform_port_power.
> >>> ---
> >>>   Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
> >>>   drivers/usb/host/ehci-platform.c                   | 31 ++++++++++++++++++++++
> >>>   2 files changed, 32 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> >>> index 3efde12..fc480cd 100644
> >>> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> >>> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> >>> @@ -19,6 +19,7 @@ Optional properties:
> >>>    - phys : phandle + phy specifier pair
> >>>    - phy-names : "usb"
> >>>    - resets : phandle + reset specifier pair
> >>> + - vbus-supply : phandle of regulator supplying vbus
> >>>   
> >>
> >> Can platforms have more than one regulator e.g. one regulator per port?
> >>
> > 
> > I imagine that yes, platforms could have one regulator per port.
> > Regulator consumers bindings impose a <name>-supply property per 
> > regulator, so, what do you think about :
> > vbus0-supply for port#0
> > vbus1-supply for port#1
> > ...
> > vbusN-supply for port#N
> > 
> > And then in probe, allocate 'struct regulator *vbus_supplies' with a 
> > size corresponding to 'HCS_N_PORTS(ehci->hcs_params) * sizeof(struct 
> > regulator *)'.
> > And loop to get optional regulator vbus0, vbus1,..., vbusN.
> > And then enable/disable the corresponding regulator in 
> > ehci_platform_port_power thanks to portnum.
> 
> Looks fine to me but we need to get Alan's opinion if this is worth the effort.
> If there isn't a single platform needing it we could probably do without it
> but the DT binding must be scalable to add this feature in the future.

I agree that for now there don't seem to be any platforms requiring 
more than one regulator, but this should be implemented in a way that 
could be expanded if necessary.

Anyway, the basic idea is reasonable.  I don't know to what extent 
people want to power-off their EHCI ports, but if they do then we ought 
to turn off external regulators at the same time.

Is there a real-life use case for this?

Alan Stern

> And what if it is ganged power? i.e. one regulator for more than one port.
> Probably they all can point to the same regulator instance and it should work.
> 
> > 
> >>>   Example (Sequoia 440EPx):
> >>>       ehci@e0000300 {
> >>> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> >>> index b065a96..05be100 100644
> >>> --- a/drivers/usb/host/ehci-platform.c
> >>> +++ b/drivers/usb/host/ehci-platform.c
> >>> @@ -29,6 +29,7 @@
> >>>   #include <linux/of.h>
> >>>   #include <linux/phy/phy.h>
> >>>   #include <linux/platform_device.h>
> >>> +#include <linux/regulator/consumer.h>
> >>>   #include <linux/reset.h>
> >>>   #include <linux/usb.h>
> >>>   #include <linux/usb/hcd.h>
> >>> @@ -46,6 +47,7 @@ struct ehci_platform_priv {
> >>>   	struct reset_control *rsts;
> >>>   	struct phy **phys;
> >>>   	int num_phys;
> >>> +	struct regulator *vbus_supply;
> >>>   	bool reset_on_resume;
> >>>   };
> >>>   
> >>> @@ -76,6 +78,25 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
> >>>   	return 0;
> >>>   }
> >>>   
> >>> +static int ehci_platform_port_power(struct usb_hcd *hcd, int portnum,
> >>> +				    bool enable)
> >>> +{
> >>> +	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
> >>> +	int ret = 0;
> >>> +
> >>> +	if (priv->vbus_supply) {
> >>> +		if (enable)
> >>> +			ret = regulator_enable(priv->vbus_supply);
> >>> +		else
> >>> +			ret = regulator_disable(priv->vbus_supply);
> >>> +		if (ret)
> >>> +			dev_err(hcd->self.controller,
> >>> +				"failed to %s vbus supply: %d\n",
> >>> +				enable ? "enable" : "disable", ret);
> >>> +	}
> >>> +	return ret;
> >>> +}
> >>> +
> >>>   static int ehci_platform_power_on(struct platform_device *dev)
> >>>   {
> >>>   	struct usb_hcd *hcd = platform_get_drvdata(dev);
> >>> @@ -134,6 +155,7 @@ static struct hc_driver __read_mostly ehci_platform_hc_driver;
> >>>   static const struct ehci_driver_overrides platform_overrides __initconst = {
> >>>   	.reset =		ehci_platform_reset,
> >>>   	.extra_priv_size =	sizeof(struct ehci_platform_priv),
> >>> +	.port_power =		ehci_platform_port_power,
> >>>   };
> >>>   
> >>>   static struct usb_ehci_pdata ehci_platform_defaults = {
> >>> @@ -247,6 +269,15 @@ static int ehci_platform_probe(struct platform_device *dev)
> >>>   	if (err)
> >>>   		goto err_put_clks;
> >>>   
> >>> +	priv->vbus_supply = devm_regulator_get_optional(&dev->dev, "vbus");
> >>> +	if (IS_ERR(priv->vbus_supply)) {
> >>> +		err = PTR_ERR(priv->vbus_supply);
> >>> +		if (err == -ENODEV)
> >>> +			priv->vbus_supply = NULL;
> >>> +		else
> >>> +			goto err_reset;
> >>> +	}
> >>> +
> >>>   	if (pdata->big_endian_desc)
> >>>   		ehci->big_endian_desc = 1;
> >>>   	if (pdata->big_endian_mmio)
> >>>
> 
> 



