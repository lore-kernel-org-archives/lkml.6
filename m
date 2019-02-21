Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B403C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFFF20818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jribNhnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBUWXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:23:36 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35589 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfBUWXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:23:33 -0500
Received: by mail-ua1-f65.google.com with SMTP id f88so221159uaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Tho6tIvUAYXamApnhuj/cUi3XD+QjFAtPYIAiUbXtI=;
        b=jribNhnqegu9qG91m4As5lZqDEGL7Duow2YEhm51aIDUM1n4ejizLIN230nxNTGUV3
         WNuBmGxc0U3zfJ5RqfH+qscO5StQmvwdbWrsa/KQAspcpRnNAlk5itPT2kac+7RiylfP
         WmFlHD8fQWl+q+blAKtgBaE/bTqgrjEEfBUME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Tho6tIvUAYXamApnhuj/cUi3XD+QjFAtPYIAiUbXtI=;
        b=NjMghEmDnNauKdnPz3t1VfNBsgb0lV7ClLesxDZeqJxqm5aPW3qzJjBj8mS0r3i16j
         JDzQ58G3MpAkm2T89h+bCuwbe5qzQDsEghryOhe1ruiv0okWn3aJzD0K4SXhaAL2d4UC
         94YfmuGbsokGojwRNsHVrl8nn0BzcHpBqb+hBy9GaoK2OFT71Mu394DqvSuHj7VBEwbk
         l8DQnqgLg0TRHIcA5D9x8EXlkUc0bSvc5hVPTY3w8IY3xtIU8wLrq876vDWybnf5Mt98
         puAAvL3mcewKU7HsY/4pET4aQObpangzCUT6zbz90e2wYiyOH1D3fq/P7MUsxErvxe2l
         7s8A==
X-Gm-Message-State: AHQUAubrniqlPSYHDhiDaWa0sb+6h7fApBsm4Oh/7DHY/vUv1/M7gTsf
        AaYPZ3MxZDZABLjZ+ZzJ6U+6e8VjcdM=
X-Google-Smtp-Source: AHgI3IYFN6Nk3uAcBYyS6A9E2LojQug9Z6eY4twdkLq6g+7hAUiaK8nUpAx26PI/v2u98ax8KanQJQ==
X-Received: by 2002:ab0:49ee:: with SMTP id f43mr497107uad.29.1550787811781;
        Thu, 21 Feb 2019 14:23:31 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id t133sm149481vsc.8.2019.02.21.14.23.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 14:23:30 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id x140so56201vke.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:23:30 -0800 (PST)
X-Received: by 2002:a1f:58d:: with SMTP id 135mr582859vkf.4.1550787809973;
 Thu, 21 Feb 2019 14:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20190211181531.GA3238@embeddedor> <CAJKOXPeHp7sKkZ+jXmTXk5GEF_7G5ujfm3Lw==G3T4thfD+F7Q@mail.gmail.com>
 <CAGXu5jLMWrb4Dszv5YSyoGt5Lb3S1oE8EnKsTou7=7Nq1rEEVQ@mail.gmail.com>
 <155027728836.115909.11546859472583324712@swboyd.mtv.corp.google.com>
 <CAGXu5jJPfoYy20WrR5ghaSo88bsA75s-OyA4qt_3Vz0cJST_MQ@mail.gmail.com> <155078541292.77512.12594007340364187685@swboyd.mtv.corp.google.com>
In-Reply-To: <155078541292.77512.12594007340364187685@swboyd.mtv.corp.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Feb 2019 14:23:18 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+_bm+usH+hK9Pz1hAS9qhmndhmt9Ue3T3Kdta3kk1LHg@mail.gmail.com>
Message-ID: <CAGXu5j+_bm+usH+hK9Pz1hAS9qhmndhmt9Ue3T3Kdta3kk1LHg@mail.gmail.com>
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

On Thu, Feb 21, 2019 at 1:43 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Ok, thanks for the background. Looks like the perf tool already
> introduced the #define __fallthrough that they use for this purpose.
> Maybe they're hoping that it will be formalized.

Yeah, GCC has an extension for it (but it's not yet part of the C
standard -- though there are open bugs against Clang to support it).
Our adoption of the markings, thanks to Gustavo's work, has rapidly
increased lately too (we started with something like 2400 instances
and we were gaining about as many each cycle as we removed). 5.1,
though, is closing in on _0_ instances. My thinking is that once we're
to the point where we can globally enable -Wimplicit-fallthrough, then
we can depend on the compiler to enforce this (instead continuing to
depend on external tracking in Coverity and the like). It was a bit of
a chicken-and-egg and I was afraid we were going to be left with this
"partial adoption" for a long time. But we're nearly to the point
where I would be happy doing a tree-wide replacement to __fallthrough
(which should be mechanically easy).

-- 
Kees Cook
