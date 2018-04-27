Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2121-1524823857-2-1086997179497812543
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524823855; b=aIprKVZlPPf586DwSDP0JlRlN+tvyfRPVFfM5ddpH0eJzLfzhZ
    63cQ9Oml2m6fEbnsqzOh0tE8Q0BdzOERi+0V+EuaI4nt9N+TalbHq0+qI3Yqq3Di
    j8xLniZD6FVIWHmuZqY+L3sPBzh0mBQV58d4hC/m3Do0Pm/Abn0Vaz4u6hUYjMDL
    i/+B2UbHsJqAfPF/5xWGMRkwBaZuc4ESsj5TUxJCn7vdftMDULjaSuojLaHvQFC+
    cj6wzTuXhaZVZn8Yb4iGMUORjvoRXrJGE6aRjqw9jmO60vVpL9LoclI4VVeen4GS
    ilVfP7at4kmDLJPZd9W63PYdO51Aacvqx5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524823855; bh=NppWMs2V51a+fBvuIafmeA/d2jAx7J
    owEzcVe9sBfNU=; b=Ku3lCJNwWIc4asJXEu58ACweYD88UsPoceFBVT0jez6omO
    n6JRq3IlnpgZZp7z6zzpmqOG/S6RXP7kxGIoFksaR17xCQfUhsn/f0j+vOUn/LE4
    swtgnsoBHd76OlTEDZsinV8zY0oVICNnjxYtvv6iFMCfKly+UdAEjZFmfDDCQ+pk
    4UpKxfwG1wiFODfsA9ffhXe8CKb22hZMROf9nF4RU3ESlF2CY+/gXPF8McD3dqEI
    1vvi8sjf3K1dt7T+MKwIHFGUMDHPA5b/jER5IXgAAIDDLWYWaLC7tEuDR/1hiOoT
    gSbuidDWCGh0xkKZbWkp/Fd3ylKYWsTV4Tcy18EQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nQfbD8ux x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=paXrWvWd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nQfbD8ux x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=paXrWvWd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfENoYNBQ3ADctdDbboCvIonZbQpM3ulL2+N9QO3s4b99G+BGYpT8GE6FZ0HaWwGSPs2xzNRJWOG5ViEOi+2HTIcJLFX2TCppbXPRrDgsox5lMnbCoz1f
    +iolM6izvYu49C3wN1bBKoi50Hby+i9foT79vEmXmf0RnMSPA/aE1HC7RVBj5E67LCu/NFy1pZDDyNTeGns1O4suy5pRHiXSnbr7fy82owhZ+f5Y9Yvxumjb
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=I5jJpb0z_YgA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Ikd4Dj_1AAAA:8 a=X5LdGvgffyiTnYx-dgUA:9
    a=E462g_FJjarSm3gb:21 a=39w_U6FGg02Y5qsD:21 a=CjuIK1q_8ugA:10
    a=aOCQ17lTpIaJ8eu7w_MA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932562AbeD0KKV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 06:10:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37489 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757657AbeD0KKU (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 27 Apr 2018 06:10:20 -0400
X-Google-Smtp-Source: AB8JxZp26vf0lBAXxrduhUzPlzqU+vmccN10MLSs2K6yCCxp7IoX7f3OWNf8gImHpvJly/odlW7E8A==
Date: Fri, 27 Apr 2018 12:10:16 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] usb: xhci: tegra: Add runtime PM support
Message-ID: <20180427101016.GQ30388@ulmo>
References: <1524754750-3633-1-git-send-email-jonathanh@nvidia.com>
 <1524754750-3633-2-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Mh8CTEa8Ax54aLHp"
