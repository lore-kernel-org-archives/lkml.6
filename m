Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C8CC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7B82087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB9Sm96k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7B82087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeJLTsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:48:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41809 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbeJLTsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:48:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so13182778wru.8;
        Fri, 12 Oct 2018 05:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HHiomxREflJbl30efl4y1P2+SizY9IsFIPHoagxqN8U=;
        b=MB9Sm96kmH24VkChjSfO3Q7SnjsUovorU2iqY6vp1GBWK/yOLgFx9HiWMQxiqH/vGI
         PlLFZpSJwpA3HteWGN4eoSVdrdO1YZaZCv7ri5lBaCxfc7A7k/iMfzGCgunVQd/3oG28
         gJKkKhldDqQOxJrkK8evGVbzPwZvguCzV2o92UZCKlfKFwjEKY88BktduRHlyRldePnI
         cdJkZtC6JZNYKPk5jNnEEgtxRdNPFyLMszWn9g7ii23aRXKDFB/kudneH7La8rgHQHFt
         04c3GvpBleh4Re8X/vC0vq8Q9/xJafDoFu6h1bPjJ3bEAPLi6ZyAtB5Pa4dGPqjBdDrb
         0WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HHiomxREflJbl30efl4y1P2+SizY9IsFIPHoagxqN8U=;
        b=lT2SBfP4Egq4kVN0n9uWuQ1eZ6p1wTQdJRWTJ+0PLBr5qdJpNFfOZctEcPIHoC0CIx
         DPMsggtXHSqW4OXWhXOlWyi6KW9ysh+/wIFgUMXYoEJPdIZynmw6mWgnNGQ5diHllPMO
         IEfOMhzRm8lUNLQAA3i+pbUXi094vPenQTxAHvtWiBQZUModIrLzEDrSizkwU+BpHn2d
         gyMbtglGIaQfpeFK7Jf6wZIN1ydWZoiLNvPb84KFgBXXZtFPp0JJ42kLZms+6Glh8Sia
         T16GmhraVRAQY3kp0K+93chLQuhGMpmOEiUNH7O/y+m/16Omuwj6jIvCIB/XSwRs6GYj
         N1eA==
X-Gm-Message-State: ABuFfohy61JkoFxXKqcI3ZXifZdD2onm4P/Nr9vR1RE2NDISXbY/A6Ww
        aPv9dGAi3GMswXbhaZWQGsE=
X-Google-Smtp-Source: ACcGV63qDu5GYCslBSRnrZt+cY56yfx2pQ8S8qQYfav0jbZac/IHRxbj3zjEgMxbZeOsKIXX8vzp9A==
X-Received: by 2002:adf:ec11:: with SMTP id x17-v6mr5104409wrn.266.1539346554095;
        Fri, 12 Oct 2018 05:15:54 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id m67-v6sm1275069wmb.18.2018.10.12.05.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 05:15:53 -0700 (PDT)
Date:   Fri, 12 Oct 2018 14:15:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     shc_work@mail.ru, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RESEND PATCH v5 8/9] pwm: add documentation for pwm push-pull
 mode
Message-ID: <20181012121552.GE31561@ulmo>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-9-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <1535461286-12308-9-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 28, 2018 at 04:01:25PM +0300, Claudiu Beznea wrote:
> Add documentation for PWM push-pull mode.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.txt |  2 ++
>  Documentation/pwm.txt                         | 16 ++++++++++++++++
>  include/dt-bindings/pwm/pwm.h                 |  1 +
>  3 files changed, 19 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentatio=
n/devicetree/bindings/pwm/pwm.txt
> index 7c8aaac43f92..6a60c0fca112 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> @@ -49,6 +49,8 @@ Optionally, the pwm-specifier can encode a number of fl=
ags (defined in
>  - PWM_MODE_COMPLEMENTARY: PWM complementary working mode (for PWM channe=
ls
>  with two outputs); if not specified, the default for PWM channel will be
>  used
> +- PWM_MODE_PUSH_PULL: PWM push-pull working modes (for PWM channels with
> +two outputs); if not specified the default for PWM channel will be used

What if somebody has this in the DT:

	PWM_MODE_COMPLEMENTARY | PWM_MODE_PUSH_PULL

which one takes precedence, or do we reject it?

Wouldn't it be preferable to either move the modes into an extra field
within the flags field, or perhaps even add another field?

I guess since Rob's already acked this, that concern may be unfounded.

Thierry

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAkHUACgkQ3SOs138+
s6GvYA//VhYSRVNBzW3PbPthk9TMJ5k2nfLZjUjH7vwAEhSSE9MAEdP+M/ScAfpE
b++6J3rnvfzUciUZRJtlHRC6AO7GyV2/oiju6Qlfn3Sg+mg5B+e2TH1eTRZuy25a
8iUBaCGO4awJbTNFiYwO7NtgWRcdCvQijcvt1VM2iPI38t4a8GCPVSqbFmpu5y3B
NvCP1oEyRxa91JDgIUaLgewiYf9Bmeld6hNVhEUx8IlA3WTX1zoj+Jnpdbnwps8l
BHl6TuMdUWHzWPy31YVZp5US/1nuuIaFc0byl8UHzZ30TNdVOTxmHKzwUo2b5XPq
GyDqZHuy0e8GacggIDY6YTOG4sgd15HBp8pFlNZwYm8rJaJzRDYWBWdMFlwaqxzx
N6y42buFEaXUbOuXZFH675HylfhL8FCdiO/xfSAHsPWt032wfFrYoVBcIyNyRAAQ
Dj8o8gMKXGJtmeNK/CKrFFuO7ZqfvhSPa6we2iCQdxvM78XRutmpsxu4sr06FT6B
HnOIq1Lm7cqQqc4rZ9fQkWrj7FTDHr0zjGZUqIClune7X6gRi00wXZV+8MaSjbpl
ghDRISv3+5V7Bz4AXREQxZNL2xpLxiNFAfuhGIuSj+T4i4aqc1AvNDzwoXy9vSxS
8NVtXk20MV4CxF14GkSITHo1y8d6sDUDbo2xhINzWcbMxAFiBM4=
=Vkfu
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
