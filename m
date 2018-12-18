Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF97C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1E1214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545091414;
	bh=D8jHlLjmXRxzcTIvW3TxZ7ZbPhavp+ZGARFcFcLCZwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B2QLC4OPrhWHbtpHqjvxFd8wK8NIxr7RudwrCg9igZcUmMB1galncWeVQYh4e7cRW
	 1Xo/4K7re3eqoavkagm1fE0XvtaD+bsBJUAb4Yky/jrArvPav9pEn+JNgNeY6+rjG6
	 aUXorR/orWCAQicMM+Dt4neFz0FtKhlBZJnjnXeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeLRADd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:03:33 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39058 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeLRADc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:03:32 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so13980395otl.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIFMyLgmyom6suLlz/HLtiekX9eZbEG7ouiW+z0GYjE=;
        b=hDjQLVYMH/jpMH0en46cQsURai21MvyleZYSJkMsoy5YfD6sGiaihuYeUbJgOE6XgC
         v+8mEvdzrc5WAC1pGb/lhyqobIW1Ct+3SnYXVbWhn+ZtK8PprEZElT4B5rfFieBbp73H
         LPnlTA8PO1GixjIprG2jCqv2yhoEgNHdpoB4Ko9BS1dTGl5W/sKWHjFyQXucGVHslcT/
         dFItP5FnrxGOSL93/g8V3vz9AKdZ4gb+JLF8VIIsCC0f35hVbbZnHhu+bccqE79WkrV+
         e8QKXQuO2qTgqs4vVcnQW/u7w8UGrEsSPxPbP2ZBbcP1kReQE4Unr9X/HqerWSk7oP71
         YxFg==
X-Gm-Message-State: AA+aEWY9EhhiO2g+sE5y7+RzcGUmR10a3v3KtkXyuToylyeyYZCjhe/t
        z8Zei0oIdmsUV8IeZfu6kIfSXseodWQ/4gr/4dsQ7w==
X-Google-Smtp-Source: AFSGD/WHeZZvStKyJEIUILLvwN6x9Yfan8ILd1Athn2CAsJUmJmIhwQO164C7K3JDxO3yrWZfbQFUBy16ClSg7V1oDI=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr11351895oti.258.1545091411581;
 Mon, 17 Dec 2018 16:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20181210084653.7268-1-daniel.vetter@ffwll.ch> <CAJZ5v0jkE=Rt2ozwcTxRdUN++Sr4HXULksDeMx4jEWj1jVDcyA@mail.gmail.com>
 <20181213095814.GC21184@phenom.ffwll.local> <CAJZ5v0iWshem3kuurF53gutVJ8jFm_caAbetK2CiSCpyc6ReeQ@mail.gmail.com>
 <CAKMK7uF7noCEgwE0QYZWQFx-OPxipAF1MojUZ8KTo_SXfQW8+w@mail.gmail.com>
 <CAJZ5v0g+-R8tbbJscL-3s23UPhyNX1v1Lj3aC=QdUBzdSCrspw@mail.gmail.com>
 <CAKMK7uHACB5-ak0b_BT-HoAmXHZ9EaCNTt7WuqckNWKQM-g2fQ@mail.gmail.com>
 <CAJZ5v0hOiL1oWGCmFv2N8-0UvCibXz02DhdFMyUQsQZ1hDjV=w@mail.gmail.com> <20181217194804.GJ21184@phenom.ffwll.local>
In-Reply-To: <20181217194804.GJ21184@phenom.ffwll.local>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Dec 2018 01:03:20 +0100
Message-ID: <CAJZ5v0gVURXg4-OGDiOo-CR8CFymSJ76Hf6TOJJJB985WjnLHw@mail.gmail.com>
Subject: Re: [PATCH] drivers/base: use a worker for sysfs unbind
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ramalingam.c@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 8:48 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, Dec 13, 2018 at 07:09:15PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Dec 13, 2018 at 5:25 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > >
> > > On Thu, Dec 13, 2018 at 5:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Dec 13, 2018 at 1:36 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >
> > [cut]
> >
> > > > > I can do the old code exactly, but afaict the non-NULL parent just
> > > > > takes care of the parent bus locking for us, instead of hand-rolling
> > > > > it in the caller. But if I missed something, I can easily undo that
> > > > > part.
> > > >
> > > > It is different if device links are present, but I'm not worried about
> > > > that case honestly. :-)
> > >
> > > What would change with device links? We have some cleanup plans to
> > > remove our usage for early/late s/r hooks with a device link, to make
> > > sure i915 resumes before snd_hda_intel. Digging more into the code I
> > > only see the temporary dropping of the parent's device_lock, but I
> > > have no idea what that even implies ...
> >
> > That's just it (which is why I said I was not worried).
> >
> > Running device_links_unbind_consumers() with the parent lock held may
> > deadlock if another child of the same parent also is a consumer of the
> > current device (which really is a corner case), but the current code
> > has this problem - it goes away with your change.
> >
> > But dev->bus->need_parent_lock checks are missing in there AFAICS, let
> > me cut a patch to fix that.
>
> With your patch before this one, are you ok with mine? Or want me to
> respin with a different flavour?

Having reconsidered this a bit I'm leaning towards annotating the
locks - if that works.  After all, what is problematic is the lockdep
false-positive and addressing it that way would be most natural IMO.

Thanks,
Rafael
