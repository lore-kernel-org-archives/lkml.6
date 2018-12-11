Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A51C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2B92081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5fd4b53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2B92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeLKLts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:49:48 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50859 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLKLtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:49:46 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so3122124iti.0;
        Tue, 11 Dec 2018 03:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5YDmiWca5IoF3gLg6Bb64LY2v7tAav6jZhl6mD04MM=;
        b=h5fd4b53VSNSoiG2XTneCLlMnzOIbEG7CqmPT2U7ErrdVcIvK4+MfhSAbfcryPBabM
         SNKGxOQPqqTZvcoWk0vwJUr2q0u/fWPubzyfoa5xmD/Zm29SSkhJIa52dyeg6mi+JYV8
         uZWTFqM1Nn+ogNaw0MrgQuKMTa7Zm32uNI79v85TwfLO69g02n6rC/ez3yRjFOR6URji
         +eartszSghWGHOSNBPFo9tNSDKuxg4q8V3uNqUXKfvBAB4FBrYCqJwXraGaE/32JfdEa
         0XAbLXfa0fr+QWJZGOa5YEOF1dKyBxQdJEPXC2RJ7iWCdr6tLB1eU8p0zpw6TpQI49xq
         Pw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5YDmiWca5IoF3gLg6Bb64LY2v7tAav6jZhl6mD04MM=;
        b=oq+pbtR+I24J/GD2bHkzE/pqPAg7LCKkGiJIFE5a7TpXzpFKRj/byTTyClptTMXDFP
         Ul+AgQVKnOm237fugu7q0W1yiHPBGbkou5KMVX8rY6wRnuRfWZR4/OkKx7i0yGVG36tz
         1O3pylaj5ihMZeXrfzwVlyyN3J0DZGapqzpg6BViq0o4BjABEX9KkkuBWxCp6M1Np+J4
         fAQjdE4lowhflRwWoFGDZQexQuKRRmB/7lGtu1bc6+LgfWQuAAN/Y98silD3bWTrJdA3
         SKTnhtP7Owb9Rujpw+tiTFCeeVnFk7AfONPZ8cPz8D5yGDcuX1O5eWv+HxPgU8Lb9dgw
         KjPg==
X-Gm-Message-State: AA+aEWb3tv5kq1ba/xOrh4wnKtjw82Hrl/Mq9f6W8PYf+R3v2UDsOON/
        EPxeb6+zK+4q/JE+8rVy7BtmiIrhSfnExj/E2KWtWP/l
X-Google-Smtp-Source: AFSGD/XmLZzv5nE3Suk1Vhxix9aIHvgAy9Jblz0odHbduKaz/EzP4+wyJCwJKDhc34aY9tf0RAKgQDdegi549m4N2xI=
X-Received: by 2002:a24:4648:: with SMTP id j69mr1891789itb.56.1544528985188;
 Tue, 11 Dec 2018 03:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20181210154433.28319-1-hardiksingh.k@gmail.com> <44f0a055e4085824629285e78ac4928e15c494e3.camel@perches.com>
In-Reply-To: <44f0a055e4085824629285e78ac4928e15c494e3.camel@perches.com>
From:   Hardiksingh Rathore <hardiksingh.k@gmail.com>
Date:   Tue, 11 Dec 2018 17:19:33 +0530
Message-ID: <CALxnk1NLo9cAUXB=oxkvz7AQnxb7dqdeG9A_MA=OwgTkYfu-yg@mail.gmail.com>
Subject: Re: [PATCH] Input: touchscreen: ad7879: Fix ERROR: foo* bar should be
 "foo *bar"
