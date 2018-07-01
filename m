Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0098EC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 04:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C3823D72
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 04:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C3823D72
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbeGAEhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 00:37:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38513 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbeGAEhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 00:37:35 -0400
Received: from mail-pf0-f197.google.com ([209.85.192.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <shrirang.bagul@canonical.com>)
        id 1fZU7C-0002ie-DY
        for linux-kernel@vger.kernel.org; Sun, 01 Jul 2018 04:37:34 +0000
Received: by mail-pf0-f197.google.com with SMTP id a12-v6so6643491pfn.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 21:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version;
        bh=V8kcEV0FJHfauh8BsjQFgHwRfcl3WPXrYEGIVg7HAoQ=;
        b=EIAcXYXTZluuVhL55sE+6gkzVsR9jRiAr8U/bwnIiYcKsccY4XrawbR9tYIh23BYsP
         cVc+THKV01XCV3Ouc0RGM6sc5rpROXIOGM9Ld2UWjLsY67LjTeYK/2JSKALNYDgYHcNC
         lhbnuXFghAL2sEiscjNPmHBxu7RnuiWJzIEeGTpRTWHwl9/nZtncgL5RfJj9fdfWd+TS
         jdMAkENX2oIqg9kykxaoRfaAAM4WyclRTrWdmlvj0hRVB1FRsAKHqVDgQMj6KXLaut9w
         sP2UKac/KQF9d/cAZLccDqKiRdJ0Y8/Ys/DWmjxIPjw2l9RN7LJJa0XPEh6yYW6r5dpU
         U4GQ==
X-Gm-Message-State: APt69E2rfGHDZYHt9jSpBnvqTtJbvUMQyPmh1KOOULGdrPsMoG5TRKfd
        N1+k/2QYkQHUaOfuhk1glAiEt0H4ONcRtMKLQTPh6c4R8rnnz2wcbNEXOYFjsY8G+Q7qv51uxnB
        SIpy4CQTd1ClZ7t+Dkxs/IPXzQ6AyWAf8Tc9n7IMbjA==
X-Received: by 2002:a17:902:4424:: with SMTP id k33-v6mr20988333pld.242.1530419852665;
        Sat, 30 Jun 2018 21:37:32 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKIprZTgrf/UkqadIPjHBxzzPy9jUfn3Ku+vWkCU923/WUu5eyBohPlAWRKO+L7PxCpl39PiXQ==
X-Received: by 2002:a17:902:4424:: with SMTP id k33-v6mr20988326pld.242.1530419852381;
        Sat, 30 Jun 2018 21:37:32 -0700 (PDT)
Received: from snb-ubuntu (122-116-76-153.HINET-IP.hinet.net. [122.116.76.153])
        by smtp.gmail.com with ESMTPSA id 10-v6sm25079573pgb.40.2018.06.30.21.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 21:37:29 -0700 (PDT)
Message-ID: <c40514afedc946d812c0e562690fd6008e926b64.camel@canonical.com>
Subject: Re: [PATCH v2] iio: humidity: hts221: Fix sensor reads after resume
From:   Shrirang Bagul <shrirang.bagul@canonical.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     jic23@kernel.org, lorenzo.bianconi83@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.tesi@st.com, marco.bianco@st.com, armando.visconti@st.com
Date:   Sun, 01 Jul 2018 12:37:24 +0800
In-Reply-To: <20180628090525.GA2540@localhost.localdomain>
References: <20180628082215.12023-1-shrirang.bagul@canonical.com>
         <20180628090525.GA2540@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-WTopwzHbvRMfViG7NwGy"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WTopwzHbvRMfViG7NwGy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-06-28 at 11:05 +0200, Lorenzo Bianconi wrote:
> > AV_CONF register (RH & TEMP. oversampling ratio's) and CTRL1 register
> > (ODR & BDU settings) values are lost after suspend.
> >=20
> > While the change in AV_CONF updates the sensor resolution modes
> > (overriding the user configuration before the device went to suspend);
> > loss of the contents of the CTRL1 register leads to failure in reading
> > sensor output.
> >=20
> > This patch restores the AV_CONF & CTRL1 registers after resume.
> >=20
>=20
> Hi Shrirang,
>=20
> I still suspect we have some hw issue (IoT Gateway) here (cc ST folks
> to get more info) and anyway I guess the proposed patch will fix the issu=
e
> completely since OD and HL configuration is not restored properly.
> Could you please double check HL/OD regs are properly preserved after res=
ume
> phase?
Yes, certainly. Will include the i2c register dumps before and after the re=
sume to support
the patch.

Regards,
Shrirang
>=20
> Regards,
> Lorenzo
>=20
> > Changes from v1:
> > - Don't drop enabling the sensor during resume
> > - Restore AV_CONF register along with CTRL1
> >   (As demonstrated with i2c register dumps of hts221 captured on Dell
> >   IoT Gateways 300x before suspend & after resume [1])
> >=20
> > Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfigu=
ration)
> > Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> >=20
> > [v1] https://marc.info/?l=3Dlinux-iio&m=3D152506543000442&w=3D2
> > [1] https://marc.info/?l=3Dlinux-iio&m=3D152534455701742&w=3D2
> >=20
> > This patch is based on:
> > git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git -b testing
> > ---
> >  drivers/iio/humidity/hts221_core.c | 31 +++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/=
hts221_core.c
> > index 166946d4978d..fc5599497f55 100644
> > --- a/drivers/iio/humidity/hts221_core.c
> > +++ b/drivers/iio/humidity/hts221_core.c
> > @@ -656,14 +656,43 @@ static int __maybe_unused hts221_resume(struct de=
vice *dev)
> >  {
> >  	struct iio_dev *iio_dev =3D dev_get_drvdata(dev);
> >  	struct hts221_hw *hw =3D iio_priv(iio_dev);
> > +	const struct hts221_avg *avg;
> > +	u8 data, idx;
> >  	int err =3D 0;
> > =20
> > +	/* Restore contents of AV_CONF (RH & TEMP. oversampling ratio's) */
> > +	avg =3D &hts221_avg_list[HTS221_SENSOR_H];
> > +	idx =3D hw->sensors[HTS221_SENSOR_H].cur_avg_idx;
> > +	data =3D avg->avg_avl[idx];
> > +	err =3D hts221_update_avg(hw, HTS221_SENSOR_H, data);
> > +	if (err < 0)
> > +		goto fail_err;
> > +
> > +	avg =3D &hts221_avg_list[HTS221_SENSOR_T];
> > +	idx =3D hw->sensors[HTS221_SENSOR_T].cur_avg_idx;
> > +	data =3D avg->avg_avl[idx];
> > +	err =3D hts221_update_avg(hw, HTS221_SENSOR_T, data);
> > +	if (err < 0)
> > +		goto fail_err;
>=20
> just return err, no need for goto statement
Okay.
>=20
> > +
> > +	/* Restore contents of CTRL1 (BDU & ODR) */
> > +	err =3D regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
> > +				 HTS221_BDU_MASK,
> > +				 FIELD_PREP(HTS221_BDU_MASK, 1));
> > +	if (err < 0)
> > +		goto fail_err;
> > +
> > +	err =3D hts221_update_odr(hw, hw->odr);
> > +	if (err < 0)
> > +		goto fail_err;
> > +
>=20
> just return err, no need for goto statement
Okay.
>=20
> >  	if (hw->enabled)
> >  		err =3D regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
> >  					 HTS221_ENABLE_MASK,
> >  					 FIELD_PREP(HTS221_ENABLE_MASK,
> >  						    true));
> > -	return err;
> > +fail_err:
> > +	return err < 0 ? err : 0;
> >  }
> > =20
> >  const struct dev_pm_ops hts221_pm_ops =3D {
> > --=20
> > 2.17.1
> >=20
--=-WTopwzHbvRMfViG7NwGy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4dy8MKREQ2noAlYwuWPdv/676GQFAls4WoQACgkQuWPdv/67
6GSa2w//TPaOHq5rAQ1VbchrMxI85BcSYW/tXNErqR+catFFJB79p60+StUjxysL
vOatiK8DapxGAWbeETqcvPxjsrEo6K83JqhCbfx98495nOtpdPxI7BvKurXqzWsP
PIbiywyYLfWvLuVaRw/IokpPBpqZX7YNHviSLDS9/W+mOwxFqYFhsKxGOPUjOrR9
XUL+FMKMRgk+aeq0jeFxYXP9NyfEoTSGm6nw2HQQghfth5RURRK+CJAs8re5OFET
JOvfiNsCQDsrOwRvhRQTqIG2nybBhNttmoSEb2HueXBUD3xmf/M7AUZ48srVYFdx
hGO6Q6vQ0WUFqUihKBb8E7mgv9lhoJLdMSHnCWiiD6xUjOvZmpBlc7WDnrH2I6E0
gJKGjnJbLxyTbC2V0mkzBnKl+tFhfdkMSgZywXZuBHva7Kk1H3Jjprk++06WNh5u
8i72phTAwOld/LgBhK2T50ZEgUp623HqPbuWK+sXvA2Adxs9I3sR32zrTBjPpcne
cxN8WOYxs5tXse+Cm+TDVEB9r0Tz25/mXZR0wv1A+HobOnb8tB5VPkeFLs9NvT/8
qaACNnzmKUY1+Fl0LwdErigU50QfhNOpQuOYbPYvmHSVnQAPvpWtU4nus2tVfalY
kstjpIiTDiog9waXvziG+4osK9c5L5M8cVbaCZqD2fi1CXUui9w=
=XTyJ
-----END PGP SIGNATURE-----

--=-WTopwzHbvRMfViG7NwGy--

