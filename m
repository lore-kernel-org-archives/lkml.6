Return-Path: <sebastian.reichel@collabora.co.uk>
X-Google-Smtp-Source: AB8JxZrTMwO8BFQyiEp3tT6zdh4K0asc2FtMUW7NGTdvCunq8LvfxLIA9NnyW0k7opACEJFygJHm
ARC-Seal: i=1; a=rsa-sha256; t=1525865333; cv=none;
        d=google.com; s=arc-20160816;
        b=USaz/WD52bMEYyz21n+SaF5cF/NuDigmCveCOMWrTIdkSHWjSmoKHhSbpNCOtMrQRD
         IlXq8HumfHJn4dcRjb4MZwaKsEt5wU3EPQQhgXOReS36EBJiDusx/r0IoRH32BNx7RtG
         oYlYEpg3sSFrwi//S65RnbjfSrGIzIeen3D4y8iZgizSneGfVXcNmtY42DzktV9PJP1Z
         pwFP66HqD88L3OeoK2QisP8X2Ty2wpcp2YY3x8UYQ5SCd46K8sjCX7qj/tp6+ll1Piso
         JdvRGdHC12xdbCU5BB3lGFd2ZR8r+rv8/kNVZRTZRIQLgZAW6uv1RlRC8u6UcHcVqGbb
         2xNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=YGarjxycFhDUyVG9ebzWwxDUlKxKBgihfeWpJLplHVY=;
        b=Gz+UBvC9gJ2O426yhLznINU92MjSg7P5YWXenY4HoIpkWm8nJfqi9UchxAofc9+mSN
         lyu3iQwoy/qrK2B5b4jJDdI0qTYtcYpUiDvHLLG3iOWoQIsevYMdAP7vYDjGEUHgxuTC
         zgpVJ8iRbhCXUXo9pYlg02kiVYpZ0BOD3el15StQDePXJ+cQHRsSYA/F8uKGe6NpUkDs
         /HqpJex21g/0VBaWWcdSGXT9VB91dQIb9A4rsnmvXQ3lb9WMVr9hEiFbdk+wdK2QZxCC
         vw79C/g2rc3tiK4XXWnnSu4fiNanrE8ZGQc8pk0r/CgbrgFxh5rAA3WYt2m24BIZN41+
         jvwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 2a00:1098:0:82:1000:25:2eeb:e3e3 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 2a00:1098:0:82:1000:25:2eeb:e3e3 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
Date: Wed, 9 May 2018 13:28:50 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: imx: dma_unmap_sg buffers on shutdown
Message-ID: <20180509112850.52amrm7ffxhk2zm2@earth.universe>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
 <20180507213610.17330-3-sebastian.reichel@collabora.co.uk>
 <20180508064351.ioczgw2v4jtryr3x@pengutronix.de>
 <20180508134047.zocurxwelw3a24ti@earth.universe>
 <20180508184612.iixr3psap4ik5fdr@pengutronix.de>
 <20180509102058.6mshag4y7aq4w2n2@earth.universe>
 <20180509104256.slkzauicnhsktqqf@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q42juzzebumcprf7"
Content-Disposition: inline
In-Reply-To: <20180509104256.slkzauicnhsktqqf@pengutronix.de>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599842789547446869?=
X-GMAIL-MSGID: =?utf-8?q?1599985768077685130?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--q42juzzebumcprf7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 09, 2018 at 12:42:56PM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, May 09, 2018 at 12:20:58PM +0200, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Tue, May 08, 2018 at 08:46:12PM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Tue, May 08, 2018 at 03:40:47PM +0200, Sebastian Reichel wrote:
> > > > On Tue, May 08, 2018 at 08:43:51AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > > On Mon, May 07, 2018 at 11:36:10PM +0200, Sebastian Reichel wrote:
> > > > > > This properly unmaps DMA SG on device shutdown.
> > > > > >=20
> > > > > > Reported-by: Nandor Han <nandor.han@ge.com>
> > > > > > Suggested-by: Nandor Han <nandor.han@ge.com>
> > > > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.c=
o.uk>
> > > > > > ---
> > > > > >  drivers/tty/serial/imx.c | 12 ++++++++++--
> > > > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > > > > index 3ca767b1162a..6c53e74244ec 100644
> > > > > > --- a/drivers/tty/serial/imx.c
> > > > > > +++ b/drivers/tty/serial/imx.c
> > > > > > @@ -1425,10 +1425,18 @@ static void imx_uart_shutdown(struct ua=
rt_port *port)
> > > > > >  	u32 ucr1, ucr2;
> > > > > > =20
> > > > > >  	if (sport->dma_is_enabled) {
> > > > > > -		sport->dma_is_rxing =3D 0;
> > > > > > -		sport->dma_is_txing =3D 0;
> > > > > >  		dmaengine_terminate_sync(sport->dma_chan_tx);
> > > > > > +		if (sport->dma_is_txing) {
> > > > > > +			dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
> > > > > > +				     sport->dma_tx_nents, DMA_TO_DEVICE);
> > > > > > +			sport->dma_is_txing =3D 0;
> > > > > > +		}
> > > > >=20
> > > > > did you find this because the kernel crashed or consumed more and=
 more
