Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E76DC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE86218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkPMbYbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE86218E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeHJW3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:29:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41056 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeHJW3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:29:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so8040055ljy.8;
        Fri, 10 Aug 2018 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p6bh/TfOs+PqVV8TfjB9FcvvDlUeH6v+2f+vP7we1ZQ=;
        b=gkPMbYbB9c96aDsW/+3jPofkbvXRsomQrNdiSAPP4PwjhAhm4rWsv6xWzOvRBETZQv
         VCTycH8dRWL28CS7ZDtsEIFZr/GgIojAWNpcidpenVLlaqNgICzR9/iP+XSJGlDXCys6
         i24cGjsRJwJdTzVmOdy6ghDD2iWrUMQIIdCjkUVTj2vEhMhFPzyRJvBSVWxvIUgTrE/D
         uJD1yYPRHaFuLAvHyB41R05flsEt/iYCEAZloWGH98uqmMDnEUSZsMYlvAgb2z4KjWXG
         s05WEPHt2qBQSX1oR612N+BaqZtfo9sbhZ+pPLbwLd3AkTj7DH8i7U2jcK/6n7G06Z4/
         VU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p6bh/TfOs+PqVV8TfjB9FcvvDlUeH6v+2f+vP7we1ZQ=;
        b=Lap9ebwpe0EC7n4BhMmDnvJ3GIfgQ5eTT5gE5bpgPgVcJcDdTxxuZbTKj8ZNWJwUxY
         yN7liq3vcrgIFo9jxEYOlPeWNvXrV1vAywZl+ABqR9oQeIBtLfWi60Fm4pHNRlD5qi2f
         hNaX2Pp2sPBbc9UPledcKAhroANBQfSgm22ieQhd7m9SlMK2VJ3EAS80JbEwDyaMu23D
         Eaq+vG1FHb5INX+StrNPH8b8CPI+GdwtAHeqosd+fVsdaX/OPkn3RKItLxvqx9YxtIFv
         IoXfMEE6tG59edxF7VA1kjYOMXM/H+KgOAvywtcfaSVMaM6ewKMJ5OUSbNEahmiQ1zoS
         m3wA==
X-Gm-Message-State: AOUpUlE7gyxK3KQ1UdY33tyxakh6hRuqK0XlZUwYmXGOkuGMUHq0y1ix
        FIldIvGDWGrvLU7BCloD4t8=
X-Google-Smtp-Source: AA+uWPyHhi9D7tkf7lrAKbNsNr6+exsIdXfR+BfA9HbHnHDPvtquu1M+03+9D47A2ViswSEtYQl6uw==
X-Received: by 2002:a2e:2bd7:: with SMTP id r84-v6mr5981304ljr.40.1533931078335;
        Fri, 10 Aug 2018 12:57:58 -0700 (PDT)
Received: from gmail.com (c-2ec24faa-74736162.cust.telenor.se. [46.194.79.170])
        by smtp.gmail.com with ESMTPSA id q72-v6sm1787143lja.6.2018.08.10.12.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 12:57:57 -0700 (PDT)
Date:   Fri, 10 Aug 2018 21:58:04 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, broonie@kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] iio:adxl372: Add sampling frequency support
Message-ID: <20180810195804.GB2723@gmail.com>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
 <1533557087-10401-6-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <1533557087-10401-6-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Mon, Aug 06, 2018 at 03:04:46PM +0300, Stefan Popa wrote:
> This patch adds the option for the user to select the sampling frequency.
> Also, the user can read the available frequencies and read the currently
> set frequency via the read_raw function. The frequency can be set via the
> write_raw function.
>=20
> When the frequency is set, the bandwidth is also checked and ensured
> that it is constrained to at most half of the sampling frequency. Also, t=
he
> activity and inactivity timers have to be updated because they depend on
> the selected ODR.
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  drivers/iio/accel/adxl372.c | 74 +++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 623c32d..d991d1c 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -223,7 +223,8 @@ static const struct adxl372_axis_lookup adxl372_axis_=
lookup_table[] =3D {
>  	.modified =3D 1,							\
>  	.channel2 =3D IIO_MOD_##axis,					\
>  	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> -	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |		\
> +				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>  	.scan_index =3D index,						\
>  	.scan_type =3D {							\
>  		.sign =3D 's',						\
> @@ -311,6 +312,19 @@ static int adxl372_set_odr(struct adxl372_state *st,
>  	return ret;
>  }
> =20
> +static int adxl372_find_closest_match(const int *array,
> +				      unsigned int size, int val)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < size; i++) {
> +		if (val <=3D array[i])
> +			return i;
> +	}
> +
> +	return size - 1;
> +}

