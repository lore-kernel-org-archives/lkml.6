Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 420BFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE67208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwR0pwes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE67208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933993AbeFLIkE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:40:04 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38147 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933363AbeFLIj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:39:57 -0400
Received: by mail-vk0-f68.google.com with SMTP id b77-v6so13887698vkb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aE7R469FlBL51oDvLq3ebVc7BnCQkl6GahLV5857ld4=;
        b=HwR0pwesDiyVu1LhQdcSVWpazbmSKcm/fcD9ShUqGpzr+hJISK/hkRVrn5mAnrTPJ8
         gD9eEUMKtFmi68woJfxKpt+M4kmVK4fRAyDQMjudq+k0q97ymjFcTvLdsrmLXlob6p5s
         HdqwE0bLqq0vzu+ynWnW4r2kb1F+YiC/cWHoXk+f41ncKyRXT/7+/uMiq8l7fuGsB1G5
         tpKdCsRNHqiLs3Al1Ww35D+rrVKbwLUbLCsGLR/dQUOjxbo/9NSFgIl+iOhYRImHhHdO
         RITJbGzm6vFyBrxrBnXwWkh+qwvaDv5xEJ3iEgOjGmzhgb61CUXmSHcCt7LljB1lprGc
         VRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aE7R469FlBL51oDvLq3ebVc7BnCQkl6GahLV5857ld4=;
        b=AD4rs23GhckRg2EAcJMso+0RpgVWcSNcTZUm8hLtkP1hCdYemLnYbPc4RNnj+Txjyl
         DJFjs4x8um7T/WYoQjFfKUleo+bNRRJrXuMqK74Q6SSLlEJeir2zKejtIAF/oVnk79kr
         c0QU5IqeSmLsV6vHMHIJ7I2jRZLa2Hhoe2151EpooTH0Z+k6WYlzWr9EQdcBLg7QY70J
         3WEMGtLZo5Ai5oLpvaDuddDTTlgVLgnWvcwTyBLJGXxHvNM7XN3JPEQhRXqXSNu5VlEA
         5wiJCN008Es946mP8LolD2ukWhSDYksLxMs3K99SOlviBE2QtPkqV90ycmekEKxdNLCu
         Rmyg==
X-Gm-Message-State: APt69E1KULX2s/w1FaacDUZi/4Y01ZEMlzpXHUMimfCj6/+VDNh6plht
        miXJOKEHh1kxvoMsxi7yNGOV1M7IGTstLVnX36k=
X-Google-Smtp-Source: ADUXVKKmwiveYk+OB+mGJKA0Z2BfU0+h3nlqW4E0EkxNz5MvcXdFbNcosfM9QJBZYwxgBZAbXobMRvypgZgyGWZY0KE=
X-Received: by 2002:a1f:82c7:: with SMTP id e190-v6mr1471913vkd.187.1528792796997;
 Tue, 12 Jun 2018 01:39:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 01:39:56
 -0700 (PDT)
In-Reply-To: <1528763954-27731-3-git-send-email-me@tobin.cc>
References: <1528763954-27731-1-git-send-email-me@tobin.cc> <1528763954-27731-3-git-send-email-me@tobin.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jun 2018 11:39:56 +0300
Message-ID: <CAHp75Vcqni6MtnLcoMG+2Tt_YeGq2QeQy4myEJp+dmjPXdj3XQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] random: Return nbytes filled from hw RNG
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 3:39 AM, Tobin C. Harding <me@tobin.cc> wrote:
> Currently the function get_random_bytes_arch() has return value 'void'.
> If the hw RNG fails we currently fall back to using get_random_bytes().
> This defeats the purpose of requesting random material from the hw RNG
> in the first place.

> -               int chunk = min(nbytes, (int)sizeof(unsigned long));
> +               int chunk = min_t(int, left, (int)sizeof(unsigned long));

Isn't this (int) implied when you use min_t(int, ...) ?

-- 
With Best Regards,
Andy Shevchenko
