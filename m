Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6657C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0679222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZQ8xJla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbfBMJkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:40:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37868 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfBMJku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:40:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id r10-v6so1418630ljj.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MgVgrlF6mf8tZ15NXBMfq9RdMNk+dT/ItwBf6Qf4iEo=;
        b=bZQ8xJlanQzijadQaPQsp0gK1u/gks5RiZ/lI/vRHd1jGipZdqNMliey+aQTZ8/W3c
         /Br0RUII7CWSmA97CHzxj+rD0QS6kHgECj/G2VH5PizQDPuNCyBqvpk10/0k5D0Ncbvk
         qM+BvF4KusfaBnhNVun0ZK+cuJBx2BHUgTjkanfdys5WAAI8l1t9AIj6fkvQOgzYSVTi
         qww2JtCs8y9UhYMhwq6P8MoSLBpQ4yKDgc97NSt1Gp2cfQCmQYiPSUQs9wA26t4jGfJk
         RxaZZplagBkE8pVzX61kHB4wAxArVi4JI0lI/XIYoySmddcD9kBIDh5MFpVwX28R06ZS
         BghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MgVgrlF6mf8tZ15NXBMfq9RdMNk+dT/ItwBf6Qf4iEo=;
        b=U5fe/nMJFdwDy0DRZf5FQzDMl1mG7FkEHhLwcxWKmZJQSKEFANRjB5idIqnmGrTeYj
         PzvKotDUr6Mv4U+ofUaxWO5BmqLYlnEn9ApwJX7Uj/L9lNmrX0C2idbqFvntOhJhWZOM
         vjQZDBXlz1kx5SoSwydLbx+lRGWCbEBNLDbEA77DTM3ck2qLDn0JPdbqzMS2knlvjAX+
         SO84hNaLufltK/52zuFVHtoV82V+U3PA+Q2edfWoWdLa3g4eb2o5n5PhDqjOEpVzGuX0
         HlMo9yzpGDurIxkU39ORJoj0ymaDgLn1oEXHxfm0NxbvqrWgCw2pIfKtocy9hsZLOd0h
         IWDg==
X-Gm-Message-State: AHQUAua7BRJjGx4/iM3Tr7zmSpprfe89skd0B0DNOw5d23GBHd6OTtvt
        WN69d15JqnqN8Sl7swr7YqH3E5pMyMYEd+bp5gjwRQ==
X-Google-Smtp-Source: AHgI3Ia502FHE4/z8kHG+Uz1w4njHZnpZVg3/AxvYAlJp8/UGttihZzU0iiddNpKwGV6JgVxkftz5E0Z+NRoNi4eCos=
X-Received: by 2002:a2e:89d9:: with SMTP id c25mr4332713ljk.105.1550050848208;
 Wed, 13 Feb 2019 01:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20190211185001.GA19472@embeddedor>
In-Reply-To: <20190211185001.GA19472@embeddedor>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Feb 2019 10:40:36 +0100
Message-ID: <CACRpkdYov_jBDZd_sQ98cZbMAOe671NdnF0-VnNGcK0+A6c71A@mail.gmail.com>
Subject: Re: [PATCH] gpio: sprd: Add missing break in switch statement
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 7:50 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> Fix the following warning by adding a missing break:
>
> drivers/gpio/gpio-eic-sprd.c: In function =E2=80=98sprd_eic_irq_set_type=
=E2=80=99:
> drivers/gpio/gpio-eic-sprd.c:403:3: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>    switch (flow_type) {
>    ^~~~~~
> drivers/gpio/gpio-eic-sprd.c:435:2: note: here
>   default:
>   ^~~~~~~
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied with Baolin's review tag.

Yours,
Linus Walleij
