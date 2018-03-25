Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELvszUezUtWKh1FdZFgyPELC6RNt9Ql0RiKENiZOhWu3MBT0Ainpt0WVb7PkhGpdpvh26hWr
ARC-Seal: i=1; a=rsa-sha256; t=1521998396; cv=none;
        d=google.com; s=arc-20160816;
        b=Z/u3O4DbMMaXKP5+nl8+nfDOMFGguufhN89jZS0DokdxCmjRdrtnDq9nwDZaQwRnZa
         OLP3DyKh/i0XUIJw7gRL5zJnojy8V/ODubtV8a8c47T9IErUyDNipPOreGVqzhq/XWK3
         mwKhEHF0FvNKhyk/4vbm/LcAKTHOIA9+RrGaXWi2DC7jX8buoh3WzPX1OsgN1ZaRabgv
         bQvGKeWcKAI9G1zJyQRIwhWZVgLd3HODHhJiVFyV5Q5OBGaGlzlFhFRPM5Iu4UmlRhzQ
         k8rmeEx86UitBLWZfoEb4K/zluAQ07iLpYL+0kenWA9b2uxTF/M8xJhSAh+lv11TZRvr
         kKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=C982W8t7/WUhpyKTYF5bYJVOxtSSZ+1xXBmkedGFHR0=;
        b=McspOlTjrrPEQq5fu3ieWJD9V6DErGONQknqAmC0hF7RhELwEeCijjW4LPL+6pifIl
         ir+Bx/nNzFIJIsKaSbWRKXB1usjhuCxZSWL0yrHO3oHUcnVw1f5u1lZP/8lQer05xZx9
         mxFsZSTikJ/ab9njeC9s7eIMaIu/y9ROi2nut9WSx5IWcpdpak91InWff+QS4wJMWuLx
         Ac6bqkqluRRBjY/D4FRecX15jhMpP5F4vcE2CH/z5WLfmLTKDLPxWBA8+WK5R1GOQnS9
         D7DTH74JygfRrLXTOoEbX0hNQXQoqv+PfgEZNpNoEOHrwq18Tysex9RSmV62VH3FI6NJ
         P4Ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488CE21716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 25 Mar 2018 18:19:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
 devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
 pmeerw@pmeerw.net, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: Re: [PATCH 3/4] staging: iio: tsl2x7x: use either direction for
 IIO_EV_INFO_{ENABLE,PERIOD}
Message-ID: <20180325181951.2af8567a@archlinux>
In-Reply-To: <20180324200555.1403-4-masneyb@onstation.org>
References: <20180324200555.1403-1-masneyb@onstation.org>
	<20180324200555.1403-4-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595850848700246638?=
X-GMAIL-MSGID: =?utf-8?q?1595930990601863224?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 24 Mar 2018 16:05:54 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The events IIO_EV_INFO_VALUE and IIO_EV_INFO_ENABLE currently have a
> falling and rising direction configured. There does not need to be a
> separate distinction so this patch changes these to use the
> either direction. Directory listing of event sysfs attributes for a
> TSL2772 with this patch applied:
> 
> in_intensity0_thresh_either_en
> in_intensity0_thresh_either_period
> in_intensity0_thresh_falling_value
> in_intensity0_thresh_rising_value
> in_proximity0_thresh_either_en
> in_proximity0_thresh_either_period
> in_proximity0_thresh_falling_value
> in_proximity0_thresh_rising_value
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
This one is fine and reasonably clear of patch 2 so I can still apply it.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index d5a237fb0a0b..940bea2378a9 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1469,17 +1469,16 @@ static const struct iio_event_spec tsl2x7x_events[] = {
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
>  		.dir = IIO_EV_DIR_RISING,
> -		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> -			BIT(IIO_EV_INFO_ENABLE),
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
>  	}, {
>  		.type = IIO_EV_TYPE_THRESH,
>  		.dir = IIO_EV_DIR_FALLING,
> -		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> -			BIT(IIO_EV_INFO_ENABLE),
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
>  	}, {
>  		.type = IIO_EV_TYPE_THRESH,
>  		.dir = IIO_EV_DIR_EITHER,
> -		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
> +		.mask_separate = BIT(IIO_EV_INFO_PERIOD) |
> +			BIT(IIO_EV_INFO_ENABLE),
>  	},
>  };
>  
