Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D1EC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B7320869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cno5bz7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B7320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeJPTxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:53:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37678 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeJPTxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:53:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id y11-v6so25162983wrd.4;
        Tue, 16 Oct 2018 05:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pvWDmgSQPmhqCK/sJeeJF1AlKM4j4zXTNV+W7gSPBjU=;
        b=cno5bz7mj69G1wh5tp+P3UWwbt9qkDTokMS2fZJw2m1/f7BiN91v7ICIMjUGy8slH4
         9HBYp7jFY+jP9uL3XaoLc68RNKKC57pxcaFRbFa6JVXKTukXLiwRc7qmGOgFBMsI9y2I
         sg5KdyRBZdQdjdjG0vd6U47wBxtQmAF+do8I/rbBx8DKP4cCZR8l9IKVIoDjgmHcWlGh
         8wY+bKdkg8jlgdyL+Ltzll7n0BahwDxGVgf/nSdXZXpaPzTBXMqWltpDwiiQMf1hLcZp
         uo125Tod6eIQIsLjq2hyMisrt7HXekmu+End1z3wARpxgoXD7w/V8CPhfrTmnexoG+OS
         4v+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pvWDmgSQPmhqCK/sJeeJF1AlKM4j4zXTNV+W7gSPBjU=;
        b=tWv6jFVeIAtb4qZFXuY4gNIx5zA486kMgh5/txbJAViYk5q/iS5KZQuQmGGn3p0Qtx
         oKiiioxNTdWYz15QWkNoxA5tb0ISjSttnEFdypuCj8ea8oHdYqepvjg64dDT0ZOBHiNG
         w/cACVL49YfsZ1FrH/r/SLFk1e15q7vUNDRVzav9M3UZbRE8UvFIrSs3A1K0NxeStc5H
         YmGpVed406xigOX8Fr9rWSq22vE/OwPexMeRIwr8EzgurW/xp1Siq68qFc5oDfZ2PlaN
         Srrk2quBpBT6yc2EOD8bu2ydHMUG4dUkUClAYLFkNqy+Ymhp4KAdYWflmmn/AFvYGB7L
         uZ4A==
X-Gm-Message-State: ABuFfog+LPZDc1B0m25u22iNuze2Mmi2FL7rHxMn3x5rQpUAw7J+UW6T
        aHAXF00eF9DGcAEzjmYCrWM=
X-Google-Smtp-Source: ACcGV60HU7Zkc6KJUaMeWr8YGTzxX+eZETMQm6z5qtKt51m9sKyLxFP03yWngjJWhKv5xaFBFpOb4g==
X-Received: by 2002:adf:db45:: with SMTP id f5-v6mr18600673wrj.237.1539691404689;
        Tue, 16 Oct 2018 05:03:24 -0700 (PDT)
Received: from localhost (pD9E5106D.dip0.t-ipconnect.de. [217.229.16.109])
        by smtp.gmail.com with ESMTPSA id v184-v6sm9996996wme.3.2018.10.16.05.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 05:03:23 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:03:21 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, linux-pwm@vger.kernel.org,
        treding@nvidia.com, shc_work@mail.ru, mark.rutland@arm.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [RESEND PATCH v5 0/9] extend PWM framework to support PWM modes
Message-ID: <20181016120321.GG8852@ulmo>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <b95d0de2-1a97-36f0-03ad-3b5e52b1fa5d@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Content-Disposition: inline
In-Reply-To: <b95d0de2-1a97-36f0-03ad-3b5e52b1fa5d@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2018 at 06:20:48PM +0200, Nicolas Ferre wrote:
> Thierry,
>=20
> On 28/08/2018 at 15:01, Claudiu Beznea wrote:
> > Hi,
> >=20
> > Please give feedback on these patches which extends the PWM framework in
> > order to support multiple PWM modes of operations. This series is a rew=
ork
> > of [1] and [2].
>=20
> This series started with a RFC back on 5 April 2017 "extend PWM framework=
 to
