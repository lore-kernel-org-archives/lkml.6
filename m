Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195B6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F6C20867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM9HpUou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F6C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeKYWhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeKYWhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:37:08 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B697820865;
        Sun, 25 Nov 2018 11:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543146373;
        bh=CEY0a6ij30l5B51ou1KValEX9JMQTBHuCYndpWRLtI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RM9HpUousVdoVFLx+CRtbljvBkQFhOhq9mcmmDCBOPSLck4hRlJQE/XD9w33svNH5
         7p3pJ3+iQ6vsKrLyefZp9OpR08A7ZRjdzEb/WgR8vU6k3hsH4lnbr0HLJ9Vq5ge6Q5
         50g9svAZVkOL3NRpn0Rmul5gzGPwGHOyBeq1THus=
Date:   Sun, 25 Nov 2018 11:46:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Staging: iio: adt7316: Add of_device_id table
Message-ID: <20181125114609.6273934f@archlinux>
In-Reply-To: <20181120165230.7079-1-shreeya.patel23498@gmail.com>
References: <20181120165230.7079-1-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 22:22:30 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> When the kernel starts up, it kicks off compiled-in drivers
> that match =E2=80=9Ccompatible=E2=80=9D entries it finds in the device tr=
ee.
> At a later stage (when /lib/modules is available), all kernel modules
> that match =E2=80=9Ccompatible=E2=80=9D entries in the device tree are lo=
aded.
>=20
> But if there is no dt table then there should be a fall back path
> with which desired kernel modules can be loaded. Hence, add
> of_device_id table in the i2c driver to be able to use when there
> is no dt table.
The patch is fine, but this description is confusing.

of_device_id is a device tree table (confusing naming in the
kernel, but of is open firmware, a standard from which device tree
emerged).

I've just dropped this second paragraph from the description to
avoid confusion.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan


>=20
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
>=20
> Changes in v2:
>   - Make the commit message appropriate and assign of_match_table
> in the driver structure.
>=20
>  drivers/staging/iio/addac/adt7316-i2c.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/ii=
o/addac/adt7316-i2c.c
> index 473e5e34ec00..41bc4ca008bc 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -126,9 +126,22 @@ static const struct i2c_device_id adt7316_i2c_id[] =
=3D {
> =20
>  MODULE_DEVICE_TABLE(i2c, adt7316_i2c_id);
> =20
> +static const struct of_device_id adt7316_of_match[] =3D {
> +	{ .compatible =3D "adi,adt7316" },
> +	{ .compatible =3D "adi,adt7317" },
> +	{ .compatible =3D "adi,adt7318" },
> +	{ .compatible =3D "adi,adt7516" },
> +	{ .compatible =3D "adi,adt7517" },
> +	{ .compatible =3D "adi,adt7519" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, adt7316_of_match);
> +
>  static struct i2c_driver adt7316_driver =3D {
>  	.driver =3D {
>  		.name =3D "adt7316",
> +		.of_match_table =3D adt7316_of_match,
>  		.pm =3D ADT7316_PM_OPS,
>  	},
>  	.probe =3D adt7316_i2c_probe,

