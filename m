Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA19CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C982075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxQjoplg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C982075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755391AbeFRT5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:57:02 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36476 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755344AbeFRT47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:56:59 -0400
Received: by mail-ua0-f195.google.com with SMTP id c23-v6so11504664uan.3;
        Mon, 18 Jun 2018 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Pi9gENfzOZQEObvEnMp1V3mn1A4hE5NRpwJSebd8olE=;
        b=IxQjoplg6RFSPBMbQ20agJdk0slOcE0r84VMxkptp0ElWVZ1XKMVUOex/kKUrWgp3i
         4R4GkMZD+VittMd3FIEFTDAa31PjbYof5xHzDk55/z9STeCHRXqpM0v0Ys/cUg9mFfIs
         AY1zztz1ez4+0cA/GW1YfsTjScz3I0T5gHKDcPekJRf2drrS2Qbx3VFZcG+fmL5hIwop
         DAKFRA88pIW3NpBdtE5ItyeYiCAiokWFfpOrY4Mf6zB25NkHyVXG2m6s2glGA9N9INSg
         fiObhRA/egrG1s+YMJ1nmNRTwetbpOJ/jRyXObM5ezyIrT/C2CvIneGARiIVzuVe4fTc
         5M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Pi9gENfzOZQEObvEnMp1V3mn1A4hE5NRpwJSebd8olE=;
        b=h9YxQ8PQVXH0BIjyDxIPPQs9jGV/XGqTKGBFtX4ighB2GugFdwO+lMbUd7CmO1n7/C
         m7lGbKi6Zs8T+AthkImCfepfWOXtjFzt5/dQoBBTnlKjuaUJiO8YH46gYxtnK/idahL5
         bTsZuR5RgH1zBYu4V46ifxLgrMiq/vVfeU8z/GKzOwBaJHqtdEnU2KI/kDe4LInK9NXa
         xlC/ReX2sMXAKvdeNCbfo07+AQ9MDWw3JPYN4ScPSJVMg5K55NvQEma+I5Z0qnpsBUsM
         a71h0gPdkWPRoNbeHozMazBr6758lsCHbcSXhMqsPvSOkdHHEs15qHF4QZeaV0+CGVr9
         yC4A==
X-Gm-Message-State: APt69E1AswnmUN/ngclbHOY2CZUcDRaafZOltgXEPBmr4qB51sT2Y8kX
        QUoW1xEY6mSvPzqMIm9Wvhua5chsIaKfJ6CEDBE=
X-Google-Smtp-Source: ADUXVKLkq2gbkArH/wskHMoqJiY//TV5nB7I2XaHAcWoM/1C6FKX42z9h3CHD2aNqWyek9hUJMzQAY6sIl+u9uBxFds=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr8613438uae.12.1529351818518;
 Mon, 18 Jun 2018 12:56:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 12:56:57
 -0700 (PDT)
In-Reply-To: <780cba4e119110f2d2a81e237874592cff4d7868.camel@perches.com>
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
 <20180615132017.23889-6-andriy.shevchenko@linux.intel.com>
 <20180615214231.GA371@yury-thinkpad> <CAHp75VcxYPCLYq1J8qqjPdgDdQnWDgZKkavmyEWD8GNxcW2mWg@mail.gmail.com>
 <0a3d86d7746792a2f848cef386941fc182653515.camel@perches.com>
 <8cfbdf809f531f8aa315fe1679c3273858038f41.camel@linux.intel.com> <780cba4e119110f2d2a81e237874592cff4d7868.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jun 2018 22:56:57 +0300
Message-ID: <CAHp75VcJLEmDTe0bCx7UkH4xMH44VUrvuFqdc++OYyE-JKd_cg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Input: evdev - Switch to bitmap_zalloc()
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <ynorov@caviumnetworks.com>, agk@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        shli@kernel.org, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 6:49 PM, Joe Perches <joe@perches.com> wrote:
> On Mon, 2018-06-18 at 15:02 +0300, Andy Shevchenko wrote:
>> On Sat, 2018-06-16 at 12:16 -0700, Joe Perches wrote:
>> > On Sat, 2018-06-16 at 21:45 +0300, Andy Shevchenko wrote:
>> > > On Sat, Jun 16, 2018 at 12:46 AM Yury Norov <ynorov@caviumnetworks.c
>> > > om> wrote:
>> > > > On Fri, Jun 15, 2018 at 04:20:17PM +0300, Andy Shevchenko wrote:
>> > > > > Switch to bitmap_zalloc() to show clearly what we are
>> > > > > allocating.
>> > > > > Besides that it returns pointer of bitmap type instead of opaque
>> > > > > void *.
>> > >
>> > >
>> > > > > +       mem = bitmap_alloc(maxbit, GFP_KERNEL);
>> > > > >         if (!mem)
>> > > > >                 return -ENOMEM;
>> > > >
>> > > > But in commit message you say you switch to bitmap_zalloc(). IIUC
>> > > > bitmap_alloc() is OK here. But could you please update comment to
>> > > > avoid confusing.
>> > >
>> > > There are two places, one with alloc, another with zalloc.
>> > > I will clarify this in commit message of next version.
>> > >
>> > > > > +       mask = bitmap_zalloc(cnt, GFP_KERNEL);
>> > > > >         if (!mask)
>> > > > >                 return -ENOMEM;
>> > > > >
>> > > > >         error = bits_from_user(mask, cnt - 1, codes_size, codes,
>> > > > > compat);
>> > > >
>> > > > If my understanding of bits_from_user() correct, here you can also
>> > > > use
>> > > > bitmap_alloc(), true?
>> >
>> > Also it might be useful to have a separate bitmap_from_user
>> > to alloc and copy.
>>
>> Maybe. I didn't check if there are such users except this driver.
>>
>> Anyway, it's out of scope of the series.
>
> That seems incorrect as you are introducing alloc/free helpers.
>
> Perhaps bitmap_dup_user [or some better name] could or should
> be one of the helpers.

Can you help with estimation how many existing users need this kind of
functionality? One of them evdev, which has an open coded variant.

Also, pay attention to that fact we have already bitmap_parse_user()
and bitmap_parlelist_user() which are called by several users.

If the estimation will show something like 3+, it would definitely
make sense, otherwise, I wouldn't like spend time on it.

-- 
With Best Regards,
Andy Shevchenko
