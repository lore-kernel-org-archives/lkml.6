Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13CAECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC772124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aC/7YU8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC772124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbeGMHjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:39:43 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54672 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbeGMHjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:39:43 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so10297629itb.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmXkKOwYEVxPye+gCWn1clF2qgQmF6Z13qiNdo88N1o=;
        b=aC/7YU8r94SESQabxfXXf68FN6Sx5Etui7FehISGyyCe+dqXPqCtiFz+knozrdpv+f
         Jod2raXyVyaSNsGigzxlMI9fVbfbMOokhOPxk4AtjKH6/wRylIaUsjAQ/GQ8vB2+h2/y
         xXPhuoiqetGwpc888zPUqvly/ZPstT84+OvB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmXkKOwYEVxPye+gCWn1clF2qgQmF6Z13qiNdo88N1o=;
        b=nkUtHGa+8O5Ef5dL/WKpujh6Sb7S/maV403qACDQqYpOMIq2GrtxyP/PfWjrWIOei8
         Um90geUE8lNFWXrbU37jmZzokKsF1dnVrQSIYrrpW8bLC/kjuvvZLxxGjpXZYRzgYnqO
         CJkFq0Q91WFV29D5kSt0xJsJZMhUACSiUP+v97Czes83Ih7C3Fi4JEYa4MgU4Lt3KLwv
         9wVP1elSKh+qf6pdAjaSQqaU62iQd0y9QiOMu1psVn5eyYc6ocPS0clVJIJ54MLi/j85
         vLZPTIzvSTNFdmomBOOn+aOaaDBfnyr3kN3AIYgxe5zVtVF3yuj6iI8KHpXn8QeLqoeg
         7W5A==
X-Gm-Message-State: AOUpUlGiGpapC0fvhEgGf3U0xebIxjgMprfhUTc2qK6BVjBGmOqOEkJw
        1g2riF2c28PHM0+3xDS9o/F+axx7Z8DQ/mYMmPwwjA==
X-Google-Smtp-Source: AAOMgpferQRQFFLWjStfw1eK79Ta2C6al4+seZYhrx6DGd21+FYVNei4F/936VbFCwh+VlwQvvzFymUwArEtkrJhvZE=
X-Received: by 2002:a24:ad01:: with SMTP id c1-v6mr3836432itf.70.1531466782561;
 Fri, 13 Jul 2018 00:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180710151915.2282622-1-arnd@arndb.de>
In-Reply-To: <20180710151915.2282622-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Jul 2018 09:26:11 +0200
Message-ID: <CACRpkdbD6D3xtR6n3oOj4wWv5AZGar71Gwiyiv8Fu89UvX_9RA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mt7621: add OF_GPIO dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 5:19 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Compile-testing the driver fails unless OF_GPIO is enabled:
>
> drivers/gpio/gpio-mt7621.c: In function 'mediatek_gpio_bank_probe':
> drivers/gpio/gpio-mt7621.c:228:10: error: 'struct gpio_chip' has no member named 'of_node'
>
> Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied. Sorry for taking some days.

Yours,
Linus Walleij
