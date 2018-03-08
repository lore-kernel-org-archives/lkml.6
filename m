Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754740AbeCHTjT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:39:19 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45853 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbeCHTjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:39:17 -0500
X-Google-Smtp-Source: AG47ELszeQzILWfbGc/koUoeXxOcEnVSQDZTDIDGf/LMEnkTwYl2zcnu2VAM2UDknuu3BLkAKN3rXv6Jm8VF/8JepqQ=
MIME-Version: 1.0
In-Reply-To: <1520534733-1743-1-git-send-email-himanshujha199640@gmail.com>
References: <1520534733-1743-1-git-send-email-himanshujha199640@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Mar 2018 11:39:15 -0800
X-Google-Sender-Auth: MfNKLbatTCj1-nxqquD4poU7QkA
Message-ID: <CAGXu5jJzLczSzfJtWbhTUqAYXRG_-zKf2x8cz8jrAxu+XjkYdQ@mail.gmail.com>
Subject: Re: [PATCH] iio: potentiometer: ds1803: Remove VLA usage
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: jic23@kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 10:45 AM, Himanshu Jha
<himanshujha199640@gmail.com> wrote:
> In preparation to enabling -Wvla, remove VLA usage and replace it
> with fixed a fixed length array and therefore, prevent potential
> stack overflow attacks.
>
> Fixed as a part of the discussion to remove all VLAs from the kernel:
> https://lkml.org/lkml/2018/3/7/621
>
> Cc: keescook@chromium.org
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  drivers/iio/potentiometer/ds1803.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
> index 9b0ff4a..6bf12c9 100644
> --- a/drivers/iio/potentiometer/ds1803.c
> +++ b/drivers/iio/potentiometer/ds1803.c
> @@ -64,7 +64,7 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
>         struct ds1803_data *data = iio_priv(indio_dev);
>         int pot = chan->channel;
>         int ret;
> -       u8 result[indio_dev->num_channels];
> +       u8 result[ARRAY_SIZE(ds1803_channels)];

It seems like num_channels is always ARRAY_SIZE(ds1803_channels).
Could the entire field be dropped?

-Kees

>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW:
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
