Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81B3C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474A3208A1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liJX55vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474A3208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbeG0L4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:56:08 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34172 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbeG0L4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:56:08 -0400
Received: by mail-vk0-f66.google.com with SMTP id l143-v6so2227131vke.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 03:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UjF6nTwgsEbX/QP2fzgeHH0/EecAJjQ7huBNdi5RP0E=;
        b=liJX55volULUwtHV6jeJbxB6u68k24taE4sL2uAnXB70g5o8vQvzVFnZ2fVwmBD+cN
         gFKuq3cRZDszoW/hq/VBJrUfCgxrXu2pvSpaKc+Q+Ak4fp1PqeGRO+Yso5q3dnK2LgEF
         Gk243TfGOQgjX5kXOvZ6qEtxfze0mH2k+s8t4dtah+uPLZcO3BiMugjaAOCiNrcVBJgy
         UjK6irdny1i/1+aZc5LLIyXMWVuCo8n4QhOV22RRk4wEe3xFgmtYbUislhhjyW76sRp3
         eOoT9G696ApwA1iOsF7V3nGe1ZJk5hnlPpQoTvHYqrR6Z2m9qWkTkDFGTtZfySpbuSrj
         e7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UjF6nTwgsEbX/QP2fzgeHH0/EecAJjQ7huBNdi5RP0E=;
        b=FkR74+5FYr5vM3NZXzqKOYK8b7but7ZfMkb8vM7ZepMwUuqzCXLtwS4Mp3pja+b5e7
         JWU6j6mff9XERUTNjt96n6XIb3PSj0gFB8ryDK1wYnpqZhVQ4akts/OFadj7pES9wD5I
         uRgNI/uYUjFXBA6A748aa6Y6IgoM5Z/UmkXPajUiQZ8pT/eZi4qwknZ27998P1F/NjBd
         f2v+JYkn7ubUO9Plm7Oo6fB4Zya/JJxGpFz5VrIhPBlYXdI5xo1SBYhikgPJgy8lG6aN
         RRFCDp/FNafudFxm7qRHff+69AdDTaDzhk2l8kGFn2uapUG8s114jKegNtcQ4Vb9EtUp
         BbbQ==
X-Gm-Message-State: AOUpUlG15mkhEZjO9yJk3IyoWSWSMRyODM/WMYigcD78tkgFvxXUmo+z
        5p/D7V3GpyaF347S3KYydtd+2usVJZ5e1yj1Z9I=
X-Google-Smtp-Source: AAOMgpf6qz3/45o6o21ZurstOd+xN5ViIApKBCjZvyJlTOMCJ3FTyJIKgKOJgKjBQ6F7kypbpCPSXioTLJJOd69c1e0=
X-Received: by 2002:a1f:4c7:: with SMTP id 190-v6mr3496407vke.63.1532687689421;
 Fri, 27 Jul 2018 03:34:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 03:34:48
 -0700 (PDT)
In-Reply-To: <20180727092111.7218-1-baijiaju1990@gmail.com>
References: <20180727092111.7218-1-baijiaju1990@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Jul 2018 13:34:48 +0300
Message-ID: <CAHp75VdMQ2Cx+0cH8PuM8t8i2NgphxEqU4g86y5Hgwi1_CQ9zQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Replace mdelay() with msleep() and usleep_range()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:21 PM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> reset() and init_display() are never called in atomic context.
> They call mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().

>         gpio_set_value(par->gpio.reset, 0);
>         udelay(20);
>         gpio_set_value(par->gpio.reset, 1);
> -       mdelay(120);
> +       msleep(120);

I didn't look to the rest, but this one will be inconsistent after your patch.

The question here is why udelay() is needed, while mdelay() changed?

-- 
With Best Regards,
Andy Shevchenko
