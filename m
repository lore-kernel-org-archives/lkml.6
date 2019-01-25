Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86C1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B34218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW/FZfVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfAYPdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:33:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55388 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfAYPdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:33:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so7099783wmc.5;
        Fri, 25 Jan 2019 07:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h3VBD3AyS3XUCFvZP1JqLnQZHYTESsfjg1Vt0LYAF2A=;
        b=HW/FZfVFJ7O8sHfPCbVYTzCPrpQCrLACLj29ds8qRNZdlLcdqiiFBL8WNA/rjoTPGT
         18yCscv6tQwFB93MUM+ZYMauIxmDBCQuuvHVz+kbHcLWAsM97iSFnnwcbK/0T/eBUQ0U
         MqDhdrTlSbnGPG3EsA6WVcEUyKzyxLoChf5A1GqJSJlaxCkjKlrElN0qtNKmeFOa5zCs
         I9iXaYIgIq4aIkNmji0rcQyZIHcOdOnamp+lwZKdTa3ueYUUz/5YFcU/HozwnXCrhpRv
         d8dBIWlms/Z2Zvnks1RSiq36guSl5GTZxqLz6s2h7Uaedzgpv7sfyff2hKNRqQO3qaSd
         TCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h3VBD3AyS3XUCFvZP1JqLnQZHYTESsfjg1Vt0LYAF2A=;
        b=l72RKz39Mcg8gQJIgIOy4k5ONDCy4T9CZexwOxX5WBUXwk8g0ByzWYVBAi6iRZtygr
         L5nbNCrX89XQsjmCFz36h+wFYgWlbmk4asl06Wr5MKbW8d5M4krAmKQP221ljuTWtdom
         y9XJDUIgtjMIhlVLjSTCjpPM9BsQof4FeBYXaRjSyXJqZMI9GpYQ7aJ6iPhnKhSxm8pE
         hdHhjdqZISYtj45IodDD6PE+aVdK72nnlGgviLOSGTy5GyhXtwm/DgfA7uLkDR0SU0J9
         BMWxtyIfj2EQuWQBum5zporLZ5tYzksiWTuJjtEBysvk+GKZAp8X3cpak9iMBpOhENMp
         jrGA==
X-Gm-Message-State: AJcUukdLR7EFGa1PhKD6EbTT3mKfAfzLBn1Kfyy8HdiE5S3eRb7yp1q4
        iDuyC7YA7VPm2rxSmmKCWFnT7GX1qyU=
X-Google-Smtp-Source: ALg8bN6wT0l03jFtghwc0ivrt/e/c0dXUjusC5YQFZbhaSAUBnJmetvT3qLQx6+6LeSFidDNTzkRoA==
X-Received: by 2002:a1c:5984:: with SMTP id n126mr7062143wmb.62.1548430392495;
        Fri, 25 Jan 2019 07:33:12 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id p12sm65357093wmi.5.2019.01.25.07.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 07:33:11 -0800 (PST)
Date:   Fri, 25 Jan 2019 16:33:10 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8169: Load MAC address from device tree if present
Message-ID: <20190125153310.GA30990@ulmo>
References: <20190125101814.6262-1-thierry.reding@gmail.com>
 <20190125145711.GF12962@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20190125145711.GF12962@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 03:57:11PM +0100, Andrew Lunn wrote:
> On Fri, Jan 25, 2019 at 11:18:14AM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > If the system was booted using a device tree and if the device tree
> > contains a MAC address, use it instead of reading one from the EEPROM.
> > This is useful in situations where the EEPROM isn't properly programmed
> > or where the firmware wants to override the existing MAC address.
> >=20
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
> > +static void rtl_read_mac_address(struct rtl8169_private *tp,
> > +				 u8 mac_addr[ETH_ALEN])
> > +{
> > +	/* Get MAC address */
> > +	switch (tp->mac_version) {
> > +	case RTL_GIGA_MAC_VER_35 ... RTL_GIGA_MAC_VER_38:
> > +	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
> > +		*(u32 *)&mac_addr[0] =3D rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
> > +		*(u16 *)&mac_addr[4] =3D rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> >  DECLARE_RTL_COND(rtl_link_list_ready_cond)
> >  {
> >  	return RTL_R8(tp, MCU) & LINK_LIST_RDY;
> > @@ -7148,6 +7163,7 @@ static int rtl_get_ether_clk(struct rtl8169_priva=
te *tp)
> >  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_=
id *ent)
> >  {
> >  	const struct rtl_cfg_info *cfg =3D rtl_cfg_infos + ent->driver_data;
> > +	u8 mac_addr[ETH_ALEN] __aligned(4);
>=20
> Hi Thierry
>=20
> Maybe now would be a good time to cleanup this __aligned(4), pointer
> aliasing, etc?

Are you proposing that I rewrite rtl_read_mac_address() to manually
extract bytes from each register read? Something along these lines:

	value =3D rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
	mac_addr[0] =3D (value >>  0) & 0xff;
	mac_addr[1] =3D (value >>  8) & 0xff;
	mac_addr[2] =3D (value >> 16) & 0xff;
	mac_addr[3] =3D (value >> 24) & 0xff;

	value =3D rtl_eri_read(tp, 0xe4 ERIAR_EXGMAC);
	mac_addr[4] =3D (value >>  0) & 0xff;
	mac_addr[5] =3D (value >>  8) & 0xff;

Looks like maybe that should be a separate patch?

>=20
> > +	/* get MAC address */
> > +	if (eth_platform_get_mac_address(&pdev->dev, mac_addr))
> > +		rtl_read_mac_address(tp, mac_addr);
> > +
>=20
> Maybe that could be made more readable with:
>=20
>       err =3D eth_platform_get_mac_address(&pdev->dev, mac_addr);
>       if (err)
>       	 	rtl_read_mac_address(tp, mac_addr);

I was following the same pattern that other drivers were, but I can
change to the above if you prefer.

Thanks,
Thierry

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxLLDEACgkQ3SOs138+
s6FADQ//bIJRLjuvqMg1gqSqCK/Lze06PFPhtnRYtXQyAqo3YqblXqbgyyUWxg5Z
UivTex/Jou2z7nHnfc0v5l3zmqG1TzovaLh6F8H2JBZXrIALm2xnycI6kdv+R8EP
0+pAS7J0sDHxUmygDeLiLT1ufDvoOnMyPKEAVThPexEX9VqlJze1cqG7ecV8BcBv
k1HSzZckrgPn/rOD8s2yBFU8cjs3fW61yyxR6ME6g3pjz/1gew2uiG+bytOjmuYp
44K3woMqjoO9PTUqdmpaKIeTNnVcwQwzwZzLC78TUA/kRnD75Ny7rmOKf4UvyazL
SD6YDW8J2iGdhyrS+ZZL9sV+RNbHFxC7lDidple8ZCBo0QJXl3kaZKwnqbqbHau2
xGOF2RXYD8PZMfwcOXzQpfgn9hsqEk6veq0tLS8CNm6CPBknGYu2iySZiohZesQ0
ftb/RMCk6ecRw0vAH2RZlXpBNKx9lgeUTSjtfdBXapyp5CeFT1HMBxjCb1SxHKoN
mpRCcEHDBBQJTcIQssADZQWYUsA3wwEKJqKsN94xMqdVWnkSnQbgGTkCsscl3SJJ
pu5k2YPf1c1xs3iVhY3QZUjspYg0WZTlFDommfbaL0RkuY2Y4qrW9OF1z2X+XC9K
Nhvf/poV/3syJTsNfClsK08Cnb2GdqfGyBGlG599L7C+pvS/aEQ=
=bENl
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
