Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D8FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C02121530
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L400fiXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C02121530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbeIZXJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:09:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45826 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeIZXJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:09:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id l2-v6so17990990qtr.12;
        Wed, 26 Sep 2018 09:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YQ2OPyWppKUABXvHUYjZ2Kc7952HZGCDvUYuvolAjg=;
        b=L400fiXaXgxa8bUcKpjdr+gIXg5PgsTGn8JRRmrZE/1o1wxUK1carXLe56pwQQAEMZ
         7fAShznlhZY46FV2Pwcl4QGVp8ctWOCzioymUayTJmenYBRZTYfMK6rch/hHmvRk4oSb
         eNx6KxqQQVP8nw9thI7ZK2aSlmyeYZAETr2fFktHsxVo6B9oHzpdVU66XZjF9kMQwmNE
         LvtHHVfgoA5+du+5zANHhHJOL25HODYQtwiJ27vrrpqn7wETicOMx4ce0PcZIm1A5hDa
         RMJd3TVkiBztWBO2UPa4fr2wCUSUex+/wK6g268d/613V4UJ4Fucxnn+kODbxsGcdydw
         oWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YQ2OPyWppKUABXvHUYjZ2Kc7952HZGCDvUYuvolAjg=;
        b=a4zaTPf7h1C9ssHZfNf4IC5gOkj3TIRNn6IfWzUGFzKZ6Qk5befYAMFcVzn4KkZn1B
         oJqINeV94EFrJhPYcx0QkILjUuYe5rwRqQ3AvruLbi+5VLdF7vxkyf0pcfcOWvPh0FYk
         X32p4YuYgajuf3VhG/jDgxWr+GfdBm+ULfGzspWpT4TRpESNfjHT8b7Jh8aC3zuNW9Xu
         xpd25u5NHKTooRBBl5ADrF6exf2ksfIEIOPfavm83BrPxPKH+ZbHGl/fMISTde6I5CHy
         AIGz7RDVc1ZXacgLyG45bJ2J8aszaDPHKcB+HVCd0pMbgxqNVqRJl7cstL9hHw56j39k
         YXwA==
X-Gm-Message-State: ABuFfohUOoZa4NWm0LC6gE0sgs/ipt9Mpwvp4OY6L6mLFNE75kyO1yRC
        fgXbxBiVqB0LYZeqbjUZpQhD/2HbHgdrJ7vyor0=
X-Google-Smtp-Source: ACcGV60ncgv7DJH1jsLsERfSnE5ZdJmFqf4nR55kZx1EQTm1QdJiVzL6RDKHh/FaAm0/Ogn0h3lKYpiibl1QuygfL4I=
X-Received: by 2002:ac8:2f86:: with SMTP id l6-v6mr5146248qta.83.1537980945433;
 Wed, 26 Sep 2018 09:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180925193418.28493-1-stuart.hayes@dell.com> <CAHp75Ve=ZnkBbdG3Myu1qzubr6+q74Q0u9pR7+nHXG=yAO-0rA@mail.gmail.com>
 <2c21dba5f4074bc0861277ec5701d2ff@ausx13mpc120.AMER.DELL.COM>
In-Reply-To: <2c21dba5f4074bc0861277ec5701d2ff@ausx13mpc120.AMER.DELL.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 19:55:34 +0300
Message-ID: <CAHp75VfbdTxywsamjM=z-3kC__4_2_6i4LD9nD0yOSJayitS5A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Update and move Dell drivers dell_rbu and dcdbas
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 5:50 PM <Mario.Limonciello@dell.com> wrote:
>
> > On Tue, Sep 25, 2018 at 10:34 PM Stuart Hayes <stuart.w.hayes@gmail.com>
> > wrote:
> > >
> > > From: Stuart Hayes <stuart.w.hayes@gmail.com>
> > >
> > > The dell_rbu and dcdbas drivers need some changes, and should be moved to
> > > drivers/platform/x86.  Additionally, dell_rbu needs a maintainer, and the
> > > listed maintainer for dcdbas is inactive and needs to be changed.
> >
> > I pushed this series to my review and testing queue to allow bots play with.
> >
> > But.
> > Please, add commit messages to patches 4 and 5 (I can't take w/o them).
> > Collect Doug's tag that proves he is okay with the change (I remember
> > he answered something to the old thread, though I don't remember the
> > details except annoying footer which should not be up in open source
> > mailing lists).
> >
> > So, while bots are playing with the code I'm waiting for v2 of this
> > with above addressed.
> > Thanks!
> >
>
> Just so it's extra clear, you want an "Acked-by" tag from Doug W in a public
> forum?  Or he should be CC to that patch and needs to give the acked-by
> tag in the V2?
>
> He already did respond in a public forum indicating this although he didn't
> "generate a tag" for that:
> https://www.spinics.net/lists/platform-driver-x86/msg16336.html

Thanks, that is what I need.

> Can Stuart just add the "Acked-by" tag himself to the commit in V2 at this
> point considering that?

Yes.

>  Or do you need patchwork to pick it up and apply it?

No need. Manual update would work to me.

-- 
With Best Regards,
Andy Shevchenko
