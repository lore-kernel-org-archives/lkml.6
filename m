Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E900C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E778B26E1B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ol3NKKwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E778B26E1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754654AbeFZTIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:08:14 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43810 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbeFZTIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:08:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id c5-v6so7153454wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 12:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vSXP8pr9YrZfpq32KDOcDU58bqTWUULMSUjOB+oqM8U=;
        b=ol3NKKwiDDF2Vuh1Ee5P0rIOzUz2O1+XA4fus5D89gbmWBRCpGqAK1oEBE+OFPj/wO
         nm99Sy4KsR7YMjLX6/ih53AFovWLIA8D5G0DgptNtgDHA9k0ZNeeCvKPP0uRURwdIkDh
         0BEUm3ulQx9di0TsIgqMyp9GuK82uTrJS6iq7d6CovudO+zLBHkOs8jQLoOFgrAbVMBd
         O9NV5c6SnXGKryc98FTCh6YsbmLf6UotIXGS4WM5wY3IN8gnJWk3nH/kPVa9E+CuS5Yp
         d/XiAU2TrqH1fiwIscDPp1YtZSrW5ypaeE2qL5D/NuX9Ie01rflKSSm7fr1oHm8vVD2z
         7sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vSXP8pr9YrZfpq32KDOcDU58bqTWUULMSUjOB+oqM8U=;
        b=lql37QxIXIbYQKaMCgj8EatfmzR1glHObaiJioCcZL1s3k01pmu9ZzqpGe30bZSl6a
         rklndNgUe8oU59oTkHeXUBl5Em0WNO/WOXZsXn2Drs1cckMokFcmwVqb5xsnJrpApAsw
         z1Z2Q2eoKaTYn3P5zwqk17ldgZTE18XhXNZPuC8y4KFfKifPvXeHhrUpBRhSbfxLfRrT
         YExyWIoD6SiUT7hcRegeTHExM2gfSG0K3UV6Us4w4fQ5M0xMKRRTNKKR+J65iVvcLgRa
         eBgnbFwG8CCPun1zYyOOpWzyXejPSruSSgT8VkUQQ9ldDQZe3yqOJg7S3OTkOmrHTp8z
         9d9w==
X-Gm-Message-State: APt69E29BmoFamcP4C1ak+XdJhIlMI142oMjE187La4GXxjoriVae/+7
        O/4nBPzK3vFWmh+D+64NssoOxZo5nUVwbbKShVGe2g==
X-Google-Smtp-Source: AAOMgpdPx2F0jewDKQ5rd57a1rVWKdMiRb/7jNU9qHbFzFSdCuimRBJ68xKMt6B1sGuTOiaOHfAtIiaG9fNaKtjAnf4=
X-Received: by 2002:adf:b3d4:: with SMTP id x20-v6mr2536118wrd.272.1530040089785;
 Tue, 26 Jun 2018 12:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180625230659.139822-1-shakeelb@google.com> <20180625230659.139822-2-shakeelb@google.com>
 <CAOQ4uxiV75+X3dMLS93iXqwmSU6eKPOUocdkXiR7MQZhEjotQg@mail.gmail.com>
 <CALvZod5ARMZL+eD8-mrxeBvxJcuVPXaCwWEgUyQw85xXWxHauA@mail.gmail.com> <20180626185724.GA3958@cmpxchg.org>
In-Reply-To: <20180626185724.GA3958@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 26 Jun 2018 12:07:57 -0700
Message-ID: <CALvZod5aEHcLs3j+AiuC1FppD-AakWhdZdQhzmTSSrktn2Gu0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: fsnotify: account fsnotify metadata to kmemcg
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:55 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Jun 26, 2018 at 11:00:53AM -0700, Shakeel Butt wrote:
> > On Mon, Jun 25, 2018 at 10:49 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > ...
> > >
> > > The verb 'unuse' takes an argument memcg and 'uses' it - too weird.
> > > You can use 'override'/'revert' verbs like override_creds or just call
> > > memalloc_use_memcg(old_memcg) since there is no reference taken
> > > anyway in use_memcg and no reference released in unuse_memcg.
> > >
> > > Otherwise looks good to me.
> > >
> >
> > Thanks for your feedback. Just using memalloc_use_memcg(old_memcg) and
> > ignoring the return seems more simple. I will wait for feedback from
> > other before changing anything.
>
> We're not nesting calls to memalloc_use_memcg(), right? So we don't
> have to return old_memcg and don't have to pass anything to unuse, it
> can always set current->active_memcg to NULL.

For buffer_head, the allocation is done with GFP_NOFS. So, I think
there is no chance of nesting. The fsnotify uses GFP_KERNEL but based
on my limited understanding of fsnotify, there should not be any
nesting i.e. the allocation triggering reclaim which trigger fsnotify
events. Though I would like Amir or Jan to confirm there is no nesting
possible.

thanks,
Shakeel
