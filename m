Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD01C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 18:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33786208AF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 18:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTXodPtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33786208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932950AbeFPSpv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 14:45:51 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:37115 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932482AbeFPSpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 14:45:49 -0400
Received: by mail-vk0-f67.google.com with SMTP id w8-v6so7441772vkh.4;
        Sat, 16 Jun 2018 11:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZUQNSgyTknAdPpmJSnNpI1XMw395wDvZJTrQqGEI10=;
        b=DTXodPtlASjuXajB26X/BG567W2UeuNglUggVj7ipotwgVesO7v7YfqkBSSHepuZym
         YtWTCzA3ECcQ9Qomcq0RlxwY8tTlfkL2rj2ja+6KKWhE+gHu860VuMwciFGF/JNmzGaw
         IfEkgGyZU7nA02mwlzgzIEDYWWn2KDPw3v22TOlB8+VwdXzFrzc1z3UrincyHPDLtEjZ
         W5ijzCvUzhP7KZc/e+pgXgiqLumR89Z4TtwMXRifoUvKrY9mIBM2IUgtd9f3WVAmCe7a
         v/LUlJsnZ22O/nn4SkUYdgjjCQX7oljeZsmnBmMyDQLVVEIZrtkU1Xd1SBMaQgDRn+7G
         Ne/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZUQNSgyTknAdPpmJSnNpI1XMw395wDvZJTrQqGEI10=;
        b=nUH0J7va1PfHESrO4vEHz+nwEd/epDhHYn7YXYcdr8N6PclUzD6vWRlBaKN86nR/ad
         JtW/P3G1nR7mv+SxCzOPWJzPFdoxqvunjOSE8tpN6S18uP8lHwmxQqOfSrT1+vrm2RP1
         D4L649oEgF9QSfOYdUw40nJIKUmbss9NK/KoH2aF/gaReGBfUPUy/gbHCRRYX4iWlfRS
         oc4FziK80geLqbrzXpIhBhBBKSPO8Zuci3zK9idmnBA2xjCsjt4vnJjwFdKv5j5Ca3oD
         lpsNlxkXvoS7C3OT911yLCPPCaedYCbauOZlpvbClQnHYptR+MZ+BZA6PWLrzEeYqes+
         o34g==
X-Gm-Message-State: APt69E1I4X9Tm00tIpN6VqrrUqAxppBCRTWJoxnuB/b2hZraLgoLVvlm
        z89QAc6PnR+BPam+Gf5XCdMprbsqqflnKXICSL8=
X-Google-Smtp-Source: ADUXVKI20eS2NQM6DZ5b4LGaMs3oRWpK4OGkZQQAIZeRrkiJZdS1pNmqpMq9BV/AoOgOPXxGcDYBMRiA7Fle7ik9Qb0=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr3729552vkd.15.1529174748024;
 Sat, 16 Jun 2018 11:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
 <20180615132017.23889-6-andriy.shevchenko@linux.intel.com> <20180615214231.GA371@yury-thinkpad>
In-Reply-To: <20180615214231.GA371@yury-thinkpad>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 Jun 2018 21:45:37 +0300
Message-ID: <CAHp75VcxYPCLYq1J8qqjPdgDdQnWDgZKkavmyEWD8GNxcW2mWg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Input: evdev - Switch to bitmap_zalloc()
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        agk@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, shli@kernel.org, linux-raid@vger.kernel.org,
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

On Sat, Jun 16, 2018 at 12:46 AM Yury Norov <ynorov@caviumnetworks.com> wrote:
> On Fri, Jun 15, 2018 at 04:20:17PM +0300, Andy Shevchenko wrote:
> > Switch to bitmap_zalloc() to show clearly what we are allocating.
> > Besides that it returns pointer of bitmap type instead of opaque void *.


> > +       mem = bitmap_alloc(maxbit, GFP_KERNEL);
> >         if (!mem)
> >                 return -ENOMEM;
>
> But in commit message you say you switch to bitmap_zalloc(). IIUC
> bitmap_alloc() is OK here. But could you please update comment to
> avoid confusing.

There are two places, one with alloc, another with zalloc.
I will clarify this in commit message of next version.

> > +       mask = bitmap_zalloc(cnt, GFP_KERNEL);
> >         if (!mask)
> >                 return -ENOMEM;
> >
> >         error = bits_from_user(mask, cnt - 1, codes_size, codes, compat);
>
> If my understanding of bits_from_user() correct, here you can also use
> bitmap_alloc(), true?

While it might be true, it's a material for separate change.
Original code uses zalloc version.

-- 
With Best Regards,
Andy Shevchenko
