Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FA3C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3419A2082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SW6OL2+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3419A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLDABE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:01:04 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46574 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeLDABE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:01:04 -0500
Received: by mail-oi1-f195.google.com with SMTP id x202so12635917oif.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 16:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PdAgZOPdB+ezFEReJg450c2Q1PATho8C2nnY6yeLpHU=;
        b=SW6OL2+JUY3TO56fKCb6in2Mi+rXqv6ybjVPdh1bR0ZOpV+cZcAZWBkFx2I88IwrzG
         0DnoOxyyoKgaU/BjY4ZteirNWagyuqR17Fp7sdCHe25EVFMIZDUPx241oLZ0I9JBO6kh
         AQkS66T9m4Zywa9M5ozPlj5wOHn2E0kZ3+0K3OD710j+DnWX0629Y5QyXGa8RTrABeaZ
         QLqmvoLieVrs/YiJE1DmwF8FDsYoRP1zh0FoDD1UUUy9clIpg52QC5lIpbe49pBJrlU3
         lvJCG/t14hvNCCe39maVRUhB9cWgqYIHzQUAdIktff9eCZb9EIvoU3meTn9DwXvMYO7d
         QaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PdAgZOPdB+ezFEReJg450c2Q1PATho8C2nnY6yeLpHU=;
        b=In0TlHrhA1tOO4ikFdJ5YuU7qR8F1YPWv+kz5EzgjJCQUlH852r6nQbD8WpGh5jQxV
         HSiMd4k6siqcuol5h7/35XEWXvlJx2gHeDwOOEa+5XpN+G/tMM7TbKcQ3tNhM/CFW+k7
         LeEtg0X0TFy2jmrmog4CIN5RFvlJD3qAy2y3+L407KZyNNVDxZckxXRAseyJHyQq+nWG
         ofaEmisOGVPKvS5dQPZV9DmbAv0Q46SVuDN7gxI7fGzgY3LcFwRehdQBwhYn/MYsmoNC
         Xp6pm1e9gziMtSXvPf8CIPwNjq7benr9baGKaQ9vvuYiczI5MzsLf8O1E/mI4b/saqzk
         tBAw==
X-Gm-Message-State: AA+aEWZScLmrYV8BlEchKyCinTHG4GYMWUzfEcjOvlukVdkVBKW+Wd6U
        ElyVcyreFjn9ppIvYHO7OmExEw/PywfSzbnQwybfhQ==
X-Google-Smtp-Source: AFSGD/UORkE5mO5+gcjuNE5NYrqAYkZjCAald8aaDg54DWJmwK4H79orBYCgIGyToSKYhqsCwjCHynG/5eB4KLclfLw=
X-Received: by 2002:aca:c4d8:: with SMTP id u207mr10824732oif.30.1543881662166;
 Mon, 03 Dec 2018 16:01:02 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-17-brendanhiggins@google.com> <CAL_JsqK5cG=QzMBFSZ31_-3ujnxqxv=jj3XYajbRLT7yWYZbfw@mail.gmail.com>
In-Reply-To: <CAL_JsqK5cG=QzMBFSZ31_-3ujnxqxv=jj3XYajbRLT7yWYZbfw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Dec 2018 16:00:50 -0800
Message-ID: <CAFd5g44vWXpY_N80UcAKVkgYQkBLP0qOV1=kwPyxcH4umOf8dg@mail.gmail.com>
Subject: Re: [RFC v3 16/19] arch: um: make UML unflatten device tree when testing
To:     Rob Herring <robh@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, kieran.bingham@ideasonboard.com,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 1:16 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 1:38 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> > diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> > index a818ccef30ca2..bd58ae3bf4148 100644
> > --- a/arch/um/kernel/um_arch.c
> > +++ b/arch/um/kernel/um_arch.c
> > +#if IS_ENABLED(CONFIG_OF_UNITTEST)
> > +       unflatten_device_tree();
> > +#endif
>
> Kind of strange to have this in the arch code. I'd rather have this in
> the unittest code if possible. Can we have an initcall conditional on
> CONFIG_UM in the unittest do this? Side note, use a C if with
> IS_ENABLED() whenever possible instead of pre-processor #if.

Yeah, that makes more sense. I will send a separate patch.

>
> I'll take a fix separately as it was on my todo to fix. I've got the
> unit tests running in a gitlab CI job now[1].
>
> Rob
>
> [1] https://gitlab.com/robherring/linux-dt-unittest/pipelines
