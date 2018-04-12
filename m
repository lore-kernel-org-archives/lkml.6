Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AIpwx497FW5IkDdhf9jJZ36MQNGTr2S1Yl1fC9BsMiSmsYtxySncf2JaxtcpWI91CZLANU2twt8N
ARC-Seal: i=1; a=rsa-sha256; t=1523544305; cv=none;
        d=google.com; s=arc-20160816;
        b=TNkg4n6kG8bulvPIUctvI2ybe4fFLA4KpTZPMpXbXI8JareVfca28OW2CscJWIYTD7
         BEwYKsewNRigWcLnYME9VS383Y9eCGlReO9+asfiwzXrbGb5T3ihRCSscQg7qseSRZvT
         r2gIBom33iFFpcdCdj3wDAZvhW/ruz9nUJ+XumKlIjx4/Th5kw3VTbuSbKkIsOzuD9YC
         XwQwdGdpp+zks8eEPgMOZ+a68S+KUA+xLsT3e/ZqGR6I6suEUn+j0sv/J4m7Siu4alcS
         Fit8ZOcTLi7m0E3Ch1UTVGGt4cpQ00td0mbn2IH4YySnk/jhxOIjUlSWZJBsLS/aO6Wi
         jiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Jhu2hptn/JJLyblcP62j3DSxNxalcPM3mXOzaFS6cQs=;
        b=lEH4KJqrRTrIwAmYQ6m4EdSEMzz/YUZadTXJb4TjXuz2X1NH3aPhD5VtWKJ7hgvL6W
         4YINqvvdAnayetTrmzVoIL5DOyk9gnuoElXlhxERr6SD9lZas33aUYdfvEuow7zO31sl
         2hNViOibcrFMPCh5UfBEDsrox9Khor3hFZb0DgFi0v4+SpQ0NQbfFdXhCiykaV/TTo4r
         +ZLuuvHVhwRrOb+szU+Ey5LLIhAKX2fgpDvjCl7hS/GGho/7AMP4/hZ6H01qsm0IV3ZA
         dj+BkLvni4h++rKYo9CEI/yq4lQX8zPw7lJWdOj+PQ0RbIsQJ9aKJBHUnEFQ65vLezNR
         99Ng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=KruKb9aR;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=KruKb9aR;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Date: Thu, 12 Apr 2018 15:45:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: gregkh@linuxfoundation.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: debugfs: check pointer before access
Message-ID: <20180412144501.GE9929@sirena.org.uk>
References: <20180329122154.25291-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline
In-Reply-To: <20180329122154.25291-1-peng.fan@nxp.com>
X-Cookie: The coast was clear.
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596274473682349198?=
X-GMAIL-MSGID: =?utf-8?q?1597551993640936601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 29, 2018 at 08:21:54PM +0800, Peng Fan wrote:

> So add check here. When the driver pointer is NULL, return -EIO.

We should be providing a name if the file is there so rather than
returning an error we should provide something in the file so we should
either suppress creation of the file or provide a default string (the
latter is obviously easier and closer to what you have here).

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrPcOwACgkQJNaLcl1U
h9AFrgf+MLkMf2qCQPQMLNgb2uUfRgbAcfBbAfnPoXbtzroZerBzWhCgyok+XxZG
GFhr+NROZhDXQ4e5s801ivUogX2Fszo4xDT8VcGiEwcmsYCOclmRL/DwQDL9IAFH
2639qK8bkAzZpX9o4ErBPY5Yc9+TrmUQR3v44Geat/QbXgDg5zBBhHaymmfIhpW2
/QkeqJ5oFtOUHnyIvG8hsN8Z8IhlUsON19ztlPfcgcIv5P5gX6qJaBt8I4lj3NVm
4egORXJq94+iKW6BGbz+AqHeG+oAcWWdKtXwo5gIE/odKTZDsGGlhumgtimwgA1G
j8XppIKIURyxj2edyokPMsKwvcrXEQ==
=POPi
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