Hum, would find_closest() work for this?
See include/linux/util_macros.h

> +
>  static int adxl372_set_bandwidth(struct adxl372_state *st,
>  				 enum adxl372_bandwidth bw)
>  {
> @@ -631,6 +645,51 @@ static int adxl372_read_raw(struct iio_dev *indio_de=
v,
>  		*val =3D 0;
>  		*val2 =3D ADXL372_USCALE;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D adxl372_samp_freq_tbl[st->odr];
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int adxl372_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long info)
> +{
> +	struct adxl372_state *st =3D iio_priv(indio_dev);
> +	int odr_index, ret;
> +

Is it worth to make sure that val2 is zero here?

> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		odr_index =3D adxl372_find_closest_match(adxl372_samp_freq_tbl,
> +					ARRAY_SIZE(adxl372_samp_freq_tbl),
> +					val);
> +		ret =3D adxl372_set_odr(st, odr_index);
> +		if (ret < 0)
> +			return ret;
> +		/*
> +		 * The timer period depends on the ODR selected.
> +		 * At 3200 Hz and below, it is 6.6 ms; at 6400 Hz, it is 3.3 ms
> +		 */
> +		ret =3D adxl372_set_activity_time_ms(st, st->act_time_ms);
> +		if (ret < 0)
> +			return ret;
> +		/*
> +		 * The timer period depends on the ODR selected.
> +		 * At 3200 Hz and below, it is 26 ms; at 6400 Hz, it is 13 ms
> +		 */
> +		ret =3D adxl372_set_inactivity_time_ms(st, st->inact_time_ms);
> +		if (ret < 0)
> +			return ret;
> +		/*
> +		 * The maximum bandwidth is constrained to at most half of
> +		 * the ODR to ensure that the Nyquist criteria is not violated
> +		 */
> +		if (st->bw > odr_index)
> +			ret =3D adxl372_set_bandwidth(st, odr_index);
> +
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -763,8 +822,21 @@ static const struct iio_trigger_ops adxl372_trigger_=
ops =3D {
>  	.set_trigger_state =3D adxl372_dready_trig_set_state,
>  };
> =20
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
> +
> +static struct attribute *adxl372_attributes[] =3D {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group adxl372_attrs_group =3D {
> +	.attrs =3D adxl372_attributes,
> +};
> +
>  static const struct iio_info adxl372_info =3D {
> +	.attrs =3D &adxl372_attrs_group,
>  	.read_raw =3D adxl372_read_raw,
> +	.write_raw =3D adxl372_write_raw,
>  	.debugfs_reg_access =3D &adxl372_reg_access,
>  	.hwfifo_set_watermark =3D adxl372_set_watermark,
>  };
> --=20
> 2.7.4


Best regards,
Marcus Folkesson
>=20

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltt7kcACgkQiIBOb1ld
UjKSoRAA30f20bS9ZZIym61gO3ry/CoRw4KxAeJz9Y+Sv02SBtBjMZCawTxK2YV/
H3QzahkFed5Udj/zNXbwm8qeyZQLbk508nM6P6XTJ9Gr52vRBTxceaFLq+DZzRoO
Ut9+3KBvOd4yMHdfFCj+NAZjGuqbWfj1F+1atxmQBrlTSqqZkgffSdByJed5Hxp1
+vBrsYH7XQb3KQAnBQ6stnp3GxdWb3FqvSwTmJxwLvBbWSE3VAho7ZJ3TNShqtZf
Sv6oq8mZ6XpYS2rlZ10iHjqiaqN4i9OhZdGXfflmCfabLkxqlwSgXQ0jvd74AZTj
v6RctgjueC+lbhJJq5XGTee0MfYHrDXF2oEPM+w4mNJjleC8SxSlg/4eRB/NsTq3
SUvo/tcMuYXbdiQPsze8AhEv0MM1soI1vhJ6EgoIRbmc3H8FYx+TZk5zT8RtBpSt
Q7OYasmyAwoaFhjvOtfeDiA/hmqySPYDBt2QdWqDdxnCZ04I5DX7MM2o9S/92PNm
FspiWVYz/xmaEZP6TKK/eg0sBuu/UPUTb7qZgtG5I3af1xjekJ3xJ7D73jrabKf5
DeAhWMt0tAxFg3SAGRIzhGRga84gVHlJ/Y2XVMJ5T4n+Kf9ZugimyNo/EvfJKFUv
bzExintPZybWjcjq3L7YrJ0qZYqDuoR72q79RHAXmzPViE+XkvA=
=NQHc
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
