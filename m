Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161638AbeCAUe3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:34:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48750 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161578AbeCAUe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:34:26 -0500
Date: Thu, 1 Mar 2018 20:34:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
Subject: Re: [PATCH v3 01/25] dt-bindings: soc: qcom: Add bindings for APR bus
Message-ID: <20180301203413.GN12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-2-srinivas.kandagatla@linaro.org>
 <20180213231244.ama4bwsehzuh5sr7@rob-hp-laptop>
 <ae65a9c8-85a3-5494-f4cc-1038fd8c9bd1@linaro.org>
 <20180218230414.dkd6kb6kd35arcyv@rob-hp-laptop>
 <636d4ac2-3bc2-7290-1645-0451c089cb8a@linaro.org>
 <CAL_JsqK3KFBGqpHRaURSrHew1HhObUvFYxuhND-FOQ4tCUaAHg@mail.gmail.com>
 <465a2ca7-9f74-8977-37ea-29fe3944c27c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3rMDlCEgcaHQQFB+"
Content-Disposition: inline
In-Reply-To: <465a2ca7-9f74-8977-37ea-29fe3944c27c@linaro.org>
X-Cookie: Real Users hate Real Programmers.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3rMDlCEgcaHQQFB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 10:03:42AM +0000, Srinivas Kandagatla wrote:
> On 22/02/18 00:14, Rob Herring wrote:

> > Am I saying a single DT node for this? Yes, perhaps.
> Yes, I will give that a go.
>=20
> So we will endup having something like this in DT for one frontend and
> backend dailink:

Let's not start encoding DPCM into DT, DPCM is very much an
implemntation detail of the current stack which we're gradually pushing
towards replacing with something better.  What we want to be doing is
just treating components inside the SoC the same as components in a
CODEC, the routing within a SoC being the same as in a CODEC and
similarly for externally connected devices.

> 		fe@1 {
>                 	is-fe;
>                         link-name =3D "MultiMedia1";

In particular having the concept of "front end" in the DT is *very*
implementation specific.  We should just be describing the connections
that exist in the system.

--3rMDlCEgcaHQQFB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYY8QACgkQJNaLcl1U
h9A2AQf/afU7I+Vlh5qhOLI+4+E9POiqDGkF2eC13xgr1bKvvC1JNlQFVnEpm4QM
xonSvnwf2rv7WLTSP6lClTLAjvXdW4qQ5KvfR6U78HxabliiJyK2aiBVjolPWjse
qvqHHciRTdA3LZmpmGE/rdo3lNAEkiCIHJups7g8spE9Dto6EaMS4Dp05q8OumgD
1DRyte5vIF9m0geqjgexGeTbADs2SwQvdBDdl1PH2Wap/lan8ricHEBVwJlz94LF
A2suvzqCPUUpCdd3vf2CaTo50oQf3Zb4mPD0iKXmpIrx2NFnB6DpqvQsH5EMFkD/
lbxRSeYYJNNSXVbCJYd64Uqez55P3A==
=9CV7
-----END PGP SIGNATURE-----

--3rMDlCEgcaHQQFB+--
