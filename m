Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D561C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545EB2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550665053;
	bh=oneBnyUlP9YvWU35HqXsEbn4oXF4ltkqonZuN13WDns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EinJsQ3KJJ3raZJf0we88J/SKrI5p/QKVYQoVNrzFMgPQZ8kmmzo8ZYyukN2RY3gQ
	 YF1KXOuKSwoQzrDl7UeQCmSYnRaQlCsT6kKa/ppevxfAsZuhilM0bewC+zYsgrT5Tf
	 adKlz0tWIF7E34c4X3v3gSuNoqQjTDyzqBGs82zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfBTMRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:17:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBTMRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:17:31 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 767A42147A;
        Wed, 20 Feb 2019 12:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550665051;
        bh=oneBnyUlP9YvWU35HqXsEbn4oXF4ltkqonZuN13WDns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dIF6CrnElBK6iAUdHgj9P4hGiEXVQ60Wxgb32bmdTG93L75kQ9l2nmD22HUEBgCxx
         iQSOr6IhOUXr8ueD0qVU2vydZv6Zq1qC8uFyObvGB5UXBThDHLxwcPMp6MHqJJ6ZfW
         HWcUGNGaDBU2z9nxQA93ZM3KzYmX89a+yfPXWRG8=
Date:   Wed, 20 Feb 2019 12:17:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] iio: mma8452: mark expected switch fall-through
Message-ID: <20190220121726.3b10e0ec@archlinux>
In-Reply-To: <20190211222318.GA21656@embeddedor>
References: <20190211222318.GA21656@embeddedor>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 16:23:18 -0600
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>=20
> This patch fixes the following warning:
>=20
> drivers/iio/accel/mma8452.c: In function =E2=80=98mma8452_probe=E2=80=99:
> drivers/iio/accel/mma8452.c:1581:6: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>    if (ret =3D=3D data->chip_info->chip_id)
>       ^
> drivers/iio/accel/mma8452.c:1584:2: note: here
>   default:
>   ^~~~~~~
>=20
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>=20
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
>=20
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
I know Peter probably won't like this, as it doesn't
read a as well, with the else dropped, but I'm going to take
it as we have had a lot of bugs caught by this code and this
is generating a false positive.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mma8452.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 302781126bc6..00e100fc845a 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1580,7 +1580,7 @@ static int mma8452_probe(struct i2c_client *client,
>  	case FXLS8471_DEVICE_ID:
>  		if (ret =3D=3D data->chip_info->chip_id)
>  			break;
> -		/* else: fall through */
> +		/* fall through */
>  	default:
>  		ret =3D -ENODEV;
>  		goto disable_regulators;

