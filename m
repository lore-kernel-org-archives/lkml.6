Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6141C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3F4218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9s/echc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389467AbeLUKSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:18:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34473 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732678AbeLUKSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:18:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id u89-v6so4253095lje.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjS3hvrEixn5/9pQvoMc3tGLnnhzRTsAaqOidISM+ac=;
        b=O9s/echcb2q8A1BcccqOZH4gBNhCojyP4ujsmCSvkrX1eSfuYISJ2XKMvV5QX0Nas7
         Ce4K9XasyXeULashj3NfasuhK4rpPiX8mo4wSPq/VA1yYcrZ1wW5pCkWR0Be0/PxArNH
         j+8fGP833PAqXcfWtKFeGoWnXvJA+Cd9DHNy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjS3hvrEixn5/9pQvoMc3tGLnnhzRTsAaqOidISM+ac=;
        b=f6w/phGXKp09Cm5Rjir6qmVuBdEot5XHrrKSzOR7X5WOgEKIPLbOpFHn/Z5W9GHmdV
         jPHrMpqTR8UAQslLolKuCLVvIcYWne88BU4PmA3Wj1UsINx6JInRAAgvaLckC1MI9YzY
         8gSjxbZZhKGax52cDcRgawVGvgBMk8Tm8BQvZc+o5dIOtzwkm8simZ5RBzXrCd6g7sdJ
         MXEkxaW/GmL1JMaqAnW7yEEUURseCND5oPL5aSdUyyJYHnbfQ0ESACnuQK3y+tgrqfLV
         E6O8rqfiK+ONtwu2QNpQt/v7Jp2kl2LS/E8PyMtE89ojwH/Ep1/VqeppXx/CXlZUe9z8
         ULNQ==
X-Gm-Message-State: AJcUukeK2ZV3NNZdGmn56sD6jtgZot4OPNn8gWR/JWFZA8zegmEkLiq+
        gE5rftmdqIM2svJimwM8v6wIv8bIgWNwou8xJnmbfEoqgl0=
X-Google-Smtp-Source: ALg8bN77P/8Ok+7H11/as2VZ1sQYqox4L74eA/yVNpQ+DFQHcsZ3KYzWwasYr0vD55aFEaaPNheMJweSmksUYamPxHU=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr1193382ljj.9.1545387520487;
 Fri, 21 Dec 2018 02:18:40 -0800 (PST)
MIME-Version: 1.0
References: <1544777086-24510-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544777086-24510-1-git-send-email-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 11:18:28 +0100
Message-ID: <CACRpkdZhSXrfnweMomHctCCofNzfCHH5EVZJ5j0aZnz-Luz79Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: uniphier: constify uniphier_pinctrl_socdata
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 9:45 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> These are constant data.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied!

Yours,
Linus Walleij
