Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeBWNUR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:20:17 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34341 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeBWNUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:20:11 -0500
X-Google-Smtp-Source: AG47ELvhfBFh6Y53JgSbLEXp+aqgxdsFGHS6RtgUab5vt8xrjrEmlcRhl7MciqvE8R3GSlaTEC79BE7V67POTTSLIU8=
MIME-Version: 1.0
In-Reply-To: <20171012213546.GA13688@embeddedor.com>
References: <20171012213546.GA13688@embeddedor.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 23 Feb 2018 14:19:50 +0100
Message-ID: <CANiq72nrH=x3T6Nzg76p1b1p5K9iPYQWZGFKMOSaKvBdRzU8zA@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: panel: mark expected switch fall-throughs
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Thu, Oct 12, 2017 at 11:35 PM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> In this particular case, notice that I replaced the "no break here,
> fall through" comments with "fall through" comments, which is what
> GCC is expecting to find.
>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/auxdisplay/panel.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
> index 6911acd..8b80a97 100644
> --- a/drivers/auxdisplay/panel.c
> +++ b/drivers/auxdisplay/panel.c
> @@ -1372,7 +1372,7 @@ static void panel_process_inputs(void)
>                                 break;
>                         input->rise_timer = 0;
>                         input->state = INPUT_ST_RISING;
> -                       /* no break here, fall through */
> +                       /* fall through */
>                 case INPUT_ST_RISING:
>                         if ((phys_curr & input->mask) != input->value) {
>                                 input->state = INPUT_ST_LOW;
> @@ -1385,11 +1385,11 @@ static void panel_process_inputs(void)
>                         }
>                         input->high_timer = 0;
>                         input->state = INPUT_ST_HIGH;
> -                       /* no break here, fall through */
> +                       /* fall through */
>                 case INPUT_ST_HIGH:
>                         if (input_state_high(input))
>                                 break;
> -                       /* no break here, fall through */
> +                       /* fall through */

Thanks! I will put it in my queue (I sent a similar one a few days
ago, so I will pick yours).

Cheers,
Miguel

>                 case INPUT_ST_FALLING:
>                         input_state_falling(input);
>                 }
> --
> 2.7.4
>
