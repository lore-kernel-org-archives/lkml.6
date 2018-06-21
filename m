Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175AAC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC13420875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuWxKvHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC13420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754505AbeFUCNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 22:13:44 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:44271 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754245AbeFUCNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 22:13:41 -0400
Received: by mail-ua0-f194.google.com with SMTP id f30-v6so1009233uab.11;
        Wed, 20 Jun 2018 19:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8/BbNkeTQGJYJ7zwuZwhEAr+TWj53ZmWFG9LfxVnadY=;
        b=TuWxKvHDdccSovocCOOBr3Wj2k+sPa/PLbXPeiPGTyTeuhXBFKL5eM0P1s57f4upgD
         B49oIVtxaSCA+VzQnhTJ4wZu802AwY931Ct5AHjaUhMIs+Nm1roHrKzuWJPNiGHnpo4q
         zAuzABVU6mDJaHBoiKtZ19olJ6CjEI8i5MNlI6GvphIjfTNUSM3pw5ot3ciL0hT8gino
         wZhwOZ1lOLuxrgePLP+/pFAJ6GrAkFvWcEcBANow2zKGg+eDHMymUAyPzhus5alIwNK9
         znZh5IodJyD4Ij2jzMBoup2LYTf4o42GF7Rl19f6W6hSk7e3BcZvLGVO18H/71xbhv9b
         NjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8/BbNkeTQGJYJ7zwuZwhEAr+TWj53ZmWFG9LfxVnadY=;
        b=aFVgfAhEs+N+416Joiz9Zqz+MRw2C5v7ib+hAnV80ZoMMUA7o2f5SVtZNynj61lwxx
         0dUFGTS2cHuAP9fUpKOYv3GHF5JI5CHip4M4Jg498leVD+ByOgNBpJBA2RPzw/8ti0X0
         OV4h4XPApZA1UNT1WzVqXCE+P8q4lTC6lBZiAYkpBCx0HeCmbBA2pKaDCIeajbd0ezrI
         g2zQcDXaY30WT6OG5eF5Y7oYTwdj9pXBG1NBMTbb05Xx7nDRpNB3dEwbfrstDpIi+pyD
         KJTvQ6UAwwYwqZkb6xCtY2Xp2rI1Wz4WeM6zu7CSmKnJ70Et33Svk3Cx9PM2QOZcLnhB
         CMgg==
X-Gm-Message-State: APt69E1mAKXGgVAvk19qmkOoJea3QNk63Bx0H2UpCNMC/KqB1B9RKfYx
        2QAqqGQe/CSKFyhOUVCi7Ke9j1BH7dmSviiZc8w=
X-Google-Smtp-Source: ADUXVKL0OFMsQNVwPeNg7Ar7xqcaeeDL8OTKTGUnOL6eMTM7lEuil7XIsvIZ6Hspw8sUwHE4+fzXs48YeeGCIUBPdeU=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr14757516uae.199.1529547220033;
 Wed, 20 Jun 2018 19:13:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 19:13:39
 -0700 (PDT)
In-Reply-To: <20180618161056.e52efd0e8bd36211e60705a2@linux-foundation.org>
References: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
 <20180618131003.88110-4-andriy.shevchenko@linux.intel.com>
 <20180618141404.68124daab97bd0f3a3051544@linux-foundation.org>
 <CAKdAkRTHOORds7aEauv4rp3_=PnGi=Nv-VS3-nAb9MztJPKG=Q@mail.gmail.com> <20180618161056.e52efd0e8bd36211e60705a2@linux-foundation.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Jun 2018 05:13:39 +0300
Message-ID: <CAHp75Vei2_V7h4oKAU+uoCG2gUJH6uXtg9zVqQ_vnyr5KEmNYw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        agk@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        shli@kernel.org, linux-raid@vger.kernel.org,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 2:10 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 18 Jun 2018 15:01:43 -0700 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

>> We can't as we end up including bitmap.h (by the way of cpumask.h)
>> form slab.h, so we gen circular dependency.
>

It's not just so easy. See below.

> That info should have been in the changelog, and probably a code
> comment.
>
>> Maybe if we removed memcg
>> stuff from slab.h so we do not need to include workqueue.h...
>
> Or move the basic slab API stuff out of slab.h into a new header.  Or
> create a new, standalone work_struct.h - that looks pretty simple.

I tried to move out work_struct, it didn't help. There are actually
several circular dependencies that ends in bitmap.h either way or
another.

First one is

slab.h -> gfp.h -> mmzone.h -> nodemask.h -> bitmap.h

And so on...

Splitting out kXalloc stuff to a separate header won't help, I think,
because of the above.
Splitting out struct work_struct is just a tip of an iceberg.
Splitting out memcg stuff won't help in the similar way.

I'm all ears for (a better) solution.

-- 
With Best Regards,
Andy Shevchenko
