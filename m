Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4+RCxiTvob//a2Q2Q1ih6ExKshwMuBuixJcd/Lzq/y4eKCyu2YQk9l7iEcLInSVPbV0WytC
ARC-Seal: i=1; a=rsa-sha256; t=1523805012; cv=none;
        d=google.com; s=arc-20160816;
        b=r2zAdilTn2Vqsaa2v2l9tquK4RFhVlts4J0ZmlBZ3YGCghZvgERd8ozDgU91lMnbq5
         0orG/OAGirUEIVxnRWIQxxjMzyc6/IrOf7bmrJOgFXJSw9d2mbFYiVOfksfj+WZOIy3/
         Cn1EY1Q8UPzn5oMobkoPr+qjT0q10ihjzJH4gCg4+WwJO5dyvqnw4eSwNGTHBNyBYU27
         Rs/NB2tQGRFjQorErg3OIizD6IJxZ+JNqlIB1o0lWRHZ6hUXBjGeXYfVMq2p8yZw5ZEq
         J4WPAmUZub5yvxoAv0A/hHhyH7fEaAepEFbXcxz7vcQb/Z/B1OicjGIOE+uMPdgcbtDi
         AJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=FAzMopLdq+rbD1PEaf4kcrIA0lTrtLEJtjFoHNURhSA=;
        b=YNOQtUiVZ3fHKMTxpaDVAkwO/jHHrnE624tWzLkl6fhyk3df/uHlF9F5qvBq/V07SB
         YS49aeL3vyNqm6hLnsXOdfUV5xmHe/F7pjEvZ5hULqli/gAL40PE9E5fndmYaSMuQr5a
         7++uPtZGbLhXu09tUee/dq6MI/3oVELGi0rrCnYPHQSUEz/857GgsbJUzUHZuAYmvIYP
         0XA8Bnw1xQTDynB/EnTZrm3PeYQH1BA93WWQ64zJHe42H2vYO6cRmtWjiaKWfofCl9nr
         BMD6JjRo+fR3pGZ2SqtErL3EsslzaRdoQubTvJ0Vx8XE02Rt9bhK5OSe1uJu6quyPp/X
         yWWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AADB2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 16:10:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/14] staging: iio: ad7746: Reorder variable
 declarations
Message-ID: <20180415161007.1890e9f7@archlinux>
In-Reply-To: <1523637411-8531-7-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-7-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649710321213681?=
X-GMAIL-MSGID: =?utf-8?q?1597825364905381265?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 13:36:43 -0300
Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Reorder some variable declarations in an inverse-pyramid scheme.
>=20
> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
Applied,

Thanks,

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7746.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/a=
d7746.c
> index 9ef476a..f53612a 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -220,8 +220,8 @@ static int ad7746_select_channel(struct iio_dev *indi=
o_dev,
>  				 struct iio_chan_spec const *chan)
>  {
>  	struct ad7746_chip_info *chip =3D iio_priv(indio_dev);
> -	int ret, delay, idx;
>  	u8 vt_setup, cap_setup;
> +	int ret, delay, idx;
> =20
>  	switch (chan->type) {
>  	case IIO_CAPACITANCE:
> @@ -289,8 +289,8 @@ static inline ssize_t ad7746_start_calib(struct devic=
e *dev,
>  {
>  	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>  	struct ad7746_chip_info *chip =3D iio_priv(indio_dev);
> -	bool doit;
>  	int ret, timeout =3D 10;
> +	bool doit;
> =20
>  	ret =3D strtobool(buf, &doit);
>  	if (ret < 0)
> @@ -680,8 +680,8 @@ static int ad7746_probe(struct i2c_client *client,
>  	struct ad7746_platform_data *pdata =3D client->dev.platform_data;
>  	struct ad7746_chip_info *chip;
>  	struct iio_dev *indio_dev;
> -	int ret =3D 0;
>  	unsigned char regval =3D 0;
> +	int ret =3D 0;
> =20
>  	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*chip));
>  	if (!indio_dev)
