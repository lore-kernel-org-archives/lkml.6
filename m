Return-Path: <bleung@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521913395; cv=none;
        d=google.com; s=arc-20160816;
        b=OwAvB2c7Ewz45xICVTZEZOlM6+D5vZFedAFKc52o7Wnnt6K0+krAEANPOqUOfCeM0Y
         k/kRL/Eazzo3Qo4cvPRrP5jreclEUkucHni3GMgJh9OFyv0tCrr7LzXvSqZi68WjYQpr
         tct5i/JDjLGsuR87lwkVxGqwC9Mw9iLgwGDoNkAdVaz37Vqpa7o+ctv5z6xgTg/efwot
         gLpbB18MHK+HTtmORteQ+gy1y8X6I7/oW5GNq5mYzzep5P2QqJ3axF+gd6qMukmMiwEG
         7wOVmWSe4BBCsYyE1ky/TA1mglSLZAFEvNYLS7jdJDzv1tOx67Pgu9jwGJkuQmvvx3ot
         d+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=SRcT2Wvv4SVpOot9VGgKbt5zt8TbJCx+SOJ2e5TqCY4=;
        b=iMccj0m5oykpnkLzFJhfKZUTMCL+NQd1WEU23T0Bt267S4bI0nDNLyy7iBSbsjwFtJ
         4y2pUbUvoMgeyYEpdHRwUfwnU9pS7PRFiBY6tolehfV3fDcth0JtWeNaurpXNlZrSq06
         QVYAJRD0JI/dVpLxVDJOqkRdsZaIlJkJFOLVYCRcc8lz3+eSrjuo6dwhxV03Lw4/MMZ/
         lv1JvbjiGdw/aW931sGTXu77ObM2mP6PvRRJ1wnZhgiWsgxiR/Ks9rCvwfnZs8ul5Npf
         gjVK3zDD0d5p+gswrGvwZSghEJbYDQPTSgU58ME8BsS3aCSdQ1B4Q8q6OGTf5K4vCNuo
         sx2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=wVYTeezA;
       spf=pass (google.com: domain of bleung@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=bleung@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=wVYTeezA;
       spf=pass (google.com: domain of bleung@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=bleung@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELtU9pcBirGPQBvo6fQHqZWaVS6x2nCtLbQxWbZjlEydjX0Sm+wo68aBndrYze1FPJKoxxKQ9w==
Date: Sat, 24 Mar 2018 10:43:11 -0700
From: Benson Leung <bleung@google.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Benson Leung <bleung@chromium.org>, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	achant@google.com
Subject: Re: [PATCH v2] USB: announce bcdDevice as well as idVendor,
 idProduct.
Message-ID: <20180324174311.GA12922@decatoncale.mtv.corp.google.com>
References: <20180324013154.230119-1-bleung@chromium.org>
 <Pine.LNX.4.44L0.1803241155560.30456-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1803241155560.30456-100000@netrider.rowland.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595777100282268882?=
X-GMAIL-MSGID: =?utf-8?q?1595841859930913983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 24, 2018 at 12:06:20PM -0400, Alan Stern wrote:
> > +	dev_info(&udev->dev,
> > +		 "New USB device found, idVendor=3D%04x, idProduct=3D%04x, bcdDevice=
=3D%2x.%02x\n",
> > +		 le16_to_cpu(udev->descriptor.idVendor),
>=20
> Unnecessary and incorrect whitespace changes.
=20
Thanks Alan. Fixed in v3.

Benson
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlq2ji4ACgkQHwn1ewov
5lhTgg/8Dx1wnMG4urKuxxykwAvk7GiDaAAbZANZl+DDl6oT9fIxbx/jSo2naEMy
/FZfFz1XYNw5jnZJn0udlaQKmtYaUr5bXMINjpH7GB8fSBZjduSSMj8yWz2yuywA
o8s+lC/pS4psu3rv1/ZLnjXr5Nv/CWu4ZkpJg1NGVnnL+PraF03LrDAG2VmqtU78
8TXphFS2WY0XxEt5o40XAflltGl7XiehAwNN1BwjzLGbFUxjq+ojYOzreXi9/Zwq
kaNoVQsjTHPPak2aqXSEuGmojngHFJb6l/+MnEQy/oV271absSqyGLbgHqBuckqt
bqMz59Dm3aBjgdCLl/n5L8H2a64r/0m1VlK5yzH61r4fzaz3t1OtHuYZPvIIMU27
6k3D6SuNPQ887+yLopoCf2yroBrAdzWmgOVyLbvClywbPzItcZNSU4Jja9SQ8Z6G
DLjHP8d9+YeTlZH2bjDBOuB6Q7b2Q/YpZIYCoOoE5GiaKCKbix6ocGXJxOnZuEsx
Ve6/6FPJdjrLinSFcSBRSm2n/1nEWmhGZnGsU8V2IGIs4Fr6tpUDPsRwohfd9jzd
4Fp8OaOVdseT2D1WsPyEZgB7uPniIwfx+liPK25IthraEgH4a8DmyFirNHSvWfHV
euby7qvSK+SOr165icKozOKdb0Zx0bfxW2/B7NMD9Gi4EpmehCY=
=uI0Z
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
