Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F0FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA0F217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3ieOM+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfBDHy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:54:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46936 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfBDHy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:54:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so13220697wrt.13;
        Sun, 03 Feb 2019 23:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UkL3QWILzswjBsIegc7wNw9Om/6xwyHoiv9eN+DbgHU=;
        b=b3ieOM+IbeEa3gDbYDeJlbSWPsPbcBPcmWMvl9Mcr48GtMhH81MNEIJtpI5/lKxo6f
         l0CJyqpY25/OK7dEjgtWSvRWQAc25KGUWpMAAqNkXih0/AYwzBbNYlqqKACfOIvDHKsw
         2N6WwVwqMhPGoYCcg4L7YEXMurfP2IGOWVqnysydQIIprwSmhd3K3m0WNv8e8rpYobd3
         oS4psFsd7oKCqkkHwOxBivZG4mRveQJuPnyg6FAvJ9/cVpWpVQTgbGirZztlApx25d/g
         Ks/+50IG818BgiYc7GaT06E5fJdn82+WD4YPuoqxPeMsUWSLaevJisknFNFfdZrBUe/Z
         XeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UkL3QWILzswjBsIegc7wNw9Om/6xwyHoiv9eN+DbgHU=;
        b=lq2F3qzfiLiHTuHtdnJOePWE2BAKnsidXMl/EB55WwdNzZ0Yfkd2Pvtqm5YBxe/dM6
         y2eK5mwrLN9ZX8QLWxpV5CxsUhFd6eLUksUy/ychHRXUYqYQkp5nKN2fHs7kJ1X4wWeK
         jPfuM38arZ1vLjA4Ynk0TqyZzbwa4SCAZN/xljENC+XLh0eajX+lVtAb6MIsMzsW7Gof
         8gPxZB+TujgmFm4ZJriuSzovmeHRT7J7n77WkjQfRCr135H7j7OLiPRlbhL79gFOjYGL
         YA1JtWspn9qxKsei3cdXLsbDPuW1I4jPBYqwMdl5FQLD0SHFAsmAtrbFlgVCKmJPmOyw
         yfaQ==
X-Gm-Message-State: AHQUAuZUQAWKF+P4lx9tx+mLofTgQxD7rJ6kTmizgKCbs/50skUpwueH
        x+Ebwnhvx/9BYPFXbU7ujqiSd/tIDBM=
X-Google-Smtp-Source: AHgI3IZhhcDEGz2ysS7TR67See+1FRdbaSZQVezC7NwJ7uBAj1xJ1K9WZMA7xFVEOdQhToxU9JPiTQ==
X-Received: by 2002:adf:e50b:: with SMTP id j11mr10496647wrm.205.1549266896486;
        Sun, 03 Feb 2019 23:54:56 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id c65sm11302143wma.24.2019.02.03.23.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 23:54:55 -0800 (PST)
Date:   Mon, 4 Feb 2019 08:54:54 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V9 4/5] i2c: tegra: update transfer timeout
Message-ID: <20190204075454.GA19087@ulmo>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-4-git-send-email-skomatineni@nvidia.com>
 <53b3f00f-b3a8-e1ef-b04b-1bdd5f5473ce@gmail.com>
 <BYAPR12MB3398D89D631E65C484DC8267C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398D89D631E65C484DC8267C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01, 2019 at 07:37:45PM +0000, Sowjanya Komatineni wrote:
>=20
> > > BYTES_PER_FIFO_WORD 4
> > > =20
> > >  #define I2C_CNFG				0x000
> > > @@ -893,8 +892,9 @@ static int tegra_i2c_issue_bus_clear(struct tegra=
_i2c_dev *i2c_dev)
> > >  		i2c_writel(i2c_dev, reg, I2C_BUS_CLEAR_CNFG);
> > >  		tegra_i2c_unmask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
> > > =20
> > > -		time_left =3D wait_for_completion_timeout(&i2c_dev->msg_complete,
> > > -							TEGRA_I2C_TIMEOUT);
> > > +		time_left =3D wait_for_completion_timeout(
> > > +						&i2c_dev->msg_complete,
> > > +						msecs_to_jiffies(1000));
> >
> > So potentially tegra_i2c_xfer_msg() could take more than 1 second
> > and then fail with -EAGAIN, correct? In that case we should set
> > adapter.timeout in probe to a larger value:
> >
> Bus clear pulse threshold we are setting is 9 (default as per spec) so
> bus clear should happen after finishing sending of 9 pulses.
> So 1sec is very long time for bus to get released and in case of ARB
> LOST whole transfer to return EAGAIN will be much less then 1sec

What if for example we have a very long transfer, say some 64 KiB on
Tegra194 and about 95% through the transfer something causes the bus
to lock up. The transfer so far would've taken something on the order
of 5 seconds, but we'd still fail, potentially with -EAGAIN, right?

Or is there some other mechanism that would prevent the above from
happening?

Thierry

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxX78wACgkQ3SOs138+
s6EljhAAt+MUmk+ZOHT9xpvGDUq5ASvO4Na15Hhu+NjQ6oA+voUmUBy1eaQBaeQz
lcndp3hcsUio6hhYpcuFv/3ltAgpJI2UuL3gYsDuNTWtwHuf4Sma52uSRvrx7kDg
kDZQgmJ4V7i2+8cHYTmvoOX2UCX5DaI9Xr7yZNcluJ8M8sGpUU2553Ya5MXH0jlt
0UWmpXtK97wtmvAtf0Uy7y1DtwU4uGLQFpurSvt985SfwlfhUmjJwAO0ZNstyBxv
1OP0ht11nMjYrGxxuUsNpycTzpmCzdpujTTtH5VrvXdl7mUEbwHMyNqbLmUmc7e7
6o0wG7cABcRTYmEOylxsQZwm7slncDZ3fdDanhdpFR5Rn3Nf555wBWJ2aFb/ikhF
cSju4Cr3jsRIAFJQ+fjqONohgINtG4Squr7V54DzDpr3rKyLEFBXRPXENAdzwETa
XoNj9M8oupw8g240RAiWzz7/LcBDtSYZomCQcFFGtMU90DePXuPhEaJ4K0DdDjE9
HV3fn4ahH+VdAjT3QUtSLutANh3tJGZKH+drYqdIt9D5j7RRX+Dms6Awdljh4HPs
4gavF4OBDzDtW9sQZB074LVSY+5fBqYlJIEHcMXRWnqfHM0Es6R0ecJaljU9zSe9
5LdQ3UhbjVOkCSyh1QPcpTWro1i1MUsNKXbbF0jFPFmC4Nfel5M=
=70Q9
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
