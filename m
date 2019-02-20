Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B5CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6B420880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="LwnaMXj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfBTQUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:20:34 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:36159 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTQUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550679631;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=WbYmo0yJiAZw1XZfb1E7GoaNJ96Lutj/HYqpMM0XePE=;
        b=LwnaMXj5szUx+g4U5IkXFsWmP1D9wOVZiborgMwj25idI+SJA12KvmPmFZlrkFviKw
        Dnv2KUjsFt+iKYnkNUTf3729l9UHlSff49wpc9oM72ubrCnBtenD2EnZQUDAVp+UR1eE
        Dl0S3oUDTwug7AQBXf9udaMlY7MKKGtSeLr95kvrVAWsulQbOUCcqT7K+jT/VLCU5ldz
        uM/bhy9DjOcYA8zljiZCcQdXXT4LO7KnL7KnoSKSB/m4DBFSvkst9/P+4BpU950TAyhD
        y4nxYq9XpE6SFJkAq5e1jZzIuM57cDISq1H62bnfexY+R0I4WqwUU5GekJvwA44IBd+I
        6WGA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/ztwDXG"
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KGKUFcF
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 17:20:30 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/9] iio: accel: bmc150: add mount matrix support
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190220161444.78f34a61@archlinux>
Date:   Wed, 20 Feb 2019 17:20:29 +0100
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
Message-Id: <4C07F0C8-3149-4DEA-B108-39F2CC04ED88@goldelico.com>
References: <cover.1550671256.git.hns@goldelico.com> <71ef51037525ae6324bc22e933c00a514d518b31.1550671256.git.hns@goldelico.com> <20190220161444.78f34a61@archlinux>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 20.02.2019 um 17:14 schrieb Jonathan Cameron <jic23@kernel.org>:
>=20
> On Wed, 20 Feb 2019 15:00:50 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>> This patch allows to read a mount-matrix device tree
>> property and report to user-space or in-kernel iio
>> clients.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> This will clash with Andy's current patch, but I'll fix that up if
> needed. Otherwise, one trivial suggestion inline.

Ok, thanks!

>=20
> Jonathan
>=20
>> ---
>> drivers/iio/accel/bmc150-accel-core.c | 19 +++++++++++++++++++
>> 1 file changed, 19 insertions(+)
>>=20
>> diff --git a/drivers/iio/accel/bmc150-accel-core.c =
b/drivers/iio/accel/bmc150-accel-core.c
>> index 383c802eb5b8..9178846cfddc 100644
>> --- a/drivers/iio/accel/bmc150-accel-core.c
>> +++ b/drivers/iio/accel/bmc150-accel-core.c
>> @@ -204,6 +204,7 @@ struct bmc150_accel_data {
>> 	int ev_enable_state;
>> 	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. =
*/
>> 	const struct bmc150_accel_chip_info *chip_info;
>> +	struct iio_mount_matrix orientation;
>> };
>>=20
>> static const struct {
>> @@ -796,6 +797,18 @@ static ssize_t =
bmc150_accel_get_fifo_state(struct device *dev,
>> 	return sprintf(buf, "%d\n", state);
>> }
>>=20
>> +static const struct iio_mount_matrix *
>> +bmc150_accel_get_mount_matrix(const struct iio_dev *indio_dev,
>> +				const struct iio_chan_spec *chan)
>> +{
>> +	return &((struct bmc150_accel_data =
*)iio_priv(indio_dev))->orientation;
>=20
> I would use a local variable as that casting is less than simple to =
parse
> to my eyes anyway!

Yes, Andy already suggested that. I just happend to pick one of the only =
two bad examples
from all iio drivers as template...

drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
drivers/iio/magnetometer/ak8975.c

>=20
>> +}
>> +
>> +static const struct iio_chan_spec_ext_info bmc150_accel_ext_info[] =3D=
 {
>> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, =
bmc150_accel_get_mount_matrix),
>> +	{ },
>> +};
>> +
>> static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
>> static IIO_CONST_ATTR(hwfifo_watermark_max,
>> 		      __stringify(BMC150_ACCEL_FIFO_LENGTH));
>> @@ -978,6 +991,7 @@ static const struct iio_event_spec =
bmc150_accel_event =3D {
>> 		.shift =3D 16 - (bits),					=
\
>> 		.endianness =3D IIO_LE,					=
\
>> 	},								=
\
>> +	.ext_info =3D bmc150_accel_ext_info,				=
\
>> 	.event_spec =3D &bmc150_accel_event,				=
\
>> 	.num_event_specs =3D 1						=
\
>> }
>> @@ -1555,6 +1569,11 @@ int bmc150_accel_core_probe(struct device =
*dev, struct regmap *regmap, int irq,
>>=20
>> 	data->regmap =3D regmap;
>>=20
>> +	ret =3D of_iio_read_mount_matrix(dev, "mount-matrix",
>> +				       &data->orientation);
>> +	if (ret)
>> +		return ret;
>> +
>> 	ret =3D bmc150_accel_chip_init(data);
>> 	if (ret < 0)
>> 		return ret;
>=20

BR and thanks,
Nikolaus

