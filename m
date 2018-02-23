Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeBWKag (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:30:36 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36734 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeBWKae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:30:34 -0500
X-Google-Smtp-Source: AG47ELt+DhoUoRFjoz2dRS2fvx2iTeuXDEwrU2OI02ZpBz4upF0lSbELsDBifXcAPj+/+PJcusIP2DvAcxE9Eip1JWs=
MIME-Version: 1.0
In-Reply-To: <1517391071-29042-1-git-send-email-shannon.ml.booth@gmail.com>
References: <1517391071-29042-1-git-send-email-shannon.ml.booth@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 23 Feb 2018 11:30:13 +0100
Message-ID: <CANiq72nrmPHq6Cb0VXBp44fY+cc84KgzB-Jn+uKS233-jMcPMA@mail.gmail.com>
Subject: Re: [PATCH] staging: auxdisplay: add missing MODULE_LICENSE()
To: Shannon Booth <shannon.ml.booth@gmail.com>
Cc: Paul Burton <paul.burton@mips.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shannon,

On Wed, Jan 31, 2018 at 10:31 AM, Shannon Booth
<shannon.ml.booth@gmail.com> wrote:
> This patch fixes the compilation warning:
>
> WARNING: modpost: missing MODULE_LICENSE() in drivers/auxdisplay/img-ascii-lcd.o
>
> Signed-off-by: Shannon Booth <shannon.ml.booth@gmail.com>
> ---
>  drivers/auxdisplay/img-ascii-lcd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
> index db040b3..9222c88 100644
> --- a/drivers/auxdisplay/img-ascii-lcd.c
> +++ b/drivers/auxdisplay/img-ascii-lcd.c
> @@ -441,3 +441,5 @@ static struct platform_driver img_ascii_lcd_driver = {
>         .remove = img_ascii_lcd_remove,
>  };
>  module_platform_driver(img_ascii_lcd_driver);
> +
> +MODULE_LICENSE("GPL v2");

This was already done by 09c479f7f1fbfaf848e5813996793966cd50be81
("auxdisplay: img-ascii-lcd: add missing
MODULE_DESCRIPTION/AUTHOR/LICENSE") back in early January.

In any case, it should have been "GPL" (i.e. version 2 or later), not
"GPL v2", according to the header in img-ascii-lcd.c, see:

  https://elixir.bootlin.com/linux/v4.16-rc2/source/include/linux/module.h#L171

But thank you for the patch! :-)

Cheers,
Miguel

> --
> 2.7.4
>
