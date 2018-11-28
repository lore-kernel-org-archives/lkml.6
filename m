Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21D7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC5A20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNu1MaAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC5A20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeK1UmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:42:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38923 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeK1UmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:42:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so21491857edt.6;
        Wed, 28 Nov 2018 01:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nqlhVcXmosPRLqlalZDILQDWgIJdYGESrxfszeHCkvk=;
        b=eNu1MaAPab5wkVsfzICkuKS/OwrWVuydaNwQ9VFoYXkX+WD3QzY7wly+J0F3MZ6u0+
         kFqiooYvQpda0C6qmH2okWn/LERzaMAV9imuJj0X8gWtuojS7bQFs9uwgj3gDUGmemsL
         EUINMMRZ+kwlobGMoqYkg+Kreao+6EUn1vNXSL0sYhF9sPCHm4+ZoRQhluGyyIl6TSEs
         tnLVpdzEWhDW1k6BPTVb/anRoSBjR9eQSXKPBN2x57a+OkvJQbgAM887ZpqEITbcxAsx
         E5HRdkMkPc1fHwyDhx0FudntLsS4hyPUlxNUaVeSNGjyoiNWBvraZzPcrG3BaXrEwnpv
         H3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nqlhVcXmosPRLqlalZDILQDWgIJdYGESrxfszeHCkvk=;
        b=kOralqJgptZVyJL4QvkMR9aTLEg6atdVck0ioO1qFbJuGhvHdPydF33mJx3Sv1JOOs
         EDC67gKdbSI2BQ8zteo34p57kddNDlr1UFt0GDQ9FN3fpL6EF4DKI0Z8akEYf5ruiYaB
         yvdY5TIhTzCghWYjlGXETG90qCzrq9vdXlnWQi03zHKc9i4I3Yve+y0KwMeFfrPzWjsR
         jGs1fsKvzdQaKmmWRwHiIbA2h+haw2d91k3JfNNF0wruIrQpXPAubSAufMu+aYDjTaO3
         hUBDUshmmBGbOMA9p94pF1sruNqe6RWERf54xghvd8+S73wcIZBBU9Jak0f2qTg6rwZS
         lV+g==
X-Gm-Message-State: AA+aEWYMezenCNnM1P2p8UZG3LHQWUpbF9cuHrDkSlhCqK5K0i1I8JzV
        KzusNhgaGjwrP9IYtojNihNTbXX0
X-Google-Smtp-Source: AFSGD/Xl1Xc3PmF8U4rP/3aiabppfdYqUsvuxbR8i3fZETVXm8rLj/3cXrmabRSHnnDUgpZ1CInpOg==
X-Received: by 2002:a50:b7d6:: with SMTP id i22mr10504043ede.27.1543398080622;
        Wed, 28 Nov 2018 01:41:20 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id p1-v6sm966426ejo.49.2018.11.28.01.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:41:19 -0800 (PST)
Date:   Wed, 28 Nov 2018 10:41:19 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jose Abreu <jose.abreu@synopsys.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        netdev@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: Move debugfs init/exit to
 ->probe()/->remove()
Message-ID: <20181128094119.GH17419@ulmo>
References: <20181123122122.18957-1-thierry.reding@gmail.com>
 <20181127132143.10473-1-thierry.reding@gmail.com>
 <316d6a25-cb61-32d8-9792-8ffcc2122d8a@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/9ZOS6odDaRI+0hI"
Content-Disposition: inline
In-Reply-To: <316d6a25-cb61-32d8-9792-8ffcc2122d8a@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9ZOS6odDaRI+0hI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 09:38:32AM +0000, Jose Abreu wrote:
> On 27-11-2018 13:21, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Setting up and tearing down debugfs is current unbalanced, as seen by
> > this error during resume from suspend:
> >
> >     [  752.134067] dwc-eth-dwmac 2490000.ethernet eth0: ERROR failed to=
 create debugfs directory