Content-Disposition: inline
In-Reply-To: <1524754750-3633-2-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Mh8CTEa8Ax54aLHp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 03:59:09PM +0100, Jon Hunter wrote:
> Add runtime PM support to the Tegra XHCI driver and move the function
> calls to enable/disable the clocks, regulators and PHY into the runtime
> PM callbacks.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>=20
> Changes since V1:
> - Re-worked change to handle case where runtime PM is disabled.
>=20
>  drivers/usb/host/xhci-tegra.c | 89 ++++++++++++++++++++++++++++++-------=
------
>  1 file changed, 63 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index 02b0b24faa58..85f2381883ad 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -18,6 +18,7 @@
>  #include <linux/phy/tegra/xusb.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> @@ -761,6 +762,50 @@ static void tegra_xusb_phy_disable(struct tegra_xusb=
 *tegra)
>  	}
>  }
> =20
> +static int tegra_xusb_runtime_suspend(struct device *dev)
> +{
> +	struct tegra_xusb *tegra =3D dev_get_drvdata(dev);
> +
> +	tegra_xusb_phy_disable(tegra);
> +	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
> +	tegra_xusb_clk_disable(tegra);
> +
> +	return 0;
> +}
> +
> +static int tegra_xusb_runtime_resume(struct device *dev)
> +{
> +	struct tegra_xusb *tegra =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	err =3D tegra_xusb_clk_enable(tegra);
> +	if (err) {
> +		dev_err(dev, "failed to enable clocks: %d\n", err);
> +		return err;
> +	}
> +
> +	err =3D regulator_bulk_enable(tegra->soc->num_supplies, tegra->supplies=
);
> +	if (err) {
> +		dev_err(dev, "failed to enable regulators: %d\n", err);
> +		goto disable_clk;
> +	}
> +
> +	err =3D tegra_xusb_phy_enable(tegra);
> +	if (err < 0) {
> +		dev_err(dev, "failed to enable PHYs: %d\n", err);
> +		goto disable_regulator;
> +	}
> +
> +	return 0;
> +
> +disable_regulator:
> +	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
> +disable_clk:
> +	tegra_xusb_clk_disable(tegra);
> +	return err;
> +}
> +
> +

There's an extra blank line here. Other than that, this looks very nice.

Reviewed-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--Mh8CTEa8Ax54aLHp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri9wgACgkQ3SOs138+
s6FCfA/+NIIPUPLO3LD+ESfrgxl8t2zBE2yH/a8k3Kp5eiW4oJ69Jt1ZAeHjjqPq
9F3BisdjSWQjYqML2ap8eQFP+b6F7qPjFQN6e3u2V782762UJ4Xq1uJjBC2Z5inw
StepwEfvw1c9FmfXx6DXPghGcwrAyYY1aGztLI/5JeoEl2J/fyMcPTX5KKjvTDSw
SLAQvlh2LEaMhaym20JZWMTREyuzdRkhNpJGc0d61jk+hDr97tmaNF+Ad3WsX4o2
Hk3Y0clnwqnoN9+DZ0dGj7thIMGsxoLfhs+1Yl1m77/IYXXfRtXfeoEvqLbdvN6c
EH6AgJUpQ+hrcYhmd6q9mGROmp8OHEwruhlHNA9cfDwl6ZQlCNdhUJVUM8msBHBl
cEnRI0qdSUHhQtjuEXCn//YOmeEX6iBtwsvZJBeqdhNUEQc2RFrKVRYfUlRzX2QC
I58WFQYKP+n7q+b3qsWccXDXVsx5Xgb9ffxIzbbq6NLj9qgygL1La0BFnZxrfi8r
iNtYW6ZYwHDHbjPHuSxWg/ilGR56WGQ41uEl81def3fEIe/W0ta6YLxN8OrB8r6W
Eop3MFWG6HqqNbuROdLkPXq18seQUaB9je9O/n0lQADwMMXY278hLA2HVXGla9qO
lCqkwTPCQC2Jx5RKq5lr8jVR8nBElriEmq4X+d7LRFZrMJjlZcI=
=m7h4
-----END PGP SIGNATURE-----

--Mh8CTEa8Ax54aLHp--
