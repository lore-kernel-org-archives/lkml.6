Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D526C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5493120857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH5AvDWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfA2Rkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:40:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35974 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfA2Rkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:40:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so23065577wrp.3;
        Tue, 29 Jan 2019 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a9UtoGUQKlY/gT+vSqEK4vURGkaTw9DdjHjytMOhuvQ=;
        b=TH5AvDWVbSOXkl7TKFV4LRsLhIrKZvhQ3B2WVD47lhHYC5TjIONxd1lXKpuPtRXRe5
         CoRK0Iaq6QZXVtlDRLr41RE9Q3Ja/8+Dbs8ejgSHH7Ho8+mN/sKmV4Tl4P6729lBt2IV
         VvOS3vaPBB48VRHOgtntEAX33r1FKhRRjZhuSo2breEeZurmY/D2+U02ieqzK3Qon08s
         vbMN/O4qz50tqnlsFXpNgYNWQRidVIPH3Lt99Sq/I1vGJqSibQV4qB/ENExwv0YOnc4p
         9HEwmRhyGHowMnJGgwGVYO5hA6/kTfyO5fePR4B7mi8IFYMwoje0fbfP59Ba0aEYoZ0d
         MKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a9UtoGUQKlY/gT+vSqEK4vURGkaTw9DdjHjytMOhuvQ=;
        b=OJN+4hCzK4oTZeJ7t7Qb7OWbDjSkRYU0bWIy9Ab9SeQ0B3d+8VeQ15Noj8DTKKO/dT
         AtsPTMa1QZw8/GiJkFPYdWVMLd/W+WlsiT6pmnHplmyzcT+v9B1294uchzALysFx6U6K
         D0KdEKEJKPkagiPjQSfa0orXX5oP5YbqfeIUj+o0hQgKdU26so0UKbsXvy0qjxQNVeX1
         yKn4BCYr8C0lHu5evOrv24mH7tHmew/+ZMyiRvCCs7UVh1YOv/n/UzM+CCRyfLLVBOab
         IRlpQ9290FvPoxes1SmD26OtAVE3WkPV8h1U4XJ97S5b9LSb/DiKzIGoyen7LO19RS6Q
         T9FQ==
X-Gm-Message-State: AJcUukedqmuPEqCSw04pdd+b8P0X7p16XkcfZsIORXPGfGllQ8SxXeak
        ajfdb4F8uONPli5h9NdfeGc=
X-Google-Smtp-Source: ALg8bN7GlpW8hqsJ+JRHEPFDap1u/Fdv5wUabXsh4P/MlFh8mL3SbmfGjpNZhb0amFqfhXG6P6krjQ==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr25698677wrh.317.1548783637469;
        Tue, 29 Jan 2019 09:40:37 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id a12sm105652318wrm.45.2019.01.29.09.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 09:40:36 -0800 (PST)
Date:   Tue, 29 Jan 2019 18:40:35 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8169: Load MAC address from device tree if present
Message-ID: <20190129174035.GA25929@ulmo>
References: <20190125101814.6262-1-thierry.reding@gmail.com>
 <59aa73fd-9cdc-8db8-b58e-ed106b084637@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <59aa73fd-9cdc-8db8-b58e-ed106b084637@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 07:34:31PM +0100, Heiner Kallweit wrote:
> On 25.01.2019 11:18, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > If the system was booted using a device tree and if the device tree
> > contains a MAC address, use it instead of reading one from the EEPROM.
> > This is useful in situations where the EEPROM isn't properly programmed
> > or where the firmware wants to override the existing MAC address.
> >=20
> I rarely see DT-configured boards with RTL8168 network. Do you add this
> patch because of a specific board?
> And you state "if EEPROM isn't properly programmed": Did you come across
> such a case?

We use these Realtek chips on some of our boards that customers can
either purchase individually and integrate into their own designs or
they can get the module as part of a product.

In order to easily allow customers to reprogram the device (they may
want to do that if integrating the module into their own products), a
so-called ID EEPROM is part of the module that stores various bits of
information. The ethernet MAC address is part of that EEPROM.

