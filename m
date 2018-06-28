Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07297C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65BA273CE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65BA273CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967260AbeF1Pgl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:36:41 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42235 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935342AbeF1Pgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:36:38 -0400
Received: by mail-vk0-f65.google.com with SMTP id s187-v6so3546745vke.9;
        Thu, 28 Jun 2018 08:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxIcuKh8U6JibxyGplmMktvcdBnhDY6cF27nkh1GyVY=;
        b=igGzlWascXMCWm4zCDGEzOzq4FL6POwQiJF9rj/dKef85i/pUe3XAcemM/BM4wzGPP
         CQcUhvlTO04C0h84NkqgX9tHJy0sNGlE4FbiXaewSJpXIoNQv5ktz+aTbNEZcKUEOntD
         GJXvNS8TmbxNNe7ztw+MD48TMC+CKJ6mieD3K3HuUjAVmx1x2m6V6k92wc3wXNHQRxpc
         ilTrVeS9oIHgQPgHLgiWsin2Dv1B0s7pmItDywk2kEsFX4/SG1ckL97fVBhG9NfOsZHf
         KRB0pxSXEKL8kJDbU3S/d0t5iAXSu/Xira4mB4hYblG3+TKbU4VrjZYqZTc1Y2CpwZoR
         +/PQ==
X-Gm-Message-State: APt69E2xkajCLDXVlp1MZYedRDVt4PfEPAldGNHgDfOxehKBSBwMPLtI
        41m7QmGC0N08f1CTq7ZFci83O0FlQnA8zFp5ZVg=
X-Google-Smtp-Source: AAOMgpcdH4gNkQS2RRYRGv2T3W/jT84RipGsfw1h0zXGVlCJP/N82F6gbRG5PW4Wo++QjWvEtWZw0+p8Xkt7snBo4m8=
X-Received: by 2002:a1f:e92:: with SMTP id 140-v6mr6607541vko.90.1530200197369;
 Thu, 28 Jun 2018 08:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180628134227.GA1719@arbeit>
In-Reply-To: <20180628134227.GA1719@arbeit>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Jun 2018 17:36:25 +0200
Message-ID: <CAMuHMdX4CACrHq1R-29190uGzhHKKrsrqqeEfJuauNjeq-sY_w@mail.gmail.com>
Subject: Re: [PATCH] leds: ledtrig-morse: send out morse code
To:     ak@it-klinger.de
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ben Whitten <ben.whitten@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Willy Tarreau <w@1wt.eu>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Thu, Jun 28, 2018 at 3:42 PM Andreas Klinger <ak@it-klinger.de> wrote:
> Send out a morse code by using LEDs.
>
> This is useful especially on embedded systems without displays to tell the
> user about error conditions and status information.
>
> The trigger will be called "morse"
>
> The string to be send is written into the file morse_string and sent out
> with a workqueue. Supported are letters and digits.
>
> With the file dot_unit the minimal time unit can be adjusted in
> milliseconds.
>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>\

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/leds/trigger/ledtrig-morse.c
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ledtrig-morse: LED Morse Trigger
> + *
> + * send a string as morse code out through LEDs
> + *
> + * can be used to send error codes or messages
> + *
> + * string to be send is written into morse_string
> + * supported are letters and digits
> + *
> + * Author: Andreas Klinger <ak@it-klinger.de>
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/ctype.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/workqueue.h>
> +#include <linux/leds.h>
> +
> +
> +#define MORSE_DOT_UNIT_DEFAULT 500
> +#define MORSE_TELEGRAM_SIZE    100
> +
> +struct morse_data {
> +       unsigned int            dot_unit;
> +       struct led_classdev     *led_cdev;
> +       struct work_struct      work;
> +       char                    telegram[MORSE_TELEGRAM_SIZE];
> +       unsigned int            telegram_size;
> +       struct mutex            lock;
> +};
> +
> +struct morse_char {
> +       char    c;
> +       char    *z;
> +};
> +
> +static struct morse_char morse_table[] = {
> +       {'a', ".-S"},

What's the added value of the trailing "S", which is present in each string,
over the standard NUL terminator, which is also present?

Given no character uses more than 5 symbols, a more compact encoding
(e.g. 3 bits for length, 5 bits for symbols) could be used.
But it may not be worth doing that optimization. And you may want to add
support for more characters later.

> +static void morse_send_char(struct led_classdev *led_cdev, char ch)
> +{
> +       int i = 0;

unsigned int

> +
> +       while ((morse_table[i].c) && (morse_table[i].c != tolower(ch)))
> +               i++;
> +
> +       if (morse_table[i].c) {
> +               int j = 0;

unsigned int

> +
> +               while (morse_table[i].z[j] != 'S') {

Without the trailing "S"es, you could just check for "morse_table[i].z[j]".

> +                       switch (morse_table[i].z[j]) {
> +                       case '.':
> +                               morse_short(led_cdev);
> +                               break;
> +                       case '-':
> +                               morse_long(led_cdev);
> +                               break;
> +                       }
> +                       j++;
> +               }
> +               morse_letter_space(led_cdev);
> +       } else {
> +               /*
> +                * keep it simple:
> +                * whenever there is an unrecognized character make a word
> +                * space
> +                */
> +               morse_word_space(led_cdev);
> +       }
> +}
> +
> +static void morse_work(struct work_struct *work)
> +{
> +       struct morse_data *data = container_of(work, struct morse_data, work);
> +       int i;

unsigned int i;

> +
> +       mutex_lock(&data->lock);
> +
> +       for (i = 0; i < data->telegram_size; i++)
> +               morse_send_char(data->led_cdev, data->telegram[i]);
> +
> +       mutex_unlock(&data->lock);
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
