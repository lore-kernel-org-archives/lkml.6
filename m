Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADC8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D43620859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gsOTKs4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfBTW0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:26:35 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45870 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTW0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:26:34 -0500
Received: by mail-ua1-f68.google.com with SMTP id e16so8803433uam.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 14:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sDpL3gmbczax8ALdj7IVEn/cdMFCR2mdLaVqooKyfDU=;
        b=gsOTKs4hDJpCcYxXFAhd3Mw19bPjFasvElf6Yd9ikqATCYiclmkqOMIuNsxSoWBTPs
         cvv7KgIQk6dYFFcC6p6vp/e6zA3KSvygM6ZzD1xDWenkLj9Umc2pmNvwwnaR2e9iG5Eh
         /zlPXUrpCbDsPF9sQP3jSKppTz0LqL6aRU0M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDpL3gmbczax8ALdj7IVEn/cdMFCR2mdLaVqooKyfDU=;
        b=cgA2JCjtL82ODVc7Lu+pwdgNTBx2eiVBJJk9gm5IqQwILGaW+0uEMONvyrFHfZrvUd
         MxY4QVgAnRuY3Ih6sr1K3cLLX+wy4J82JFiUt8ohAJqaFFaH31/0VFzyIepAKftzSlAN
         0Wd7DT/6jqe4BgYJ6aRuqmcinlpFW0BG250f3S99WIwVCp5phWlphFAjzWIBzukUeLJp
         C/XU8llLOLQSil7b+aLIlfxj5HLBKF65mLcdgNL3lliqfm60jgvDw6itBgQ9YCaASCif
         5hxcnpn/moQj9GKzoRpnD8dtyxvw4+ziFfJGuCPi/PLEB1CEud/qf2rUU7UKqbs7mggS
         is9Q==
X-Gm-Message-State: AHQUAub45vSkt3bl9GXPVGv29Rb847CLUGtRmlz57N2mARGh9pshdqGH
        s/TtGELHNdQvXLbZuNm0ELdpjcJ5VgE=
X-Google-Smtp-Source: AHgI3IalhHrTS7MmAQEjF9878pHAE4QtWUD0BtsJaXF7cLE09TJboUls8jVFznOTLq+WqLgglYN5BQ==
X-Received: by 2002:ab0:60c1:: with SMTP id g1mr8367506uam.23.1550701592076;
        Wed, 20 Feb 2019 14:26:32 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a68sm17745442vsd.24.2019.02.20.14.26.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 14:26:30 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id m20so14495971vsq.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 14:26:30 -0800 (PST)
X-Received: by 2002:a67:ec81:: with SMTP id h1mr19076075vsp.188.1550701589790;
 Wed, 20 Feb 2019 14:26:29 -0800 (PST)
MIME-Version: 1.0
References: <20190211181531.GA3238@embeddedor> <CAJKOXPeHp7sKkZ+jXmTXk5GEF_7G5ujfm3Lw==G3T4thfD+F7Q@mail.gmail.com>
 <CAGXu5jLMWrb4Dszv5YSyoGt5Lb3S1oE8EnKsTou7=7Nq1rEEVQ@mail.gmail.com> <155027728836.115909.11546859472583324712@swboyd.mtv.corp.google.com>
In-Reply-To: <155027728836.115909.11546859472583324712@swboyd.mtv.corp.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 14:26:06 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJPfoYy20WrR5ghaSo88bsA75s-OyA4qt_3Vz0cJST_MQ@mail.gmail.com>
Message-ID: <CAGXu5jJPfoYy20WrR5ghaSo88bsA75s-OyA4qt_3Vz0cJST_MQ@mail.gmail.com>
Subject: Re: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 4:34 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Kees Cook (2019-02-12 10:57:05)
> > On Mon, Feb 11, 2019 at 11:41 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > It is just the GCC which has to be fixed not the code. You want to
> > > adjust the code for specific version of GCC and what if GCC changes
> > > its warning? For example GCC might require "fall through: "... or any
> > > other syntax. Another point - what about clang's syntax?
> >
> > -Wimplicit-fallthrough=3 is stricter and maps to -Wextra, hence its
> > choice. GCC's levels were chosen based on the existing linters, static
> > analyzers, etc. The patterns are unlikely to change (see the gcc
> > man-page).
> >
> > Clang doesn't recognize anything in C mode (hopefully this will be
> > fixed in the future[1]).
> >
> > As long as one of the compilers is able to check this, we'll avoid the
> > bugs associated with this mis-pattern. Gustavo's efforts here have
> > found kind of a lot of bugs, so I think it's worth a little churn to
> > add these (and make minor adjustments to existing comments).
>
> Just curious, what compilation phase does this check run in? Could we
> gain a macro like FALLTHRU or even lowercase 'fallthru' that expanded to
> whatever the compiler wants to see and then there would only be "one
> way" to do this?  It would alleviate the above concerns, but maybe I'm
> rehashing something that's already been proposed and rejected.

When this got discussed a while back, the thinking was that since
we're also dealing with static analyzers (e.g. Coverity) and IDEs that
literally parse comments in the code, it was most sensible (at least
for now, prior to there being a formal C "fall through" statement --
there is for C++ but not yet for C), we'd stick to explicit comments.
In theory, we will be able to do a tree-wide change to add the C
statement once it exists.

> Of course, I'm happy to merge any of these patches that tweak things so
> no worries either way.

Thanks! :)

-- 
Kees Cook
