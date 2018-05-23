Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932498AbeEWKkf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:40:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37497 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932350AbeEWKkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:40:32 -0400
Date: Wed, 23 May 2018 12:40:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, alexander.duyck@gmail.com,
        tobin@apporbit.com
Subject: Re: [PATCH v2 1/1] drivers core: multi-threading device shutdown
Message-ID: <20180523104029.GC15312@amd>
References: <20180505154040.28614-1-pasha.tatashin@oracle.com>
 <20180505154040.28614-2-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
In-Reply-To: <20180505154040.28614-2-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> When system is rebooted, halted or kexeced device_shutdown() is
> called.
>=20
> This function shuts down every single device by calling either:
>=20
> 	dev->bus->shutdown(dev)
> 	dev->driver->shutdown(dev)
=2E..
> Finally, with ixgbe_shutdown() it takes 0.37 for each device, but that ti=
me
> is spread all over the place, with bigger offenders:
>=20
>     ixgbe_shutdown
>       __ixgbe_shutdown
>         ixgbe_close_suspend
>           ixgbe_down
>             ixgbe_init_hw_generic
>               ixgbe_reset_hw_X540
>                 msleep(100);                        0.104483472
>                 ixgbe_get_san_mac_addr_generic      0.048414851
>                 ixgbe_get_wwn_prefix_generic        0.048409893
>               ixgbe_start_hw_X540
>                 ixgbe_start_hw_generic
>                   ixgbe_clear_hw_cntrs_generic      0.048581502
>                   ixgbe_setup_fc_generic            0.024225800

ixgbe is network card, right? So ... it does not have any persistent
state and no moving parts, and there's no reason we could not "just
power it down"?
>  /*

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsFRR0ACgkQMOfwapXb+vLi5ACghu7XPMOFEDfbMhAS5WGr5bgI
hfIAoKI3dPA3N005lBvY/4K3irEQODZ2
=S3tw
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
