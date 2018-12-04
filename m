Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7DCC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B3820851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bDY/6r5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B3820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeLDLYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:24:23 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:44157 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeLDLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:24:19 -0500
X-Greylist: delayed 1177 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Dec 2018 06:24:17 EST
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wB4BOEtV020593;
        Tue, 4 Dec 2018 20:24:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wB4BOEtV020593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543922655;
        bh=FlpS0XJ3z9z0ek44Gl7gERWZOMn7xf3fsoCpTAa2s0M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bDY/6r5odPfRiVoJw4MrN9wl+3t+EDn8Xax/qxq7h1MVJIS+5bLlrucrtPAbAePJo
         dDJET3uiy0tNJl5XvWxUuf8zQecd6yEfDDA65hUfWEIMtOARm/upcgdAdcAeY68ArM
         8kwrq6IJlGdMd8r+XzGLoxtA5xRFWMyskujrRcnAltZQ9isT9g4XbA29CaeXE7Fac5
         tyTBFO2SRKSeLWdKTLQMDOeMKTIYifFFBuwwyINe+0npcQjMjksoiQlOIlkY/aGrBI
         q/KbCJkoE8rtm9uXxx02Mfmt54gGj3jE6mBMu8U3xxl2QOkWYXSUkfZeoaAaVU0NgL
         RhiKjNhqlaHuw==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id p74so9578137vsc.0;
        Tue, 04 Dec 2018 03:24:15 -0800 (PST)
X-Gm-Message-State: AA+aEWYnt48IdtNsRWBnNFQG/zjpnZHajloBVEWZvIj5YNWxD63cr9h5
        dkeGb0SXaylhHX1xRcwpO+tqS4VaDfC4/0tXIl0=
X-Google-Smtp-Source: AFSGD/VqyZrnTs2ct8snVogSYKalfHnqVVXxUVHGSn/iKlzkXmXur/pANgXaQDNsEI2sseGB0zWEAUtH73pJh6GFu5I=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr8494079vsm.181.1543922654170;
 Tue, 04 Dec 2018 03:24:14 -0800 (PST)
MIME-Version: 1.0
References: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com> <1542589336-13925-2-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1542589336-13925-2-git-send-email-sugaya.taichi@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 4 Dec 2018 20:23:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNASnBobLm51VL=EVt+97-KBX3vEqXGjTH-L-q1Qn8_GUQA@mail.gmail.com>
Message-ID: <CAK7LNASnBobLm51VL=EVt+97-KBX3vEqXGjTH-L-q1Qn8_GUQA@mail.gmail.com>
Subject: Re: [PATCH 11/14] pinctrl: milbeaut: Add Milbeaut M10V pinctrl
To:     sugaya.taichi@socionext.com
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sugaya-san

On Mon, Nov 19, 2018 at 10:01 AM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Add Milbeaut M10V pinctrl.
> The M10V has the pins that can be used GPIOs or take multiple other
> functions.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>


This patch was sent to:

linux-clk@vger.kernel.org,
devicetree@vger.kernel.org,
linux-arm-kernel@lists.infradead.org,
linux-kernel@vger.kernel.org,
linux-serial@vger.kernel.org




Unfortunately, the most important ML

  linux-gpio@vger.kernel.org

was not addressed.


The pinctrl maintainer may not notice this patch.







> diff --git a/drivers/pinctrl/pinctrl-m10v.c b/drivers/pinctrl/pinctrl-m10v.c
> new file mode 100644
> index 0000000..d4ca713
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-m10v.c
> @@ -0,0 +1,765 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Socionext Ltd.
> + * Copyright (C) 2015 Linaro Ltd.
> + * Author: Jassi Brar <jaswinder.singh@linaro.org>


My company name is "Socionext Inc." instead of "Socionext Ltd."







> +static struct platform_driver m10v_pinctrl_driver = {
> +       .probe  = m10v_pinctrl_probe,
> +       .driver = {
> +               .name           = "m10v-pinctrl",
> +               .of_match_table = m10v_pmatch,
> +       },
> +};
> +
> +static int __init m10v_pinctrl_init(void)
> +{
> +       return platform_driver_register(&m10v_pinctrl_driver);
> +}
> +arch_initcall(m10v_pinctrl_init);


Can't it be builtin_platform_driver()?

Which device requires this to be arch_initcall()?





--
Best Regards
Masahiro Yamada
