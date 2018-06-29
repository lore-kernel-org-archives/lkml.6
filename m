Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6E5C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1545E27CD8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjCbOGlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1545E27CD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936525AbeF2UZM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:25:12 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:43803 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbeF2UZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:25:11 -0400
Received: by mail-vk0-f65.google.com with SMTP id d74-v6so6043195vke.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 13:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TmkFRUsqr+CJ8ytuagy1vxqnv88Ajfd7n2gOZgj3DIk=;
        b=qjCbOGlFx0ccouvnvx/zAsJActRVk+JpxMRqPZP3Hvdnmf+9JCZNxPkhtimnOCY139
         3umVQHZJEnSORjd6jxPk5ADo2qZd+qUITpe/gHUoxHfFsAVFffHbJlwvzmB2gjFqU847
         nC0Smq3UGwnZ9/0mCADoRxnhkZKSqF0WG7sfZxmPhwJLhOfLmOu/nswMM7WrrYpcKOTt
         VN0ul9WnEDnE2qOQajRWQauaY4TRPmf+aI/t6yE2eXIzJzYhrDMubO9VBlMipBWKoc4M
         iacPYdll3hsf1E3lt7zYpfjHZz42T5jQ4s7e1xD8oZ5DMgIZfLBBgN5McjboKtK4bXK4
         piQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TmkFRUsqr+CJ8ytuagy1vxqnv88Ajfd7n2gOZgj3DIk=;
        b=SDgrWJjwGzs1A6J73t3bP9uiCBeMv4SQpZ3LeN5HUAhlU06lIXukATPA3+bKTfCGKZ
         Plfsq+FfjQ7UMEX6+FThEWKIuKkGf8BAc5rUYd/pD8LLYwElD9lNCuCazALcqOtdpGVD
         L60XX4TbaV75Hm+Kc4IJ+7uJy/JD80hDSAR+UsciP3AQHbg01rcuUjQK9JheVuEJEy+H
         Gs91Ug238DJCq2TV/rknU5TWvhjBEu/r8R5cmbC6yU7WsDliSr6y1n92Bak+ke5r+G1N
         8xm4z/Z33sKCH66msq7DBGMMJKqeqrSGgY4W4asS1r1kZKiRTPaEflu8w2EFKGzIvx8H
         b29Q==
X-Gm-Message-State: APt69E1Ai+z9Q0upeKWzlkZf7KPOu1MI3n+of+corKTBiT7HTs1xkQA+
        pYuH0+oFn75LvtRXkkckMg9D6TCb5luLXmVUYmY=
X-Google-Smtp-Source: AAOMgpcbt87EIcqytyA+h6yIH3IOTDEViFD4VK0Y1MLcqY7U0Ha8qqZacASyc3rjpFrhmgOXz2soNOxffk6D6oPz5/A=
X-Received: by 2002:a1f:6dc4:: with SMTP id i187-v6mr3128035vkc.131.1530303910912;
 Fri, 29 Jun 2018 13:25:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 13:25:10
 -0700 (PDT)
In-Reply-To: <6d223fd7e9b74075be886b21189d8b50@AcuMS.aculab.com>
References: <20180629033303.13012-1-yuehaibing@huawei.com> <a0b2a088-4887-e864-d211-bed0665a0b81@infradead.org>
 <22bb151b-d651-597b-21b6-0e6346ac32c9@huawei.com> <6d223fd7e9b74075be886b21189d8b50@AcuMS.aculab.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jun 2018 23:25:10 +0300
Message-ID: <CAHp75VdUUCdmZ+Bg+5QCJN2+yax5hsLj1hbUTbBwQSFYb57a8Q@mail.gmail.com>
Subject: Re: [PATCH] lib/string.c: fix a typo in comment: 'iff' -->'if'
To:     David Laight <David.Laight@aculab.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 6:30 PM, David Laight <David.Laight@aculab.com> wrote:
> From: YueHaibing
>> Sent: 29 June 2018 04:45
>>
>> On 2018/6/29 11:35, Randy Dunlap wrote:
>> > On 06/28/2018 08:33 PM, YueHaibing wrote:
>> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> >> ---
>> >>  lib/string.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > Hi,
>> >
>> > This isn't a typo.  "iff" means "if and only if".
>>
>> ok, my poor english, thank you.
>
> It's not really english, but a shorthand used by mathematicians.

I remember I did a very same mistake (and sent a patch!).

Perhaps better to fully spell it to avoid "once per 3 years" activity?

-- 
With Best Regards,
Andy Shevchenko
