Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZodj5F8GWJRIHqKZY+JvD7YakZi5owSC+M6NQqpQHfVF27l8tLicAPiTJOh0tbY41zazRGw
ARC-Seal: i=1; a=rsa-sha256; t=1526575497; cv=none;
        d=google.com; s=arc-20160816;
        b=Rgh4pGtpviR9y1XqpM7KmGGsw99kc7e8WSxYg0sqehgxewq5bYvDrHUc7ILXjXALaU
         qHoOw4wEMs9TNU+ZyBJOLsqQWzP0O6cNk/L3bjVt2E2jFoyLqtKRv9HQjQbz5wuGo84s
         jd6B3XYTth9UWcU2nI6Te+DIW1eFJbzZtaMdlOSTBBc+F+pKM7xzPJOk1IAvpoxUAYy7
         Z8s2S40P8rd4v+Fotz+SksyOiD/5zeCOpxco8thpHaQ+R37X/YE/O1RcX6AHFX3SPbiQ
         gqD9y4K8TeA2NgKPby7uqBbtcjZE+HAQGiqzHuWN9/wyaNIR/Z6k25IT/NVjjWOvct/u
         zPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=CGWWz9P2cUt3iHndFHEyAO7AE2j633+x5adA1M1iets=;
        b=lkTL2zPaMnmAU0R/11XX2oDe5TDsu+rdB0H8DLSQjPbigzeI/wlmcxnPeVrkhkq3WA
         9KJkWZmy33T9bbJHFdWB1nA2ToJtkFWDbfQUT8Ochmb+fUfucFQ4Hj3/1S6BVFAjSNOf
         M9jljXtn7vn2MGp1IVHst/QPGmKzhzI2GSyhY7MgVCpjEJPymFwvm85wvfmLZzcXMdq8
         /aSgX7a/eFMDU4/5Y3bDBBGLXWvVtPmdp4KCIwZl50vSdbTc5a0NRQYolnkYnBYLVwRh
         fhu4xPUD7L/OUCFGexnld4clB6FuWVm1aQU/uw1f+STBtQO3hR5+26T0KTqDsDIrJwF2
         1h8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=IKF9AxVW;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=IKF9AxVW;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 17 May 2018 15:55:44 +0900
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
Message-ID: <20180517065544.GO20254@sirena.org.uk>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
 <20180509125635.5653-10-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UOYwgDhKKQYesrzQ"
Content-Disposition: inline
In-Reply-To: <20180509125635.5653-10-srinivas.kandagatla@linaro.org>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599991553144563990?=
X-GMAIL-MSGID: =?utf-8?q?1600730429397463008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--UOYwgDhKKQYesrzQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2018 at 01:56:20PM +0100, Srinivas Kandagatla wrote:

> +static struct q6afe_port *afe_find_port(struct q6afe *afe, int token)
> +{
> +	struct q6afe_port *p = NULL;
> +	struct q6afe_port *ret = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&afe->port_list_lock, flags);
> +	list_for_each_entry(p, &afe->port_list, node)
> +		if (p->token == token) {
> +			ret = p;
> +			break;
> +		}
> +
> +	spin_unlock_irqrestore(&afe->port_list_lock, flags);
> +	return ret;

This lock only protects the list, it does nothing to ensure that the
port we look up is still valid by the time we return to the caller.
That means we won't crash during list traversal but does nothing to
ensure we won't crash immediately afterwards if the port is deallocated
just after we look it up.  What stops that happening?

--UOYwgDhKKQYesrzQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9J28ACgkQJNaLcl1U
h9DU0wf+Jtg3rkURqsNLq9Q51w6wZOr5Z1t4oGjqjm177dzbIX0kk0g+c1ZhXwXg
+mf5+FHVn/KLccGKF/FC9P/vqyi6woA35Rw+QCofo/yQDM46Zzf7Fx0uu2A5nwle
C8ikwuP9e3ubGeRACgUc+y02tkc/HtxN/q5QeEb/6tmVDC+5sNTBRbKkvarql/uV
vgOFSMarPI2jXj0w6ckSKzh2RTKVqsTCmbs2CA+n8F2L2DddcGpO2MmI9CGihAJE
ZWvl1NSw84lrPzT8+zepPvBAGc46WdAZdQSTD6NCpemz4whVLWyWsosiXSPuowHb
ezb4siubq+6OXdKqCrLcz9yLhWb70Q==
=+I/X
-----END PGP SIGNATURE-----

--UOYwgDhKKQYesrzQ--
