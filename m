Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A53C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 20:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6963321759
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 20:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtGukRAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6963321759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbeHDWxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 18:53:34 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39628 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbeHDWxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 18:53:34 -0400
Received: by mail-ua0-f193.google.com with SMTP id g18-v6so8167940uam.6;
        Sat, 04 Aug 2018 13:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jxpw+xVPbIb6+LuL1gBVbF9RgLCzuiDcxE23GzFxzU4=;
        b=HtGukRAoZiTEMBXy0p1U17dkZpN2XHcKGFJRIy6Y9amCNutXN3HHgGOtB3ma75KCQ6
         uZ87HuVxjSfBtsEr2A0B6cVXI/b9GNnDWh4rbiEzdDzFfQDHAibSSD6WzH5vZDJx/Z7I
         6/z2EnAw+lpRCCFwv6kuglC4ownqeCYoOjJen89mlVQqtRD856dgONGksAxBvCo+QeHq
         M5Z/EPt68/r1xYZP7fOAe2wmURQgHIlDieeHH+FsWo0qis4MRIXW84WdKgaMa+GSwtKC
         dirsgPWypyUyaMEahP5TgMINf05TXw+tcmCsmzfD+UNf9Zta0pFXKTsQvHfjDMVRbyzC
         +ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jxpw+xVPbIb6+LuL1gBVbF9RgLCzuiDcxE23GzFxzU4=;
        b=BuvXrlOv91mqo9G1gK0zaXrF3HwsshcBYCEQDVJ+qep73ke6Vg4VdZjvNG7kfS4g3o
         NaiHHYw75bhUs5/SPQv/RCKzRkOjsZwBWT0/wqPLyaN2r7qTTTPuztkKrUcQRmrA+cPt
         smEAVhaKxE3iu2ilWRr5qMXe3Sw6DLCLR0kChZaGNi+JXDzJMt/C+cmyucUUyZVPqrgl
         DPUL7pLn1j+itHEONiW68IiyBRpfJ/nXLjvKWLsyeqtsM7Xez4jRQM7GPWMl9oHQWkDQ
         GzTusQ8tqClGsR5mFYJAFy51rXHlPLd31vR3lNwG2b2BX4mPOpKox50pKredCT4eAhlW
         ZzFg==
X-Gm-Message-State: AOUpUlFp3vEQ44VDvNpsIQCQi78EIRxQRuW9eda4gTPdRvmWUVPQUOJe
        S9qXeBYXBjnxe2uWe6Mglpw5rAL6DctulTPpX1Q=
X-Google-Smtp-Source: AAOMgpejO+J5YCwIjFEWTE0fnO0wdykyp1dfR1GXWxw+zrfcDZxmGO2/xYIjbX8BbsEvcS2U54yStZiOE5iEnT4rwyk=
X-Received: by 2002:ab0:13c7:: with SMTP id n7-v6mr6432941uae.47.1533415898600;
 Sat, 04 Aug 2018 13:51:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 13:51:37 -0700 (PDT)
In-Reply-To: <1533404620-18536-1-git-send-email-mark.jonas@de.bosch.com>
References: <1533404620-18536-1-git-send-email-mark.jonas@de.bosch.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Aug 2018 23:51:37 +0300
Message-ID: <CAHp75Veo__Zu_Uk5-CN5q_yEUHs0fDsKZu9van89JBX2Prs7-w@mail.gmail.com>
Subject: Re: [PATCH] eeprom: at24: Fix unexpected timeout under high load
To:     Mark Jonas <mark.jonas@de.bosch.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wang Xin <xin.wang7@cn.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 4, 2018 at 8:43 PM, Mark Jonas <mark.jonas@de.bosch.com> wrote:


> -#define at24_loop_until_timeout(tout, op_time)                         \
> -       for (tout = jiffies + msecs_to_jiffies(at24_write_timeout),     \
> -            op_time = 0;                                               \
> -            op_time ? time_before(op_time, tout) : true;               \
> -            usleep_range(1000, 1500), op_time = jiffies)

This one understandble and represents one operation.

> +#define at24_loop_until_timeout_begin(tout, op_time)           \
> +       tout = jiffies + msecs_to_jiffies(at24_write_timeout);  \
> +       while (true) {                                          \
> +               op_time = jiffies;
> +
> +#define at24_loop_until_timeout_end(tout, op_time)             \
> +               if (time_before(tout, op_time))                 \
> +                       break;                                  \
> +               usleep_range(1000, 1500);                       \
> +       }

Besides `while (true)`, which is a red flag for timeout loops,
these are done in an hack way. Just open code them in both cases, or
rewrite original one to keel it's semantics.

-- 
With Best Regards,
Andy Shevchenko
