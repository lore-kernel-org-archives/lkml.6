Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6803C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AA62146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="DGpw7WP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfBTQYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:24:44 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.102]:33034 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfBTQYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550679881;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ykBr//Kn+s4BIUETzlQJ/bz5PbKAGheHxikONNh1zhM=;
        b=DGpw7WP2BbsGpk0pR6pbLOsfoEAqsCsOLsRaHtnPj1yv8WO+iKmZkp/t2iXGDMPLBS
        XwIb4mYzJydmUNlWxh/tIze05UXTZ4gsTKolIc2WHbZyz/H+pacyFE0RU7SH6MhEQnjg
        pxyBlmMsNMNGKsypVs+pH6JpFndp32WuopJhRtkxQZV8hI2vz6xgztBEuY1psIwiAwOV
        d940fvF3oHQQdxpCuh196si2tvK8fD9ET0HDh/LYI5dHwo9iU20MP/M+P0hQpK3kvf5Q
        Ah8Tz2IKvNThQXYtnAVi7xeMpMDOkileUrd4Tzht50gHOf5ykiyamd+0df4fC5dtIA/n
        zMEQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/ztwDXG"
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KGOdFdI
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 17:24:39 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 9/9] iio: magnetometer: hmc5843: add mount matrix support
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190220161942.703f0c4a@archlinux>
Date:   Wed, 20 Feb 2019 17:24:39 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7BB4D99-1792-4BFB-8D9D-F8EFC1D1B692@goldelico.com>
References: <cover.1550671256.git.hns@goldelico.com> <effcfa7fb13fb8ba2b8b13ab07a6eb86defec77e.1550671256.git.hns@goldelico.com> <20190220161942.703f0c4a@archlinux>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 20.02.2019 um 17:19 schrieb Jonathan Cameron <jic23@kernel.org>:
>=20
> On Wed, 20 Feb 2019 15:00:56 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>> This patch allows to read a mount-matrix device tree
>> property and report to user-space or in-kernel iio
>> clients.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> The rest of these are all fine, though I suggest considering
> a local variable rather than the fiddly bit of casting.

Ok, fine.

I will wait some days for further comments than then
submit a v2 with all known improvements.

BR and thanks,
Nikolaus

>=20
> Jonathan
>> ---
>> drivers/iio/magnetometer/hmc5843.h      |  1 +
>> drivers/iio/magnetometer/hmc5843_core.c | 14 ++++++++++++++
>> 2 files changed, 15 insertions(+)
>>=20
>> diff --git a/drivers/iio/magnetometer/hmc5843.h =
b/drivers/iio/magnetometer/hmc5843.h
>> index a75224cf99df..e3e22d2508d3 100644
>> --- a/drivers/iio/magnetometer/hmc5843.h
>> +++ b/drivers/iio/magnetometer/hmc5843.h
>> @@ -43,6 +43,7 @@ struct hmc5843_data {
>> 	struct mutex lock;
>> 	struct regmap *regmap;
>> 	const struct hmc5843_chip_info *variant;
>> +	struct iio_mount_matrix orientation;
>> 	__be16 buffer[8];
>> };
>>=20
>> diff --git a/drivers/iio/magnetometer/hmc5843_core.c =
b/drivers/iio/magnetometer/hmc5843_core.c
>> index ada142fb7aa3..e6b6da70c152 100644
>> --- a/drivers/iio/magnetometer/hmc5843_core.c
>> +++ b/drivers/iio/magnetometer/hmc5843_core.c
>> @@ -237,6 +237,13 @@ int hmc5843_set_measurement_configuration(struct =
iio_dev *indio_dev,
>> 	return hmc5843_set_meas_conf(data, meas_conf);
>> }
>>=20
>> +static const struct iio_mount_matrix *
>> +hmc5843_get_mount_matrix(const struct iio_dev *indio_dev,
>> +			  const struct iio_chan_spec *chan)
>> +{
>> +	return &((struct hmc5843_data =
*)iio_priv(indio_dev))->orientation;
>> +}
>> +
>> static const struct iio_enum hmc5843_meas_conf_enum =3D {
>> 	.items =3D hmc5843_meas_conf_modes,
>> 	.num_items =3D ARRAY_SIZE(hmc5843_meas_conf_modes),
>> @@ -247,6 +254,7 @@ static const struct iio_enum =
hmc5843_meas_conf_enum =3D {
>> static const struct iio_chan_spec_ext_info hmc5843_ext_info[] =3D {
>> 	IIO_ENUM("meas_conf", true, &hmc5843_meas_conf_enum),
>> 	IIO_ENUM_AVAILABLE("meas_conf", &hmc5843_meas_conf_enum),
>> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
>> 	{ },
>> };
>>=20
>> @@ -260,6 +268,7 @@ static const struct iio_enum =
hmc5983_meas_conf_enum =3D {
>> static const struct iio_chan_spec_ext_info hmc5983_ext_info[] =3D {
>> 	IIO_ENUM("meas_conf", true, &hmc5983_meas_conf_enum),
>> 	IIO_ENUM_AVAILABLE("meas_conf", &hmc5983_meas_conf_enum),
>> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
>> 	{ },
>> };
>>=20
>> @@ -635,6 +644,11 @@ int hmc5843_common_probe(struct device *dev, =
struct regmap *regmap,
>> 	data->variant =3D &hmc5843_chip_info_tbl[id];
>> 	mutex_init(&data->lock);
>>=20
>> +	ret =3D of_iio_read_mount_matrix(dev, "mount-matrix",
>> +				&data->orientation);
>> +	if (ret)
>> +		return ret;
>> +
>> 	indio_dev->dev.parent =3D dev;
>> 	indio_dev->name =3D name;
>> 	indio_dev->info =3D &hmc5843_info;
>=20

