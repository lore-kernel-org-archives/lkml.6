Return-Path: <robh+dt@kernel.org>
X-Google-Smtp-Source: AIpwx4/mUPjeU2qGsyL2ciPYxIHeFyQN/A9K8Gcq0Zrpogz6K3P/ecsBFiFSsGor8lfU4hIgBag+
ARC-Seal: i=1; a=rsa-sha256; t=1524680240; cv=none;
        d=google.com; s=arc-20160816;
        b=gzZPeUGVjnO4g1lgoehsZ6OqBjFtHi54x3z3Nu9fv3wSl/SLv1iJM7feE4EVdfqTKL
         dQLFBrx01UQC/hq6xzU31Ny+dtjaiOCdzOpKdSIwTgBGztJsmx+g2Xy13dTFyw+oNgs6
         vl1xUAqJUDQPgqdCCFUxC4UbgqZeAXKRNhshmLoyghYg+FJWosD8iTs+rcvTwCRpJg+V
         j/ZjqoL12B/3rLU6ImO84ejp3xt+lcISxPqmEmde4zO2IxpZ6AvdMrda2wCR5Df8fBbP
         4SxU2H3PNL3U8z6FZKIvRLs68xRDgZwe2302P9U0Pp3eRa3cgNA5JYTrOi/LBCZDiSp3
         y/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=Ye2waH5zL8JSnM60u6p7ZDsWGIYVSeJyaij3yeFFfC8=;
        b=w0OXCI98PRWtMAwFdcySW4fZRWOegn7XNP7DDeWZMtUp0fuBY0n9fFUCkRnMcNDv9f
         PD7YXjy1ayS3oHyEYuSW56ByKYfv9oMCldtK3KsUi3EHQ2dK/dMmm42zASNolUEb/KUt
         OI0EWAKWWt0Z0uJXSVApXUbos0y9K1KJ7lP9vwARsmYccqI3PiB9PzA4z7Hyzp6Ih1W/
         7sAkYIzwom50KENjx1IyeA2+D3mFfUAKWsFUzzGpM56JPq3ry8/gDcuxYqPxNzwkFIet
         Plpqn0tnsarxYivQZsQcALp2ofdnmaH+fEjX2qE5z6HCt0A/rFkAs+H+s8am+YWHNqiX
         TPvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A377F21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180424163458.11947-5-johan@kernel.org>
References: <20180424163458.11947-1-johan@kernel.org> <20180424163458.11947-5-johan@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 25 Apr 2018 13:16:58 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com>
Message-ID: <CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1598743107749593272?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 11:34 AM, Johan Hovold <johan@kernel.org> wrote:
> Add binding for u-blox GNSS receivers.
>
> Note that the u-blox product names encodes form factor (e.g. "neo"),
> chipset (e.g. "8") and variant (e.g. "q"), but that only formfactor and
> chipset is used for the compatible strings (for now).
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  .../devicetree/bindings/gnss/u-blox.txt       | 31 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/u-blox.txt
>
> diff --git a/Documentation/devicetree/bindings/gnss/u-blox.txt b/Documentation/devicetree/bindings/gnss/u-blox.txt
> new file mode 100644
> index 000000000000..bb54b83a177f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gnss/u-blox.txt
> @@ -0,0 +1,31 @@
> +u-blox GNSS Receiver DT binding
> +
> +The u-blox GNSS receivers can use UART, DDC (I2C), SPI and USB interfaces.
> +
> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> +properties.
> +
> +Required Properties:
> +
> +- compatible   : Must be one of
> +
> +                       "u-blox,neo-8"
> +                       "u-blox,neo-m8"
> +
> +- vcc-supply   : Main voltage regulator (VCC)

What about V_BCKP?

> +
> +Optional Properties:

reg is required if using I2C, SPI, or USB.

Datasheet also shows an interrupt pin.

> +
> +- timepulse-gpios      : Timepulse (e.g. 1PPS) GPIO (TIMEPULSE)

Why the 3rd "TIMEPULSE"?

> +
> +Example:
> +
> +serial@1234 {
> +       compatible = "ns16550a";
> +
> +       gnss {
> +               compatible = "u-blox,neo-8";
> +
> +               vcc-supply = <&gnss_reg>;
> +       };
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index b5f978a4cac6..2128dfdf73f1 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -374,6 +374,7 @@ tronsmart   Tronsmart
>  truly  Truly Semiconductors Limited
>  tsd    Theobroma Systems Design und Consulting GmbH
>  tyan   Tyan Computer Corporation
> +u-blox u-blox
>  ucrobotics     uCRobotics
>  ubnt   Ubiquiti Networks
>  udoo   Udoo
> --
> 2.17.0
>
