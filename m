Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeENKfm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:35:42 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:47074 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeENKfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:35:41 -0400
X-Google-Smtp-Source: AB8JxZp7P0Hii9eOcTEMW9O/oTQt0VDGjOQVyweXCp459p9fDyrv8p8EY7RDyWgOAwNGzX4vBV+xjkV49uSV+o45GTQ=
MIME-Version: 1.0
In-Reply-To: <20180509194726.29166-1-peda@axentia.se>
References: <20180509194726.29166-1-peda@axentia.se>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 14 May 2018 12:35:40 +0200
Message-ID: <CAKv+Gu_ffVT2Ns5ta9jLLWf-ZdzO7+EZn+-6wpWHYx9--r5umw@mail.gmail.com>
Subject: Re: [PATCH] i2c: synquacer: fix fence-post error in retry loop
To: Peter Rosin <peda@axentia.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 May 2018 at 21:47, Peter Rosin <peda@axentia.se> wrote:
> There is a difference between attempts and retries.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/i2c/busses/i2c-synquacer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
> index a021f866d8c2..915f5edbab33 100644
> --- a/drivers/i2c/busses/i2c-synquacer.c
> +++ b/drivers/i2c/busses/i2c-synquacer.c
> @@ -509,7 +509,7 @@ static int synquacer_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>
>         dev_dbg(i2c->dev, "calculated timeout %d ms\n", i2c->timeout_ms);
>
> -       for (retry = 0; retry < adap->retries; retry++) {
> +       for (retry = 0; retry <= adap->retries; retry++) {
>                 ret = synquacer_i2c_doxfer(i2c, msgs, num);
>                 if (ret != -EAGAIN)
>                         return ret;
> --
> 2.11.0
>
