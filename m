Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx49QR/5xzqUvvdFNU3/mwQcTGT2TtTxSUbXOjcpIa78L5FbEENKYmTeOXhKEyTRzIDSk+k5Q
ARC-Seal: i=1; a=rsa-sha256; t=1523377218; cv=none;
        d=google.com; s=arc-20160816;
        b=UKUCl9fngDYYJ9CEdKTg68hCJIo1RZrpSQKYjGpX6VIRH6wlnANncZGqW5XXxqUEGW
         mG73oSXnPpY0Pb2pnfTNYslAYvZ9bwzyXSJDaK+AY/142IEVHf9tEwx+VLk+fRNwiLx/
         tTempBiHd70RflMxDVYU7+I1GGg7bM3wHoUOgYqxCe8h9ikcw9Y22NNUZC+il0zjUeKr
         XTvvi3dCM/Dr6NaW9SvnOGZp65GSF9rSUIxU+V4C833J1o+uT/5jcV1/6Tuh/JcMZb05
         AfXF0vIxaVBuGEBWWdc8iGrh0PtYcGFrmlhfjBsp/tDSheZSK5XPxn/46nVYt33gB43f
         qGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=WjGW+sBOAUEP/rXUeNoW7cTmOkrfFQldZpyMhx7Svzc=;
        b=SIQg1V4i9YVU3PLLbEVtS+DCtVwNJ8uU0EAP+mxMVhr4Fe+91V1efICq4pFteAGpXr
         p0TbjbVRdUPLnbhiJ0ougozLTLp2kK6BAGHh4KqIbhUtIf0EFFApD227BIaleHkknXmC
         h/zdN5C4aOu5w+L6gKUK4gW17pcwhbEyYnAuOyLE8+nHxsGqt41HCdOXKNh7nZhtZ3JT
         Q3bKD2g3RoKvzDpxTjspGLKQ48/BtRczn2kI7yH+heXN/68BzJH6Peh6GY0+YtG7UYNl
         TBRflidGpYYH8bnS2IF2w9sPoNNY/wateykOYUdqZiLBt6msgFL69RuSnQQY3zUry5PY
         MlYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=yOlNyJpI;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=yOlNyJpI;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH v2 6/6] iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R
 support
To: Stefan Popa <stefan.popa@analog.com>, jic23@kernel.org,
 Michael.Hennerich@analog.com, lars@metafoo.de
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net, davem@davemloft.net,
 mchehab@kernel.org, gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 akpm@linux-foundation.org, Ismail.Kose@maximintegrated.com, lukas@wunner.de,
 fabrice.gasnier@st.com, mike.looijmans@topic.nl,
 kstewart@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1522418209-11927-1-git-send-email-stefan.popa@analog.com>
 <1523375929-29830-1-git-send-email-stefan.popa@analog.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8285eee1-3fda-867f-9b30-ce693057f57c@infradead.org>
Date: Tue, 10 Apr 2018 09:19:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523375929-29830-1-git-send-email-stefan.popa@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596371266008141789?=
X-GMAIL-MSGID: =?utf-8?q?1597376789538155116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/10/18 08:58, Stefan Popa wrote:
> The AD5694/AD5694R/AD5695R/AD5696/AD5696R are a family of 4 channel DACs
> with 12-bit, 14-bit and 16-bit precision respectively. The devices have
> either no built-in reference, or built-in 2.5V reference.
> 
> The AD5671R/AD5675R are similar, except that they have 8 instead of 4
> channels.
> 
> These devices are similar to AD5672R/AD5676/AD5676R and
> AD5684/AD5684R/AD5684/AD5685R/AD5686/AD5686R, except that they use i2c
> instead of spi.
> 
> Datasheets:
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5671R_5675R.pdf
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5696R_5695R_5694R.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v2:
> 	- Refactored the patch
> 
>  MAINTAINERS                  |  1 +
>  drivers/iio/dac/Kconfig      | 10 +++++
>  drivers/iio/dac/Makefile     |  1 +
>  drivers/iio/dac/ad5686.c     | 28 +++++++++++++
>  drivers/iio/dac/ad5686.h     |  7 ++++
>  drivers/iio/dac/ad5696-i2c.c | 98 ++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 145 insertions(+)
>  create mode 100644 drivers/iio/dac/ad5696-i2c.c
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index a00fc45..dab0b8a 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -145,6 +145,16 @@ config AD5686_SPI
>  	To compile this driver as a module, choose M here: the
>  	module will be called ad5686.
>  
> +config AD5696_I2C
> +	tristate "Analog Devices AD5696 and similar multi-channel DACs (I2C)"
> +	depends on I2C
> +	select AD5686
> +	help
> +	Say yes here to build support for Analog Devices AD5671R, AD5675R,
> +	AD5694, AD5694R, AD5695R, AD5696, AD5696R Voltage Output Digital to
> +	Analog Converter.
> +	To compile this driver as a module, choose M here: the module will be
> +	called ad5696.

The help text (following the "help" line) should be indented 2 additional spaces,
according to Documentation/process/coding-style.rst.

(for patches 5 & 6)

>  config AD5755
>  	tristate "Analog Devices AD5755/AD5755-1/AD5757/AD5735/AD5737 DAC driver"


-- 
~Randy
