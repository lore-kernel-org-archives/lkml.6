Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1D316256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAB720857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbi9AbDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAB720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbeG3Su5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:50:57 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:46653 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeG3Su5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:50:57 -0400
Received: by mail-ua0-f194.google.com with SMTP id u11-v6so3631916uan.13;
        Mon, 30 Jul 2018 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7GC9s5VIT8ydoro0UBQO8EA2Ao+qMvL3sBRIiBrZ3m8=;
        b=rbi9AbDUOyYAGmEadQMizzfrY4t5uEJThJoCouFHT8wkm8mZtyv5KEYjnbZk5GRqMY
         YC4xT1nTOtDvgDz4B43KB/Gp2xDxlfpIRMidNNF4Ytzj/HHfcwYU2wyfEXuvbpI5ysd4
         9wiVDDELNc/Ry1t20KDigKrW3GCE3dcCPYCctbzuAVwDHUqQ77G7+ZhG19o5fWgMhMyH
         KmEgribvzgM0jzl79/GHY0Z4yjzaOf0UUhS4QLwfcvysZ6FuaDSZWX7NZ5lyN4BkcS+q
         QdPeYdebv7L1VU88qXerbL2NL0pbIvw8RYHlZv9gtGNY9PGG6db9sRAdp2Lj8iLbrMXk
         /7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7GC9s5VIT8ydoro0UBQO8EA2Ao+qMvL3sBRIiBrZ3m8=;
        b=WRSdh5lR80rGf9k6dCPIg2NDuEXAAyVw08k5RWay998AsoP1BEIQ/rMnAqNHQEvKn7
         uwmHKydWgL/thtjXVIHU/0Foy8T/v9nir9YSdQzkor+N+uDRqrFMjXp4g1VMcRYQHTw0
         vh7OJnY5E4GUksuDhTEpfOsVkxU/bqbp3tbtHdG9Rnh52vy5QFdgtTU+5tsRln0s3SME
         ibx7yCdweC8vddztgpCiWTLHt8g4B6BzzCiEjI0Nc76DScmJx5UEASfHOGYpzNAbjo18
         vmJsyTF1BxOyVtorcCUDq2EjDlaSVltGX5YM2/hWf6r4kn2KfobEBzxeGvGT3aUs9p5i
         UPHg==
X-Gm-Message-State: AOUpUlEWwkd2wD//+SRe9Df1QpFjTfiO0IkBRvP7SnY62Kh1FQQgsPm+
        klkq85uqfDJ2VNfkZCpmSxl0pwqrGJ/1Brh+TDBFBH7x
X-Google-Smtp-Source: AAOMgpc5GolzAGGBrVT+ol10CTjpzlQeP6g1ta6BTRXVjOSrlNv7nlMscGNqGVa1lJjAbuIURcQ/6GxDWjTHangrQl0=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr12614497uaf.199.1532970899486;
 Mon, 30 Jul 2018 10:14:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 10:14:58
 -0700 (PDT)
In-Reply-To: <20180730093418.124648-2-tmaimon77@gmail.com>
References: <20180730093418.124648-1-tmaimon77@gmail.com> <20180730093418.124648-2-tmaimon77@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Jul 2018 20:14:58 +0300
Message-ID: <CAHp75Vfr_XvDbCBgh0z6iHe8BH9t8ZN6QpP9t4HvXd10db-Hcw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: mmio: add inverted direction get_set io support
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 12:34 PM, Tomer Maimon <tmaimon77@gmail.com> wrote:
> Add get_set_inv_dir and get_set_multiple_inv_dir I/O functions
> to call the data register when the dirction is input and
> set register when the direction is output.
> the functions will linked to the I/O get functions if the user set
> BGPIOF_INVERTED_REG_DIR flag in the bgpio initialization.

> +       /* Make sure we first clear any bits that are zero when we read the register */
> +       *bits &= ~*mask;

Theoretically it's possible to get mask and bits longer than one long,
and bitmap API has to be used.
Though, it seems entire driver has been written in an assumption that
it's never happen.

> +                               gc->get_multiple =
> +                               bgpio_get_set_multiple_inv_dir;

I think you may keep it on one line.

-- 
With Best Regards,
Andy Shevchenko
