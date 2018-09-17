Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A79ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3C4214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hww4X8VK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3C4214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeIQPlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:41:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42343 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeIQPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:41:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id f1-v6so12632708ljc.9;
        Mon, 17 Sep 2018 03:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SqPlVUxQy+vbuNcH1v7ijfG5njf3uUfvXLX7FXDlak=;
        b=Hww4X8VKsMvBy2IVBcc4LRmZ45b7vcmDv0tvbN2q9QjtaBTcpcSlMNGlTI+Qt2ed97
         un493KxCZZvcRC7DTuFUDTLvmEjVc0Bu8bY8bgM6YkLfwvHYeKj9EyHFVUyn0k9JBazj
         HHwH7kpSyQLW96ehcfq7Fkc+4lcMNKXQh0mHpOQdXshEZDCseJ9L5zy5OWO37Jaykp9G
         0v3IYtRx5kM/GS1MqdvN+eczQYZWZKLwSKDiq4+hYcHFZ9di+wSf/Fd6tXMUisLoQILL
         1NX/lSlKY2d9yeoi+VqWIVFwd82ffwLSajXXY1buI+RyfLVZqyZMHbpXMyGMY61MUTPk
         2foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SqPlVUxQy+vbuNcH1v7ijfG5njf3uUfvXLX7FXDlak=;
        b=ZbCK1as50xVqnZUh+foY55ti2TGqE5gRda3h+waNd0vaWXGW8gA71dmIbGR6HdYq2V
         xlQPD0tqFWnV4z0GQXeMuBt+HFXU5oD7OL9iJk7/TvvtEdeupUXplQeKYd+rTvZTX7/S
         4vuB16pnQrif06UMTlc/u5iQHfIz7bU7M2Q31l87lhQ2yMkZ0nPP7xJALcBa8wnNx0Ym
         TZNwZoXqC78r3LEq93FQnN80ewfJy0pKt4zX6nkOdDPA9hV83cNFIijgdRFO9VIKFtay
         NnR/AcfFzCB3yrk43dCy1YXJNkAMMG1/7tAvkrOqllP1vzqCTKBYeF6zHMHsGR6E5ka4
         9OWw==
X-Gm-Message-State: APzg51CbbEV7iyMKxVyZdTi15p2MVOymGQkuhrzoGrejTYu5Bn9/9a/H
        mpJqgr2k1GS2+ZxUA0CUW5ROdfdrcJ2qP+jEgeJZHL1r
X-Google-Smtp-Source: ANB0VdYh1JeFmO8t4US3QP86bEW8a7eolQiJxjPLosSubj3/NlQe/3UlPaSqB7HItDm5SaeCc7mI66oJNlSOHVV3ksg=
X-Received: by 2002:a2e:680a:: with SMTP id c10-v6mr15288467lja.59.1537179274332;
 Mon, 17 Sep 2018 03:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180913133704.15739-1-ricardo.ribalda@gmail.com> <CACRpkdYgC7Z79c3swKE=ZwEUfVTC+oijKOqo5HwVdXLOsTT8Mg@mail.gmail.com>
In-Reply-To: <CACRpkdYgC7Z79c3swKE=ZwEUfVTC+oijKOqo5HwVdXLOsTT8Mg@mail.gmail.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Mon, 17 Sep 2018 12:14:17 +0200
Message-ID: <CAPybu_3aaCyw9e4FJpu2r7QbGUVzDrjPmfo4oSue1Ncu0jkLGQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Free the last requested descriptor
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus
On Fri, Sep 14, 2018 at 10:56 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Sep 13, 2018 at 3:37 PM Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
>
> > The current code only frees N-1 gpios if an error occurs during
> > gpiod_set_transitory, gpiod_direction_output or gpiod_direction_input.
> > Leading to gpios that cannot be used by userspace nor other drivers.
> >
> > Cc: Timur Tabi <timur@codeaurora.org>
> > Cc: stable@vger.kernel.org
> > Fixes: ab3dbcf78f60f46d ("gpioib: do not free unrequested descriptors)
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>
> Patch applied for fixes with Jan's Reported-by tag.

Just a heads-up

I haven't seem the patch on your kernel tree at
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/refs/heads

it is probably on your computer tree, but I wanted to make sure the
patch is not lost in the wind :P

Thanks!


>
> Yours,
> Linus Walleij



-- 
Ricardo Ribalda
