Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6708C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BC1206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYD/R1pI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbeLQOdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:33:06 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43548 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeLQOdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:33:05 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so9596823lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 06:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FfMbVp5YMXr1H/mpP7GL3vPx+FLo0xOuSRHrRnAulJ0=;
        b=gYD/R1pItgtSKAHZIcfSaV7yBe5wKplJubkUpiC8W1KnWgBK536GwiDYZ/UlU2NkWm
         wT/oXHiQb04wUtyHTrOYTn+oIEPMTurm4MH10N5DxCr01KPKOv+DWUlTZ9fsb1XuAmoT
         0yf0sGDYGOdijm0evFqWDEbFgP5Agngb1aNmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfMbVp5YMXr1H/mpP7GL3vPx+FLo0xOuSRHrRnAulJ0=;
        b=KPXkyZJVsdHFjbo964mzGFuTk1DB+fVKjvsuudaoogG1jZs5rbS9do3LDVz14Drexw
         p1YYTmXBS2wPUEN0Anw3yJnVMXzH0a/bjHQjgs5z4R7YwyZuXYVoigh7CMI+msQfYXpE
         Gieozj0Eq4U0whB0iOUMCUtDkjjSYpxGXVNCDwPzOBqLElvwJzYvwxDgH3m2ZPjT2x/x
         SLG6iEiE3dym6tn6UUFZaIOHYkfHFIrm+LvzI5NOAQpMy46PNbLBeVUj49VWt+CT+8jm
         +n31q+DK+ZtyX+7S2yIRQu5veFXlrkNhhelVU0ZA/TFMcy7WggbKpKsDz12L6qeOMi1+
         9sBQ==
X-Gm-Message-State: AA+aEWbTOc1QK1O/6dDdK3CFq5CEnayrOUsLr7Uv1/Znip2tbN2hjKlo
        khIrFE7QfxnWwv6PrX6yJJqmuWLi3JKnv63Nne4UUA==
X-Google-Smtp-Source: AFSGD/VQnEnv54TkBJQzI5o63okcRbREIvKuKE2T8ehh75UZgFtKLp9sCMZ4AZlvZyJ/qHD7UNnUMwbn25BCyz45MC8=
X-Received: by 2002:a19:4849:: with SMTP id v70mr7219677lfa.62.1545057183636;
 Mon, 17 Dec 2018 06:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20181214074825.6976-1-ms@dev.tdt.de>
In-Reply-To: <20181214074825.6976-1-ms@dev.tdt.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Dec 2018 15:32:51 +0100
Message-ID: <CACRpkdaTR-Bb6MBtP34GCEtjqfxSNr5PQjDZ_PFqX2B+odGu-w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: xway: fix gpio-hog related boot issues
To:     Martin Schiller <ms@dev.tdt.de>, John Crispin <john@phrozen.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 8:48 AM Martin Schiller <ms@dev.tdt.de> wrote:

> This patch is based on commit a86caa9ba5d7 ("pinctrl: msm: fix gpio-hog
> related boot issues").
>
> It fixes the issue that the gpio ranges needs to be defined before
> gpiochip_add().
>
> Therefore, we also have to swap the order of registering the pinctrl
> driver and registering the gpio chip.
>
> You also have to add the "gpio-ranges" property to the pinctrl device
> node to get it finally working.
>
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Patch applied unless John Crispin has objections, it looks
good to me!

Yours,
Linus Walleij
