Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00552C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1FA217FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YIIo0kFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfBEO6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:58:41 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38170 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfBEO6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:58:39 -0500
Received: by mail-vs1-f65.google.com with SMTP id x64so2316856vsa.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 06:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vEZrhap4DKDzL33IX1IUHBUfhrfd5KWFlwZJyE13X80=;
        b=YIIo0kFrLatMhydvN5vDzkqwWX1wusnAVSPWvVN06nJXq30buDFuyoVnrlRYsS3TOW
         xYngitihNUeAkV81iiq3HClaeYsfW2YoGLbKzps1jyVI/V1HsPPPBuE088XIDQ62Z+yB
         Qo/SVLX4CR2t7fkNGZlvSwjGZ26VYNUCgZh8l8nbwVSrWeplvVOnBRuiAylyWsJhuqul
         BvfJiaN7MONucIXVKlMy/BB1EcMKXU4vtffTsD5ucZ04orMPglIOYX47blwb/TbE/ig6
         ZbNuHrUathNiFQJFqafcaIuQL1Y+iHI//S9CAFgZuV8EiqAsI1PE3UV39reHy3JgT6aX
         eMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEZrhap4DKDzL33IX1IUHBUfhrfd5KWFlwZJyE13X80=;
        b=SmO8BfhjrGdX46/ucH8iqIxDzcopmtNNCFI6FM7gidif5papz8gPxN30HVu/NGZATM
         o1VkJjjNkSXr6sCSiomr9dyCiDRJKoGjS/HjNn4xGvU89MrKal4azB4qQKkLgjhYZayC
         c2EpZMX6slHb/TYI0QTjTMXmEdXoe90696394AH8WzDuc465gkMLLUDPr0urCqlfk2KY
         dg3ZaPBpHHzbsXa9ZafnpU+1VKsAS4WU0vFEdl1zY7o6ICUFMeR0w1DpgY1EZoWkuhlN
         0CKbh5DvWbhPYm0/aS9AM4Ojl8+gq8ZwMIkjUO0qQ9dyh9OiwFjrJtnjdkTEDfQSP5Xf
         tkLQ==
X-Gm-Message-State: AHQUAuZPBAY3YTNqvdTePyHrJ9JDAzuIJ1fa/BCpJDKy7p6/eIw1rMZH
        7Pmw1NNs0pyh90gdshQJBfvm6hPkT8cwJGYIrC+CyBU9DGw=
X-Google-Smtp-Source: AHgI3IY5JqIfmmhli3sbjMslQHiWiblOQVCCvxKk+niMseGnOFV5xegpHxxGvPvT9qdF0cf3ElpeQjhltGUM+tngJ3I=
X-Received: by 2002:a67:b245:: with SMTP id s5mr2144230vsh.200.1549378717802;
 Tue, 05 Feb 2019 06:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20190131020141.28352-1-bjorn.andersson@linaro.org>
In-Reply-To: <20190131020141.28352-1-bjorn.andersson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 Feb 2019 15:58:01 +0100
Message-ID: <CAPDyKFpvBnFg1+mtTvBP72qAu2=ciSwV=PMaEgM=iMSDcvtc7A@mail.gmail.com>
Subject: Re: [RESEND PATCH] amba: Allow pclk to be controlled by power domain
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 at 03:01, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On the Qualcomm SDM845 platform the apb_pclk is controlled as part of
> the QDSS power/clock domain. Handle this by allowing amba to operate
> without direct apb_pclk control, when a powerdomain is attached and no
> clock is described.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Resending this separate from the series it was originally part of.
>
>  drivers/amba/bus.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 41b706403ef7..3e13050c6d59 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -219,8 +219,13 @@ static int amba_get_enable_pclk(struct amba_device *pcdev)
>         int ret;
>
>         pcdev->pclk = clk_get(&pcdev->dev, "apb_pclk");
> -       if (IS_ERR(pcdev->pclk))
> -               return PTR_ERR(pcdev->pclk);
> +       if (IS_ERR(pcdev->pclk)) {
> +               /* Continue with no clock specified, but pm_domain attached */
> +               if (PTR_ERR(pcdev->pclk) == -ENOENT && pcdev->dev.pm_domain)
> +                       pcdev->pclk = NULL;

This looks fragile to me.

I would prefer to make a do match with DT, to check whether the clock
is needed or not. Moreover, there should be no reason to check for the
->dev.pm_domain, because, if there was an error while doing the
attach, that should already have been reported/propagated.

> +               else
> +                       return PTR_ERR(pcdev->pclk);
> +       }
>
>         ret = clk_prepare_enable(pcdev->pclk);
>         if (ret)
> --
> 2.18.0
>

Kind regards
Uffe
