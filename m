Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F16ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 05:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E9D2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 05:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="ERLqbQ82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E9D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeIQKsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:48:00 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38731 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbeIQKr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:47:59 -0400
Received: by mail-oi0-f66.google.com with SMTP id x197-v6so17773513oix.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 22:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WpYvUsoYgEGeP6B6ATx+yRD/LNy0fnUPx29m2jEuTH0=;
        b=ERLqbQ82XbYx90SfX4tnL/wbyHap91e5MDsXAGtg188sqPSn0VU/1QGQVJyykCCLuL
         k2S2qg8x5oU5LkUewMwlT9nZQw4IjIOPRw66rADU5GaCG+ReitZsyvVnFrcMFirUSS0r
         KjxiQc0+Qap2ZRl87QFxnWLt/xooxreN9W+4jBUQAGKl9vvHHLxEwd/9UYbK5P0aNxGz
         1Pgl+ZNVIdS0MKWT/1/x9P4Wwf3P/awtEAZhHChx+AXkhkjiNdOR1x8fCfBrXdLCbd9d
         XLO2h1PVt/Gzif01jRz1O/wwumAy5so8xJ6gLq56EA0z7u4UMT8gfEJo49/oHTaFmVAf
         8w3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WpYvUsoYgEGeP6B6ATx+yRD/LNy0fnUPx29m2jEuTH0=;
        b=PE5C4omukf6GeFmoZvSDGayhLD7C4h3Uds0tuKZPbPCZIAMsy5TVKiMM7J3TSf3R4/
         Xv/13sm5H6py3p3+bU+QFJFC9yeIQgPUgXiz8aJvOkrTs+35NJjfukQrzIGm+WvuKEn0
         bLxEeSo/vKzbhQlgspZE7ZIOnftkHfUM707gbsjxjPeUOC6DK7Gcata4vmS0osWmEwPA
         U4JOMwZXVfnMVbsLEqqSZIdrcr6mZ5ddNROWgZJxjKjAidNgd1QpuGWME2WVYJxjm4wO
         REWuRw9kT/FeEZaU+7L0P5Q/3dAKFOB7jtf2k7OszO4dthi5NfbZxKYuz+0MCtm3wHXq
         7osA==
X-Gm-Message-State: APzg51AZPM2sOF1HrdJW2IhDc5SZxuOP826REu/Uys1vFTMxlktlCHoY
        /fnip9+geWcHibgJ8GKw+c1ab4EV1iOzBdZmKcUlIw==
X-Google-Smtp-Source: ANB0VdYrd0ZTOyB1ckn2C3AgPnWnQtDpvHzUG4U4q6wVXHtOLMiadsrWueK4jPdUfYIyBewkcyaPAyNoOGz0ABlAQtU=
X-Received: by 2002:aca:338a:: with SMTP id z132-v6mr17268356oiz.184.1537161735227;
 Sun, 16 Sep 2018 22:22:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a2b:0:0:0:0:0 with HTTP; Sun, 16 Sep 2018 22:22:14
 -0700 (PDT)
In-Reply-To: <CAJuCfpG1=pXOg=1GwC33Uy0BcXNq-BsR6dO0JJq4Jnm5TyNENQ@mail.gmail.com>
References: <20180828172258.3185-1-hannes@cmpxchg.org> <20180905214303.GA30178@cmpxchg.org>
 <20180907110407.GQ24106@hirez.programming.kicks-ass.net> <20180907150955.GC11088@cmpxchg.org>
 <CAJuCfpG1=pXOg=1GwC33Uy0BcXNq-BsR6dO0JJq4Jnm5TyNENQ@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 17 Sep 2018 13:22:14 +0800
Message-ID: <CAD8Lp47F5N8xN41KFHybVVTpV_TEewERD-eJov6iiqBJUyVR9g@mail.gmail.com>
Subject: Re: [PATCH 0/9] psi: pressure stall information for CPU, memory, and
 IO v4
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suren

On Fri, Sep 7, 2018 at 11:58 PM, Suren Baghdasaryan <surenb@google.com> wrote:
> Thanks for the new patchset! Backported to 4.9 and retested on ARMv8 8
> code system running Android. Signals behave as expected reacting to
> memory pressure, no jumps in "total" counters that would indicate an
> overflow/underflow issues. Nicely done!

Can you share your Linux v4.9 psi backport somewhere?

Thanks
Daniel
