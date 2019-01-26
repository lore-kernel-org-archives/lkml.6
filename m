Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63F7C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA88A217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfAZRJW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:09:22 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:61579 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726070AbfAZRJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 12:09:21 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 15361170-1500050 
        for multiple; Sat, 26 Jan 2019 17:09:16 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190126075749.GA30117@archlinux-ryzen>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20190126071122.24557-1-natechancellor@gmail.com>
 <CAKwvOdmA6075WEPaKkL9d1wUQmboU9CxhbNT1oiVk8_Onjh5Rg@mail.gmail.com>
 <20190126075749.GA30117@archlinux-ryzen>
Message-ID: <154852255129.15238.871669857659377262@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v2] drm/i915: Disable -Wuninitialized
Date:   Sat, 26 Jan 2019 17:09:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Chancellor (2019-01-26 07:57:49)
> On Fri, Jan 25, 2019 at 11:34:19PM -0800, Nick Desaulniers wrote:
> > On Fri, Jan 25, 2019 at 11:13 PM Nathan Chancellor
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
> > > Explicitly disable the warning like commit 46e2068081e9 ("drm/i915:
> > > Disable some extra clang warnings").
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/220
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > 
> > Reviewed-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> > 
> > probably could give Chris Wilson the suggested by tag.
> > https://lore.kernel.org/lkml/154513398652.1108.7150969916024071452@skylake-alporthouse-com/
> > 
> 
> Ugh you're right, completely slipped my mind.
> 
> Suggested-by: Chris Wilson <chris@chris-wilson.co.uk>

Ignorance is bliss. Applied to dinq, thanks!
-Chris
