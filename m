Return-Path: <linus.walleij@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520412984; cv=none;
        d=google.com; s=arc-20160816;
        b=XPDwACdf50fPDorKgd+3q9iEOhRXHdqyhVdBpA8E9VzKGnSMdakAtyvMNOm4Y8X4NU
         mywiJRPafcNbqcME5i3nIz4dcPbfjUepqWTLiej5UAktN6yuTYOSuA8ozLoGb2gwGnuA
         QmSZ7SIlhEbpzbZxAIEABMdZ5zVxk85EZY8SRCVn/KG5mqpzfcSrylXS9Z2ZviZR0R+G
         zwObOp94v8kuoooETWHNn1bPSeZahIb3zr4NXJSP361i+B+uru5zzA599QcihViRZj4o
         LHIQ5zwAAOLcRGhEdK6Fcf/1Qok1vEf6R/YuJzPe+LebKibXACtBJnMopRvKcnD/mqdN
         SoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ql3jdEm7qR9eIzYECHQz4UPIktGWWWbkJ2CRPxQs2FY=;
        b=F45vO303dnHnCM/CQMOXxzK8D2ZidVxw2gaAo6Fk/PiIjclM5TIvgK8BLjEuC1gZIu
         FvOywFZWIbL5M2RU00mZzjQ1drzF5DPeEQgDioJALzdNtKKpK1r5gUBMxABeq8yt9s4F
         TEqUMT5VU5cD5Lup+KFdT2wW/yNXisLYdcnqQiupTBXDNDUkcUOl5/UEF8utwf3/c2X5
         mTfQAgde2oF+5McerEO7NPDb/b2isW3PWyMpLYSqZA1mtCH1Lu+ai641LCL/6kbjJ4Qm
         2v7XO8ifDjy44BJryDvruRCl0dRx4MrUeXTxYgmQnHBAwGm886QLBuXv8RMdwOAfVmaL
         i4+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=A7FcBGhT;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=A7FcBGhT;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELv9IPOZqSu0cO+0OVqfqJNrmukfhJK0TfLKbKVSxuJC4Q58F60ddn6ybB4pAhm/5ZnUNeDzTFcJuBR52id9QzU=
MIME-Version: 1.0
In-Reply-To: <1520301560-114573-2-git-send-email-leo.wen@rock-chips.com>
References: <1520301560-114573-1-git-send-email-leo.wen@rock-chips.com> <1520301560-114573-2-git-send-email-leo.wen@rock-chips.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Mar 2018 09:56:23 +0100
Message-ID: <CACRpkdYKNiaEqCNyWq=xjOs3Xz0_YRkhkWkxuS4okD-XRVRj9w@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] [media] Add Rockchip RK1608 driver
To: Wen Nuan <leo.wen@rock-chips.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	jacob2.chen@rock-chips.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
	Eddie Cai <eddie.cai@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594151753514968819?=
X-GMAIL-MSGID: =?utf-8?q?1594268565485376792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 2:59 AM, Wen Nuan <leo.wen@rock-chips.com> wrote:

Thank you for the patch! Nice improvements over all!

> From: Leo Wen <leo.wen@rock-chips.com>
>
> Rk1608 is used as a PreISP to link on Soc, which mainly has two functions.
> One is to download the firmware of RK1608, and the other is to match the
> extra sensor such as camera and enable sensor by calling sensor's s_power.
>
> use below v4l2-ctl command to capture frames.
>
>     v4l2-ctl --verbose -d /dev/video1 --stream-mmap=2
>     --stream-to=/tmp/stream.out --stream-count=60 --stream-poll
>
> use below command to playback the video on your PC.
>
>     mplayer ./stream.out -loop 0 -demuxer rawvideo -rawvideo
>     w=640:h=480:size=$((640*480*3/2)):format=NV12
>
> Changes V3:
> - Instead use the new GPIO API.

This is looking really nice from a GPIO point of view!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

The comments below are just nitpicky good-to-have.

> +       pdata->gpios.reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +       if (IS_ERR(pdata->gpios.reset)) {
> +               dev_err(dev, "could not get reset gpio\n");
> +               return PTR_ERR(pdata->gpios.reset);
> +       }
> +       ret = gpiod_direction_output(pdata->gpios.reset, 0);
> +       if (ret) {
> +               dev_err(dev, "reset gpio set output error %d\n", ret);
> +               return ret;
> +       }

So what you do here is first assert reset and then de-assert it,
triggering a reset? Maybe you should add a comment
about that so people get it.

> +       pdata->gpios.irq = devm_gpiod_get(dev, "irq", GPIOD_OUT_LOW);
> +       if (IS_ERR(pdata->gpios.irq)) {
> +               dev_err(dev, "could not get irq gpio\n");
> +               return PTR_ERR(pdata->gpios.irq);
> +       }
> +       ret = gpiod_direction_input(pdata->gpios.irq);
> +       if (ret) {
> +               dev_err(dev, "GPIO irq set output error %d\n", ret);
> +               return ret;
> +       }

Why is it necessary to request the GPIO as output
and drive it low and then immediately turn it into an input?
Why not just request it with the flag GPIOD_IN and
skip the second statement?

> +       pdata->gpios.pdown = devm_gpiod_get(dev, "powerdown", GPIOD_OUT_HIGH);
> +       if (IS_ERR(pdata->gpios.pdown)) {
> +               dev_err(dev, "could not get powerdown gpio\n");
> +               return PTR_ERR(pdata->gpios.pdown);
> +       }
> +       ret = gpiod_direction_output(pdata->gpios.pdown, 0);
> +       if (ret) {
> +               dev_err(dev, "GPIO powerdown set output error %d\n", ret);
> +               return ret;
> +       }

This looks dangerous. Like you assert powerdown and then de-assert
it (similar to reset above). Why not just request it as
GPIOD_OUT_LOW?

> +       pdata->gpios.sleepst = devm_gpiod_get(dev, "sleepst", GPIOD_OUT_HIGH);
> +       if (IS_ERR(pdata->gpios.sleepst)) {
> +               dev_err(dev, "Could not get powerdown gpio\n");
> +               return PTR_ERR(pdata->gpios.sleepst);
> +       }
> +       ret = gpiod_direction_input(pdata->gpios.sleepst);
> +       if (ret) {
> +               dev_err(dev, "GPIO sleepst set input error %d\n", ret);
> +               return ret;
> +       }

Just request as GPIOD_IN and skip the second statement?

> +       pdata->gpios.wakeup = devm_gpiod_get(dev, "wakeup", GPIOD_OUT_HIGH);
> +       if (IS_ERR(pdata->gpios.wakeup)) {
> +               dev_err(dev, "Could not get wakeup gpio\n");
> +               return PTR_ERR(pdata->gpios.wakeup);
> +       }
> +       ret = gpiod_direction_output(pdata->gpios.wakeup, 0);
> +       if (ret) {
> +               dev_err(dev, "GPIO wakeup set output error %d\n", ret);
> +               return ret;
> +       }

Just request as GPIOD_OUT_LOW?

> +struct rk1608_gpios {
> +       struct gpio_desc        *reset;
> +       struct gpio_desc        *irq;
> +       struct gpio_desc        *sleepst;
> +       struct gpio_desc        *wakeup;
> +       struct gpio_desc        *pdown;
> +};

Very nice :)

Yours,
Linus Walleij
