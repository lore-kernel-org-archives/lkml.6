Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76175C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C2421873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4CND8zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeLRTBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:01:49 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34052 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeLRTBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:01:48 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so14824269ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aVvKRasEcMJmG+26dfvEoDyzu5fKSKEiXYvCB/g791I=;
        b=L4CND8zfnNTXlCi1HRwbGJwObKwEN02g3AUN1VYsskQmYZRklYse8GZGCvZk3MTOAA
         acZoUDH5KBZYAlqeGny0bpKgprzRMf37n+Nv/gxGqkw0XVIyGxA4nF7BDzcQW3OZEStZ
         dmvUVzrj0Mdcy6swf5PEhVZ5z626Qw5IXJZPdESr3rcUUORVoJwfVOPJyS5gRChyRWtD
         4H6SPhYwshKaygHwHnAqe1DxhfDsPObI9mJ3GULifY2OdOghxZbz9J3lmQZz344wnsTv
         mc0vZxWOKbfMT2kmBxPLZMQEWLLZQaW0WxkvfswBzOZtL1R6vjEonaFvAxAhoIw5P5V1
         HNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aVvKRasEcMJmG+26dfvEoDyzu5fKSKEiXYvCB/g791I=;
        b=f3Pl/0W63cV5+x2YBStwGXgpBJJoG4KVrkc9B5tpr1LFlXDDLBX7VsxijX9NjZlZNO
         6onZw85aWDcuA5c6veKIvupbSIiB/IvEdYxShkkuTD+HN82idHnAYUryvWobbJEHBbNJ
         WgJwdYUUdDVI3aAlL+PD4y1fP0/xpKjiuEP0oI1/nyKX3KLjlXczPsp/GZdFGZq9p+9H
         /GPRkaZCymNZeUuuYgwth+/6aWrsGq6pHEAcCTZmCiv3EBZBKe96BRBuryj3FdsS2AW3
         Fomr8Wg2BQKp4I3ErKfqoCcMYRYqO2O6gjARERK8rHDrpcTrd5OGZQSlmq5I30QdqOHt
         NzsA==
X-Gm-Message-State: AA+aEWZsViDm+ullnlbbfhHNa//J/4aq0k4MUlzBQ/a00lGq3Kg5yucN
        4c02vFf3uHKbH14D7hraft4=
X-Google-Smtp-Source: AFSGD/U7ldUetxxDudPvfiKIvumgfryQoKY6n0XM+XkECmX0d9Cijcvlx6xJ7KTx8CULT4uFglqAlQ==
X-Received: by 2002:aa7:c0d0:: with SMTP id j16mr16956465edp.173.1545159706533;
        Tue, 18 Dec 2018 11:01:46 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id p36sm4844960edc.78.2018.12.18.11.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 11:01:45 -0800 (PST)
Date:   Tue, 18 Dec 2018 12:01:43 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] drm/i915: Disable -Wuninitialized for intel_breadcrumbs.o
Message-ID: <20181218190143.GA7036@flashbox>
References: <20181025193601.11746-1-natechancellor@gmail.com>
 <CAKwvOdm2r8bfXQCBiUjnQNnCs8ETxzYQHK4ZjMrfLyRvw77zAQ@mail.gmail.com>
 <154513398652.1108.7150969916024071452@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154513398652.1108.7150969916024071452@skylake-alporthouse-com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:53:06AM +0000, Chris Wilson wrote:
> Quoting Nick Desaulniers (2018-10-25 23:20:58)
> > On Thu, Oct 25, 2018 at 12:36 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > This warning is disabled by default in scripts/Makefile.extrawarn when
> > > W= is not provided but this Makefile adds -Wall after this warning is
> > > disabled so it shows up in the build when it shouldn't:
> > >
> > > In file included from drivers/gpu/drm/i915/intel_breadcrumbs.c:895:
> > > drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c:350:34: error:
> > > variable 'wq' is uninitialized when used within its own initialization
> > > [-Werror,-Wuninitialized]
> > >         DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
> > >                                         ^~
> > > ./include/linux/wait.h:74:63: note: expanded from macro
> > > 'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
> > >         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
> > >                                ~~~~                                  ^~~~
> > > ./include/linux/wait.h:72:33: note: expanded from macro
> > > '__WAIT_QUEUE_HEAD_INIT_ONSTACK'
> > >         ({ init_waitqueue_head(&name); name; })
> > >                                        ^~~~
> > > 1 error generated.
> > >
> > > This warning looks to be a false positive given that init_waitqueue_head
> > > initializes name before it is used. Rather than disable the warning for
> > > the full folder like commit 46e2068081e9 ("drm/i915: Disable some extra
> > 
> > cc author/reviewer of 46e2068081e9.
> > 
> > I'm fine with the patch as is, unless others prefer to disable it for
> > the whole subdir?  We could be playing whack-a-mole in the future
> > disabling this warning for other translation units.
> 

Hi Chris,

> Yes, exactly this since the warning is generated by a core header and a
> fairly common pattern its use is not restricted to any single file.
> (Will not all selftests similarly explode?)
> 

Well, -Wuninitialized is turned off for the whole kernel unless W= is
passed. So I suppose it should be turned back on for the whole folder
but I noticed that the i915 Makefile purposefully turns all of the
disabled warnings back on for heavier coverage so it makes some sense to
just leave it off for one translation unit when it's just one
translation unit that has the problem. That said, I'm more than happy to
send a v2 turning it off for the whole folder if you think that best.

> The other false-positive clang-6 gave was for local_clock_us().
> Presumably that one is fixed?
> -Chris

With this patch, I can build i915 using defconfig and allyesconfig
without any warnings with tip-of-tree Clang.

Thank you for the comments!
Nathan