> > > > > memory, or is this "only" a finding of reading the source code? I=
f the
> > > > > former it would be great to point out in the commit log, if the l=
atter,
> > > > > I wonder if this is a real problem that warrants a stable backpor=
t.
> > > >=20
> > > > A bit of both. One of Collabora's customers had a (scarce) kernel c=
rash
> > > > in imx-serial and modified multiple things in the driver. The crash=
 is
> > > > gone, but it's not clear which change fixed it. I could not
> > > > reproduce the crash so far and I'm currently rebasing and splitting
> > > > their changes into upstreamable portions with proper patch
> > > > descriptions. From reading the source this looked like a real issue.
> > >=20
> > > In which context (kernel version, operating mode (e.g. rs485)) did th=
ese
> > > happen? What does "crash" mean? The kernel did just hang or produced =
an
> > > oops? If the latter, can you show it/them?
> >=20
> > I pasted the oops, that triggered writing the patches (Linux 4.8, no
> > rs485, 4MHz baudrate). I think, that the actual issue has already been
> > fixed upstream between 4.13 and current master.
> >=20
> > -- Sebastian
> >=20
> > ...
> > [  302.516696] Unhandled fault: external abort on non-linefetch (0x1008=
) at 0xf0938000
>=20
> This is usually a missing clk. Alternatively RX is disabled and the
> RXDATA register is read. Scrolling through
>=20
> 	git log v4.13..linus/master -- drivers/tty/serial/imx.c
>=20
> I didn't find a candidate for fixing that.

It happens while the port is being torn apart. I think the following
patches from you are very good candidates. Especially since the
remaining diff fixing the issue in the customer's old kernel has a
smilar change:

76821e222c18 - serial: imx: ensure that RX irqs are off if RX is off (9 wee=
ks ago) <Uwe Kleine-K=F6nig>
dedc64e02f5d - serial: imx: Stop to receive in .stop_rx() (9 weeks ago) <Uw=
e Kleine-K=F6nig>

-- Sebastian

--q42juzzebumcprf7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlry228ACgkQ2O7X88g7
+prf1w//RO3HU/eZRCF7548Kz17+XDcy+upDoVOGyOpul/nboloktn5mpqf04j0L
onMEwFMxCfb2Z0VmJCYyVdLacl1tLap1FCou1gIOdPkiwO75366HA6K5IYNVVmKe
5VojtI7pafSVS+S5FeCp6BD0OB2RLte745C1CuO8kdFD4d+eFhiVpL8wtQHg8zBd
9VivfONK2dxdo7fUTMB6b3Ng+mB32NESopD3pg+ntvLNT7InJoOPWgaPVeLmYP4m
HkDJLBtvOFfyklk3xK7f6KSk4s4wKIY6hxD51fwQhhraUnnUe9sZpE7b+rw+cQGy
ovMdK8qt51rv2S3YOfCOB0/87QhlzF+aUzs+DqDdUh8185wmT2MTyUxwe/6U1DsE
GlXD+/v6dozkaaOBBKDxw1kckoYp5RYCnHzpnykkd6I8DFaCIPO3GUaSuJt0Drx9
xEDT46KVl6RTOW+gn8PeiXr3NPPTGMbosL8JRYq0rZOEOhL/almTrwCWsaDxgIb4
0OsfQ9GWIrl5Q+zQ/2iohKNh1XFDMKLngnt92trYYKuTD3cEQ2ZeJJEv6Z3SKVW4
2isspDC4Gcv6yEedaQiYrsx/Dge8t6CSAIDOMxWviPXJF0aBmf8Cl6/zS5vcvo7C
QL5mI9uUtQ4vRsNds3j3J4vzYQLuX7u+Ye3gokJzP+jQYbxmggA=
=eFu/
-----END PGP SIGNATURE-----

--q42juzzebumcprf7--
