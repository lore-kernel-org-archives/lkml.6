Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5228AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF87A2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD/+lEDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF87A2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJJVLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:11:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37063 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJJVLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:11:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id y11-v6so5828868wrd.4;
        Wed, 10 Oct 2018 06:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oZaJguUzxuy0QaRGzElsePFhOHzRsa8gD77wQ03IE9g=;
        b=nD/+lEDA2oav/aFzC1wp2IS+CytYyGVix6tT03s8/xULXU1+t8qdVGJw4MISiVpkzD
         T0oIbc8N4b8pMkuGqTJWs2CiGsRpTrAdrOCj+x2slG0eU47hE2Rgub8UkjTknR1usgMS
         V+TYIIlei4V+nmuDJ6avnsbxpqtpp5IbjqHcrCV1Sc/kZ/6QgHtNdKz7tfy8CrSkBDkk
         8En1WSVz0Cqi3JDVyI2ACRdcqsNS+HC1/KyssYvVOlRyznJTnUuUqOVO/tWfrAwUXdjI
         op/8qJ/v3EZgfvPhuLRgI9XK4z7GXABPyR1brj3gxOePbI5kGzqW+G9TMqT6rnMJ/G2J
         IuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oZaJguUzxuy0QaRGzElsePFhOHzRsa8gD77wQ03IE9g=;
        b=rLnb7YGEQMEorq4N/AmVolhSWymePDV/qVRkuVW7EslHWosI49O5pRRP51YwzcMa+A
         Uh4Di0DPguMslaP0vrhxuWmXOILbvlJ7Q5DZ4QZzzEPlKFfaFEY1JZpOvilVW0f2eQn7
         LWo1VpdfhtYVGto6BYccL8wrMJwNV8cLad/uuue8MS+HIkohSYxxN8zwJVdq0F7Dlt/f
         lquD8pHEvSRRA5MyeCxbE1MsIhsFKU5MTkwOE2yoA0aq/vJH2NIVJFvnQY1RJ3GehAkA
         kNp3PffIU3ltkQ5lPbMHGBHj2T6hhtWZBSkNqAOoBr8c6+V6oKgtFu1ZFsCux6pxVNJt
         qQcA==
X-Gm-Message-State: ABuFfoh1oYy+J9sOCoLzGKn/5eT3OAkfE+dPp/5jOygO6ni/F6J1PaWL
        YtuNE1xHCHAPju+i7McnvM0=
X-Google-Smtp-Source: ACcGV63XWmpAwazIBDC322RbxDtXlA1MXsfA6zHBXCPiJxywyvsaDMWRGoha3iQKYkGGQgDHtS6eAA==
X-Received: by 2002:adf:fa04:: with SMTP id m4-v6mr22240158wrr.182.1539179368102;
        Wed, 10 Oct 2018 06:49:28 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id r8-v6sm25003814wrm.14.2018.10.10.06.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 06:49:27 -0700 (PDT)
Date:   Wed, 10 Oct 2018 15:49:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, hch@infradead.org
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Message-ID: <20181010134926.GD21134@ulmo>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
In-Reply-To: <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
> From: "Wesley W. Terpstra" <wesley@sifive.com>
>=20
> DT documentation for PWM controller added with updated compatible
> string.
>=20
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Compatible string update]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sifive.txt         | 32 ++++++++++++++++=
++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Docum=
entation/devicetree/bindings/pwm/pwm-sifive.txt
> new file mode 100644
> index 00000000..532b10fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> @@ -0,0 +1,32 @@
> +SiFive PWM controller
> +
> +Unlike most other PWM controllers, the SiFive PWM controller currently o=
nly
> +supports one period for all channels in the PWM. This is set globally in=
 DTS.
> +The period also has significant restrictions on the values it can achiev=
e,
> +which the driver rounds to the nearest achievable frequency.

What restrictions are these? If "nearest achievable" is too far off the
target period it might be preferable to error out.

> +Required properties:
> +- compatible: should be one of
> +	"sifive,fu540-c000-pwm0","sifive,pwm0".

What's the '0' in here? A version number?

> +	PWM controller is HiFive Unleashed specific chip which warrants a
> +	specific compatible string. The second string is kept for backward
> +	compatibility until a firmware update with latest compatible string.
> +- reg: physical base address and length of the controller's registers
> +- clocks: The frequency the controller runs at
> +- #pwm-cells: Should be 2.
> +  The first cell is the PWM channel number
> +  The second cell is the PWM polarity
> +- sifive,approx-period: the driver will get as close to this period as i=
t can

Given the above comment, maybe "sifive,period"?

Thierry

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu+A2YACgkQ3SOs138+
s6EnhBAAisb2txXuWgUYVwXrt00c7mGjqT9MoPa2RqflyVyREJUhfkZ6cx6C3s6N
ofs5/qGuivoKkknjcTwM8eRoPCvQU29wvA6qBwBwXi8ZHNqconlKZ/kWukNMbzJw
Lg4IT0JKjgHdOzqzLCB/OcD6O8vw18ZmfpVgzBIa/cbmOm140nO4HJcWSfr7QYNt
J32OBqTzOv1ATNjiSL6R+SFkoFTeedrwBDyjWK07P02kEnxJFLC8HGukTz9Kp7dr
75N658I5yoQ/DNvlDfamGAqMGVP0+zRmxz85zWC0XrZtIAlXRlMvaADQiRbF82qy
i2HLlFRV+qg5H/MgVF8aSHPgYX/EER2NFlbfrnSeDDRFS/83sWFPsQRzkbjqOBzI
UXODeUTaU1wz1dFnC800JDwnWCp0hVNwQyasYTv6eNU/YV673tiTTP6jBC/WwSUW
8LZn30e1lKznFwd1LMusco4sZ6NLxIwpgAnXEx4Sg9PSsUSalK3ev+/CXFVQSX/4
xLEkYzr5y+4i4Sg6ncfJBYuO19w1iys97pUbgjKshu1OWNh311pMtUh4gU4o+3FE
Q7u3Jxqa59HNjjWgNxhc89LO0StDrjmpF2wlPnQuuBkkPR8pDFW4cmyFZBNc2bLO
uQVgULnz+3vIy6TvzbegBSzyIHwibIWbVdafoNVnULilsRWKHNE=
=NGVA
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
