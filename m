Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbeBVLkr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753747AbeBVLkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:40:46 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3F721796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Thu, 22 Feb 2018 12:40:42 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 013/100] rtc: cpcap: stop validating rtc_time in
 .read_time
Message-ID: <20180222114042.7kpgq67raje7wbyz@earth.universe>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
 <20180221205635.31314-14-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3cxjms7q5mhycwfo"
Content-Disposition: inline
In-Reply-To: <20180221205635.31314-14-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3cxjms7q5mhycwfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 21, 2018 at 09:55:08PM +0100, Alexandre Belloni wrote:
> The RTC core is always calling rtc_valid_tm after the read_time callback.
> It is not necessary to call it just before returning from the callback.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-cpcap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/rtc/rtc-cpcap.c b/drivers/rtc/rtc-cpcap.c
> index 3a0333e1f21a..a8856f2b9bc2 100644
> --- a/drivers/rtc/rtc-cpcap.c
> +++ b/drivers/rtc/rtc-cpcap.c
> @@ -119,7 +119,7 @@ static int cpcap_rtc_read_time(struct device *dev, st=
ruct rtc_time *tm)
> =20
>  	cpcap2rtc_time(tm, &cpcap_tm);
> =20
> -	return rtc_valid_tm(tm);
> +	return 0;
>  }
> =20
>  static int cpcap_rtc_set_time(struct device *dev, struct rtc_time *tm)

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

--3cxjms7q5mhycwfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqOrDcACgkQ2O7X88g7
+ppjzw//UebQxXzcI0HNj3maCsHnQTMQ7v5OjaqgrFkMuARmRFN8QLQAu3vqROfH
GJ9IJ/yyzvx9oMuJ3YBlLVz4fQcru/IVEgkBk1kmk2vt5wadRMcWvs0hAFhvmKNZ
zBhONVPqanI12/3YbYlBAIAPONyiULUZ3BfXyz5PeXj5KellD69Tdg1UMrHFDiT5
y86TPx/WHmRvJP2F63b3JznpX9brvnKSMWbp27C/aGNWi1aJbf9NCQTImlxlxeSX
uxyxjy13jvAShc/46jQfRSt8tFdmcAgU1dUJfHbHG/QkqN6giKEh6fBl8vhWRTb6
5JnlTh1moKzfZDjfFefOSOE61URtqAtXV/2a/8dPS7srAYsjv7SUA4Iizfch+8ll
ZIlzvM3UxwKvy8cxmhZhp82RfVEr2+5/Z+q8SSpfaWwbg0FVhQfmoGp7UK9XfRPD
1mvS6VQnv8oJGbSF9Zc3dgDcuLKcor1dCcgg/hKNbf3W9qIxnJIoEAoE+23lzh3u
cb+SyQQGY0hQECQ5Z+jNo12JTZ3uVEwCv9RRfbDWU21joENZHSNz3GGa/mO9eENX
oCoC8Q3YdZA/ZIFKVvl5MRZS/EJu2yNuP3srzmszBUHLoDIpG2rLxKfmOPWqWCNm
UVABV/52UMY5BQNrC3DwV1v/+eUBuWMVdyLQGNUZvtBazJergX8=
=y3bA
-----END PGP SIGNATURE-----

--3cxjms7q5mhycwfo--