To:     joe@perches.com
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        michael.hennerich@analog.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, 11 Dec 2018 at 01:07, Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2018-12-10 at 21:14 +0530, Hardik Singh Rathore wrote:
> > Fix the coding style problem reported by checkpatch.pl.
>
> While whitespace only checkpatch cleanups are generally not
> well accepted, why do one pointer location cleanup when you
> could them all:
>
As suggested, I have sent the v2 patch for pointer location cleanups
in all other
drivers/input/touchscreen/* files.

> $ ./scripts/checkpatch.pl -f --types=pointer_location --fix-inplace drivers/input/touchscreen/*.[ch]
> $ git diff --stat -p drivers/input/touchscreen/
>
> produces:
> ---
>  drivers/input/touchscreen/ad7879.c   | 2 +-
>  drivers/input/touchscreen/ektf2127.c | 2 +-
>  drivers/input/touchscreen/gunze.c    | 4 ++--
>  drivers/input/touchscreen/inexio.c   | 4 ++--
>  drivers/input/touchscreen/mtouch.c   | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index 2aae880c8aa6..6fa714c587b4 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -289,7 +289,7 @@ static int ad7879_open(struct input_dev *input)
>         return 0;
>  }
>
> -static void ad7879_close(struct input_dev* input)
> +static void ad7879_close(struct input_dev *input)
>  {
>         struct ad7879 *ts = input_get_drvdata(input);
>
> diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
> index 0ed34ff787ce..28fa1b36f7a5 100644
> --- a/drivers/input/touchscreen/ektf2127.c
> +++ b/drivers/input/touchscreen/ektf2127.c
> @@ -51,7 +51,7 @@ struct ektf2127_ts {
>         struct touchscreen_properties prop;
>  };
>
> -static void ektf2127_parse_coordinates(const u8* buf, unsigned int touch_count,
> +static void ektf2127_parse_coordinates(const u8 *buf, unsigned int touch_count,
>                                        struct input_mt_pos *touches)
>  {
>         int index = 0;
> diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
> index 054c2537b392..56cf1a1ea3ea 100644
> --- a/drivers/input/touchscreen/gunze.c
> +++ b/drivers/input/touchscreen/gunze.c
> @@ -53,7 +53,7 @@ struct gunze {
>         char phys[32];
>  };
>
> -static void gunze_process_packet(struct gunze* gunze)
> +static void gunze_process_packet(struct gunze *gunze)
>  {
>         struct input_dev *dev = gunze->dev;
>
> @@ -72,7 +72,7 @@ static void gunze_process_packet(struct gunze* gunze)
>  static irqreturn_t gunze_interrupt(struct serio *serio,
>                 unsigned char data, unsigned int flags)
>  {
> -       struct gunze* gunze = serio_get_drvdata(serio);
> +       struct gunze *gunze = serio_get_drvdata(serio);
>
>         if (data == '\r') {
>                 gunze_process_packet(gunze);
> diff --git a/drivers/input/touchscreen/inexio.c b/drivers/input/touchscreen/inexio.c
> index b9bc56233ccc..13bd0bf580a7 100644
> --- a/drivers/input/touchscreen/inexio.c
> +++ b/drivers/input/touchscreen/inexio.c
> @@ -79,7 +79,7 @@ static void inexio_process_data(struct inexio *pinexio)
>  static irqreturn_t inexio_interrupt(struct serio *serio,
>                 unsigned char data, unsigned int flags)
>  {
> -       struct inexio* pinexio = serio_get_drvdata(serio);
> +       struct inexio *pinexio = serio_get_drvdata(serio);
>
>         pinexio->data[pinexio->idx] = data;
>
> @@ -97,7 +97,7 @@ static irqreturn_t inexio_interrupt(struct serio *serio,
>
>  static void inexio_disconnect(struct serio *serio)
>  {
> -       struct inexio* pinexio = serio_get_drvdata(serio);
> +       struct inexio *pinexio = serio_get_drvdata(serio);
>
>         input_get_device(pinexio->dev);
>         input_unregister_device(pinexio->dev);
> diff --git a/drivers/input/touchscreen/mtouch.c b/drivers/input/touchscreen/mtouch.c
> index a3707fad4d1c..8278a9058640 100644
> --- a/drivers/input/touchscreen/mtouch.c
> +++ b/drivers/input/touchscreen/mtouch.c
> @@ -90,7 +90,7 @@ static void mtouch_process_response(struct mtouch *mtouch)
>  static irqreturn_t mtouch_interrupt(struct serio *serio,
>                 unsigned char data, unsigned int flags)
>  {
> -       struct mtouch* mtouch = serio_get_drvdata(serio);
> +       struct mtouch *mtouch = serio_get_drvdata(serio);
>
>         mtouch->data[mtouch->idx] = data;
>
> @@ -110,7 +110,7 @@ static irqreturn_t mtouch_interrupt(struct serio *serio,
>
>  static void mtouch_disconnect(struct serio *serio)
>  {
> -       struct mtouch* mtouch = serio_get_drvdata(serio);
> +       struct mtouch *mtouch = serio_get_drvdata(serio);
>
>         input_get_device(mtouch->dev);
>         input_unregister_device(mtouch->dev);
>
>


-- 
Thanks,
Hardik
