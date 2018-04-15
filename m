Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx48VYrCvhE4fW/n3jW4+UNSo2+wqbJy6yo2yHt3HNUKxkmlYwBxi1IvQDWMSjuF7w9jDfpOR
ARC-Seal: i=1; a=rsa-sha256; t=1523806669; cv=none;
        d=google.com; s=arc-20160816;
        b=jFqbx1s70BinPX12DEN9qvEaJd5SdnBR2XxzYxrpiIOalZvuNxvmK/NeU5/xieaFpj
         QGTE3+ENecx56QOf5HhNTwuQagLM4ZNZoIMW8tGk4yEFEARkAApek6UzYI0RuTbyv8K4
         W9yZippi8y+r1n8gUf89ACl5obPJMqjktxFLKmP7zcJSLteR15bnIoqlO1sTEMQElmFy
         uNr3h3oMsfVajDY2kxCM5+j5x5cLlYD6oaR4bWOlStS/04ToPTjcgYlWbse/ViaPxW5C
         UPrCmNxq67y/snfIQI4iy1qTZTbEqV75VWEuGKG2ee2VVQ33nd7Hhz73cIIiF/0OqPdf
         NEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=A1KmijpIMUPkUnO/eB8moBV0WmyhvJIBH2NjhFdpB6I=;
        b=AFuEN6judjUCoJESwgnk+6wAUjMN57Q01cqq0vPCbxjRqRYgwcRaHLFJaXR4rbsHcx
         Jc6W1oMCp5HlJugpYKzvtwwHwdPhTwNLOCwRDHvuRFVeEe3CnNB15HjSwTQsdSWbsIMa
         u62rRZrld+wZ5/Zm+o46Z4KFXkTUmLYAMpCC+SGsu+T72uhgF+NkDDWbCpIbrGP77Pw2
         21TWJ2d9Tw6S14txdi4V6NZ24VwCtJ6OG7Vd4dQR6xRFKNWPpUFSlyYRtg7UteOxDRrB
         s9IakysuKqfOR7lPNmjD25bQ4+EC0FmIxyAcBQBLWiUJ3q5Z+S6/J2qPjYDRBQlMEH4j
         q1tQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DFD2176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 16:37:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 11/14] staging: iio: ad7746: Add devicetree bindings
 documentation
Message-ID: <20180415163743.2fa992f9@archlinux>
In-Reply-To: <1523637411-8531-12-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-12-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649752365907922?=
X-GMAIL-MSGID: =?utf-8?q?1597827101795250940?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 13:36:48 -0300
Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
A few comments inline.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/staging/iio/cdc/ad7746.txt | 34 ++++++++++++++++=
++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/staging/iio/cdc/ad7=
746.txt
>=20
> diff --git a/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt=
 b/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
> new file mode 100644
> index 0000000..7740f05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
> @@ -0,0 +1,34 @@
> +Analog Devices AD7746/5/7 capacitive sensor driver
> +
> +Required properties:
> +	- compatible: Should be one of
> +		* "adi,ad7745"
> +		* "adi,ad7746"
> +	  * "adi,ad7747"
> +	- reg: The 7-bits long I2c address of the device
> +
> +Optional properties:
> +	- adi,exclvl: This property defines the excitation voltage level for the
> +    capacitance to be measured. Possible values are:
> +      * 0 =3D +-VDD/8
> +      * 1 =3D +-VDD/4
> +      * 2 =3D +-VDD * 3/8
> +      * 3 =3D +-VDD/2 (Default)
> +	- adi,nexca_en: Invert excitation output A.

The naming is rather odd.  Why _en?

> +	- adi,nexcb_en:	Invert excitation output B.
> +
> +Example:
> +Here exclvl would be 1 (VDD/4), Excitation pin A would be inverted and
> +Excitation pin B would NOT be inverted.
> +
> +i2c2 {
> +
> +      < . . . >
What does this spacer add to the example?
Sure, there can be other devices, but no need to illustrate that here.

> +
> +      ad7746: ad7746@60 {
> +              compatible =3D "ad7746";
> +              reg =3D <0x60>;
> +              adi,exclvl =3D <1>;
> +              adi,nexca_en;
> +      };
> +};
