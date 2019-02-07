Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1967C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FD821872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPhkRuDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfBGLlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:41:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52850 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfBGLlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:41:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so5755475wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 03:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CjnvclVyKeLBTw1SQbK4p0yaTy2NU4lox4zdRpAQ4MY=;
        b=xPhkRuDxRZs9kMkzugyDMMCiA88+9vP82WGmqzDAOd8PaQypsyv+qp+qIV9kpfsElc
         WPAur3i/Bqgbfjg4BlfdCI7AvcBZ83JfHUgUKOAn+q4aZIzOUExEuXHAh0xGmcbRBoJT
         hOuZT+fijBYxlWWCeJNZdCzGCALJ0SNaT4kCw4evlnwehR4ma/cA0QD9iEX3o25aOJ63
         Ou6B5++f5aux6qP30pDu6dOLUU6ogdvddu7oSC2KPL56xYVaVFkAJb//uRpM7E5RA0VJ
         BFRPeWctSTPu3jMxvPcLXzagfFWQU2v+nT46kZqAjsL3avWhsF3y8Uv2KFCvY1L6iKck
         MMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CjnvclVyKeLBTw1SQbK4p0yaTy2NU4lox4zdRpAQ4MY=;
        b=MokXvJiMbNMoZQBmvtgObMi9iRje90EYNjJfFCwHwLGn+Jgb/h7AjqFjIbw5dZmhf2
         0hOcC8h8+9PTL3ApXqeOwbME+eAXPWJFNdonUXJp7y9MHvarZ803dQ3eNHX3DjWm0BdK
         qurPiwS0NwKlWmXywZQ5UN9meUZ3VqHZly/oYcUf4VTeI2oAbI4wVpafwjDE8iF4Sa3u
         dcrrrrUS4XPgd6d8ivxzzzRB5l2TxsheXBX24U30+c+kLvTSAWJ+PPzwjUKxehxjb/yv
         KsowHNgrnOdhmmVVGrxdp96SDUmQPf7JxfNY/p6ixWMekcdiVSUg6p/6XlfudwOIf69v
         YW4g==
X-Gm-Message-State: AHQUAuZFdTYxZo/bfw2PaFzVh88MNB5owL1/DGnQUunyHr9dULc1w1zS
        q8zhbYQeZKxBnVdBBYHNIHfy0w==
X-Google-Smtp-Source: AHgI3IbrwSRDDzIAMqfkz0BdySTvQrzRe4tzFZhjEbeopuT0V9slkyeC+zQO7Yc7j2MwJa01GKk0Vw==
X-Received: by 2002:a1c:2686:: with SMTP id m128mr6801157wmm.52.1549539665724;
        Thu, 07 Feb 2019 03:41:05 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id s3sm15678284wmj.23.2019.02.07.03.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 03:41:05 -0800 (PST)
Date:   Thu, 7 Feb 2019 11:41:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v8 1/8] mfd: regulator: clk: split rohm-bd718x7.h
Message-ID: <20190207114103.GF20638@dell>
References: <cover.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <58a56ac25564baa221d471e878a3e4f5d9081f36.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58a56ac25564baa221d471e878a3e4f5d9081f36.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Feb 2019, Matti Vaittinen wrote:

> Split the bd718x7.h to ROHM common and bd718x7 specific parts
> so that we do not need to add same things in every new ROHM
> PMIC header. Please note that this change requires changes also
> in bd718x7 sub-device drivers for regulators and clk.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
> 
> Please note that I maintained the acks from Mark and Stephen even
> though this is a squash of 3 commits and both Mark and Stephen had
> only acked one of the patches. (The patch which touched their area
> clk for Stephen, regulators for Mark). I interpreted their acks as
> 'the split is in general Ok and portion I am interested in is fine'
> and thus maintained the acks. Please let me know if this is not Ok.
> 
>  drivers/clk/clk-bd718x7.c             |  6 +++---
>  drivers/mfd/rohm-bd718x7.c            | 23 ++++++++++++-----------
>  drivers/regulator/bd718x7-regulator.c | 24 ++++++++++++------------
>  include/linux/mfd/rohm-bd718x7.h      | 22 ++++++++--------------
>  include/linux/mfd/rohm-generic.h      | 20 ++++++++++++++++++++
>  5 files changed, 55 insertions(+), 40 deletions(-)
>  create mode 100644 include/linux/mfd/rohm-generic.h

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
