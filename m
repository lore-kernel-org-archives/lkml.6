Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E748DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB8C21934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9M5Y+YR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393619AbfBMSOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:14:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43517 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388861AbfBMSOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:14:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so1510006pgk.10;
        Wed, 13 Feb 2019 10:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRY5HoG5i38cgYi22cGhd/Pw1E8+gVO/G+VMgFhACLY=;
        b=l9M5Y+YRf8At8goYoA5JlSEOZ37Mhz5oI6Rp9QebUqesKOaQLDLrO/9cgP8niNDHD8
         jOz4pyQ57HsD2LR9BPN1wNDPe3B0u/+TurcKb2aXkBQCbJSKN4/BErHrUIZxMLA43PDT
         KLyx27cRlXiTrCmOzX9BZdwOfa5MtzMucafNNBW7UrQg/Wua64hsL30lIZP6b65ISLKL
         dDFCCJDi67D0Vk3/YK+H8udls1qE32PK+7R5iqqY4MnaidwwI2xKOyCUGnLYfDQYODq7
         YZMHBQBBV+EJV2M2PfheKEULXindru/EIkq+1cGaxS72iI0KFWme3pg6JOc/7W5nOAqQ
         ypvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRY5HoG5i38cgYi22cGhd/Pw1E8+gVO/G+VMgFhACLY=;
        b=DYchKw6PWBai8X/HwtKV7W0lit9dOtQd9OT2GUHPR9ciQNaXGgaq6+Dn9EQ2D9wYLO
         ee5OT/C2gWMSks2dc6qgey01Tx3V+pgKsN6WBI6sYOBgSQePUILQD3v45pAC7LXHAFlS
         8dcmLXm8u5hwEgEu0oy5qEA7J0kTLUpBvxJ5CkModJ4txN9NqGHfOq6o3KStFFU67F8f
         Ei82dzbQm6k9zl1T3sP7bAoDy08Em3G61CSzzFNFt6MdvWbUK9bqwhhKgzA21BE9kNTI
         buDEqbcT+SC1o/Y7KPwGv7OdwpxrFBqmUC9shoW5GdyeCA4Lub3zxdgcubtYovbqfOxc
         YJPA==
X-Gm-Message-State: AHQUAuZ/3LjbgVZFeOYMIGZz4YRdtES1v+KgbvPZAChIWoZh180gnTVo
        EzOcThcFwamCW+r5MBTmSaU09xr4vf4HhnQBZHezfo/Q
X-Google-Smtp-Source: AHgI3IYjEzlE+PWYy8F5d/BliHsQwnZqjpzxqv8JqKlP1u5f54t+7D4Hh5eJ+F/sqkps+xCnebk1Ce+qXS33molfzEc=
X-Received: by 2002:a63:20e:: with SMTP id 14mr1583981pgc.161.1550081646522;
 Wed, 13 Feb 2019 10:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20190213150810.32750-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VeTwjbdjAXPZfB5B7oataarjG0epV1SzokdYnCj8xcPhA@mail.gmail.com>
 <63bb8cc7-4feb-f69c-33be-ba5308c441d1@linux.intel.com> <CAHp75VdH8G+FfvznZePEG1F5A1Eyh8XF=a-MqpNooLWnBbP+gA@mail.gmail.com>
 <6db89a43-8c69-fc33-a777-61250433fcaa@linux.intel.com>
In-Reply-To: <6db89a43-8c69-fc33-a777-61250433fcaa@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Feb 2019 20:13:55 +0200
Message-ID: <CAHp75VfF_fWtDG=jWJx_-ASCCjV2VGP4hh3HM8LOCEmv3q=K7w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] ICL support and other enhancements for PMC Core
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 8:02 PM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
> On 13-Feb-19 10:58 PM, Andy Shevchenko wrote:
> > On Wed, Feb 13, 2019 at 5:50 PM Bhardwaj, Rajneesh
> > <rajneesh.bhardwaj@linux.intel.com> wrote:
> >> On 13-Feb-19 9:03 PM, Andy Shevchenko wrote:

> > We don't do rebasing for published changes. Only in rear cases when
> > otherwise would be worse.
> > Darren didn't respond to my question what he thinks about this case,
> > but at least it's not related to the code itself which, in my opinion,
> > decreases a severity.
>
> Thanks Andy. So if i understand correctly, you are suggesting that i
> should ignore those patches that made to "for-next" branch already?

I suggest you to rebase your local branch against latest subsystem tip
branch, resolve conflicts if any, test, and only after that send a new
version.

> So should i just send a v3 comprising of remaining 5 patches and of
> course,  addressing recent review comments?

I dunno how many patches you will get after rebasing. It might be 5,
might be more, might be less. You decide what will be in next version.
Just carefully describe the changes in the log.

-- 
With Best Regards,
Andy Shevchenko
