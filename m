Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05DFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968162190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390629AbfBOP5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:57:37 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:52779 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389818AbfBOP5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:57:36 -0500
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E04AA24001A;
        Fri, 15 Feb 2019 15:57:32 +0000 (UTC)
Date:   Fri, 15 Feb 2019 16:57:32 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS" 
        <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/8] leds: Add support for AXP20X CHGLED
Message-ID: <20190215155732.nmtshldcjk2qyhx4@flea>
References: <20190215115013.11098-1-stefan@olimex.com>
 <20190215115013.11098-2-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s6rnltusscnwmgci"
Content-Disposition: inline
In-Reply-To: <20190215115013.11098-2-stefan@olimex.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s6rnltusscnwmgci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

Thanks for working on this.

On Fri, Feb 15, 2019 at 01:50:06PM +0200, Stefan Mavrodiev wrote:
> +static ssize_t control_show(struct device *dev, struct device_attribute =
*attr,
> +			    char *buf)
> +{
> +	struct led_classdev *cdev =3D dev_get_drvdata(dev);
> +	struct axp20x_led *priv =3D to_axp20x_led(cdev);
> +
> +	return sprintf(buf, "%u\n", priv->ctrl);
> +}
> +
> +static ssize_t control_store(struct device *dev, struct device_attribute=
 *attr,
> +			     const char *buf, size_t size)
> +{
> +	struct led_classdev *cdev =3D dev_get_drvdata(dev);
> +	struct axp20x_led *priv =3D to_axp20x_led(cdev);
> +	unsigned long val;
> +	int ret;
> +
> +	ret =3D kstrtoul(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	/**
> +	 * Supported values are:
> +	 *   - 0 : Manual control
> +	 *   - 1 : Charger control
> +	 */
> +	if (val > 1)
> +		return -EINVAL;
> +
> +	priv->ctrl =3D val;
> +
> +	return axp20x_led_setup(priv) ? : size;
> +}
> +static DEVICE_ATTR_RW(control);
> +
> +static ssize_t mode_show(struct device *dev, struct device_attribute *at=
tr,
> +			 char *buf)
> +{
> +	struct led_classdev *cdev =3D dev_get_drvdata(dev);
> +	struct axp20x_led *priv =3D to_axp20x_led(cdev);
> +
> +	return sprintf(buf, "%u\n", priv->mode);
> +}
> +
> +static ssize_t mode_store(struct device *dev, struct device_attribute *a=
ttr,
> +			  const char *buf, size_t size)
> +{
> +	struct led_classdev *cdev =3D dev_get_drvdata(dev);
> +	struct axp20x_led *priv =3D to_axp20x_led(cdev);
> +	unsigned long val;
> +	int ret;
> +
> +	ret =3D kstrtoul(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +	/**
> +	 * Supported values are:
> +	 *   - 0 : Mode A
> +	 *   - 1 : Mode B
> +	 */
> +	if (val > 1)
> +		return -EINVAL;
> +
> +	priv->mode =3D val;
> +
> +	return axp20x_led_setup(priv) ? : size;
> +}
> +static DEVICE_ATTR_RW(mode);
> +
> +static struct attribute *axp20x_led_attrs[] =3D {
> +	&dev_attr_control.attr,
> +	&dev_attr_mode.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(axp20x_led);

I can't really say whether adding sysfs handles for this is the right
thing to do, but if it is you should document the interface.

> +	if (!of_property_read_u8(np, "x-powers,charger-mode", &value)) {
> +		priv->ctrl =3D AXP20X_CHGLED_CTRL_CHARGER;
> +		priv->mode =3D (value < 2) ? value : 0;
> +	} else {
> +		priv->ctrl =3D AXP20X_CHGLED_CTRL_MANUAL;
> +	}

I'm not sure we want to make this a property of the device
tree. Changing the device tree isn't an option for some users, so we
need to make sure we can change it even if we can't change the device
tree.

A kernel module is one option, but the other reviewers might have some
alternatives.

> +	str =3D of_get_property(np, "default-state", NULL);
> +	if (str) {
> +		if (!strcmp(str, "keep")) {
> +			ret =3D axp20x_led_brightness_get(&priv->cdev);
> +			if (ret < 0)
> +				return ret;
> +			priv->cdev.brightness =3D ret;
> +		} else if (!strcmp(str, "on")) {
> +			ret =3D axp20x_led_brightness_set_blocking(&priv->cdev,
> +								 LED_FULL);
> +		} else  {
> +			ret =3D axp20x_led_brightness_set_blocking(&priv->cdev,
> +								 LED_OFF);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id axp20x_led_of_match[] =3D {
> +	{ .compatible =3D "x-powers,axp20x-led" },

Having a wildcard in the compatible isn't great, since it doesn't
really allow you to identify which part it is you're actually using,
and that wildcard might become inconsistent at some point.

You'd better use axp209-led (but the name of the driver is fine).

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, axp20x_led_of_match);
> +
> +static int axp20x_led_probe(struct platform_device *pdev)
> +{
> +	struct axp20x_led *priv;
> +	int ret;
> +
> +	if (!of_device_is_available(pdev->dev.of_node))
> +		return -ENODEV;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(struct axp20x_led),
> +			    GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->axp20x =3D dev_get_drvdata(pdev->dev.parent);
> +	if (!priv->axp20x) {
> +		dev_err(&pdev->dev, "Failed to get parent data\n");
> +		return -ENXIO;
> +	}
> +
> +	mutex_init(&priv->lock);
> +
> +	priv->cdev.brightness_set_blocking =3D axp20x_led_brightness_set_blocki=
ng;
> +	priv->cdev.brightness_get =3D axp20x_led_brightness_get;
> +	priv->cdev.groups =3D axp20x_led_groups;
> +
> +	ret =3D axp20x_led_parse_dt(priv, pdev->dev.of_node);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to set parameters\n");
> +		return ret;
> +	}
> +
> +	/**
> +	 * For some reason in AXP209 the bit that controls CHGLED is with
> +	 * inverted logic compared to all other PMICs.
> +	 * If the PMIC is actually AXP209, set inverted flag and later use it
> +	 * when configuring the LED.
> +	 */
> +	if (priv->axp20x->variant =3D=3D AXP209_ID)
> +		priv->ctrl_inverted =3D 1;

This should be matched on the compatible.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--s6rnltusscnwmgci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGbhbAAKCRDj7w1vZxhR
xf8nAQCoVhXm4+oiKNXqfXQdtlEZLP44Z8I8IyLvwk7LkJ8aXAD+PiQA1alhYoiN
+cq1w6+gSml19dmkaPFhyqKP3BGZ7w8=
=fl9M
-----END PGP SIGNATURE-----

--s6rnltusscnwmgci--
