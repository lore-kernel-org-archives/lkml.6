Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E48C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E452175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdF0Swko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfBGQCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:02:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53478 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBGQCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:02:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so399051wmb.3;
        Thu, 07 Feb 2019 08:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GS4CC/2jT2E7yHXh+Rz7JzatxjeOauOkRt/Zu/kp9P4=;
        b=WdF0SwkoeZCjNu5eDeIMLob8iP/5m5HXsw9KtlTxK3RjRYCmhp3OXP81LJfDp6tHtH
         mbets4cZp4d30IxojnEtVGNe+tQwMbGFhlr5XBgvAPOfFV6iDLpEEa0zfIooswd61gGe
         +mUF/GHo6zH2hVWd6k45ZVdXyHYEFkFxuk6ED93nWd05gofZlUMDLUQ3veF31/SSNuS/
         Wa1DgMHXMfMzc37wv3JVB/bIfNl9gWJZj6e/sVZ+6hZ0s5nuwrpAeFICOUpfdHHBtaoK
         1dDMRvSt5A5d44PPbGLXCsdYo9/p38+YQTI5S1lIT4mGKzLkhmz0LuyQZmvWi8gRJczh
         3Slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GS4CC/2jT2E7yHXh+Rz7JzatxjeOauOkRt/Zu/kp9P4=;
        b=DZbthpI51AMb1akNvLa7DVJFAL+V0tSK2YGrrJfYRjLtuLxsUBvv5janZRlE/CxRgU
         ZBVm139vIRAuHMdeyIMotlOmrAjnMdEWstlLg+mMsEoV8Ec/i3DnXxZBvZVy8RSjeF8j
         BotHw4oU/7yEHUK7sslVlHK7a9KgpVM07B2wuKZ6iV/B0aoXqjykLSWLkDwquns2j7My
         BsDpzedtushzXF3jth/0oYOhVTh0Eyqif1vl3gaXYJnLW5v8F63JJR5lTITi1lFp5g/A
         PuR4NdxXS3ubUfDMsyXfHo219O7aNLsASOw0Xrx9m4B8VUWfchCZ7zatHVIDx3OJK7qr
         6c6A==
X-Gm-Message-State: AHQUAub6vj69d/OfNTQRT0MTtwdSh3+2J9AkenYQdvPm7dP48ml7CQnX
        pSICH5UbGfn/jb22JGrCBBg=
X-Google-Smtp-Source: AHgI3IaHVB0DKz23P7YFKJ7yhBa6Xf+eAB3aKsZfdLXChs4j4HxdyI9H/wbDAwt9WuwnDZqD7V8rwg==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr7373775wmh.43.1549555349120;
        Thu, 07 Feb 2019 08:02:29 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id d9sm14044wrn.72.2019.02.07.08.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 08:02:28 -0800 (PST)
Date:   Thu, 7 Feb 2019 17:02:27 +0100
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
Subject: Re: [PATCH V14 3/5] i2c: tegra: Add DMA support
Message-ID: <20190207160227.GA17445@ulmo>
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
 <a6b1acbd-9be0-62b7-29bb-081d93ee92fb@gmail.com>
 <BYAPR12MB3398712D185CCCB345EB2B5BC2680@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398712D185CCCB345EB2B5BC2680@BYAPR12MB3398.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 03:11:06PM +0000, Sowjanya Komatineni wrote:
> >=20
> >=20
> > > @@ -1124,6 +1453,10 @@ static int tegra_i2c_probe(struct platform_dev=
ice *pdev)
> > >  		}
> > >  	}
> > > =20
> > > +	ret =3D tegra_i2c_init_dma(i2c_dev);
> > > +	if (ret < 0)
> > > +		goto disable_div_clk;
> > > +
> > >  	ret =3D tegra_i2c_init(i2c_dev);
> > >  	if (ret) {
> > >  		dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
> >
> >
> > Missing DMA resourcing release on probe failure.
>=20
> If probe fails due to other reasons, then I2C interface will not be
> available and boot will not even happen.
> Do we need DMA resourcing release?

It's also possible that probe will fail for one of the I2C controllers
that is not critical to basic system functionality. You don't want to
leak these resources because it's bad practice (other people reading the
code may conclude that it's okay to leak resources).

Also, if everyone is really careful about not leaking resources, it
makes it much easier to track down leaks.

Thierry

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxcVpAACgkQ3SOs138+
s6Hoxw/+NcIdkyYd3PVqW2LsaKXT0vVD59qHSMamsVIWFn8cte8syifEDmFLDvi0
uSLGliFbyPprH9xDtZd0ZZ8KwGlMe8XQbU22clpsvtZ+fj1qY1KymRfxrH8mfS4t
114rQAcewGmpMJSWBmaV+g1kgp397E4FtwFUsdKZcWRrQXAFlNyqZFYQVKg1zUmV
w28rJ9faQeWy3c5H9+LQhzJMC5kBGgN21J37sHwCchwnBtVPXnIojh+nfpDfwE5y
tJG2m6T7YM8VGyvJUpJaz0iVYU3ELxqACCS7y4EPRefb5x9n0Wpm+7jbeSDo7nyK
E9YQd2sqVBQz1qL4EApF7Y3pUyPs44Ch2FdsZwLnp/ynFkmP+s5hPWSLVw8yOGve
5kq0G6uKATVYgy/79eXGynhBF6kLFtUiaEg38OAC5BPWtmk/Gpc75tVm5KMR1c65
asW2hXb0Fa+4Jp4PZ83nHJNsj8DcQX+yRXPPsHnhddWsKmBU9lYIMZxWhQjEAAZ8
54oRd67M4ceivxwut/ew1QOgMZhqQ6YDoDbX3VZ+0sFUXQPOUEsOYiDBOVuNw/cx
tvhsohTL9OkrFKdFH2Y30ax8sO1nWstj1Vj5nIajZqVr5q47WEZRMqTaQ1ssHsrM
wT7Xq7KRBQu3E1uBGVAlcLyiShce61ONjdgi+SckE0WlCJeqJsM=
=TjFG
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
