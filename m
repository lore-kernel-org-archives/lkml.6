Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD46FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930682146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kaOtDabI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbfAKMYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:24:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45741 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfAKMYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:24:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so10631172lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 04:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qt0Y1dBvP1yZHLvTc7/Wi1C3TUVDJWGCqhdEKX/4bGo=;
        b=kaOtDabIsRebwvz+nMvQ9QU7cPNo10cF9Bf9iRrMBPIAwqNZmMxwymVGSaejj92Tpg
         pRCnQhED4RHC84hFFENoKoo4wb+ZX2XqSI4cFhyTGIwA9kt/XmUDL1LJzsJfj9sMo6IZ
         NO1OxNYTFLVqYKrM/N5GuUZ+ablJfjTji1qJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qt0Y1dBvP1yZHLvTc7/Wi1C3TUVDJWGCqhdEKX/4bGo=;
        b=ix3C00r/oatCPy409tCe0NyysN7KXWbgbpGm5ly0spE05nCVX7k/nBCk2l7hOCAJGZ
         eeGlhp8GIwNBQ1bu2yhaG4d00+3v0XgnfU8irgBb9ne/3WOV2Rzc5+N4gsm73ZhByOGa
         ObVwsKoGZ29ethFSiNXYmTkUPP6LCxAlLlrZGRM9ZU7kJ5pG0KjcqwMZzB6p7CYtcZJE
         ZmdVtU4RWXJKde8uHUu1cx9vcUSazj4wkBgXs7mTNqJrXcUy3Zgfv7acAyNdY9Kf1SfC
         iAHnwOE9VJcfANf+6Xx+M+QW2oTOkUfikvz0JGPBZaLBKNuqvsMszyvAJ7PGUiK0tftw
         Eywg==
X-Gm-Message-State: AJcUukd60cYclJEem0txnnzhjR8PxuNczHvZlxZCw5Nwq6yCXhDgI5wP
        yaqNC9RnzO9juincuAjVCZofwWsx/TzPyPnNQUAD6g==
X-Google-Smtp-Source: ALg8bN4Zw186eFn7e8p4QqxWN8F9nIbXKgLuIgF0rK750r+nBqWvLxSKVQUE6fkz9rgH1zUuWSqRBecAmw7p9LaOtdc=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr8431759lfa.32.1547209438192;
 Fri, 11 Jan 2019 04:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20190104173733.GA29979@embeddedor>
In-Reply-To: <20190104173733.GA29979@embeddedor>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 13:23:46 +0100
Message-ID: <CACRpkdavhVgmNzuS=CSouTNZjqGsD68acwvPwJPPz4gfE1jw+Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mcp23s08: use struct_size() in devm_kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 6:37 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     void *entry[];
> };
>
> instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied.

Yours,
Linus Walleij
