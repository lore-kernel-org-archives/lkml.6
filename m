Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F46C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543492186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crc5LZWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfBFRam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:30:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36910 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBFRam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:30:42 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so8098126iti.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5MD26BBKvAItyYxLe+zAjYHyLxzZQedEnSOItHVT1ew=;
        b=crc5LZWXXlWsEeUtNyA18m6xlrjoODFf+h4/pc/E0+AQvngZOUuXPiEpGGU646IVDF
         LL+iX/r4JF3e23tul6OG/D1fZgwm3JZ0q3DWm157q3PUonAyiQhSH1YDcTQTPnwU8yK8
         Wmj0K/gnOJgIK4pzi1Z0ufRiSkVUrkdroiGKec4tJCVhO+uMeTrjJHst9LNi8ITt9TDu
         YxQPfS5q9iWIaHo2oX3bFWqhFQ3TpF3JcnmrYi7q32UDLXFJb3NCEBHB3KvyFqKSogDG
         x/o/hD7971KCj431PKt2fs6KcbUVxeZiiEAdT1UorRcg3irVkVIK4TJgSz+x+w47kUts
         /+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5MD26BBKvAItyYxLe+zAjYHyLxzZQedEnSOItHVT1ew=;
        b=DAC8SzdCv7NusuFOkmVmirPqa2NUqNFr8CGMhiQbH4syaOq+466tzSSXTMttCxfvRU
         ID14ImB+S3qDD4nEc4fbbH05j4E/yFqN0rpR7M4gnhX1/Ztc49iPeQidOvfgsmP7CIZo
         skPY9adxdyhgSj6ih1FQS4+T7ls1u5w/X3rGOlyruoqvWSWX28yTlgVs2DxiPaghGPoo
         mK6+p5W96hUgwP8hEjyaJxzB+LVXBeT+x5RdvOGm2xnc38T3J3FlBbEVBQ3b3R321l05
         pXm9VZlCFt1jOMP0aVNFaN/pdzeiBauU7mrhwfz7CN80p7EuA6SFnpaqBqe+IRvijwSp
         lbbQ==
X-Gm-Message-State: AHQUAuZBDwQPG9VawPrPLbP7WnZblHqjWumSVt5MO0yF/5oRGfYcwZp6
        4SsecyGk+3GOkixRnStAFPb259t7NnfEzDvmOHuuIA==
X-Google-Smtp-Source: AHgI3IaZqd9QVvnnUAcFDjZ3k9avrX2zAynA2LgeQQwCbREUwMk5eh0WQnXPlnHuKxV8OXtjEj/JJrwl3tvUFA4CzTE=
X-Received: by 2002:a02:1217:: with SMTP id i23mr6447098jad.53.1549474240746;
 Wed, 06 Feb 2019 09:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
 <CAGngYiUsq55EUKa0rYCeQ62VanhwNUxs-pfkJxUwqd4HO3m-Lg@mail.gmail.com>
 <20190205184355.GC22198@kroah.com> <CAGngYiUMuM_ZxHKVWRihDHZcMncvTwR6Sz1zGNJLrGpyhhT1uQ@mail.gmail.com>
 <20190206164657.GC8466@kroah.com>
In-Reply-To: <20190206164657.GC8466@kroah.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Wed, 6 Feb 2019 09:30:29 -0800
Message-ID: <CAKdAkRQbCj59_Cw2RqpyDEU2zzn4ajOjXF44NE2LJ7QB8-DLtw@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 8:47 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 05, 2019 at 02:12:31PM -0500, Sven Van Asbroeck wrote:
> > On Tue, Feb 5, 2019 at 1:43 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > >
> > > It really should happen when the device is removed (if it is a driver
> > > that binds to a device.)
> >
> > Absolutely. That's why I'm advocating adding a devm_init_work(),
> > which will take care of this automatically.
> >
> > But it's of course not universally applicable. Not all drivers use devm.
>
> Ick, no, watch out for devm() calls.  Odds are this is _NOT_ what you
> want to do for a device.  Remember when devm calls get freed (hint, not
> at driver unbind/unload, but at device structure removal.


??? We unwind devm on probe() failure and after remove() is called.
The device can live on.

>
>
> By creating a work queue, you are suddenly tying module code to a device
> memory structure lifespan, both of which are totally independant.
>
> It's the same issue with the devm irq call, that has been nothing but a
> nightmare as everyone gets it wrong.  Try to learn from our past
> mistakes please :)


Yeah. But devm irq gave most trouble because we did not have enough
devm APIs so we often ended up with mixed devm/non-devm usage and that
is what was causing most of the issues. If we can switch everything to
devm then devm irq is not that troublesome.

I have 2+ drivers that currently use devm_add_action_or_reset() to
install action canceling work, they could be switched to
devm_init_work().

Thanks,

-- 
Dmitry