> >     [  752.134347] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup=
: failed debugFS registration
> >
> > The imbalance happens because the driver creates the debugfs hierarchy
> > when the device is opened and tears it down when the device is closed.
> > There's little gain in that, and it could be argued that it is even
> > surprising because it's not usually done for other devices. Fix the
> > imbalance by moving the debugfs creation and teardown to the driver's
> > ->probe() and ->remove() implementations instead.
> >
> > Note that the ring descriptors cannot be read while the interface is
> > down, so make sure to return an empty file when the descriptors_status
> > debugfs file is read.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > This applies on top of net-next.
> >
> > Changes in v2:
> > - avoid access to ring descriptors when interface is down
> >
> >  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 +++++++++++--------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 076a8be18d67..5551fead8f66 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -2550,12 +2550,6 @@ static int stmmac_hw_setup(struct net_device *de=
v, bool init_ptp)
> >  			netdev_warn(priv->dev, "PTP init failed\n");
> >  	}
> > =20
> > -#ifdef CONFIG_DEBUG_FS
> > -	ret =3D stmmac_init_fs(dev);
> > -	if (ret < 0)
> > -		netdev_warn(priv->dev, "%s: failed debugFS registration\n",
> > -			    __func__);
> > -#endif
> >  	priv->tx_lpi_timer =3D STMMAC_DEFAULT_TWT_LS;
> > =20
> >  	if (priv->use_riwt) {
> > @@ -2756,10 +2750,6 @@ static int stmmac_release(struct net_device *dev)
> > =20
> >  	netif_carrier_off(dev);
> > =20
> > -#ifdef CONFIG_DEBUG_FS
> > -	stmmac_exit_fs(dev);
> > -#endif
> > -
> >  	stmmac_release_ptp(priv);
> > =20
> >  	return 0;
> > @@ -3899,6 +3889,9 @@ static int stmmac_sysfs_ring_read(struct seq_file=
 *seq, void *v)
> >  	u32 tx_count =3D priv->plat->tx_queues_to_use;
> >  	u32 queue;
> > =20
> > +	if ((dev->flags & IFF_UP) =3D=3D 0)
>=20
> I tried looking for an helper to check if interface is open but
> couldn't find one so I guess this is the right thing to do.

Yeah, I had done the same thing and came up empty-handed.

> Acked-by: Jose Abreu <joabreu@synopsys.com>

Thanks!
Thierry

--/9ZOS6odDaRI+0hI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv+Yr4ACgkQ3SOs138+
s6GLpw/9Gm1I3bb+4A/cCUEPmPMW7CsfwJXDoVKUD44P7C+S4T0j+RjGRpGWQzgN
gIHV5HEBgFWJWNSLUZnWXBTObeGU5qrhkT6hfSxrVw0+V+4aOKM7qUTgydD3V1Du
7JVd9iAUj6lMPUdpKyDIEgw7GEE7Cb2ja54RX5Z7lPRFqiW26VGz1keNaE9EKctk
qQgX6aXvmifRj9DxJQWSOaZr0T8uZwjm6HxwKrvZa7KoIrWE78pnI380IMAWinUs
aaLd/pxSDIuhpbK+O+jPKA0ixbiLHYxNliyGABKk8QekcXuxvlxF5rgTN6BvvWAw
zf4ePjCveawRNPhb80oxE5YIdNnwvZQ//ba6J77P16eGOM2YgxL65BwIaYPEe1Tf
w/t7u6P4fAyRRaQL3k2ECPdfLvKPgoiUcd3/Xmo5PHZT3CFNtpvdl+CCFCawPt/A
HTNGHP14NZtfoNtqXOVO1omZ15+3TxG8JWKXjitJ0wQbACxb2aBKfcXLBoY7XFhh
yJB5TXY9e+aL3GoDoFTAxgj8avHqBmYZ4LYU2SbQtqjENC9Oh+DUyXU2AEjXqMoV
D21ZdMIvooLxFcyRQCdK8rXq4fQ+GHfX3YUv6z3xk09GbEa4qZIOJNqXpA8O1Z1T
d8dSyLkLWQQmdYe1LTIBRJgpPsvG0CJWaXnGLEgYCCeVZwKhlW8=
=8+GH
-----END PGP SIGNATURE-----

--/9ZOS6odDaRI+0hI--
