Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753162AbeENMSh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:18:37 -0400
Received: from www.zeus03.de ([194.117.254.33]:44974 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752908AbeENMSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:18:35 -0400
X-UD-Smtp-Session: l3s3148p1@GDwAfClsEoggAwDPW8cGAAId4P/+oMhl
Date: Mon, 14 May 2018 14:18:33 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: tegra: Remove suspend-resume
Message-ID: <20180514121833.2hcpuwfjxmzi3rcx@katana>
References: <20180513211347.7187-1-digetx@gmail.com>
 <20180514115933.GH18312@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2ynxx7vuy2woa7ea"
Content-Disposition: inline
In-Reply-To: <20180514115933.GH18312@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2ynxx7vuy2woa7ea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 01:59:33PM +0200, Thierry Reding wrote:
> On Mon, May 14, 2018 at 12:13:47AM +0300, Dmitry Osipenko wrote:
> > Nothing prevents I2C clients to access I2C while Tegra's driver is being
> > suspended, this results in -EBUSY error returned to the clients and that
> > may have unfortunate consequences. In particular this causes problems
> > for the TPS6586x MFD driver which emits hundreds of "failed to read
> > interrupt status" error messages on resume from suspend. This happens if
> > TPS6586X is used to wake system from suspend by the expired RTC alarm
> > timer because TPS6586X is an I2C device driver and its IRQ handler reads
> > the status register while Tegra's I2C driver is suspended, i.e. just af=
ter
> > kernel enabled IRQ's during of resume-from-suspend process.
> >=20
> > Note that the removed tegra_i2c_resume() invoked tegra_i2c_init() which
> > performs HW reset. That seems was also not entirely correct because mov=
ing
> > tegra_i2c_resume to an earlier stage of resume-from-suspend process cau=
ses
> > I2C transfer to fail in the case of TPS6586X. It is fine to remove the
> > HW-reinitialization for now because it should be only needed in a case =
of
> > using lowest power-mode during suspend, which upstream kernel doesn't
> > support.
> >=20
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  drivers/i2c/busses/i2c-tegra.c | 33 ---------------------------------
> >  1 file changed, 33 deletions(-)
>=20
> Shardar, Laxman, any thoughts on this? The is_suspended thing looks to
> me like a workaround of some sort that may not be needed if clients have
> proper suspend/resume implementations. Even without suspend/resume
> support in client drivers, the driver core should resume devices in the
> right order (I2C adapter before any of the clients), so I don't see any
> cases where the is_suspended logic would be useful.

Thanks for this patch!

This is closely related to a discussion we started recently:

"I2C PM overhaul needed?" https://lkml.org/lkml/2018/5/4/329

And part of the outcome is that the I2C core should print a WARN if an
I2C client tries to use I2C at suspend_noirq state or later. This is to
remove logic like in this patch from all I2C host drivers and to make it
more explicit that those I2C client drivers need their PM fixed.


--2ynxx7vuy2woa7ea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr5fpgACgkQFA3kzBSg
KbYFrBAAn1F3FNYeGHatTstgcxn4+7xs+TjTvIGu785vi2AO1DEz24ZPqZYMcbMY
XySLG1l9vfFoDXQXsTTKf6N17NAc4eNH6xUK8ic09OC6tIqe+kAm/uAF0czlZTC9
a2ls7vykyfqzFmod7ilmwfpuDnozu3SL3VD/0hQ9kdS3/LtYW4SE+0p6dhi1UHLC
ANZyPB/7yG3meGoqoQzFD579Ebzfqbn8C670L+hPsJUN4UQ4srQGOmfrBSzg/qsi
LkPFTTkkXWYhkXltLY7fnUpc7FEpnLETk/Mdfz8gfXqem5VVq82JTz/nIwPM4wYS
waGWcMdnhwBfXbM0TE31uGZ2Wq5Mz/spbyBYTSgjrLOkNb24pecpTAbvjRNVoJk4
aRRX7Wkxw9xKWQy6uGxVq2Kmyq0X8+gTeUZEbDBvIBbrVJnF6r/bVuFEZLTGHLWi
iniVcpSdTpLnYPybMKTxSqsbcbWGrVmwA2VvB7zCP98pd/8JRwruR4bnev0DaCXn
fr+o9D7h22Ayus7jwxZfKdcdQ7AwcgNKfFcBmgH92DalVyHXjucWnbeN7diq9vAm
wZJbhK4+ctSXbFGLpiNhB0MLmxDeU3sPc/v88dGTLuZ1FctDKwb4nYWastuYj3A0
+zcGRJbVvFgOji7m4FA+kVPNrTKYl+VVAJMXoahOsIAH3E+gArQ=
=n9jK
-----END PGP SIGNATURE-----

--2ynxx7vuy2woa7ea--