> support PWM modes". The continuous work starting with v2 of this series on
> January 12, 2018.
>=20
> Then Claudiu tried to address all comments up to v4 which didn't have any
> more reviews. He posted a v5 without comments since May 22, 2018. This
> series is basically a resent of the v5 (as said in the $subject).
>=20
> We would like to know what is preventing this series to be included in the
> PWM sub-system. Note that if some issue still remain with it, we are ready
> to help to solve them.
>=20
> Without feedback from you side, we fear that we would miss a merge window
> again for no obvious reason (DT part is Acked by Rob: patch 5/9).

First off, apologies for not getting around to this earlier.

I think this series is mostly fine, but I still have doubts about the DT
aspects of this. In particular, Rob raised a concern about this here:

	https://lkml.org/lkml/2018/1/22/655

and it seems like that particular question was never fully resolved as
the discussion veered off that particular topic. I know that Rob acked
the DT parts of this, but I suspect that this might have been glossed
over.

To restate the concern: these extended modes have special uses and none
of the users in the kernel, other than sysfs, can use anything other
than the normal mode. They may work fine with other modes, but only if
they ignore the extras that come with them. Therefore I think it's safe
to say that anyone who would want to use these modes would want to
explicitly say so. For example the sysfs interface already does that by
changing the mode only after the "mode" attribute is written. Any users
for special use-cases would want to do the same thing, that is, drive a
PWM in a specific mode, on purpose. You wouldn't have a "generic" user
such as pwm-backlight or leds-pwm request anything other than the normal
mode.

So my question is, do we really need to represent these modes in DT? The
series currently doesn't contain any patches that add users of these new
modes. Are such patches available somewhere, or is the only user of this
supposed to be sysfs?

I'm hesitant to move forward with this as-is without seeing how it will
be used. The PWM specifier flags are somewhat abused by adding modes to
them. I think this hasn't been completely thought through, because the
only reason to specify a mode is to actually set that mode. But then the
DT ABI allows a bitmask of modes to be requested via DT. I know that
only the first of those modes will end up being used, but then why even
allow it in the first place?

And again, even if we allow the mode to be specified in DT, how do the
consumer drivers know that the correct mode was being set in DT. Let's
say we have a consumer that requires the PWM to be driven in
complementary mode. Should it rely on the DT to contain the correct
specification for the mode? And if it knows that it needs complementary
mode, why not just set that mode itself? That way there's no margin for
error.

Thierry

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvF04cACgkQ3SOs138+
s6GG0hAAlC2Z3aJHAYoeHw4ddR2xifXrA2kY8m2t9zCD2M+xV2MKYEfTrCDdcFwE
SqIcFv/5rxHCpuxRCe2iaAOEHmg8BbJzmmil00WJ09J+rRCmkQDuaIoiFZTbHfxg
6LJY+qofpaNOXT5VwIM38ZD3Qgp8/+kyxTKZ6bWe5dvBq/36v21A/3rTA2Xm4BEv
SzaaCcIkULGvRAEpqkolMXok/QoE4R7tf+9N9xD76YRYAfLl73tqoZFf4JUubFuN
r3KtjmYX5GuAB8l/41tMidbC91zlFs9H2pd/bz4oyzwb5f2A+gHoGuZMxBQfy0kh
z9vqS/PPnAzDoCZ6RsB3kU/P82ZcHydcfvtOIfwpZjJybiwiSD3eXQdbTgVrx/nO
FmKZ7quScUQS0PyY9j4h/XJ0Tml8+9/TAsdlOORMjIU2kpQLhXWYlWDG1RAMlpMJ
PI+z4ATJGZv0XDDXaDGFxlQ2z4v/+1kANLgd2V5sBUwcQIxRHGD+lDGyL0+8WJXc
C+X9YVxYwut6rfm0dr+f9YBeq+ffT2RoDejHL6bmYB7KOh8HRbJaeNF3uqbYP0UN
2K4c+P0+1xFk/fQqi+NsFYJp0QCBcaWQigrfPNR88BxHh+R6MoGu14aDWnxTohsO
/TJGLriOaUGybg4pyRCA3kW0iODH2U9xSwGh195PYpUM/DC0oCc=
=c3h/
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
