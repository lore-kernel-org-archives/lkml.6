Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD1EECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADBD20858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbtv+11r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADBD20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeGUSjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:39:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46403 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeGUSjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:39:06 -0400
Received: by mail-ed1-f66.google.com with SMTP id o8-v6so12195837edt.13;
        Sat, 21 Jul 2018 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/SDmpWRaJ7ZZJzlqvAMCPoOZ6jKA4QMalM/VbUk7DBQ=;
        b=Fbtv+11rJb9yWXsASYjxzqXi21gZqBN7by9kS+ctEYGOUDV6h8o5MKtZVch94KXMEV
         yIPgf3pcsTeR4x383u/Je9TtyMIWSn2jxXRv3EcNT8Ikcyilcm/R2tCIwWJ0d/E7+LZB
         efgiJmMEaPi+rCB6n+KuwFAztRjEoLh7vr3PzFFw7hsXFHZJOVRQhTU2Fylrq0MEBffl
         BwOJ9XaR8xGMgm9bBvYh3IY2eRy7pduoPgPkXexgS1CuK1vJBHvfKNrgscWC7//DJbe4
         eblg+m0JrTAcfgSfsGBo0htEZcIFjhDLuTV+dvjZapYmsKYyU6GQO/a8WspUrAuTh5vk
         tgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/SDmpWRaJ7ZZJzlqvAMCPoOZ6jKA4QMalM/VbUk7DBQ=;
        b=pHKj9Z/mVEfFUaXBhOhLQ3i5ZcxNW9UVhLXIlPJU7NEjaIJlZLRCMeN65KOM747aTZ
         YjvGUAB+W01DB+D3t4OjNnFFaSeYYAQUeRTAmhs6OucKmYycn7rl1fOcv7WAXc6h8V3h
         HEggigLeqj+D/iSHLpQ9oK0eBrSl7drywfsgQy0Hg63vXU+ylf/LWC+oHePgVm/CydY3
         KYcE+c6i7hYWWV2L20R7szczatLOBs6YUJfzRty0CIwvXd3O2vqJBWGtxukRTgk/SASm
         L4cKLTgoK34sv/TsFmWadtXHOBXp9MMhyL8GnFzgkyGsOLtDH0XO4MwtPzZkZbPHqe4R
         BJsw==
X-Gm-Message-State: AOUpUlFe7nFVTH6TsDG+gMQ/xjX/cP241q07ojLFHFQ4zDdUTtTqP0OW
        2pzbgZSJsl//q7V5kiZQO5Pe0Up8NK1tZy89jqg=
X-Google-Smtp-Source: AAOMgpfg94HbYJzxJTCpyTQJPwc6HQSLjYOw4D+WWlE4+Of1XUEA4F/ddiWx5hLz8Iinf3dpeGOGGd3HhZx5pxtTJns=
X-Received: by 2002:a50:ec89:: with SMTP id e9-v6mr3651483edr.258.1532195135127;
 Sat, 21 Jul 2018 10:45:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:e844:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 10:45:34
 -0700 (PDT)
In-Reply-To: <CAHp75VegzWr8Q2idzAWpc5Nw3T5n=vWkMvspe0YGRwEQ_h0p+A@mail.gmail.com>
References: <1532122284-19602-1-git-send-email-himanshujha199640@gmail.com>
 <20180721161934.75066d97@archlinux> <20180721153607.GA11127@himanshu-Vostro-3559>
 <CAHp75VegzWr8Q2idzAWpc5Nw3T5n=vWkMvspe0YGRwEQ_h0p+A@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Sat, 21 Jul 2018 20:45:34 +0300
Message-ID: <CAEnQRZC80FWN9EADvE9geu773=vwRmE0JEwSfy_DMjig0d=qqw@mail.gmail.com>
Subject: Re: [PATCH v4] iio: chemical: Add support for Bosch BME680 sensor
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Himanshu Jha <himanshujha199640@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 6:43 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Jul 21, 2018 at 6:36 PM, Himanshu Jha
> <himanshujha199640@gmail.com> wrote:
>
>>> > +   /* Look up table 1 for the possible gas range values */
>>> > +   u32 lookupTable1[16] = {2147483647u, 2147483647u, 2147483647u,
>>> > +                           2147483647u, 2147483647u, 2126008810u,
>>> > +                           2147483647u, 2130303777u, 2147483647u,
>>> > +                           2147483647u, 2143188679u, 2136746228u,
>>> > +                           2147483647u, 2126008810u, 2147483647u,
>>> > +                           2147483647u};
>
> This one needs perhaps a bit of though, but...
>
>>> > +   /* Look up table 2 for the possible gas range values */
>>> > +   u32 lookupTable2[16] = {4096000000u, 2048000000u, 1024000000u,
>>> > +                           512000000u, 255744255u, 127110228u, 64000000u,
>>> > +                           32258064u, 16016016u, 8000000u, 4000000u,
>>> > +                           2000000u, 1000000u, 500000u, 250000u, 125000u};
>
> ...this one obviously just a not needed one. You may replace it with a
> one constant and simple calculation to get either value (index from
> value, or value from index).

Indeed this can be reduce to:

125.000 << (15 - idx).

The real question here is if we approximate 255.744.255u to 256.00.00u how
much different is the result. Being a gas sensor I think it is very
hard to appreciate.

We can go with this formula + adding a comment with the table with the
exact coefficients.

thanks,
Daniel.
