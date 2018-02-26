Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBZQAB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:00:01 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34971 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbeBZQAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:00:00 -0500
X-Google-Smtp-Source: AG47ELvW43rg9GZpPzCK9SjgFnshS8WVohsWeRcNyqJgbfndu5mjb6oIdRy+jJdO7w0J4aN/fGNdmXOo8QAUVsO1z00=
MIME-Version: 1.0
In-Reply-To: <20180225235432.31209-3-rabel@robertabel.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu> <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Feb 2018 16:59:38 +0100
Message-ID: <CANiq72ne=brTBwkeV29H7S3=KH17VQL6GD_Z2N6aWvGC7tgY-g@mail.gmail.com>
Subject: Re: [PATCH 2/4] auxdisplay: charlcd: name x/y address struct
To: Robert Abel <rabel@robertabel.eu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 12:54 AM, Robert Abel <rabel@robertabel.eu> wrote:
> Signed-off-by: Robert Abel <rabel@robertabel.eu>
> ---
>  drivers/auxdisplay/charlcd.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
> index e3b2fd15c5a3..a3d364e6c666 100644
> --- a/drivers/auxdisplay/charlcd.c
> +++ b/drivers/auxdisplay/charlcd.c
> @@ -67,6 +67,11 @@
>  #define LCD_ESCAPE_LEN         24      /* Max chars for LCD escape command */
>  #define LCD_ESCAPE_CHAR                27      /* Use char 27 for escape command */
>
> +struct charlcd_priv_addr {
> +       unsigned long int x;
> +       unsigned long int y;
> +};
> +
>  struct charlcd_priv {
>         struct charlcd lcd;
>
> @@ -80,12 +85,9 @@ struct charlcd_priv {
>         unsigned long int flags;
>
>         /* Contains the LCD X and Y offset */
> -       struct {
> -               unsigned long int x;
> -               unsigned long int y;
> -       } addr;
> +       struct charlcd_priv_addr addr;

Since this is a very small change and you use it in the 3rd patch, I
think it is clearer to have it there.

>
> -       /* Current escape sequence and it's length or -1 if outside */
> +       /* Current escape sequence and its length or -1 if outside */

While this could be left in its own patch ("fix typo...").

Thanks!
Miguel

>         struct {
>                 char buf[LCD_ESCAPE_LEN + 1];
>                 int len;
> --
> 2.11.0
>