Typically the ID EEPROM will contain a valid MAC address if the module
is part of a product, but if customers purchase the module individually,
it is expected that they use a MAC address from their own pool.

Typically early boot firmware will load the MAC address from the EEPROM
and store it in the ethernet device's device tree node so that the MAC
address programmed into the ID EEPROM will be used by the ethernet
device at runtime.

> In general the patch is fine with me, I just want to understand the
> motivation. One further comment see inline.
> As of today we already have the option to set a MAC from userspace
> via ethtool.
>=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Based on net-next.
> >=20
> >  drivers/net/ethernet/realtek/r8169.c | 35 +++++++++++++++++-----------
> >  1 file changed, 22 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/etherne=
t/realtek/r8169.c
> > index f574b6b557f9..fd9edd643ca5 100644
> > --- a/drivers/net/ethernet/realtek/r8169.c
> > +++ b/drivers/net/ethernet/realtek/r8169.c
> > @@ -6957,6 +6957,21 @@ static int rtl_alloc_irq(struct rtl8169_private =
*tp)
> >  	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
> >  }
> > =20
> [...]
> > @@ -7252,20 +7268,13 @@ static int rtl_init_one(struct pci_dev *pdev, c=
onst struct pci_device_id *ent)
> >  	u64_stats_init(&tp->rx_stats.syncp);
> >  	u64_stats_init(&tp->tx_stats.syncp);
> > =20
> > -	/* Get MAC address */
> > -	switch (tp->mac_version) {
> > -		u8 mac_addr[ETH_ALEN] __aligned(4);
> > -	case RTL_GIGA_MAC_VER_35 ... RTL_GIGA_MAC_VER_38:
> > -	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
> > -		*(u32 *)&mac_addr[0] =3D rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
> > -		*(u16 *)&mac_addr[4] =3D rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
> > +	/* get MAC address */
> > +	if (eth_platform_get_mac_address(&pdev->dev, mac_addr))
> > +		rtl_read_mac_address(tp, mac_addr);
> > +
> > +	if (is_valid_ether_addr(mac_addr))
>=20
> Here array mac_addr may be uninitialized (if platform defines no MAC
> and chip version is not covered by the switch statement).

Good point. I can memset() mac_addr to make sure it is invalid, rather
than undefined, for chip versions that are not covered.

Thierry

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxQkBAACgkQ3SOs138+
s6GvkQ/7BEyMdMJpuYhqNU7g/U6ExGOPKKa+OJJoECaCreF4Wyg9i3rWiaY2ST7q
1Py9vinh+EjEF/uMpkCCLTBB6UbA92aqWcI7d27GA+VV88yEWaQxHcty0/j5k2dX
w7Bcip/Z/Tmul63WdFsdPrQmNvrrXV4NU51uXRlGj8zRK6GXobmZGzroH4rEXa+b
3hvD1mT6htpGtGqet4VryDFW4+COVuMOycT4ABF/5vyn9g/Pe9C/9j+rPC7LXowR
spVeLudHgIApYmdASpIBv73LiOZpVEpmgIOqhDNNvyeu1HMh+yU5fLRGTFKnMZ9B
wvcjTaESNtX6yoEFi9a/HxdwGrUMqAbLtJ4s2CiNo7R4AvjM1JOweKP4QtTtRwIj
LYO0UaOTQHhkpi4+kTitPZj5RCbei3PS/WQ7hZX34rcaM0xkYapm3mpxhhPUPnnq
j7OHGMKvQFEHhkjI1a4icY8IRIURTRHWNgBfBg/r1ZKG4eO4eoF490bs5qDN/an5
uRKBUVcENhYN270gD0tcnoL7HPmqNkIFjpr3PiVyXrrGBsV80avdhTFpwqQMoLCE
1Tx78ezmmjlL9df07n8bixLhVeR2yneyo5FK4C+rtO9BQihvSZOxndoVQmnODoFC
krw0pnPN2ReR2BKIj9Vhq3FgqT7DPiPSLn9B9N+wfJn7lF92Gh4=
=OR3H
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
