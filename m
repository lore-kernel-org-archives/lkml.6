Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A345C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2951D20671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kPoew86f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="He3TMTKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2951D20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937059AbeFRXyx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:54:53 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38516 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936965AbeFRXyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:54:50 -0400
Received: by mail-vk0-f68.google.com with SMTP id b77-v6so10628589vkb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 16:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QpJN9Y/Qwm/bmVk5+OnUHYUYRzW39k9TZkAjl3KItnE=;
        b=kPoew86fcu5bcD3Bazv8n9J0l/YdrrQ4OTBvrvoiY/S0kQm3bYRIKS1fHmisZoQkzF
         eupli710lWNWBq4MQ4g8lKXFBfZBV+AExs6D7qJK2h+cliHKzHqtLSvhtJ5r4MatFh33
         yWDaesbbEcQ0hELOwONddW98P0KuDaCQuB4Sq6p1/ALYSr9ebLqnm+p615imD8LytCdJ
         HoaloQkeXmJ6YQRpZekUJ9sqTYniYKA1UIYmyCvu3FbhXXyOiKnyttL+sIKz+HrOw0kz
         B4EXqlVPPt3nJm1dnbW+ZhLhH/3AxEZ5B3wFiYVIglSkXGr5oehUkXjHnH9J2TtqI20t
         3tjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QpJN9Y/Qwm/bmVk5+OnUHYUYRzW39k9TZkAjl3KItnE=;
        b=He3TMTKH1ZZ/3sAL+l+i5kKetu0sZ49FhMhEHvY3RU16kCgCChZTg1jGvjPSX5VGui
         JLJCitkfS6eopCIcHr6uo/uWsqgUhzDLaHIQ/tlL8Enq7j2AYM3SZ23G3fDR0Gs2sImD
         +DW00s0E0UZBe4L22Mg/IAaehrgpfTAOYWZ04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=QpJN9Y/Qwm/bmVk5+OnUHYUYRzW39k9TZkAjl3KItnE=;
        b=jscZ7gdA/NAuyRHsUXGM25qx1tYmVyEw7qxsqJpxF4zt1JkxVMMd9tO8xrFM7WmS6k
         yxyEdXy3wRQoNsrMrIFV+hbjUIdV35Vjc+w8EctEz+bgngiwfqd9kYlUkGo9odytUZqB
         3wyOsKdI89vFaa/mXKAsqOZKMFUJUtV+Qe4B465EYo1rZGZ5P9ja5mGYa/eQpGRAX4XK
         878SuWHEJ561MVz4k3108Kch7xVKuHPmNXcNM/XjSqtozsSD2U739KxEsxECP3tFrOQq
         6RV2QDBUAtJfqgJb9dBnFhfY4LQXU+SboCr3jsMUn81RZssgoNSzRX5YNyH9HpCJyanW
         oW/g==
X-Gm-Message-State: APt69E35pMJTUKIXGsn5g5ov7EJWgCEfv+cGwQydtC94ZcU+S+QcYUtS
        q6H0DLuSp51kLqjOUEr1oz/e8EiceAL0GfatF83mPQ==
X-Google-Smtp-Source: ADUXVKI5wAawzEndGn1yDUPRwjrLvO8gQE98186WTfGL3HoxsybwUOPuPUlfewlf8ToIZDshzDj7g+V6S5yXDLC09hY=
X-Received: by 2002:a1f:c007:: with SMTP id q7-v6mr8827419vkf.144.1529366089735;
 Mon, 18 Jun 2018 16:54:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 16:54:49
 -0700 (PDT)
In-Reply-To: <20180618205255.246104-3-swboyd@chromium.org>
References: <20180618205255.246104-1-swboyd@chromium.org> <20180618205255.246104-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Jun 2018 16:54:49 -0700
X-Google-Sender-Auth: 6SuDTp6SV91G0AwJizF_t4lIhqY
Message-ID: <CAD=FV=VpFR4hpREnWpvG2MQAONheKtNfLkyNM8-AFXMcGD7OPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 18, 2018 at 1:52 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> We rely on devices to use pinmuxing configurations in DT to select the
> GPIO function (function 0) if they're going to use the gpio in GPIO
> mode. Let's simplify things for driver authors by implementing
> gpio_request_enable() for this pinctrl driver to mux out the GPIO
> function when the gpio is use from gpiolib.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 3563c4394837..eacfc5b85f7f 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -176,11 +176,27 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
>         return 0;
>  }
>
> +static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
> +                                  struct pinctrl_gpio_range *range,
> +                                  unsigned offset)
> +{
> +       struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> +       const struct msm_pingroup *g = &pctrl->soc->groups[offset];
> +
> +       /* No funcs? Probably ACPI so can't do anything here */
> +       if (!g->nfuncs)
> +               return 0;

Is there a reason why you'd want to return 0 instead of some sort of
error code?  Wouldn't you want to know that this pin can't be a GPIO?
Another non-ACPI example is sdc2 on sdm845 and it seems like you'd
want to know if someone tried to set one of those as a GPIO.

...oh, but I guess ufs_reset also has no funcs but it still probably
wants to use the GPIO framework to write something.  Hrmmm...  Maybe
check if either in_bit or out_bit is not -1?


> +
> +       /* For now assume function 0 is GPIO because it always is */
> +       return msm_pinmux_set_mux(pctldev, 0, offset);

nit: should you be consistent with msm_pinmux_set_mux() and call it
"group" instead of "offset"?  It looks like it's supposed to be the
same thing...


-Doug
