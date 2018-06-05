Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeFEJGM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:06:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55073 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeFEJGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:06:10 -0400
X-Google-Smtp-Source: ADUXVKKlqsbv6MnwxwnwVwNMYf8AyxGZ9x0xiPFeeC3Q+fc/XEE5yGmYryrmrxaXzhCR845diQc6dg==
Date: Tue, 5 Jun 2018 11:06:06 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, mathias.nyman@intel.com,
        jonathanh@nvidia.com, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: remove the code build warning
Message-ID: <20180605090606.GA20649@ulmo>
References: <1528216500-14172-1-git-send-email-gengdongjiu@huawei.com>
 <20180605084019.GA8665@kroah.com>
 <e2b3ea42-ab55-a1b5-567a-1a57a5f45b5c@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <e2b3ea42-ab55-a1b5-567a-1a57a5f45b5c@huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 04:54:17PM +0800, gengdongjiu wrote:
>=20
>=20
> On 2018/6/5 16:40, Greg KH wrote:
> > On Wed, Jun 06, 2018 at 12:35:00AM +0800, Dongjiu Geng wrote:
> >> Initialize the 'err' variate to remove the build warning,
> >> the warning is shown as below:
> >>
> >> drivers/usb/host/xhci-tegra.c: In function =E2=80=98tegra_xusb_mbox_th=
read=E2=80=99:
> >> drivers/usb/host/xhci-tegra.c:552:6: warning: =E2=80=98err=E2=80=99 ma=
y be used uninitialized in this function [-Wuninitialized]
> >> drivers/usb/host/xhci-tegra.c:482:6: note: =E2=80=98err=E2=80=99 was d=
eclared here
> >>
> >> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> >> ---
> >=20
> > Any hint as to what commit caused this warning to show up?
>=20
> It seems below commit:
>=20
> commit e84fce0f8837496a48d11086829bdbe170358b7a
> Author: Thierry Reding <treding@nvidia.com>
> Date:   Thu Feb 11 18:10:48 2016 +0100
>=20
>     usb: xhci: Add NVIDIA Tegra XUSB controller driver
>=20
>     Add support for the on-chip XUSB controller present on Tegra SoCs. Th=
is
>     controller, when loaded with external firmware, exposes an interface
>     compliant with xHCI. This driver loads the firmware, starts the
>     controller, and is able to service host-specific messages sent by the
>     controller's firmware.
>=20
>     The controller also supports USB device mode as well as powergating
>     of the SuperSpeed and host-controller logic when not in use, but
>     support for these is not yet implemented.
>=20
>     Based on work by:
>       Ajay Gupta <ajayg@nvidia.com>
>       Bharath Yadav <byadav@nvidia.com>
>       Andrew Bresticker <abrestic@chromium.org>
>=20
>     Cc: Mathias Nyman <mathias.nyman@intel.com>
>     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>     Signed-off-by: Thierry Reding <treding@nvidia.com>

I've never seen this warning before. It's also a false positive in that
technically the mailbox message will always have at least one bit set in
"mask". However, I don't see how the compiler could know about it, given
that the data comes from an external source, so I think this makes sense
as a hint to the compiler. So:

Acked-by: Thierry Reding <treding@nvidia.com>

Can you provide more detail on what exact version of which compiler you
used that triggered this? I wonder why it's never presented itself with
the compiler that I use.

Thierry

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsWUnsACgkQ3SOs138+
s6Gg1A/6A7nFC4EyLNBlNi2EAo5oSBhXA4/i4b+HkR1LHHtteuQH3so3HUavC7Gm
J8Pz46KMAXZmEW2fMfT+Kfqh6Cs8+3xx9grJ2XMASV1kSdYzbYMwNIiEidvD006Y
d1nvdrRSnFvWytGtsykpY9coCrNlA8t41OkbtR73l9UDN5ETGqsNxujc3sT7stZT
eqMoIlIqOcwVRKPDv3Tgm88iTawc0NuMcfLqCd7dI7netkOV51yIVTs5baDFHL/7
iYl7l1FdIa1wMi6bWs0TSFQZilYoj2i4ADffRvhgTVU0zAjmWFOre2yPPBlCT9z8
FIG1FfLzS9TT7bgMkCp/BTk7XBBcMHPUM0AheqSxYPq+juIp0Ia2Z4dnmxyPPc3f
jvkEWHRgXMENRkitMtUV4lTVmVCjDJwLZRdmWIc4S5A/E9nJMuwnWdIDSRPZXVsY
3XR8pt1AWMBF9unPsaxW3X+IsaMgYoD4vJZ/LWtgO+l8p5+AqCeoYobSmNyU3nlc
PgogrW2Lxg/Nd8jrHl4LbGw/7rSLnt6UK85E0afLbIPQtkEwg7uAvhQpC+Q04Lxh
+WXj0Iv1dt9oYXSyXrfUcMMMVf2tDHcinXdk8F55Exojp4Wm7vD/RKjI90+RAmvR
d/Mvex80nrxGL8XTeDjJhGfiExQBbNf7fJfMhCdn5w9xFrxqc6U=
=GnaC
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
