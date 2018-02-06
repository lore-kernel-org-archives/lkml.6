Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1507316-1517932252-2-11553392794703661294
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  UNPARSEABLE_RELAY 0.001, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517932251; b=BIRWkDweD+joQ0L0artbh337DP3WVtETCtoiMVfymgXbTbp
    nDvbXJvm1ti9ZESnh/VkHmORHxzt9bUpKhvmLv4hT7Nyw8vRy7Gspcn3bTXfNwx2
    Fg671fV1nzQEgA8kxx8pb37MfxwMEDnRsGc1DU5/F25lCtJ9VdndD6pd+1OAV++a
    90e1nMGyasoWygTARg7UDBB39kSIv5Ugl+eYaiMLfM9G/yqxo+rsa9dHqz4H0cB6
    DL7XPAxPz9y1NuVVJQuQ+4cc7UW3Zt8CIlf4+Imb5WrZsceOWHjp3Bf72nczG0lk
    BT2tRqqiOVA36QBRWjapgcgzGDJJtD1mHVczhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517932251; bh=fnUanQL7+oLIwfiMm2mlxbCaL+
    YB7qFIvIHfAAJ/Iwc=; b=Nmcgrla7tbpMojgP5V5DSqODpIyQimRmj5l05zbTQ5
    r4RNR39RHweeta/t5NGiOx9fVV8VwH09rd5IHSItvS50AmuUhlFJhmN1xFLVTCv1
    IziaDPAgtDoLMek7oEgJPY1S+s3mxbSxDl76mq4HcCGNooT3Vg8iR3p1c2E/kGkq
    IW0PYbL8zq52AwjVbXkwlE4weGPQLunmvKh3V3koYy+p0DOnf7lZU8hW8HqcpRPc
    GmmGC3iM6Bm1A+2MCsxP4mJ54hlayPqPBBLbyn0DzC4zi41VPJJ45xItn15Mvg0z
    kQuc9hn9eFu/f1zVFWZ4OWyubhXWZUG2kJ9XrdovWceg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=collabora.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=collabora.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeBFPuq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 10:50:46 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34886 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbeBFPup (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Feb 2018 10:50:45 -0500
Date: Tue, 6 Feb 2018 16:50:41 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ian Ray <ian.ray@ge.com>, Nandor Han <nandor.han@ge.com>,
        Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>,
        kernel@lists.collabora.co.uk
Subject: Re: [PATCH 2/2] usb: chipidea: imx: Fix ULPI on imx53
Message-ID: <20180206155041.objiu5j5kftmzp4q@earth.universe>
References: <20180124171439.10721-1-sebastian.reichel@collabora.co.uk>
 <20180124171439.10721-2-sebastian.reichel@collabora.co.uk>
 <20180129033315.GA20311@b29397-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f37pcu7qnjouqver"
Content-Disposition: inline
In-Reply-To: <20180129033315.GA20311@b29397-desktop>
User-Agent: NeoMutt/20171215
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--f37pcu7qnjouqver
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Mon, Jan 29, 2018 at 11:33:15AM +0800, Peter Chen wrote:
> On Wed, Jan 24, 2018 at 06:14:39PM +0100, Sebastian Reichel wrote:
> > Traditionally, PORTSC should be set before initializing ULPI phys. But
> > setting PORTSC before powering on the phy results in a kernel freeze
> > on imx53 based GE PPD. As a workaround this initializes the phy early
> > in the imx platform code and disables phy power management from the
> > core.
> >=20
> > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  drivers/usb/chipidea/ci_hdrc_imx.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/=
ci_hdrc_imx.c
> > index de155c80eb70..e431c5aafe35 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> > @@ -83,6 +83,7 @@ struct ci_hdrc_imx_data {
> >  	struct clk *clk;
> >  	struct imx_usbmisc_data *usbmisc_data;
> >  	bool supports_runtime_pm;
> > +	bool override_phy_control;
> >  	bool in_lpm;
> >  	/* SoC before i.mx6 (except imx23/imx28) needs three clks */
> >  	bool need_three_clks;
> > @@ -254,6 +255,7 @@ static int ci_hdrc_imx_probe(struct platform_device=
 *pdev)
> >  	int ret;
> >  	const struct of_device_id *of_id;
> >  	const struct ci_hdrc_imx_platform_flag *imx_platform_flag;
> > +	struct device_node *np =3D pdev->dev.of_node;
> > =20
> >  	of_id =3D of_match_device(ci_hdrc_imx_dt_ids, &pdev->dev);
> >  	if (!of_id)
> > @@ -288,6 +290,14 @@ static int ci_hdrc_imx_probe(struct platform_devic=
e *pdev)
> >  	}
> > =20
> >  	pdata.usb_phy =3D data->phy;
> > +
> > +	if (of_device_is_compatible(np, "fsl,imx53-usb") && pdata.usb_phy &&
> > +	    of_usb_get_phy_mode(np) =3D=3D USBPHY_INTERFACE_MODE_ULPI) {
> > +		pdata.flags |=3D CI_HDRC_OVERRIDE_PHY_CONTROL;
> > +		data->override_phy_control =3D true;
> > +		usb_phy_init(pdata.usb_phy);
> > +	}
> > +
> >  	pdata.flags |=3D imx_platform_flag->flags;
> >  	if (pdata.flags & CI_HDRC_SUPPORTS_RUNTIME_PM)
> >  		data->supports_runtime_pm =3D true;
> > @@ -341,6 +351,8 @@ static int ci_hdrc_imx_remove(struct platform_devic=
e *pdev)
> >  		pm_runtime_put_noidle(&pdev->dev);
> >  	}
> >  	ci_hdrc_remove_device(data->ci_pdev);
> > +	if (data->override_phy_control)
> > +		usb_phy_shutdown(data->phy);
> >  	imx_disable_unprepare_clks(&pdev->dev);
> > =20
>=20
> Sebastian, I have a question, do you have any USB or generic PHY drivers
> for ULPI bus, any power controls are needed for your ULPI peripheral?

