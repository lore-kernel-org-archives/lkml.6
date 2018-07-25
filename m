Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3106DC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5F620843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxBBbCtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5F620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbeGYXPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:15:25 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33857 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730370AbeGYXPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:15:25 -0400
Received: by mail-ua0-f196.google.com with SMTP id r10-v6so6092609uao.1;
        Wed, 25 Jul 2018 15:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R9a9ijSQ8fwMFX1p3k3gqervRxy6uQwT1IHScFPuUXw=;
        b=fxBBbCtCJcdITcY4LGa9y4NMnzONOGaDlM3kNG9CeTJkMvtUKEfg4fJw8OLeZ99RHO
         qKkq3gb2F3/0M9WMLnrdJkrnAw+lrWxjlQnME+DgZMIY9DIyZNuPS+F5AWNuefzTkc4D
         Kd/Xf7q+nxW33mTFgUGb90ynaaqjOtZlRJl76r2NwUyi54JzgZ1DSCELvyE2xyZ88YkS
         c0vaiDLbgOYVLnpQ6HwKAfBUUF5og/cEWiw3gCwI8uOL2M88y0kSr+noO5Lp7Qo9llpI
         agbKS0nRqr1/YNiijVi4Ytk32igHQ2K2MbGhcJ/9aIS7PXTt37OD9TvWSJU3vynY6Ht4
         m2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R9a9ijSQ8fwMFX1p3k3gqervRxy6uQwT1IHScFPuUXw=;
        b=soqF5KV4l10uOk4mOsEw6A3iFpSBamuacuPv0yeJNj4uCZVe2VmYnJe9+7p9yTl5l7
         FHuDVHmoWROiSBLiIsnAUtGfaXH67ne9oZAblizMxQksaM5+xmi3pXCL4zqhOq5GHF53
         IX8XQJt5ZMqJOBWuXDPCf5LPlC9YpIHyDjZYtSQ2p/blvxjBc+7W8uTv61znwRoVYGkm
         nWzjo6pjD/YS0rYpRK+eDBXm1vcbbAEDl6siyA9J9dwixiluqKD9+t+jYJwVtZN38U2t
         rYO1lJYrabDLBy3cI6YReR9XcLt3GHsGp3o9SQ7dHSo85TznDnj66UQQ6ia+HSt0boW4
         QYPw==
X-Gm-Message-State: AOUpUlH59BOFSEclLrxNI/qnuR/I0alI2dCiNWEihD+A8QbnJBC+ERFi
        KszJsae27j2AWQh5noeS2Dz1YdfaOBZwUmE/KJ4=
X-Google-Smtp-Source: AAOMgpd25Z0VtP1CN/COYSEXfvbui/rnWln6l3c71LW9HqJVtFGgxaDXkS5W6y/c318P0mYVp9xCnQ2VvChcRDUyAeg=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr16213270ual.28.1532556104574;
 Wed, 25 Jul 2018 15:01:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 15:01:43
 -0700 (PDT)
In-Reply-To: <20180725100450.22300-1-hu1.chen@intel.com>
References: <20180725100450.22300-1-hu1.chen@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 26 Jul 2018 01:01:43 +0300
Message-ID: <CAHp75Ve7i0QsrjshtMMp0cb44Mtet-SHDN+XuQHF-EHH_KuZEQ@mail.gmail.com>
Subject: Re: [PATCH] serial: core: stop passing NULL in uart_resume_port
To:     Chen Hu <hu1.chen@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 1:04 PM, Chen Hu <hu1.chen@intel.com> wrote:
> We found the baud rate is changed after S3 on some Intel Broxton
> platforms. The baud rate should be restored during resume. However, some
> set_termios() callback such as dw8250_set_termios() for DesignWare 8250
> will skip setting if old termios is NULL. We address this issue via
> passing a dummy.

Why does it need to be "fixed" here then?

>
> Signed-off-by: Chen Hu <hu1.chen@intel.com>
> ---
>  drivers/tty/serial/serial_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f02965936f2e..8b815f1539e8 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2217,6 +2217,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>         struct device *tty_dev;
>         struct uart_match match = {uport, drv};
>         struct ktermios termios;
> +       static struct ktermios dummy;
>
>         mutex_lock(&port->mutex);
>
> @@ -2277,7 +2278,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>                         pm_runtime_put_autosuspend(uport->dev);
>                         if (ret == 0) {
>                                 if (tty)
> -                                       uart_change_speed(tty, state, NULL);
> +                                       uart_change_speed(tty, state, &dummy);
>                                 pm_runtime_get_sync(uport->dev);
>                                 spin_lock_irq(&uport->lock);
>                                 ops->set_mctrl(uport, uport->mctrl);
> --
> 2.13.0
>



-- 
With Best Regards,
Andy Shevchenko
