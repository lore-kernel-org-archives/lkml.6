Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4/AF6ZN7kj0cH0Ug7JOagrpZlOqYZF41tTsIi7ThwVS2gmmjFP7aH721zLmv6GAM+vMntrh
ARC-Seal: i=1; a=rsa-sha256; t=1523804755; cv=none;
        d=google.com; s=arc-20160816;
        b=Xgybx9/g4mdxHZGotaKoRgojaKd72p9IPekx0YpOTNe9a1G3N6JWEu/BjawsFN/7f9
         KVe6lQZSXdrUxUUJ4GSB9+f+rF9N+UmtMyKUWjdM+r50gAnwFkhUOVvQgz3NFNGTr0t+
         2Y41VmKQddRV7pTMnslWilOkVTLdNmU14EWVP4c6R87pRazNnGohYSQ1vsJ9wOHA6/P1
         jialJp4BEJU/JsefLs3wQ4bveuvOGODKgfG8VNjRAtwhIYrSjteSp4lSLzPT9Ym1GrS6
         9eGWdI9fWooB8lGf1bH/Q5NpTmSATCtvVO4lkEzR8g0SCk8NDysOksbbRY9MbupV5Sc+
         NusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=usyXKaVkBnrK4G0XdfmA7wGaqs1TmCBCPAHpYoOsvIc=;
        b=V9AAV/TZPDXPn/bOhebtoa4m6eNEvXf5nKPxuDg/GSlJZ+O/wgobziNKExHU2LVNus
         dB/A2uIRu4YEkfUnbCaJwOSjWeDvHywP4V0ujtDOwxIiM4OPHPt0puzJ3bE3Z32erPcg
         Ef2/mnuXUy93NxBAUcbDAm/JH2i965IvGkNcvqmtVrs9qiv4ik58YuEL5uXH9a0snROq
         gD78JRsoeUnOBz/9DTLbL3hQakTVmVkVqEVf/OH2BEIDPrFuKW1bh5VmhcpfD8wH4iLj
         O0+rqlwTxEz3RjmePSrWlmrCVbQTh8qdBSmumyAWTrtA0RW3QTyDAVRA1CbIbe//LvuA
         J6HQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3517520779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 16:05:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] staging: iio: ad7746: Fix bound checkings
Message-ID: <20180415160550.4705667e@archlinux>
In-Reply-To: <1523637411-8531-4-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-4-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649691066295032?=
X-GMAIL-MSGID: =?utf-8?q?1597825095759500537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 13:36:40 -0300
Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Also remove unnecessary parenthesis
I am probably missing something.  I'm not sure what you mean
by fix bound checking?   There are superfluous brackets, but
I don't see any functional change to indicate there was anything
wrong with the original checks.

>=20
> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/a=
d7746.c
> index 516aa93..d793785 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -458,7 +458,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  		ret =3D 0;
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		if ((val < 0) | (val > 0xFFFF)) {
> +		if (val < 0 || val > 0xFFFF) {
>  			ret =3D -EINVAL;
>  			goto out;
>  		}
> @@ -470,7 +470,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  		ret =3D 0;
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> -		if ((val < 0) | (val > 43008000)) { /* 21pF */
> +		if (val < 0 || val > 43008000) { /* 21pF */
>  			ret =3D -EINVAL;
>  			goto out;
>  		}
