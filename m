Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE29C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C08420675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wCAe5nJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404989AbfAPPhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:37:02 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52785 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731042AbfAPPhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:37:02 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so3596929itg.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 07:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=03Xzgc/yYBULlgSjVEVvc7XjbAwjLLb3XgSpqBuRyqU=;
        b=wCAe5nJuXTMD1zfPpda/rAUOzjzlC3q7TklLqW37c2+5tASDV7t8STUCfAJCggFAa+
         xHE9AqJfIfwEd4VM+8a0YKhtrUZs+dkCB3MSyByBqj+6CKkfCYlGUhQhPQWYyUi2qNZh
         JS16LLAdV+7vlqS1x8JJVKClUFjSHBF25A+GiGrhlcKYkE3vBNkVaeQJeSFkooR0kHDZ
         XJptqpo0lEYbUm8BrOpjaIox/V9ZgRzHMl/vN7r4Pxok6h1ebB/+u9XzNX4njTtYUGVK
         Egl5imrKsTYN4Y+KMDFpwVe9diTUyknxZyaM2F40u07W9FpKkQGcK9RnmWrATQcSsizR
         mMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=03Xzgc/yYBULlgSjVEVvc7XjbAwjLLb3XgSpqBuRyqU=;
        b=FW2FIVRBCW4fAwRYxTJb2njoIzpqNAT5e4Rd1dwWnY324FXELdNHw4rYO6kRb8RjZU
         gLDElgo07DsbXW66k8+n6m/QoN48n7dnT6tR8D4nHhti7+blVMwBHu2Kh9Q2LE1vmuBT
         jZ0axFGh/As5TFUCyVJge7K9Nlubi1NgIWoObQWTKuk5xNR4uUS3wxzxt+kGqMCBpdiz
         jCXFastWUtGJ8r1P6P8F8PS9TGi5R/TD1FBR+ii0qHYdgrbMZ6cCW6eTSpYb02NW+IYc
         dQP//b+ewSQQPCvwvWbY/Uw2i8degCnbZvTp0/N9oCw0rUqL+kB1fhK9F9Nmo4nMC9tO
         lilg==
X-Gm-Message-State: AJcUukeC4zj3R0cb0Dsrcli26682WJiurplEMKuJVXxfZnk439CaZqQ+
        0SzC5qx5vEf5gCZDL9KoZvqn9kYmBGp0u5iOIp3ByA==
X-Google-Smtp-Source: ALg8bN6bHS133qDDRZmzII+imtz87SpHjzWGrwJt7wB63iwfcgUfbmf35eUOyj8Nl84p3XeS4+8jzovEJPu/HHJP0mQ=
X-Received: by 2002:a24:9d1:: with SMTP id 200mr6354028itm.53.1547653021178;
 Wed, 16 Jan 2019 07:37:01 -0800 (PST)
MIME-Version: 1.0
References: <20190111174347.25040-1-brgl@bgdev.pl> <20190116133544.5288A2082F@mail.kernel.org>
In-Reply-To: <20190116133544.5288A2082F@mail.kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 16 Jan 2019 16:36:50 +0100
Message-ID: <CAMRc=MdNGJhaGMMwwLHPO0hnoM6vZbdAX8xEHC75QSmZwjZt-g@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: fix line event timestamps for nested irqs
To:     Sasha Levin <sashal@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 16 sty 2019 o 14:35 Sasha Levin <sashal@kernel.org> napisa=C5=82(=
a):
>
> Hi,
>
> [This is an automated email]
>
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: d58f2bf261fd gpio: Timestamp events in hardirq handler.
>
> The bot has tested the following trees: v4.20.2, v4.19.15.
>
> v4.20.2: Build OK!
> v4.19.15: Failed to apply! Possible dependencies:
>     Unable to calculate
>
>
> How should we proceed with this patch?
>

I sent a backport of this patch.

Bart

> --
> Thanks,
> Sasha
