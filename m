Return-Path: <thierry.reding@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525084887; cv=none;
        d=google.com; s=arc-20160816;
        b=BP9/JAeqa2asmmWb4ByTCnJpqcslgZ+nLgerWHl51JOAP/Qa1d4Bx3Nqp9YdQHnP11
         f/LWr+E9jbViImzOqIG5ChcdxBl0hLxz2qdRfI3g19MS/LsrHlyOZ4rj6wS3xXGSLpKG
         8vPNeh4SRP9fGaJweGHtOnt4th3VpmU1XgmPn51NjPBBPNyiny+SmSCTtU9xshTQaaMe
         vDhoAj6gd6MBOrEHypxAJ0WAr0xIqXX19RkF3OHZ01yDJ4Tad0Ge8Lbzfc9kWvJQDaGB
         uneYyXh55OMUB3Ve2fsCv7OICYuyzjhu0TKIyZI1TYPiqpwl1wdyM8UQmbWVoHZEiq4i
         dsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=dP9OiVIdm3xuhxV81HuOoEZPbImObf2bbf25h0lE7Kw=;
        b=TxS2bc4acpzAssRn/JusG7IXhthRRHpDhaC1tmYyQA6lZCOz8jjTJaRls3/BExA5gr
         94K53n3vRpERd+gINua/uomRZtyv2OH/IJwm9+zTUiusTCcGqCLedW68Bi8kjBS0qfug
         5iwM85kJDshIGQkZ6K75xXGs9nLrHThYnKU9SonZ8bRcHtjRVbRv2ar90tOITvUJfmGB
         tgAWqYUXNRZKk5Zz2obZRQDFFfYUOlDNzCXQBiSw7Wbz++3rJvruT9qdYog/Ew9hs9Nf
         DawiP8V1mAXzJIGK52kc+UrWzXy93pYYSRfgpbQ3cnG2IjmcITi0d+TQvNfqAzmV5cT2
         zaow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Eq173FKw;
       spf=pass (google.com: domain of thierry.reding@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thierry.reding@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Eq173FKw;
       spf=pass (google.com: domain of thierry.reding@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thierry.reding@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZovCc5VegEEn5srdRDQVv5gwfiaZlnEmpVKBhN/AjQf8hR92rRJHnS4re8TD54ebb9ttNOXEg==
Date: Mon, 30 Apr 2018 12:41:24 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, hch@lst.de, linux@armlinux.org.uk,
	gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
	bhelgaas@google.com, zajec5@gmail.com, andy.gross@linaro.org,
	david.brown@linaro.org, dan.j.williams@intel.com,
	vinod.koul@intel.com, robh+dt@kernel.org, frowand.list@gmail.com,
	jarkko.sakkinen@linux.intel.com, rafael.j.wysocki@intel.com,
	dmitry.torokhov@gmail.com, johan@kernel.org, msuchanek@suse.de,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	bharat.bhushan@nxp.com, leoyang.li@nxp.com
Subject: Re: [PATCH v4 1/2] dma-mapping: move dma configuration to bus
 infrastructure
Message-ID: <20180430104124.GE2476@ulmo>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1524883919-29484-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <1524883919-29484-1-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1599167411022495118?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 28, 2018 at 08:21:58AM +0530, Nipun Gupta wrote:
[...]
> diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
> index 88a3558..a9ec99d 100644
> --- a/drivers/gpu/host1x/bus.c
> +++ b/drivers/gpu/host1x/bus.c
> @@ -314,6 +314,13 @@ static int host1x_device_match(struct device *dev, s=
truct device_driver *drv)
>  	return strcmp(dev_name(dev), drv->name) =3D=3D 0;
>  }
> =20
> +static int host1x_dma_configure(struct device *dev)
> +{
> +	if (dev->of_node)
> +		return of_dma_configure(dev, dev->of_node);

The conditional here is somewhat pointless since the of_node should
always be set. If it weren't it should be considered a bug and this
function welcome to crash to make that very obvious.

Either way:

Acked-by: Thierry Reding <treding@nvidia.com>

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm8tIACgkQ3SOs138+
s6HAJg/9FscZP4vLRd/bBp6+rBZLIilAu8k5gn/V+Tv9DJZRIXPsbeOuuixcznXK
Sc940MSfERPYXl8fscrW9kdJWuFM4W3bdXJGzZ08T+IdVVSyFdbldOoPAVpeLi8Y
C8pT3jlCLD5r6foGpUXy52rt6Jtuh7Tc4+3rr+D5h/efg9kbudcOjb2p3hcUDum+
6BJSl7yVKDN6yjK1+o7GHu0wic6CWZe/mNmaQ7g8jn7ahWV3kHnwrHj3/3l4N+h+
cDiZhl34yzyEJRyQ0aHr1r2qdEJTXYA33JpX0zMhqzpv9JCMa+VlteQ48kXSxxTN
X6TuS4pmeihUA9h3pFsuGAogPvW/tznL8tr9c2F2cJ/VDL3itQmfNmzT44ybrZYT
uNPIULOaNePPf10DGcd4RZCJIMUDQeza1IHEmiwlDnr5lYJWJUDtSb4ZfyA2j87y
q5wcupDKuqQ4v2tdkcZb9z8Mm5jYGsrWDVKFxKDPfx0LAwzmo5MNOcbGHnPiy8Oo
N24oBFW3v1ESkzX9Yfd7VCDcKIms1qjO2hyVmIb6jCvPg36E8mqG3f599zn8zCdu
i7xUnhwOs64t/yj62rPEd++T6dEsn7idUd6RGkZxLAWwSMipQ7dFhh0nBbKUGwwU
8yRNFMAtpLAaTnt4FqcLN/0BFZ09zwCVHJFw/mYxeUTFGN/V4Xc=
=hGR3
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
