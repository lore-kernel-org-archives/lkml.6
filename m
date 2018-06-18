Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC00C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA35B208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLhPKT/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA35B208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933524AbeFRPut (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:50:49 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35553 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754091AbeFRPur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:50:47 -0400
Received: by mail-it0-f65.google.com with SMTP id a3-v6so12694106itd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HWniTUO/mCVBgyBmopP5hRnFwVsP8Zwle68vqY3Fe3o=;
        b=iLhPKT/owTIiEHt8wkbbSfpu44xxs+H5ZB8ac76/NkyICyZmsQ3UpCJ8d6yISflr0v
         GGSg7MS0chNo2hI/Z2r6EJPwXulo73KNG6bT4lbcUw/z4/m0lLjT+LbSohyLbReQ1Mfu
         p1vfNA36nUYwFb2aMOlWzrTWw9mSdoLps9h5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HWniTUO/mCVBgyBmopP5hRnFwVsP8Zwle68vqY3Fe3o=;
        b=a0fRxe5gWglF92D75U5hAIcipztI7PUV2gJLzey5/63TbbCYVmMnRZxX6hneODgN4h
         /0PkJAAB1fIBoC+5jBqz1a+NIPxSooHEpzWg9BrAwsiHJ57fMKnlDpGgcVJ03oumChrF
         N8t0YggjtYr8TkhwRb4Q92vB3I4E1+nsXyajlA2yvIo9vr54GiPFE32eabnClKJZcKgJ
         C9TuADCiurJ/VQ2zFfFdreRq5wf0KBVWKBic8Mrk0XbyZ8uJc0/WIebGbLWl4AX3L2jU
         ncFFHAguZC9MU7IcfzxlHzSf/DeWLj/FOC8k0faNPyYiDPnogWhmXE0ovOGgrYELCSSU
         IWVg==
X-Gm-Message-State: APt69E1zT3oeI30TL5f7e/SIjkMoC83Rq+wRUtuD4hhNgEGT3YbmTHmT
        eJE66C6tSB4IXPujBzfCSx0hu4FDfxEzHvaRsR1vbQ==
X-Google-Smtp-Source: ADUXVKKOl3Lwsf9RwwmuHywfWMVhEsjsZr13+hDYYRv4VkYQ1uiuUz9mRmkB1x3BBVls4zBtCyYT6Po/B0K9hEHtbz4=
X-Received: by 2002:a02:2422:: with SMTP id f34-v6mr10500010jaa.2.1529337047162;
 Mon, 18 Jun 2018 08:50:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 08:50:46
 -0700 (PDT)
In-Reply-To: <CAK8P3a0dP+zvucn=_um1zRgBYQCskrhqa2KNSDtnpSu199baWw@mail.gmail.com>
References: <20180618141811.3353245-1-arnd@arndb.de> <CAKv+Gu-r_+b_tCXeZeE6=EN3=1N98rheODOwV_4mpb9GMzdqrQ@mail.gmail.com>
 <CAK8P3a0dP+zvucn=_um1zRgBYQCskrhqa2KNSDtnpSu199baWw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 18 Jun 2018 17:50:46 +0200
Message-ID: <CAKv+Gu9OD6s24Aq1bLBr-yq_tn6wPR0TAkddO+VTwM7jR76dOQ@mail.gmail.com>
Subject: Re: [PATCH] efi: cper: avoid using get_seconds()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        gengdongjiu <gengdongjiu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 June 2018 at 17:49, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 18, 2018 at 5:47 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 18 June 2018 at 16:17, Arnd Bergmann <arnd@arndb.de> wrote:
>
>>> -               atomic64_set(&seq, ((u64)get_seconds()) << 32);
>>> +       if (!atomic64_read(&seq)) {
>>> +               time64_t time = ktime_get_real_seconds();
>>> +
>>> +               /*
>>> +                * This code is unlikely to still be needed in year 2106,
>>> +                * but just in case, let's use a few more bits for timestamps
>>> +                * after y2038 to be sure they keep increasing monotonically
>>> +                * for the next few hundred years...
>>> +                */
>>> +               if (time < 0x80000000)
>>> +                       atomic64_set(&seq, (ktime_get_real_seconds()) << 32);
>>> +               else
>>> +                       atomic64_set(&seq, 0x8000000000000000ull |
>>> +                                          ktime_get_real_seconds() << 24);
>>> +       }
>>
>> Given that these values are never decoded and interpreted as
>> timestamps, can't we simply switch to the second flavour immediately?
>
> I considered that, but the downside would be that all future filenames would
> come before all past file names.

Won't we have that same problem in 2038?

> I don't know if the order is important at
> all, but the current implementation at least looks like it's intended to keep
> all file names strictly sorted across boots.
>
>          Arnd
