Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbeBJJ3N (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 04:29:13 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44305 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJJ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 04:29:12 -0500
X-Google-Smtp-Source: AH8x225OJQKts+juKz89YPxgk+8CGiu0aTWQrKgSD8Ij3zLDa3sigpubGJlyV2ZRJfdkoebRGIb0c90Vfv46Clei+yk=
MIME-Version: 1.0
In-Reply-To: <20180209235012.4993-3-rabel@robertabel.eu>
References: <20180209235012.4993-1-rabel@robertabel.eu> <20180209235012.4993-2-rabel@robertabel.eu>
 <20180209235012.4993-3-rabel@robertabel.eu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 10 Feb 2018 10:29:11 +0100
Message-ID: <CANiq72kx763JPhGhiL3CU_XT0SjWOf4N-vgmHpt4SC7Hv5cgsQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] auxdisplay: charlcd: use null character instead of
 zero literal to terminate strings
To: Robert Abel <rabel@robertabel.eu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 12:50 AM, Robert Abel <rabel@robertabel.eu> wrote:
> Using '\0' instead of plain 0 makes the intent clearer that this is indeed a string and not a series of integers.
>
> Signed-off-by: Robert Abel <rabel@robertabel.eu>
> ---
>  drivers/auxdisplay/charlcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
> index 324d02f9f1c5..92549c8344a4 100644
> --- a/drivers/auxdisplay/charlcd.c
> +++ b/drivers/auxdisplay/charlcd.c
> @@ -527,7 +527,7 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
>         if ((c != '\n') && priv->esc_seq.len >= 0) {
>                 /* yes, let's add this char to the buffer */
>                 priv->esc_seq.buf[priv->esc_seq.len++] = c;
> -               priv->esc_seq.buf[priv->esc_seq.len] = 0;
> +               priv->esc_seq.buf[priv->esc_seq.len] = '\0';
>         } else {
>                 /* aborts any previous escape sequence */
>                 priv->esc_seq.len = -1;
> @@ -536,7 +536,7 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
>                 case LCD_ESCAPE_CHAR:
>                         /* start of an escape sequence */
>                         priv->esc_seq.len = 0;
> -                       priv->esc_seq.buf[priv->esc_seq.len] = 0;
> +                       priv->esc_seq.buf[priv->esc_seq.len] = '\0';

Trivial. Compile-tested.

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

>                         break;
>                 case '\b':
>                         /* go back one char and clear it */
> --
> 2.11.0
>
