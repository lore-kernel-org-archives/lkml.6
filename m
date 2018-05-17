Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZpU9PhFFdmVOYUQC8yTxg8H2g59a53ykYxhxq0MGDDmPUpF5am5mbGQOJJLvGgp7wVHnCDJ
ARC-Seal: i=1; a=rsa-sha256; t=1526577797; cv=none;
        d=google.com; s=arc-20160816;
        b=NEkdC/FTKDpkZu/gRxI3SunkqMiZll5lvFBUd8JoqMuf5b211MFEHjpjEuWA+dkJI2
         +dQ+kQF4MdnHVaeOdyu6cScwKpE+Ucs9e3hZeXwhdo7WSzjFV+UMWYbr0lvyXcVuiRQi
         52QGC/vPIotBzTciop4aFn7oQu7FQyic1HPdvXTJCnzVfVQZ1oGzM0I1nk/5RRENlMlB
         XdM8wJzkG53n/dpLE/EiDrNpAb5LmHL6RWtMH8ixfREB0Ha02eircEO5S/Xx28LfDLH8
         i6SXKIYAkJget1XUv5s22sRbhVtnwO5IfG9LoRcfCY8M6KHhrM+LHgzcL6N+elSbU/NN
         +LHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=AisXeNHk1gcBw3LmpxY/eGrk1JrIw3YkZOT6eyaE7sg=;
        b=uvrvo2RctNvWVROQ9KuFq+ZXTqX3+ZoAe1SEdqqTJkfqdh2CaiSDn+oNZC9DwHkjai
         HQO3ZSK10R8+vc/TPZwdRaeMsxs1WpKUz7pUNeewSxVNSSDyy96MEcLNYnnQYYrqKPDu
         0crMojMXw0s0hWpqIzpnXn8NDGWvpoFw+Cxs6SxOvMvu0RNqeACGX5lsvrs0NNDrT2GQ
         ozEWdqM8u50AsXmUFsk9zKbif1qdJS2fb8isF3gpLTI6ghAvUXNsmETiKtRoYCdp5RGN
         Lfbdg9DBPBFvQcLhb39xss2a2FHX+V0Ez+B5fPWmEQQr7nD9U9OmtD0ZLTTYTvOTasBA
         LrzA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=mHTjkW8L;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=mHTjkW8L;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 17 May 2018 18:23:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org, robh+dt@kernel.org,
	bgoswami@codeaurora.org, gregkh@linuxfoundation.org,
	david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com,
	plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com
Subject: Re: [PATCH v8 09/24] ASoC: qdsp6: q6afe: Add q6afe driver
Message-ID: <20180517172308.GX20254@sirena.org.uk>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
 <20180509125635.5653-10-srinivas.kandagatla@linaro.org>
 <20180517065544.GO20254@sirena.org.uk>
 <507b8b76-0846-a492-73e6-782b9953bc36@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TOkWJigZa0YodlBE"
Content-Disposition: inline
In-Reply-To: <507b8b76-0846-a492-73e6-782b9953bc36@linaro.org>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599991553144563990?=
X-GMAIL-MSGID: =?utf-8?q?1600732841215488558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--TOkWJigZa0YodlBE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 17, 2018 at 06:10:49PM +0100, Srinivas Kandagatla wrote:
> On 17/05/18 07:55, Mark Brown wrote:
> > On Wed, May 09, 2018 at 01:56:20PM +0100, Srinivas Kandagatla wrote:

> > This lock only protects the list, it does nothing to ensure that the
> > port we look up is still valid by the time we return to the caller.
> > That means we won't crash during list traversal but does nothing to
> > ensure we won't crash immediately afterwards if the port is deallocated
> > just after we look it up.  What stops that happening?

> Each port is allocated and de-allocated in dai probe and remove calls
> respectively.

> Lets say... So for this case to happen the dai has to be removed (unload
> module) at the same time when the interrupt callback happens due to delayed
> response from previous commands.

> This case would be almost impossible because all the calls to afe service
> are synchronous with timeouts, if any of the previous calls times out the
> respective caller would get an error, this should prevent him from unloading
> the module in the first place.

The user can also trigger manual unbinds without unloading the module,
and to be honet the scenario where the DSP has stopped responding well
and is delaying responses sounds like exactly the sort of time when
users might try to reload the driver...

--TOkWJigZa0YodlBE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9unsACgkQJNaLcl1U
h9AJvwf9GOcfk1SHbrXQgWUeZhYqtqeq7roCOu5AXTmB1UChVog1Pjf6l2Mf1yU+
PAWzywXIZHB2QCC8Gia0XFvOGsSFU4UNrnutGvw69HSkzVWNoxwwZ8Go/CNFlEYD
TJgABR2Ottsx5DblnHSwEVT2UjAKd1NKR/obMiVTNAbCiHHplvE09cBOQ+ysZwpO
wu/RakkwOPICIXqqwXVBGcEymLP2GmzE6BWZlIzgUdk7ZKN7OPUzjcbEYflixoBB
Yb/A+bjxkuN+8Nzsb6Y9ysVzb4x5/S2GSThQscb0MtGc8xDrjFzVA7nYDoxfAkQK
qA1P7H6maKckxnOQS+pvZHgtMDpkGA==
=6KkS
-----END PGP SIGNATURE-----

--TOkWJigZa0YodlBE--
