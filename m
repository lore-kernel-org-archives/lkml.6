Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9B9C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774A120879
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcGW9VhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774A120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeLLKmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:42:46 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37747 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeLLKmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:42:46 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so15141127edb.4;
        Wed, 12 Dec 2018 02:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2i6QOHHjflGb6wmoWSrtYBez+X6La02TBVxROJGnN2c=;
        b=mcGW9VhJIobR5WuaI64lJQis8m841bRfjqNsfLOAaIFq0Lzdn0xrhQ9kZhpd4hAmTZ
         f5WH9RUBh59kXG0Rgh7S1dL9MFbHdai+MT9zBK7PrJ6dHpDJCEodJI73qShpRasm4/Hw
         Z7olTNdLIx8jvj6DmsJVAGtdFQARl0JokFA8p/13FvURFLknNPqTkDFktIuXrrQi3rer
         +3kiXAl0aS3VbOFDeU2FK2VECg49hLoTdqD499LtilSgrSsCUkHLpuNAlT2zPgAroFuD
         yA7fc0RfgigutDkpytcaSVY9BdnminOTd9RY6PEyFPYrbxhMmH9rVZeJ5ugry/yVNKzP
         aqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2i6QOHHjflGb6wmoWSrtYBez+X6La02TBVxROJGnN2c=;
        b=K0wVhpWHgrDmXDynR4RE98j4CgsWeVI6b6L0BLQpmW+ioPTnuAHfWd3Qo5x6JaNDgx
         xoVmf2qVY8bCWPFkje/Q16+ggxU2FvtIdbw3jMhGzOVs65jwQTmAA1ix8Kwg/frow5O5
         JCbN1/yDNuaVNRzn1UxG0clse1qc2v2ECvrb1n7RelO9uNEbfyrY3XHJxG/V65dICMb0
         qS/ZERd8yrTG5msG/o2kVGWmJJ211rV+h2tuna7DHOsz2QkHDrpiaY/bc0OW/wHsUX/0
         y36Xcur0o/KwtsQHDVfMjvT5/P30GTj4WaZs4IUKrYPf5rVuu4dwVax4C1L3l+2EjHvJ
         cT/g==
X-Gm-Message-State: AA+aEWYzGROI02CM6CKaGTMGmDfThP5P/xSxJTU0n1ZZVuL0hVr+y0Sy
        GY1FyThdM1OabTzOmsud/60=
X-Google-Smtp-Source: AFSGD/Xe0GHS+yw4OL3tTZC7lpCAunUG3VqCtBB1B9izoGr1ToGI1P93Ur7QsmlbcwznGMVqF9k8Cg==
X-Received: by 2002:a17:906:5a84:: with SMTP id l4-v6mr14947924ejq.229.1544611363806;
        Wed, 12 Dec 2018 02:42:43 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id y4-v6sm2575766ejc.10.2018.12.12.02.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:42:42 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:42:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC v2] pwm: Add Xilinx AXI Timer in PWM mode support
Message-ID: <20181212104241.GA17654@ulmo>
References: <20180322135316.19685-1-alvaro.gamez@hazent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20180322135316.19685-1-alvaro.gamez@hazent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 22, 2018 at 02:53:16PM +0100, Alvaro Gamez Machado wrote:
> This patch adds support for the IP core provided by Xilinx.
> This IP core can function as a two independent timers, but also use both
> counters as values for period and duty cycle of a PWM output.
>=20
> There can be many instances of this IP in a design, but the first one of
> them will be used to generate system's clock. If we were to use this driv=
er
> against the first timer instance found on the DT, we would expose it as a
> PWM controller, and reconfiguring it will break the clock.
>=20
> To avoid this we add an attribute pwm-outputs to this device declaration.
> This new driver will fail to probe when pwm-outputs is different than 1.
>=20
> We could use a boolean, but future versions of this IP core could impleme=
nt
> several PWM and counters, so when (if) this happens, we would only have to
> adjust the pwm-outputs comparison to allow more than one PWM devices.
>=20
> Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
> ---
>=20
> This is the second proposal on getting AXI Timer PWM capability into Linu=
x.=20
> The other alternative, which was sent un June past year, didn't look for
> pwm-output attribute, so in order not to kidnap control from
> arch/microblaze/kernel/timer.c it used a different compatible string. Tha=
t's
> not wrong per se, but raises the question: can one piece of hardware have
> two compatible strings depending on its intended use, rather than on the
> nature of the hardware itself?
>=20
> If there's interest in mainlining this or the proposal I sent last year, =
I'd
> be grateful to hear from the devicetree maintainers and maybe approve or
> suggest any different aproach.
>=20
> Best regards
>=20
>  drivers/pwm/Kconfig         |   9 ++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-axi-timer.c | 204 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 214 insertions(+)
>  create mode 100644 drivers/pwm/pwm-axi-timer.c

Did any discussion regarding the above-mentioned issues ever ensue? How
do you want to proceed? At the very least we'll need some sort of device
tree binding for this driver, so perhaps start with a DT binding
proposal and take it from there?

Thierry

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ5h8ACgkQ3SOs138+
s6Eqvw//dWmvMrydYl6c8WeS0Y8XwZY64KX/7cExH8bO6PvV/+WoPzyrIXW4CRDP
oPSIkzrGvg04uoNYs/5lI23t0pxu11cSsG1oqZJcbJymRyv4HzoaXk9eek6OCLff
Z3emfLCGplLrR/vpL9lIvatGUGV35JiQ8FC2KSEPqwRU3TqKxJEWu/WcT5JwCO9f
qI99RS+eef5rzoUiiekePrkQu9U9FXlnLszTyp9bm+vSCHvjWaKfBADPEIkieCXv
+KvqjGgCZq0r88Hjk/14Cp1XGda9hq0olKKYyXFrQUIT7dIULycpp/HehjLr7SrD
CHzOOKNGf4el5KZZNsWQGTqJB0LjgoMne8gEe4+T5P6F5Dh1Q1nL09H+HWUKmB5l
JASjN2cQK/+CC/GCx0wtkt/ESw10ZvQb8Ln3YFGHmNRkO4rYkzWTL6Y3hZ3d9QA3
mU0KidpgJwvxCaEaTf6n7DmEs2VkbZnaMaQOaEndvfcIrPhGpzsUNEqqXKc1JvXd
Pa6DCbdlhN0OiYisPGn3ZmFlOlvLZVBBhYunL1rJWToP4R9vGyIQXo7m/BhZg7aR
F1I8D88eSW4wy3oLA4QPgJJyr8TDE3Z7InSZCEWkAcYZrNxGOHFqeWyhKYpex0+e
uW2VUXRbmSOCAnM+eqZE9GTUSj1siQ/M5v7XdctaoI9Hdu25prA=
=ri20
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
