Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753427AbeDSOex (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:34:53 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42567 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753086AbeDSOeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:34:50 -0400
X-Google-Smtp-Source: AB8JxZpJ+ptcT60nvB7KGv5E+TKfLMdrdWFk+sDnVsgbMoVjfIwCObF65TJGo1wzjSp2DOTU0pEAtLOsBuK9dLKycGU=
MIME-Version: 1.0
In-Reply-To: <20180419140641.27926-4-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com> <20180419140641.27926-4-wsa+renesas@sang-engineering.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 19 Apr 2018 16:34:29 +0200
Message-ID: <CANiq72kqcAom9QHG9fXNjDyuNC7_bh8ni6_vH0juaRdUVmf8pA@mail.gmail.com>
Subject: Re: [PATCH 03/61] auxdisplay: simplify getting .drvdata
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Linus Walleij <triad@df.lth.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC'ing Linus W.]

On Thu, Apr 19, 2018 at 4:05 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Seems fine and other drivers in platform/ also call dev_get_drvdata
directly for this.

If Linus does not have anything against it, I will put it in my queue.

Thanks,
Miguel

> ---
>
> Build tested only. buildbot is happy. Please apply individually.
>
>  drivers/auxdisplay/arm-charlcd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/auxdisplay/arm-charlcd.c b/drivers/auxdisplay/arm-charlcd.c
> index b3176ee92b90..26246ab7a066 100644
> --- a/drivers/auxdisplay/arm-charlcd.c
> +++ b/drivers/auxdisplay/arm-charlcd.c
> @@ -329,8 +329,7 @@ static int __init charlcd_probe(struct platform_device *pdev)
>
>  static int charlcd_suspend(struct device *dev)
>  {
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct charlcd *lcd = platform_get_drvdata(pdev);
> +       struct charlcd *lcd = dev_get_drvdata(dev);
>
>         /* Power the display off */
>         charlcd_4bit_command(lcd, HD_DISPCTRL);
> @@ -339,8 +338,7 @@ static int charlcd_suspend(struct device *dev)
>
>  static int charlcd_resume(struct device *dev)
>  {
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct charlcd *lcd = platform_get_drvdata(pdev);
> +       struct charlcd *lcd = dev_get_drvdata(dev);
>
>         /* Turn the display back on */
>         charlcd_4bit_command(lcd, HD_DISPCTRL | HD_DISPCTRL_ON);
> --
> 2.11.0
>
