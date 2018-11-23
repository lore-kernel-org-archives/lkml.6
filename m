Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BA1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA8C20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="D/+LEI7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA8C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504471AbeKWX5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:57:06 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41731 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390867AbeKWX5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:57:05 -0500
Received: by mail-io1-f68.google.com with SMTP id s22so8748581ioc.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 05:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pp/Z+h9nD1AtF0u37xW2WawLjTdUlyrsMPEdN1CHzEo=;
        b=D/+LEI7IIRXnPuR0a/M22VHp9mzH7iOIWWTu9U8SS4O5lgoUkXa/uE/eAxLCuY7tUK
         3xFnZ7cc9Ke9sOWiUVJ0TPKDQD00QI0bDIvyfRb39jC6iGET785xUfo9rvqBO9hbOGu8
         Y5dR3YlJuRufmU9WcVrjxVtssX3YsjjE7MDUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pp/Z+h9nD1AtF0u37xW2WawLjTdUlyrsMPEdN1CHzEo=;
        b=meEoai/z5Ka7xA1W8kLH4EmKysb6wSDRY6Z48JRwK/PZTW86gvAi1Us3/58g+7DauT
         ClFzpPuTAkiNO+KEA4RpQiobci+g9tIlDGvRQl37Y2VmYAUiNFsjgcPLOWqeE71aCER5
         zvw4ue/QX4m4RjrBC5gMY5rZPgwGP1l6zIExCOWH50D/l7aQI50uFWwUM98ts4TVLOBO
         3XPZDUYKVtrz7LTNAZRxFBvkCbWULEsO+E7Fqo/8oCy0VqHaNnK/qjiJEBb0dFj0FbmY
         Wr22qbxIU8Ujwnv6CvJuGjRFoxaLaWWcHMCtt6mV0cLBWCNn8S1jS5VESp9fvivkpX1o
         ytvg==
X-Gm-Message-State: AA+aEWbQfHPPdUInFtSTZXSM/5ir4jQlEw1kiDi47efMwF+3z5dJUSGq
        H2OC6JVUI2/sE4Ra4IICvYBNRh1Ezvr4Z8ZkqmbvqQ==
X-Google-Smtp-Source: AFSGD/X1/WJmovfD0ryl5eN0NgvHlhhUSdFQLXKQ8i823q92XvfeD96+GPgppMdWwKaDGoPV+/h/Sf0yJDsDNU2q7v0=
X-Received: by 2002:a6b:b642:: with SMTP id g63-v6mr12326078iof.34.1542978776623;
 Fri, 23 Nov 2018 05:12:56 -0800 (PST)
MIME-Version: 1.0
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-3-daniel.vetter@ffwll.ch> <20181123111237.GE8625@dhcp22.suse.cz>
 <20181123123838.GL4266@phenom.ffwll.local> <20181123124643.GK8625@dhcp22.suse.cz>
In-Reply-To: <20181123124643.GK8625@dhcp22.suse.cz>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 23 Nov 2018 14:12:45 +0100
Message-ID: <CAKMK7uGv7dHqE4_Gmsum=uhfbVo=ymq-QhsR5cHLOC4ZTq4MxA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm, notifier: Catch sleeping/blocking for !blockable
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 1:46 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 23-11-18 13:38:38, Daniel Vetter wrote:
> > On Fri, Nov 23, 2018 at 12:12:37PM +0100, Michal Hocko wrote:
> > > On Thu 22-11-18 17:51:05, Daniel Vetter wrote:
> > > > We need to make sure implementations don't cheat and don't have a
> > > > possible schedule/blocking point deeply burried where review can't
> > > > catch it.
> > > >
> > > > I'm not sure whether this is the best way to make sure all the
> > > > might_sleep() callsites trigger, and it's a bit ugly in the code flow.
> > > > But it gets the job done.
> > >
> > > Yeah, it is quite ugly. Especially because it makes DEBUG config
> > > bahavior much different. So is this really worth it? Has this already
> > > discovered any existing bug?
> >
> > Given that we need an oom trigger to hit this we're not hitting this in CI
> > (oom is just way to unpredictable to even try). I'd kinda like to also add
> > some debug interface so I can provoke an oom kill of a specially prepared
> > process, to make sure we can reliably exercise this path without killing
> > the kernel accidentally. We do similar tricks for our shrinker already.
>
> Create a task with oom_score_adj = 1000 and trigger the oom killer via
> sysrq and you should get a predictable oom invocation and execution.

Ah right. We kinda do that already in an attempt to get the tests
killed without the runner, for accidental oom. Just didn't think about
this in the context of intentionally firing the oom. I'll try whether
I can bake up some new subtest in our userptr/mmu-notifier testcases.

> [...]
> > Wrt the behavior difference: I guess we could put another counter into the
> > task struct, and change might_sleep() to check it. All under
> > CONFIG_DEBUG_ATOMIC_SLEEP only ofc. That would avoid the preempt-disable
> > sideeffect. My worry with that is that people will spot it, and abuse it
> > in creative ways that do affect semantics. See horrors like
> > drm_can_sleep() (and I'm sure gfx folks are not the only ones who
> > seriously lacked taste here).
> >
> > Up to the experts really how to best paint this shed I think.
>
> Actually I like a way to say non_block_{begin,end} and might_sleep
> firing inside that context.

Ok, I'll respin with these (introduced in a separate patch).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
