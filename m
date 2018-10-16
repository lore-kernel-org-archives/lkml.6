Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA28C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C057221471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHklnCrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C057221471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeJQF5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:57:09 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:43230 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQF5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:57:09 -0400
Received: by mail-ed1-f46.google.com with SMTP id y20-v6so22893426eds.10;
        Tue, 16 Oct 2018 15:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NXSAtxInDpav2TMfWlEdFVVydwk5NLD0uC7NkOBdkl0=;
        b=lHklnCrszkTaulrgZXfARRO9d77Wg+UDrSyaIEaly3GG8fB80q66Bl0brunxzs7E80
         KGZfHVG4jYvFGEow7yuwGk6w4fTqHakMt/vZzCop+14tndRJwrmKfJGBNf9Kq9V2oDeG
         MhTFSziEPWLymRgd3IlRYS+yiy/N3K6mPZvNRuLxzHjop5JICWlCVsXDrBZqBUEHCB5t
         nR3lD7RR64AoTupo8QA0c/kpeSB5W1q4UmTgKef0DLOZTf6W2eHg1US5SmfTE0ODpOwE
         BuonFXZkT6maYIgMRLAe/ve9sUGx7e4vq7wUVNwQY1Bq7knv8Dqx3CESKlensAEyqobA
         EgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NXSAtxInDpav2TMfWlEdFVVydwk5NLD0uC7NkOBdkl0=;
        b=bE41dXQp//0mtbfymWudQrZoRPoyKPz8fbmAFibBzdgepC1NzMgRA2PIX3T7zwXQqH
         yuZMWYBBa0pOvFxvTh0psHyfnFsYuvD0wOxWAiEvIdutqmNFH1HYLitVLk/4DnzxR5Lf
         2xrfLys9FLcLQ0V30w/TJ38XpJz2ZKhDkfaPS1NXf30BJF2Qf8bB1ZrmT97PykQgK7+g
         A3lqXr55mPEJ8mvGmo1tT5QuyeC9IhVexN4PjvCs76X1D7I4PfDu9ESUp08Ign5KZQxV
         IVhAi1R9I2HTkUa2YUgn0on9XOYwqgODiuclp4mJrCnVLHNRD+cVzVmHP3RgfNriCFt8
         jkDA==
X-Gm-Message-State: ABuFfoiaS9PrO9Ac8lPq/raYh8X11ZNjl4j+6uFmpiF7NG1qxDNkWg/s
        83ilAMB+GRqGau/3uEoY2plQKI2F
X-Google-Smtp-Source: ACcGV60rrLbJWV/HWOuoMh3CcWXwYK9mvu3bgZZd43NHgPJnF7Ok448MJxN+vpAVjYkAUDXN8aqYZg==
X-Received: by 2002:a17:906:4583:: with SMTP id t3-v6mr25076310ejq.210.1539727480103;
        Tue, 16 Oct 2018 15:04:40 -0700 (PDT)
