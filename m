Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx49aDX0HsR/j01ddCrBACTWbOhr9xDK0ATGjWR6YUar5RM1sXx1thermxZYWcQysdDdnSTr2
ARC-Seal: i=1; a=rsa-sha256; t=1523804861; cv=none;
        d=google.com; s=arc-20160816;
        b=WxHxfmK/Dk/DvQTTFTzJk501ObUDuOaGbo+L2AH4yGYw81vE04/t/wfolj0YYPiBxm
         QSDRBQHP6zsgS2vK7SGI9oR70Sy6p8fiW0wPQZec0nncGusIgYFNNlTkpDKRq1zb57zY
         x0kznlmBbClJK5CWDlP49dulkmsNm0nX+2lRmesnbbzbTlhvHVMD0VpR7iFobIJyP+Hr
         M7sVMuDOayymimkiKS5aNunzPmkF83rDVP0lFWsxjqpBAVYotZ2dDMp3fnpAYrwv16CE
         TFqaB7xmJru/cQlAbRhFBzu4jY4BQSJLoqo9fGH0QRjYOfHrgyTukZsKzBwy3/IWQx03
         1OPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=3JpsywUoEaiOQUygQ1BhgmP8POCkRGU89wX6Z7igUQ0=;
        b=vm0fy6MYOOblYAFHoF2KQISP54KhTnRf1eFiWmtL3BN1mZJzm2HSoUEQHkcgdgNLyr
         0/tOg4tyWFYsU30I4TxETCdvVeYEx4RK2QNt7vHK1VPhVYoaHPnBdiUVH9Q50tYB01nf
         8x77IwtJ/bhZWODJj9aNgK+qtrHDUbSzs2YB7fZuGPG1Cpzt4FLkf989W1/HIl4cjkFp
         mRF2rPzhYCNxywwYB19i/HgKL28v16jDJ06o5e6XUN9SKOVxT5PO1aCtFFspPtwceGlu
         0DlUkiyw2jn+HgVtsah1Y6LWoIqxqGOB4aR49msYmMD8Wh3pjOyTsxVqUufkBnKent8T
         jOOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397E420779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 16:07:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/14] staging: iio: ad7746: Fix multiple line
 dereference
Message-ID: <20180415160736.2195142b@archlinux>
In-Reply-To: <1523637411-8531-5-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-5-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649697263625417?=
X-GMAIL-MSGID: =?utf-8?q?1597825206654493060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 13:36:41 -0300
Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Clear checkpatch.pl WARNING about multiple line derefence but creates a
> new one of line over 80 characters. In my opinion, it improves
> readability.
>=20
> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
I wouldn't say I personally have strong views either way on this, but
your version is fine so I'll apply it.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7746.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/a=
d7746.c
> index d793785..82fac76 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -410,8 +410,7 @@ static struct attribute *ad7746_attributes[] =3D {
>  	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
>  	&iio_dev_attr_in_voltage0_calibscale_calibration.dev_attr.attr,
>  	&iio_const_attr_in_voltage_sampling_frequency_available.dev_attr.attr,
> -	&iio_const_attr_in_capacitance_sampling_frequency_available.
> -	dev_attr.attr,
> +	&iio_const_attr_in_capacitance_sampling_frequency_available.dev_attr.at=
tr,
>  	NULL,
>  };
> =20
