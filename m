Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7A0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D323720B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lntAZsQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfBFMzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:55:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53327 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbfBFMzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:55:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so2371552wmb.3;
        Wed, 06 Feb 2019 04:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vZx4P1PdN5ThifFFMSL4i/6yprDS3Sosy76ja/tPiC4=;
        b=lntAZsQ554Dc/9FxC8DLHuhk8yjb+JoBOq7uDUHpL9DO/Cm7+C1WuV8gd1nBygc2cb
         ztLxtq1Kr2+gBoG32cKFAGZbuayqEbixe/Shg0a4hOJ8EVxftSMRKXymmsLZYa2pOcfl
         Flm+ZfOijDwrNImUCP+evCCgNycZIKSZENkKOgrYNMDUxhSI+Ma35+CeoXY+KtldbvuD
         2IE/Yx8XyiNIx0J9Xx1Y6iB7vdukV6WkX8tLscCIV8+kLgrYtYdCfhvYwxCtAhagM8OO
         bSvE7hcH5rydNQXWpzrCoFj0rF3JVCfLOxDddSOeHGouxgQ7k3WhzWq2KugE56qqya2V
         xgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vZx4P1PdN5ThifFFMSL4i/6yprDS3Sosy76ja/tPiC4=;
        b=QwGM2XETFtvnZkf8cVu7FrEhbdvTAuhS6eh3xoRDbNROb8un9I8lc3/YW8E965BmrR
         31GCpoJjtOg1lIhawmesIEtMiq+z6NaFbri+Ev1+PAOZ0LcgAodbGgT+wViYnlC28GSS
         7OAhXm3bHhKB9/36a+/Ilp/AIewnCLphHf0wIwHeypkvqbw8ophCbPBRjLsniXkYgqQd
         IXziNF/A6kihAetKOLLtonx37JXT8frLcQU5UPxoN//z9IUW3gtbW0dckZPnCCovIU6k
         BIsbxk7YZgBA5rrq9DYLozccYuclH7Ch3QBHTcDnfPUFqSNxv5Qpi66cV0wUg0MWhBXS
         Rlpg==
X-Gm-Message-State: AHQUAuasf2l3Fbwmqo18fWJFpTHoFf8Gv7fllPVGXyn8bdZG02qKa38i
        /k63coV/T1x7EGdRMWQd/xQ=
X-Google-Smtp-Source: AHgI3IaxAf/66h4v+3Hy77NV2TeD9AAxmHFY4/C6jY1hCmC7jUU+KLRSioELd5peUtR3keUyTDlOyg==
X-Received: by 2002:a1c:e911:: with SMTP id q17mr3359006wmc.31.1549457747564;
        Wed, 06 Feb 2019 04:55:47 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id c129sm15089075wma.48.2019.02.06.04.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 04:55:46 -0800 (PST)
Date:   Wed, 6 Feb 2019 13:55:45 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>, jic23@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        vilhelm.gray@gmail.com, linux-stm32@st-md-mailman.stormreply.com,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
Message-ID: <20190206125545.GI21676@ulmo>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
 <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
 <20190205222522.GB1372@mithrandir>
 <6584a59b-657d-adc9-fab2-eb1a9baba05d@st.com>
 <20190206085405.pdiwd3c6wjog5hl7@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Li7ckgedzMh1NgdW"
Content-Disposition: inline
In-Reply-To: <20190206085405.pdiwd3c6wjog5hl7@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Li7ckgedzMh1NgdW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 09:54:05AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Feb 06, 2019 at 09:42:48AM +0100, Fabrice Gasnier wrote:
> > If you agree with the current approach, I can send a V2 with Tomasz's
> > suggestion to remove the ifdefs and use __maybe_unused instead.
>=20
> I think the suspend callback should have something like:
>=20
> 	if (is_still_enabled) {
> 		/*
> 		 * The consumer didn't stop us, so refuse to suspend.
> 		 */
> 		dev_err(dev, "The consumer didn't stop us, so refuse to suspend.\n");
> 		return -EBUSY;
> 	}
>=20
> This way there are no bad surprises if the pwm is suspended before its
> consumer and it's obvious what is missing.

Something that just occurred to me: perhaps as part of pwm_get() we
should track where we were being requested from so that we could give
hints in situations like this as to where the consumer is that forgot
to suspend the PWM.

I suppose we already have pwm_device.label to help with this, but
perhaps we could improve things if we stored __builtin_return_address
during pwm_get() to help users pinpoint where they need to look.

Thierry

--Li7ckgedzMh1NgdW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxa2VEACgkQ3SOs138+
s6EMtQ/+NuYEI6bg9mbWLyhJ3zRbtXrmiV+D2Rr3AvfBXKYks4TF9pGSJFk3f/L+
GLjT4DXZqqCHlnZkHRkvUe/FVjwkSvusTwcQE6TPYZ9ikPG1pXoaA8mFAR9NS4Yf
E0RWwnoMkIpnvF82peQf1zb1ZIlaSwidvFYTA3XYXjdRXzjipix2qkYy55K9FBU7
X9z6uJlAk7UgoTNXKmt+C6VPLTKdQ0TGcN7j/mVIv9cBeYaRzqrUicTqDqMU+Qw1
2kZDJwaXqD4wB0ai8631f2sdruSlIREg8+M4HydMZxiwuqZ0zuX2I3Gm2ihdUQ3P
fFkslyeUouUJ0IWGtZMY1Y5HexCKD3iN837g7Iugpo4rvr2ububpfiCuG1o7v/W4
n3jO7/K0SmjBO+iMiaFgmoaJeEIvg+F+64n54F5ZNdnk1+dVWwJJhHFTtpsGq1c8
bK+MNRdVlwGRug61fIXKQSKPqkr+Flx6xYv+y0AZZ/fGV5Lujx4vJgydUdnfKrqV
OWivKy6KysxAMbgmyyxfDkx06GPlSPk/g7iJ37I5SeHwuie9HWi7M1iycPYIdo+x
hlYJOJOfhXQ+WxaBQ8u6xGW7a4SBJbOKdup60mkVftOJT7yl0ydHtWdOyXpJ92xX
RxWJVBo7WifuGP/40vv6Kz9XFYXBvlCOO1xvvbkismhJjAqVFHo=
=Re92
-----END PGP SIGNATURE-----

--Li7ckgedzMh1NgdW--
