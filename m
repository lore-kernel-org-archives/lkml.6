Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xZNGIGZvHlsUYwAAmS7hNA
	; Mon, 11 Jun 2018 12:47:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 69F91607A4; Mon, 11 Jun 2018 12:47:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8EUm6lz"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 04F6760541;
	Mon, 11 Jun 2018 12:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04F6760541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932958AbeFKMrb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 08:47:31 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45596 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeFKMr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:47:29 -0400
Received: by mail-ua0-f196.google.com with SMTP id k14-v6so13393506uao.12;
        Mon, 11 Jun 2018 05:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WPXGr+s3Szyfok0w2Ppvm3sA7IRQliz0AqP22oT9WYU=;
        b=K8EUm6lzDbSq2Fmj9kYUcyIFjnX4zhTIP71qq8ewoZjhbHIzzmmbVZMe1NXmgptxN/
         HY+yiE2tgR68SIBTnxYSycIC8fTEKJ3pe7YObU3tG9cf9UwmvYn6mkPgESJx1KKsiAI8
         KAK6PTDVk1oaIXh2gscO2ZeWdcgfOFra/+y8EhQeVL4bzvm2pfrvRQgCoWnt9qMViOkN
         pvhoT0hmV97OLHu9/wF76aILS+1XURxi7+uEppMxs763gpENQv+ah0wvtepRARnH8YHM
         UY853gBx9B4eelOqE+O2h+uSUv/vuVaLxe4mzdh+QDM+OmeLtWOeFSYUVwJxFmE8xzA7
         LMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WPXGr+s3Szyfok0w2Ppvm3sA7IRQliz0AqP22oT9WYU=;
        b=dSGM5nY9ty1uX9ltkkn+IrLK/vFH8pKcDV41RUe/Fd6xGxDlYggwlil3PNHnPIIppd
         fDUKJH9DmzAEx6adO7Qq/PaEZEBdY2ukoUqvd5Bj8vb/TcSYxXbtC53fOm0Z/81UhCIv
         RP2DgHOxnNHKxQUwwSJ3CkRiIk7Sl8PGshLjRgjT/hYvcXRxpMhH1rR/dH8THTttt7wy
         4O54263gIrCkV7ck0fXMY9G2+NcreXMlPApgDDgFWWy8UVtOGkEf/htIHZRrWmyh5z6U
         +ajBoYdgeZ20TL/4JZkAI3QCAqa7u7AqTFHURxu1dYqrND11sP9+jCCUM+BhTMvn54Hj
         x6DQ==
X-Gm-Message-State: APt69E0LoQ20D8qXk4DfUlmGMbCcuxr8VDGNw7Geh86ERfxvoBzkCVSh
        5gI/VK0axh8+hJT4u5YDtUhEYl/44DKYPLkZRLk=
X-Google-Smtp-Source: ADUXVKJ9XTcdVlftq6cA0iWajGDthu9yGqCGDPttHxOFezSc36+oT+QBQcVPCWQov34lVh1XuJBytUNw43VxHJCMgiY=
X-Received: by 2002:ab0:6008:: with SMTP id j8-v6mr651628ual.28.1528721248687;
 Mon, 11 Jun 2018 05:47:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 05:47:27
 -0700 (PDT)
In-Reply-To: <20180611115240.32606-21-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com> <20180611115240.32606-21-ricardo.ribalda@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Jun 2018 15:47:27 +0300
Message-ID: <CAHp75VcKxZdp=Rmkt=K+yHq2aFAfSsD+SrKvPsSCCVLmLgc1pA@mail.gmail.com>
Subject: Re: [PATCH v2 20/24] serdev: Make match_id accessible by drivers
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 2:52 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Drivers that make use of the driver_data field require to transverse the
> id_table. There is no reason to have one implementation per driver.

> +const struct serdev_device_id *serdev_match_id(
> +                       const struct serdev_device_id *id,
> +                       const struct serdev_device *sdev)

I think slightly better would be

const strunct serdev_device *
serdev_match_id(const struct serdev_device_id *id,
                       const struct serdev_device *sdev)

>  {
>         while (id->name[0]) {
>                 if (!strcmp(sdev->modalias, id->name))
> -                       return 1;
> +                       return id;
>                 id++;
>         }
>
> -       return 0;
> +       return NULL;
>  }
> +EXPORT_SYMBOL_GPL(serdev_match_id);

Can we avoid ping-pong changes in the series? I mean to introduce this
helper in this form in the first place?


> -               return serdev_match_id(sdrv->id_table, sdev);
> +               return serdev_match_id(sdrv->id_table, sdev) != NULL;

return !!serdev_match_id(...);
?


> +const struct serdev_device_id *serdev_match_id(
> +               const struct serdev_device_id *id,
> +               const struct serdev_device *sdev);

Same as above.

-- 
With Best Regards,
Andy Shevchenko
