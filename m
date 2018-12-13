Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E968AC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6382086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeVK8xft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6382086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbeLMRAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:00:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32817 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbeLMRAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:00:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so2650367eds.0;
        Thu, 13 Dec 2018 09:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pcnIrSCb3TiNxanA4JWzs3t6qu5AG3XJHatulUqJN2s=;
        b=EeVK8xft/IYpyiBqSbYcZtv5maZF9VdKRTmivNTERFFkzWcKpDXNLn7iAhnVDdbKVM
         gV2Xkjf0ZUWgCuTUQvgMlyhKCV/uz0Ro+buj18j7E+7fCC1U5+nJZoQ+g/GTJPwsS6sT
         8bfz88F4CJe2KTaeEZpAt8oOddlOxQxHtOO5BfJRSBH2ErDuCEXil3CEfbrP5V/9XPD2
         Lj7z6hreyB4KqheBMEccGGv9CmlSteQTaM7mnDrOWcWeGXFqFYwWrtjUYlespMFcUC7z
         +MYFSEqvUh6qVNMRQlJ/DAKLWae+3bHo3MPA9LFJ5s9qUkbAHG+am1VKyxCT65iAUbn/
         UB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pcnIrSCb3TiNxanA4JWzs3t6qu5AG3XJHatulUqJN2s=;
        b=q8uppa+bV5xoMt+VU57WRcLvlqD5RzHnLjrxXA9lTykTnEUYUvlf1IAjI/1QpHJWs2
         dw7A+d+U6xl1pwSiuG/O0zH+B+vuEtT8q5gmGgz2EqXWcbzykVdF8yGFp2+4+U+04iFX
         tRMKkbUmKyRbQUGeJYgiqe10rL9ZDKnaM5a7MI6Ls+ujwsMU8x09FjBReE75q+w0taKX
         ZBCzuB+v6V9u0/a2zbv5jw+CM20F1b4mfSgPiylLtudtz+0tTPIPvCGxdAgyYer26sDD
         sEnqYZH9M+PuU27zFqyUnR7ZcyWl82iq/30yEAvx0zHxDKGQYmMyscxr8YZDuyWkkxWh
         NhgQ==
X-Gm-Message-State: AA+aEWbh0Pkqi3nPvRiP5ghvcj2zOqYA7oP4PT1zGPePEi/3CEgkm8JT
        DvOkV5l2QXMpuGHnk4wQQLROR0e/
X-Google-Smtp-Source: AFSGD/Wc9btZ2VDghWbh5QWYdw0rKV2bp0cJDJz+mWrsRX/Zz6m3lAT4vbLYIaMzNn6MU4R+abLyrQ==
X-Received: by 2002:a50:c252:: with SMTP id t18mr81920edf.57.1544720402645;
        Thu, 13 Dec 2018 09:00:02 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id l51sm740367edb.36.2018.12.13.09.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 09:00:01 -0800 (PST)
Date:   Thu, 13 Dec 2018 18:00:00 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pwm: imx: Implement get_state() function for
 hardware readout
Message-ID: <20181213170000.GA14581@ulmo>
References: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
 <1538403588-68850-3-git-send-email-michal.vokac@ysoft.com>
 <20181212105432.GD17654@ulmo>
 <20181213085213.7k5ihn7bdrtess3g@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20181213085213.7k5ihn7bdrtess3g@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 09:52:13AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Dec 12, 2018 at 11:54:32AM +0100, Thierry Reding wrote:
> > On Mon, Oct 01, 2018 at 04:19:48PM +0200, Michal Vok=C3=A1=C4=8D wrote:
> > > Implement the get_state() function and set the initial state to refle=
ct
> > > real state of the hardware. This allows to keep the PWM running if it=
 was
> > > enabled in bootloader. It is very similar to the GPIO behavior. GPIO =
pin
> > > set as output in bootloader keep the same setting in Linux unless it =
is
> > > reconfigured.
> > >=20
> > > If we find the PWM block enabled we need to prepare and enable its so=
urce
> > > clock otherwise the clock will be disabled late in the boot as unused.
> > > That will leave the PWM in enabled state but with disabled clock. Tha=
t has
> > > a side effect that the PWM output is left at its current level at whi=
ch
> > > the clock was disabled. It is totally non-deterministic and it may be=
 LOW
> > > or HIGH.
> > >=20
> > > Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> > > ---
> > >  drivers/pwm/pwm-imx.c | 53 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  1 file changed, 53 insertions(+)
> >=20
> > Applied, thanks.
>=20
> Did you miss my feedback for this patch or did you choose to ignore it?

Don't have anything in my inbox, but I see that it's there on patchwork,
so I suspect it was eaten by the spam filter. Let me copy-paste here and
go through it.