The devicetree for GE PPD is available in the mainline kernel:

$ grep -A9 "usbphy[23] {" arch/arm/boot/dts/imx53-ppd.dts
	usbphy2: usbphy2 {
		compatible =3D "usb-nop-xceiv";
		reset-gpios =3D <&gpio4 4 GPIO_ACTIVE_LOW>;
		clock-names =3D "main_clk";
		clock-frequency =3D <24000000>;
		clocks =3D <&clks IMX5_CLK_CKO2>;
		assigned-clocks =3D <&clks IMX5_CLK_CKO2_SEL>, <&clks IMX5_CLK_OSC>;
		assigned-clock-parents =3D <&clks IMX5_CLK_OSC>;
	};

	usbphy3: usbphy3 {
		compatible =3D "usb-nop-xceiv";
		reset-gpios =3D <&gpio2 19 GPIO_ACTIVE_LOW>;
		clock-names =3D "main_clk";

		clock-frequency =3D <24000000>;
		clocks =3D <&clks IMX5_CLK_CKO2>;
		assigned-clocks =3D <&clks IMX5_CLK_CKO2_SEL>, <&clks IMX5_CLK_OSC>;
		assigned-clock-parents =3D <&clks IMX5_CLK_OSC>;
	};

So currently the machine only uses drivers/usb/phy/phy-generic.c. Both
USB phys are actually SMSC USB3315, which is also detected by the kernel:

root@csmon :~# cat /sys/bus/ulpi/devices/ci_hdrc.*.ulpi/uevent=20
DEVTYPE=3Dulpi_device
MODALIAS=3Dulpi:v0424p0006
DEVTYPE=3Dulpi_device
MODALIAS=3Dulpi:v0424p0006

So maybe drivers/usb/phy/phy-ulpi.c should be used, but I don't see
a simple way to do so and using the generic PHY works.

-- Sebastian

--f37pcu7qnjouqver
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp5zssACgkQ2O7X88g7
+poeZBAAlVAXdTP0z0WIjJnmEnZWUWtIeZb6riM2k5aDYjtPjEs5Uwm0qk6V7dS6
0RCXES8Fphb+t0CcAue4r6KMaJducfjhaLC4j5rpVFw2I9+yf1VkPn7UfFyCncr9
9sLzSbX/z0Sn6MJATUi904PA5oeDn+bOj8SzpYq0gOFhO7VVoUKF6tu9uYA+StiQ
BDWmyHN//3G6BexmJFhfY5NGu9UUH1Fn9+QEiHX2SNrmAvYQzRZEp//9nNFLLaHm
NTKzxiC0GN5MRwNj3Wib5zJKMCrA2ZzRhWv4rFqLnNAPZ9s9AviPn5uXUebnjWMp
22whjlGJJg8bzxO1lFAoNQiXpurQk3PwqaT+EWE7DQ3XXkof+saY/bL0ARlrE9Z/
WH3tTIMzl9eLjDCDNsAcAlA/+lg2ok9UsU38tmqHe4tBMhQCAQmZaA/vDGtNxpO9
hdlCBAwCZouJkXv6yHkx/bfpR1YmvPjOk4n8JwcAhU0L3EYPx7q/UTJyCX0ao1+K
5COirzoBQV7SS2YUz3Qq8XZVXedb4ozgfC1SznOnIIMa+8OiWslvm3P/rkbs/7Ju
K8nA07COCFm/YBWGYQ6w4njVC3WEdDEoZk8SawX3ERtTvPZiH/qSer590JHp01mB
qtmSfHAYnxpF6yTEAE9hqleR2Lm8fjOdVABbKV5WA1HX4fk8Jv4=
=l+Js
-----END PGP SIGNATURE-----

--f37pcu7qnjouqver--
