Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47D2C282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 07:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75641218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 07:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CClxPR+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfAZHfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 02:35:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42215 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfAZHfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 02:35:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so5578509plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 23:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Zu3iJppXldVBVez87nYuBocwMsNFARnj63T7E5Tedc=;
        b=CClxPR+dHEr+5x/9Qq670Uq1gtIITPI94xoEJov0aW8McWwKu7N87/DWSBXxH6tAG2
         dWsCqANaKefd6OAHisFhyEnXgoDPFVvizbRZ4OYTiDhn2TPpZD2ZGxBoMuDOVQ/77WPB
         0ek/dYG5UIe43urXO3gxh0RYwxM5djHgfQQ6hnK/p4A8Wn8GsH5V7BZJ392SWOtKcz+F
         mNeYrZXSfcSqH+FbMf0d0SRl7Wnbfmfq6c/A6oXeWNYxgH84dpV2sxCYCjzexTGI64iY
         FoTP/NH06uEmUGLZAxhhR68QPpVoy2nP/vLLA9lCOB06yiRi6i4LT+RBs8b/tjdVZCcI
         KHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Zu3iJppXldVBVez87nYuBocwMsNFARnj63T7E5Tedc=;
        b=WKHaE15k7HL7/8CsC6/TFwQ8boPudheFNxjaIHGZRbkSGT/aF8MJrOyqHWbmQzh5F6
         91JnjxZF1CEDgTepCJVvIgRTgk11wzoYo7KbkwBjtq6VEMBnyHHxrhNOyosXd3E+lz87
         lgEoPgaoX92ocVpvmaDaXLIEmnr/eLFnaU10r11ayXrdxjjH0I1qCwjRrSMV3SJdim7n
         DoTsZcj0DqqT3FjULMy0hXI7vABpZ9ZP16Z0+Gj4NSfJkxIOa8DcexH+AdtEjEiPP++W
         NPYaimustLm78tV8dXX7Yn2ilvHjA1waUTGYjYMqZBzoAnv/iL7+iudxk4diO7xH4p6k
         gIog==
X-Gm-Message-State: AJcUukeUriG1KuDC15MNZLtYTX5qi3h1Ny17BBTHTuAcibfle/uzHLP3
        lxdDn211N8AtNbsGQYFsEV1PyTqcFKs4yWNICRDmvg==
X-Google-Smtp-Source: ALg8bN4XiIwjG7CCNZifFudmlP2cXUZTNNB0vz9BSvobr87OH/Rzst3aMWPLg0hxiFBWdfl7RuQ87C2EMKT0W7s7OJU=
X-Received: by 2002:a17:902:7b88:: with SMTP id w8mr14082098pll.320.1548488116306;
 Fri, 25 Jan 2019 23:35:16 -0800 (PST)
MIME-Version: 1.0
References: <20190126071122.24557-1-natechancellor@gmail.com> <CAKwvOdmA6075WEPaKkL9d1wUQmboU9CxhbNT1oiVk8_Onjh5Rg@mail.gmail.com>
In-Reply-To: <CAKwvOdmA6075WEPaKkL9d1wUQmboU9CxhbNT1oiVk8_Onjh5Rg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 25 Jan 2019 23:35:05 -0800
Message-ID: <CAKwvOdk+XKA52ohj5oU7d9QbHDdXaHYe8M5WaV+yq5vWTm6VKg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915: Disable -Wuninitialized
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:34 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jan 25, 2019 at 11:13 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > This warning is disabled by default in scripts/Makefile.extrawarn when
> > W= is not provided but this Makefile adds -Wall after this warning is
> > disabled so it shows up in the build when it shouldn't:
> >
> > In file included from drivers/gpu/drm/i915/intel_breadcrumbs.c:895:
> > drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c:350:34: error:
> > variable 'wq' is uninitialized when used within its own initialization
> > [-Werror,-Wuninitialized]
> >         DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
> >                                         ^~
> > ./include/linux/wait.h:74:63: note: expanded from macro
> > 'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
> >         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
> >                                ~~~~                                  ^~~~
> > ./include/linux/wait.h:72:33: note: expanded from macro
> > '__WAIT_QUEUE_HEAD_INIT_ONSTACK'
> >         ({ init_waitqueue_head(&name); name; })
> >                                        ^~~~
> > 1 error generated.
> >
> > Explicitly disable the warning like commit 46e2068081e9 ("drm/i915:
> > Disable some extra clang warnings").
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/220
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>
> Reviewed-by: Nick Desaulniers <nick.desaulniers@gmail.com>

gah! I am on my work device, in that case it should be:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> probably could give Chris Wilson the suggested by tag.
> https://lore.kernel.org/lkml/154513398652.1108.7150969916024071452@skylake-alporthouse-com/
>
> > ---
> >
> > v1 -> v2:
> >
> > * Rather than disable the warning for the problematic folder, disable it
> >   for the entire folder like Matthias's commit.
>
> Thanks for following up with a v2.
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