> > @@ -93,6 +96,55 @@ struct imx_chip {
> >
> >  #define to_imx_chip(chip) container_of(chip, struct imx_chip, chip)
> >
> > +static void imx_pwm_get_state(struct pwm_chip *chip,
> > +  struct pwm_device *pwm, struct pwm_state *state)
>=20
> broken alignment.

I can fix that up, no need to resend for that.

> > +{
> > + struct imx_chip *imx =3D to_imx_chip(chip);
> > + u32 period, prescaler, pwm_clk, ret, val;
> > + u64 tmp;
> > +
> > + val =3D readl(imx->mmio_base + MX3_PWMCR);
> > +
> > + if (val & MX3_PWMCR_EN) {
> > +  state->enabled =3D true;
> > +  ret =3D clk_prepare_enable(imx->clk_per);
> > +  if (ret)
> > +   return;
> > + } else {
> > +  state->enabled =3D false;
> > + }
> > +
> > + switch (FIELD_GET(MX3_PWMCR_POUTC, val)) {
> > + case MX3_PWMCR_POUTC_NORMAL:
> > +  state->polarity =3D PWM_POLARITY_NORMAL;
> > +  break;
> > + case MX3_PWMCR_POUTC_INVERTED:
> > +  state->polarity =3D PWM_POLARITY_INVERSED;
> > +  break;
> > + default:
> > +  dev_warn(chip->dev, "can't set polarity, output disconnected");
>=20
> Should we return an error here?

We can't return an error here because the function has a void return
type. I'm not sure what it means if the POUTC is neither "normal" nor
"inverted", but perhaps a good idea would be to default to either of
those two in that case, or perhaps forcibly disable the PWM so that
we get known-good values in the registers?

I'm tempted not to treat this as a blocker because it's not actually
a bug or anything. Prior to this patch we also ignore whatever this
field was set to.

> > + }
> > +
> > + prescaler =3D MX3_PWMCR_PRESCALER_GET(val);
> > + pwm_clk =3D clk_get_rate(imx->clk_per);
> > + pwm_clk =3D DIV_ROUND_CLOSEST_ULL(pwm_clk, prescaler);
> > + val =3D readl(imx->mmio_base + MX3_PWMPR);
>=20
> It would be more cautionous to not rely on the reserved bits to read as
> zero. So I suggest to mask the value with 0xffff.

If that's what the documentation says I think it's okay to rely on it.
But I can add the mask if we want to play it extra safe.

> > + period =3D val >=3D MX3_PWMPR_MAX ? MX3_PWMPR_MAX : val;
> > +
> > + /* PWMOUT (Hz) =3D PWMCLK / (PWMPR + 2) */
> > + tmp =3D NSEC_PER_SEC * (u64)(period + 2);
> > + state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
>=20
> Would it make sense to introduce a policy about how to round in this
> case? (Similarily for .apply?) This is of course out of scope for this
> patch.

I'm not sure what you means by policy. The above already does round to
closest. Is that not an appropriate policy?

Thierry

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwSkAwACgkQ3SOs138+
s6EvbRAAiSoc68kPXavkXZaCnhLaycjollGIu/aIustggx3HHqDdj2NtxG2EW/SF
VtpYuBhq2KcayaEjz8lnIc2LFYJpUdPrIH1DfXy9KDrk+wzPpXlQbTXWJyringWp
3H5arVlIRlLqI6RBkxHY2cAakUJpBdyULir9TNPX/Sdy/Zn06keJzSQOodXpfJ60
fsRcQ+oMddsBYtj2rUSSWpkGkHkcZKfo93e4rfm86+1MEcva6ysjv6Sa3FQNFPq5
f/N1SiVEYgAmSkf/o+uuu3hKLDr3GVb2jIA4XYOPBmUmAfhpsBZyILTwgoIq8mcA
S5KBMhMr5oe/1SHTZe1d2v6N9+gRiDLDJPQa3v1wMkXqH/ukzmKCmmesDvXXj4LC
hc/WmC6acDqJckWoY7hwFyn7BzIBp/BQ5LmXxeLGREYQKfnHULUv9fcZs2Kgh2Nf
QYGs9cf07+liqqUIVdEX47LTLih0xUbPyfeC78mT6ItLk4dDFTMydgCfwPDpkbFm
hldkWKyg9ylW+K03RnQHAZeT28nQzzC1AhoB5TeoJMS8RtuK1CNe+laKkkD6Pc1j
tBGasO/tqCypLhzbpjQvk8dxJSzrv6Wz8WSEnWqnSGOYkqkyWnajQ572Cb6EjxFl
UiOWJDYkSRDQO8q8JvfLib/tS4R5z+jcJvT39vONj6IVTVvUnTE=
=XRn/
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
