Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1909470-1518976247-2-3750013713591623840
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518976246; b=hh8XfKqzdQRTqEZHARkwrAcaGyGZ8PG5pQPJXVvetLVJ4s3
    MkMimGUGAUFIoHkYCJWNWnfL2jFSJZSwy1qPi8lt7MJSSGPZOhO67lQyNDpEmu4S
    3zmE3/yV4jBDNbhmmJQ4Kv3AG0KpY97KZWS+u1ooMMMn5Uu4EU0pMD57XjphxOR9
    ko62HQvXQ6gYPSHQk68m7tWqr5UGPGiBl+Hjd3XD35B4zJUdHDF0kXB9c+JTNhPp
    qPmojnoNaWFxaOM46xD14BFCnaTx5jwfc4hqjdNVqPeTgSWDufgejVpUyLIuCdVy
    pT1t3TMfEN1r6TwRCZgxTI1hgtDcuYApLN95Quw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1518976246; bh=7RnetWs
    yXZMTelvrddqq8fbMBiXxTJhsDYPP4D5RKYs=; b=Ld7TKTxJY63eY/glCbLLAQo
    2P5DbCEkgAnjHoMUwJ1KMUIAo3p82exZ6M1fr+Z6FPtQIk93R3osRNjH3Pt6eIUJ
    1fIvnlkiZhY8gkWkrj90R96hLjYHl20Nlef0925iwEM/AWenM0pGw9+51Ibc7qA/
    OErq/wh11md7IlpiWR2Hf/BeNjmjy0hX0l4hHXU9E70377wDk6Nh3vu/Z12NLduY
    yAnq1XpWDm4AQ13u7fg+2zfq0m4nAwCBPdKt0ifc/bIw+ugW6CZx8gx9ou/tS+t+
    SQWT4G3KDcmji7RXhAZ67x1LjOGRaQ64LngznM3bg2T1eNQHLrG+eeVdgKLYkRw=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbeBRRud convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Sun, 18 Feb 2018 12:50:33 -0500
Received: from muru.com ([72.249.23.125]:57530 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751442AbeBRRuc (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sun, 18 Feb 2018 12:50:32 -0500
Date: Sun, 18 Feb 2018 09:50:27 -0800
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on
 Droid 4
Message-ID: <20180218175027.GW6364@atomide.com>
References: <20180217210723.7013-1-tony@atomide.com>
 <20180218003139.qiojzvfnbb5vdmrj@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180218003139.qiojzvfnbb5vdmrj@earth.universe>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Sebastian Reichel <sre@kernel.org> [180218 00:32]:
> On Sat, Feb 17, 2018 at 01:07:23PM -0800, Tony Lindgren wrote:
> > For reference here is what I measured for total power consumption on
> > an idle Droid 4 with and without USB related MDM6600 modules:
> > 
> > idle lcd off	phy-mapphone-mdm6600	ohci-platform
> > 153mW		284mW			344mW
> 
> So more than twice the idle power... We really want to get runtime
> PM working :/

Yes and we want' modem to idle too :)

> > +/*
> > + * MDM6600 status codes. These are copied from Motorola Mapphone Linux
> > + * kernel tree. The BB naming here refers to "BaseBand" for modem.
> > + */
> 
> Actually your status codes are BP_ (baseband processor) prefixed.

I'll just get rid of the naming and stick to MDM6600 prefixies.
No need to keep the confusing BP/AP prefixes.

> > +static void phy_mdm6600_init_irq(struct phy_mdm6600 *ddata)
> > +{
> > +	struct device *dev = ddata->dev;
> > +	int i, error, irq;
> > +
> > +	for (i = PHY_MDM6600_STATUS0;
> > +	     i <= PHY_MDM6600_STATUS2; i++) {
> > +		if (IS_ERR(ddata->gpio[i]))
> > +			continue;
> 
> This can be dropped, since the driver errors out of probe
> when there are gpio errors.

True will drop.

> > +static int phy_mdm6600_init_lines(struct phy_mdm6600 *ddata)
> > +{
> > +	struct device *dev = ddata->dev;
> > +	int i, j, nr_gpio = 0;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(phy_mdm6600_line_map); i++) {
> > +		const struct phy_mdm6600_map *map =
> > +			&phy_mdm6600_line_map[i];
> > +
> > +		for (j = 0; j < map->nr_gpios; j++) {
> > +			struct gpio_desc **gpio = &ddata->gpio[nr_gpio];
> > +
> > +			*gpio = devm_gpiod_get_index(dev,
> > +						     map->name, j,
> > +						     map->direction);
> > +			if (IS_ERR(*gpio)) {
> > +				dev_info(dev,
> > +					 "gpio %s error %li, already taken?\n",
> > +					 map->name, PTR_ERR(*gpio));
> > +				return PTR_ERR(*gpio);
> > +			}
> > +			nr_gpio++;
> > +		}
> 
> I think the code should use the gpiod_get_array() API.

OK thanks will take a look.

> > +	/* Give up shared GPIOs now, they will be used for OOB wake */
> > +	devm_gpiod_put(ddata->dev, mode_gpio0);
> > +	ddata->gpio[PHY_MDM6600_MODE0] = ERR_PTR(-ENODEV);
> > +	devm_gpiod_put(ddata->dev, mode_gpio1);
> > +	ddata->gpio[PHY_MDM6600_MODE0] = ERR_PTR(-ENODEV);
> 
> You want PHY_MDM6600_MODE1 instead. Also I would just use NULL.
> NULL is used by gpiod_get_optional and is handled by the gpiod
> functions, so you don't need to check for gpio errors everywhere.

Oops yup let's just drop this until we know what to do in the
further patches.

> > +#ifdef CONFIG_OF
> > +static const struct of_device_id phy_mdm6600_id_table[] = {
> > +	{ .compatible = "motorola,mapphone-mdm6600", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, phy_mdm6600_id_table);
> > +#endif
> 
> I suggest to just depend on CONFIG_OF in Kconfig and drop the ifdef
> and of_match_ptr() parts. It's very unlikely, that this will be
> used without DT and would need quite some rework anyways.

OK

> > +static int phy_mdm6600_probe(struct platform_device *pdev)
> > +{
> > +	struct phy_mdm6600 *ddata;
> > +	struct usb_otg *otg;
> > +	const struct of_device_id *of_id;
> > +	int error;
> > +
> > +	of_id = of_match_device(of_match_ptr(phy_mdm6600_id_table),
> > +				&pdev->dev);
> > +	if (!of_id)
> > +		return -EINVAL;
> 
> I suggest to drop the of_match_device(). The driver will error
> out anyways when it can't get the gpios.

OK

> Generally I'm a bit worried about handling the mode gpios in two
> different drivers. It looks like it might become a dependency hell.

Yeah you're right. That will require the modules to be loaded
in the right order. It's probably best that we handle the mdm6600
to SoC wake-up in this driver. And then maybe export a function for
toggling the SoC to mdm660 wake to make sure the dependencies are
clear for the modules.

Regards,

Tony


