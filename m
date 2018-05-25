Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030570AbeEYV5r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:57:47 -0400
Received: from www.zeus03.de ([194.117.254.33]:52358 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030503AbeEYV5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:57:45 -0400
X-UD-Smtp-Session: l3s3148p1@kN+J2w5tFs4gAwDPW8avAAId4P/+oMhl
Date: Fri, 25 May 2018 23:57:43 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jean Delvare <jdelvare@suse.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: i801: mark PM functions as __maybe_unused
Message-ID: <20180525215743.fwmvbapwh6kjpyrh@katana>
References: <20180525210952.1861881-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t353iqtd4sucz3uc"
Content-Disposition: inline
In-Reply-To: <20180525210952.1861881-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t353iqtd4sucz3uc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 11:09:46PM +0200, Arnd Bergmann wrote:
> Changing from UNIVERSAL_DEV_PM_OPS to SIMPLE_DEV_PM_OPS caused a harmless
> warning in configurations without CONFIG_PM_SLEEP:
>=20
> drivers/i2c/busses/i2c-i801.c:1723:12: error: 'i801_resume' defined but n=
ot used [-Werror=3Dunused-function]
>  static int i801_resume(struct device *dev)
>             ^~~~~~~~~~~
> drivers/i2c/busses/i2c-i801.c:1714:12: error: 'i801_suspend' defined but =
not used [-Werror=3Dunused-function]
>  static int i801_suspend(struct device *dev)
>=20
> This removes the incorrect #ifdef and instead marks both functions as
> __maybe_unused, which is a more robust way to express the same thing.
>=20
> Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtim=
e PM")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Should be fixed in my for-next branch:

https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/commit/driver=
s/i2c/busses/i2c-i801.c?h=3Di2c/for-next&id=3D4b2f9bd5e39fb47011074c9a26b64=
b616acc18f0


--t353iqtd4sucz3uc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsIhs0ACgkQFA3kzBSg
KbYfEg/+OG2T5tGeUVcOaWq4aEmKP48uI2IZi59UtguQ1BMSeHTv4yfaVcj7VJSb
ijpxNX/Bsbrp3OnL19Xax2Qy4yrbXkl2kru5kEIU1UnHQLw8kC7bI19f/NPCXkks
Jj97sYV5d1sszAFVsoZ0SlkqehuIow6p6K1mnrcd5mjnALQf1+VcOPUNZvduTA8I
IR8UbrDNQTBSEBYdYICtzM0Vm+aaoMKzK9Ek4kItY3LwJYjjndHYlpIbjGckADWa
DrCtoOKphCrUdZ/D0jpGWsrVnY0TqeGXVqW/NGnLd7sJ8W2yyrnYqEzI5gpD8HqZ
h6AQcJOmZQg4W9RjWozwSSz94iIddikZXgNbzoZLG3MU1rMSSwNuH3PsPIDdBlC9
yPD5q+0U07i/W2T0iE0dFxeEu7QTKp79lK6y8t8GkyPnUDNiQ91NaE37478QIoiK
dHSoIQR35KuzzqSRWTtm9JsNOuzmurGAu0/whef5oC9yc3GrxWCXl/P+lr2R9EvL
ifEA88lyLeU97SLlnO0go0mz1du/FF8P91Ko+IwqMdFvvrlxlkOCH4ctAT0KD2F7
O1BeNlpvJzvIPIg5e1BE9Ws5TgRrHZ4k0QZ1cf1kw1fejSB6v+rLHq8oCI5ACWiM
iGAS4FRVSq6NgmRSFmP9hIHy9Aj+dTVW2eXHort/MNVzpSleyzg=
=Ta8Z
-----END PGP SIGNATURE-----

--t353iqtd4sucz3uc--
