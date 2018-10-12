Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00FAC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AA22087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnYkKYac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AA22087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeJLSPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:15:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38727 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJLSPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:15:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id a13-v6so12915580wrt.5;
        Fri, 12 Oct 2018 03:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/b+VycXEgumQlj8+CR3YSCavTy78fDjvWdT9Eiibs5Q=;
        b=CnYkKYac89F7hBEZ8NGi5cADyHu39zTWiCsNMK+CmN1YvXAhJGG+9ExDQDEfzFH8V+
         eLtRSDWdyylbIq7k4nr2CvmMQXywOqUt1pAwMuBt9v2PBOXmMjCOfszpcdd7G2FlDuuZ
         pLy27ZOOT9oblvwnYpjjPY3+wkZRHm5KfXFCkGZ9Yx5H/8+K3+CUEmQAwDZCKP5uTGRL
         GRywzJEzDH3qpjVFuKtwX4/EnImas3kHkYSjqW0xvhLtBY4IelhyF+ZIPGZswMAEN/br
         hcB29Hbk3lkx05rhdywK76nirO2RwS9bNbJnfkgsgCpHC9Cd9J/LA09dY+h47Wxv/ZPA
         REiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/b+VycXEgumQlj8+CR3YSCavTy78fDjvWdT9Eiibs5Q=;
        b=TI16kab+rY7aoe/v1wMP/X/1SmJqQ6E0E1br4cCVgtSLYr6dIJK8jgCOXtRkh/LWBR
         Oyyq1Jp3uqibZizZ+mAGMHu3c7YzVBKX3P8wXQFgG682WdFH8yzh/EKsComzpJ2AawAM
         y/kSBJ3p+4lXeQHT/XIsYOYeebjQFzol84QiDbtQdBQBGN0fHPNwRxp699JJCl+XGPdv
         hWsEwPoyDToyBV7/u8bBiiJcFHVk/Tae5A7S0snchJjAb7bgwtmb5sjKMocZosdfOFHA
         8VOMyqXnY1U8STgSomtLcheO/9vdzWDM89XertNSuoEIjjVpR9kCLnspVsDXzIG+qUjd
         Ce1w==
X-Gm-Message-State: ABuFfoic6za+QjWeCJ7gikKMJUiWIEFG4rP6d9rhnTbLdJSN0zEeAZz1
        gPYtFQ6bFBHnfVHalASUcKA=
X-Google-Smtp-Source: ACcGV60QmXu0o+nBgCWf6g4L+FuZv4JBO5Ux5dxcQPPyb/kw1OVwuqdaZPo8e7t1mlu3b9opXh8USw==
X-Received: by 2002:adf:b743:: with SMTP id n3-v6mr4892065wre.274.1539341040056;
        Fri, 12 Oct 2018 03:44:00 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id y64-v6sm997203wmg.28.2018.10.12.03.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:43:59 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:43:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 13/24] pwm: jz4740: Allow selection of PWM channels 0
 and 1
Message-ID: <20181012104358.GK9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-14-paul@crapouillou.net>
 <20181012104053.GG9162@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HmK7y6O+lKZIGkr"
Content-Disposition: inline
In-Reply-To: <20181012104053.GG9162@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HmK7y6O+lKZIGkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 12:40:53PM +0200, Thierry Reding wrote:
> On Tue, Aug 21, 2018 at 07:16:24PM +0200, Paul Cercueil wrote:
> > The TCU channels 0 and 1 were previously reserved for system tasks, and
> > thus unavailable for PWM.
> >=20
> > This commit uses the newly introduced API functions of the ingenic-timer
> > driver to request/release the TCU channels that should be used as PWM.
> > This allows all the TCU channels to be used as PWM.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >=20
> > Notes:
> >      v6: New patch
> >    =20
> >      v7: No change
> >=20
> >  drivers/pwm/pwm-jz4740.c | 28 ++++++++++++++++------------
> >  1 file changed, 16 insertions(+), 12 deletions(-)
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>

Technically this should be:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--+HmK7y6O+lKZIGkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAeu4ACgkQ3SOs138+
s6HsGA/+OJEoG7dAfVGZx3RgpI7szDdd/ub5tyj8iEnxQJesIILP6jDs17mjzQ6g
jaDfYBESKsbVTJiOo/hpgekRsRFVmzZcDXwDAHM0w47OzDNNGT4NNBMNbg94ioki
hycEzI0w8Ty/K/uUBBpHfeswoBNAVrNn/xEE0Wp5ULvcak8AjfWj8gjkdSRgioB/
ghl5zGM0uVZzYjKKNCaQXEcCIO+aTPdvC/fHq5L6yBpfqwFh80OoxJlieK31uGMf
m59ZIkKQsPGvQSRZzuDZtwE6f9iQCBT+2BDebWwJjpUt4nC1oJS8biIEVC2UMEPX
94ltWiddkrj4DPpxZE8fqPhMFegd2cN1CmdB8WIkF6d+/K3LlvktsXmRULqWLI6z
7kF7mufd/s4KzIm35NkD+66+avzFcJYqGCvJMuk/aHAigqOXV8MVQo5zuHHLHl7/
C4KZaAQpXcuwfIt9blMHY+LxILA+vcWewhbIpE6397ICD1o8P//gKCBbQ2nQHAZE
+MtBHieUJMl6zjzsdT3PkifebmJxD0xXz9HdTH6xVR7l5tYrbaenGJwT1TsNYVnp
a+mpz7TXQozQTpXx0DoRrEgYa5Fx+arEMqsBctx9slWENPxwZWC2zyKCeHKYhrA1
vNUzJSXwmQozneec9SaJ6NKSqb/O9n1LOBC0rVV07OwrcuC5/cI=
=DqPs
-----END PGP SIGNATURE-----

--+HmK7y6O+lKZIGkr--
