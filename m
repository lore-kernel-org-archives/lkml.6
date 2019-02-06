Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019D6C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDEB218A1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549435762;
	bh=uAMOjikEha65wy4d/1fTwYdJYrkXvw9NF371fAQ+YBE=;
	h=From:To:Subject:In-Reply-To:References:Date:List-ID:From;
	b=AqBBZS7n+kbZx9N91ShBG7OaDcP6PzI39FtalRFHrs5llBTgtsjfZqiE2YSCeXPsQ
	 kWs0eqXwdXlCGV2ShfvUUWsZ8GZZuA/bwsSboyP/bjnDkmcXazipzZHIO2iSmYxhZi
	 6IEVOwoy+LRbWEopxaIJ2A86JcR0+I3v1CDPfQBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfBFGtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 01:49:21 -0500
Received: from mga04.intel.com ([192.55.52.120]:53878 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfBFGtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 01:49:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 22:49:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,338,1544515200"; 
   d="asc'?scan'208";a="112747819"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga007.jf.intel.com with ESMTP; 05 Feb 2019 22:49:17 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Jochen Sprickerhof <git@jochen.sprickerhof.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Gautam <gautam.vivek@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] usb: dwc3: Enable GBit Ethernet on Odroid XU4
In-Reply-To: <20190121140204.GA2360@vis>
References: <20190121140204.GA2360@vis>
Date:   Wed, 06 Feb 2019 08:49:13 +0200
Message-ID: <87ftt1mmxi.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


hi,

Jochen Sprickerhof <git@jochen.sprickerhof.de> writes:
> Note that it only works with USB_XHCI_PLATFORM=3Dy. Also it needs a hard
> reset when coming from an unpatched kernel.
>
> This was included in the original patch in
> https://patchwork.kernel.org/patch/9992809/ but got dropped when
> accepted in d8c80bb3b55b phy: exynos5-usbdrd: Calibrate LOS levels for
> exynos5420/5800.
>
> Old behaviour:
>
> $ lsusb -t
> /:  Bus 06.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
> /:  Bus 05.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=3DVendor Specific Class, Driver=3Dr815=
2, 480M
>
> New behaviour:
>
> $ lsusb -t
> /:  Bus 06.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
>     |__ Port 1: Dev 2, If 0, Class=3DVendor Specific Class, Driver=3Dr815=
2, 5000M
>
> Tested on Debian unstable using u-boot-exynos (2018.11+dfsg-2) and Linux
> 4.19.14.
>
> Signed-off-by: Jochen Sprickerhof <git@jochen.sprickerhof.de>
> ---
>
> Hi,
>
> I'm not sure why this it only works with the driver compiled into the
> kernel nor why it needs a hard reset or why it was the line was dropped
> when the patch was accepted. Would be great to get some feedback of the
> authors.
>
> Cheers Jochen
>
>  drivers/usb/dwc3/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index a1b126f90261..0008bccc30aa 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1169,7 +1169,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  				dev_err(dev, "failed to initialize host\n");
>  			return ret;
>  		}
> -		phy_calibrate(dwc->usb2_generic_phy);
> +		if (dwc->usb2_generic_phy)
> +			phy_calibrate(dwc->usb2_generic_phy);

I can't see why this is necessary. What's really going on? Why is this
branch helping?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxag2kACgkQzL64meEa
mQarTw/+Ns4rlBwr4YIbrETU1mmX0mMc/THNbHQm8ZyV7LYTN4s5+EhwxI7cvm8i
mgH55ePYXst4nac7HhKn+Jk4aRO7tA0n3B4YHQaGxlWkJeqlCjFhUb8B+ZsN5/mY
MIyPFmxGaxjeP5bfvNfbMbPnTAH1TaeFbwTAFNVpvfMOJLJAou9n3yR7KeUepyIf
RVoVZxQzy328LHODpzCuWNbJLZJ2Cu4VVWpeLuSXKt373+Or5ELvK2svX9e6HzGy
XiCVdcZYe0OzQ75DDx7vkjcoNBH1Ao4Rz5ONW92kSj0F8W3abbA4hk1Gz8D3gAnw
5FCtv7ulpGNx5IdLCYoSayEyrY39HzWRiaVw9ZfM2hvvOokkJxyHtGmfZcE/oZMO
XG2pcMrWNJjcDp7hnbTQXgkIN9b86IEt3SIUsl45Ng1l/0rEY/c0s/IqiYXa7FSy
HbculWcSRBx2h8GrNDCYyamh9kNtF7WwN9R3O8n/L5csdh/NSbjEAP3HYvvnag7Y
Bfov2cDeFfKSZBe0stRa2Y3kHxmHc/T+sJoLJlO8993hTdjLraCDY2ByBS8TI0yK
dv45wEWLsZm7MhEC5jKqd7WxoM45/I/oCPB380wjNKY6svsGQMV2MkubWWTiDkrh
ff2Mu3qrng+kLW3mj/2noNdasN2IdQHUcazwEmaCR2nGxstnjJ8=
=USvh
-----END PGP SIGNATURE-----
--=-=-=--
