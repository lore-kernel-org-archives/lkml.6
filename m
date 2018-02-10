Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeBJJnv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 04:43:51 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34741 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeBJJnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 04:43:50 -0500
X-Google-Smtp-Source: AH8x224EeVeNEEMU9dgc8yW+wAdTv4aNwxU7WyZkrETnm8BHuMQ5JST92hdyZk6keea7bG+E3mRNgmo3etws/8izB6E=
MIME-Version: 1.0
In-Reply-To: <20180209235012.4993-4-rabel@robertabel.eu>
References: <20180209235012.4993-1-rabel@robertabel.eu> <20180209235012.4993-2-rabel@robertabel.eu>
 <20180209235012.4993-3-rabel@robertabel.eu> <20180209235012.4993-4-rabel@robertabel.eu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 10 Feb 2018 10:43:49 +0100
Message-ID: <CANiq72mdqK0uf_7drJ=g3W=_M8JhM4TbOS2kuwPbc=T9+Bzs-w@mail.gmail.com>
Subject: Re: [PATCH 3/3] auxdisplay: charlcd: replace octal literal with
 form-feed escape sequence
To: Robert Abel <rabel@robertabel.eu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 12:50 AM, Robert Abel <rabel@robertabel.eu> wrote:
> There is no need to resort to octal escape sequence for the form feed character when an established escape sequence exists.
>
> Signed-off-by: Robert Abel <rabel@robertabel.eu>
> ---
>  drivers/auxdisplay/charlcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
> index 92549c8344a4..a3486db03d81 100644
> --- a/drivers/auxdisplay/charlcd.c
> +++ b/drivers/auxdisplay/charlcd.c
> @@ -555,7 +555,7 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
>                         /* back one char again */
>                         lcd->ops->write_cmd(lcd, LCD_CMD_SHIFT);
>                         break;
> -               case '\014':
> +               case '\f':

Normally I wouldn't bother with this kind of change, but since the
other switch cases all use escape sequences, this improves
consistency, so agreed.

Trivial. Compile-tested.

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

>                         /* quickly clear the display */
>                         charlcd_clear_fast(lcd);
>                         break;
> --
> 2.11.0
>