Received: from localhost (p200300E41F201D00021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id f25-v6sm3258881ejb.29.2018.10.16.15.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 15:04:39 -0700 (PDT)
Date:   Wed, 17 Oct 2018 00:04:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Wesley Terpstra <wesley@sifive.com>, linus.walleij@linaro.org,
        palmer@sifive.com, linux-kernel@vger.kernel.org, hch@infradead.org,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Message-ID: <20181016220437.GB31973@mithrandir>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010134926.GD21134@ulmo>
 <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
 <20181016110142.GC8852@ulmo>
 <6e108e3c-15c1-b13b-ac3e-60c5eb209c7b@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <6e108e3c-15c1-b13b-ac3e-60c5eb209c7b@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 10:31:42AM -0700, Paul Walmsley wrote:
>=20
> On 10/16/18 4:01 AM, Thierry Reding wrote:
> > On Mon, Oct 15, 2018 at 03:57:35PM -0700, Atish Patra wrote:
> > > On 10/10/18 6:49 AM, Thierry Reding wrote:
> > > > On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
> > > > > +Required properties:
> > > > > +- compatible: should be one of
> > > > > +	"sifive,fu540-c000-pwm0","sifive,pwm0".
> > > > What's the '0' in here? A version number?
> > > >=20
> > > I think yes. Since fu540 is the first Linux capable RISC-V core, SiFi=
ve Guys
> > > decided mark it as version 0.
> > >=20
> > > @Wesly: Please correct me if I am wrong.
> > It seems fairly superfluous to me to have a version number in additon to
> > the fu540-c000, which already seems to be the core plus some sort of
> > part number. Do you really expect there to be any changes in the SoC
> > that would require a different compatible string at this point? If the
> > SoC has taped out, how will you ever get a different version of the PWM
> > IP in it?
> >=20
> > I would expect any improvements or changes to the PWM IP to show up in a
> > different SoC generation, at which point it would be something like
> > "sifive,fu640-c000" maybe, or perhaps "sifive,fu540-d000", or whatever
> > the numbering is.
>=20
>=20
> The "0" suffix refers to a revision number for the underlying PWM IP bloc=
k.
>=20
> It's certainly important to keep that version number on the "sifive,pwm0"
> compatible string that doesn't have the chip name associated with it.

Isn't the hardware identified by "sifive,pwm0" and "sifive,fu540-c000"
effectively identical? Is there a need to have two compatible strings
that refer to the exact same hardware?

> As to whether there could ever be a FU540-C000 part with different IP blo=
ck
> versions on it: FU540-C000 is ultimately a marketing name.=C2=A0 While
> theoretically we shouldn't have another "FU540-C000" chip with different
> peripheral IP block versions on it, I don't think any engineer can guaran=
tee
> that it won't happen.

I would argue that if at some point there was indeed a chip with the
same name but a different IP block version in it, we can figure out what
to call it. Sure there are no guarantees, but it's still fairly unlikely
in my opinion, so I personally wouldn't worry about this up front.

Anyway, I don't feel strongly either way, I'm just pointing out that
this is somewhat unusual. If you want to keep it, feel free to.

Thierry

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvGYHQACgkQ3SOs138+
s6Hahg/+NQ5CHvFT0bH8HcY8uoN6f7XFm/apwAkvBhdwjG5Cwrz5vvnWRk5T6kgu
Uwg9cLx/UDQPEoswnA6J7A/2UHzRojvLYhismbi4JPLxkTNEZEgwAN5VYbVrC1Dx
HBpFtfK30gXG207M27uMSOVf3xd4j1vYliUC662NG4cSOGZJZIjLRmooTIMPoYTk
ICh+GIvxgqw4PdgtyYGi1Yvi6upw9LqOSzUC0sQQNkQqZXv/4SwGeWxEGCOXNxof
Gvg3dUU5/N/jOQWlmZTSOuao1BeEUiGreLcCyv8PoMklYwFUJJlz0DauamuQGINy
WDtHAGcFiIRbrGNAVs59TSz0Wur/o3by9uRSE0UYfa2i2zrYE9PeNSGyunyeMrtu
VacYjYiGyUNRO20YGtn4/rHIOiPZT6vnFY+gj7q5T3q4KghiZgmoRhYHEagJwH8/
IwepyPsn3yKJvepitm1WF4oTQeyAYIIayTYKn25BXXtwv6T8oU6WYBDVvQttgLw4
m8kMf8DErLPwBBI8QGUGbrm5FpiJhX045kmRlSyqL6tXx/xopzNNdioRV7gRprE4
rBQfSrl90OxM9J58eUHeMmi/tasjlKAVmPoyUC04JyQM3IZIT/ZUYJ3sf/eYQigl
tjEHVAh68jtI8NJ1me9cT9z/7NoIDvG8qwQsFXytk51g7bu98DM=
=8BAi
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
