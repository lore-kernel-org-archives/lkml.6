Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B74C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE2420879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TYv4qvYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfAMDzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 22:55:04 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:17926 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfAMDzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 22:55:03 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x0D3srFW012197;
        Sun, 13 Jan 2019 12:54:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x0D3srFW012197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547351694;
        bh=MLmbrY6gJCTsikFhFlVTaYkEc7iRoLO5sQPpeaPromQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TYv4qvYAhAUY4Yf+xESqNRBLmxvN0q4t9JwZiJK6pVjZYXWNERrnS8zNkKeZu4/Uc
         U6Mw57M16JtcRktQzJYRooRMZcUaPmNeNa7nY8KyGzvor5AUwnZ8MQGdQuIpEPCCo8
         t+7HVH+voB7SpwWJB0Q9LwVaQNUgioQdDFl50L6rnxH4SQdL9M1s3RjROWx/5WRAQB
         Uhy5KMWylWOOpnABTz50RjTwrpGSEpORaeVeRQku7vPefHEpAagH/U80G6Nb3aV1N4
         46F8lKKDrIgFNOQdeBBiTsh9FgRnoyji61SS2BghUE7eicsv6ZpjxAoBhmT3wQSCQ6
         I2NWLpHn9uk6g==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id z11so6005602uaa.10;
        Sat, 12 Jan 2019 19:54:54 -0800 (PST)
X-Gm-Message-State: AJcUukfD+QQMg7ba0PKLnAHiwe6yVx2QJaDNKs+arF68wUYPInOLxyMr
        rO2JHXMhAPPbGqydBUWJ0V1+I1y2a6iPZD0ObGs=
X-Google-Smtp-Source: ALg8bN5M1A0NBZiSgrQWfrdkLRFMVTyjW2zzXhOQAi8esyI6dtiOu37jEhlUfiUKUUMrfP0agf3s1jssQG+hgB+Nb9Q=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr7671495uad.55.1547351693047;
 Sat, 12 Jan 2019 19:54:53 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAS-r4gZOxdJCNaQwHtOYbxHbdupu57qncWkE+bhGfb_7g@mail.gmail.com>
 <20190111190538.6744-1-paul.burton@mips.com>
In-Reply-To: <20190111190538.6744-1-paul.burton@mips.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 13 Jan 2019 12:54:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNATEs-+GcVohYPLW3sVMDfpLNtT3dbRYcO5FNqJTf9G5SA@mail.gmail.com>
Message-ID: <CAK7LNATEs-+GcVohYPLW3sVMDfpLNtT3dbRYcO5FNqJTf9G5SA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Disable LD_DEAD_CODE_DATA_ELIMINATION with
 ftrace & GCC <= 4.7
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 6:00 AM Paul Burton <paul.burton@mips.com> wrote:
>
> When building using GCC 4.7 or older, -ffunction-sections & the -pg flag
> used by ftrace are incompatible. This causes warnings or build failures
> (where -Werror applies) such as the following:
>
>   arch/mips/generic/init.c:
>     error: -ffunction-sections disabled; it makes profiling impossible
>
> This used to be taken into account by the ordering of calls to cc-option
> from within the top-level Makefile, which was introduced by commit
> 90ad4052e85c ("kbuild: avoid conflict between -ffunction-sections and
> -pg on gcc-4.7"). Unfortunately this was broken when the
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION cc-option check was moved to
> Kconfig in commit e85d1d65cd8a ("kbuild: test dead code/data elimination
> support in Kconfig"), because the flags used by this check no longer
> include -pg.
>
> Fix this by not allowing CONFIG_LD_DEAD_CODE_DATA_ELIMINATION to be
> enabled at the same time as ftrace/CONFIG_FUNCTION_TRACER when building
> using GCC 4.7 or older.
>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Fixes: e85d1d65cd8a ("kbuild: test dead code/data elimination support in Kconfig")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: stable@vger.kernel.org # v4.19+
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes in v2:
> - Invert the dependency as Masahiro suggested.


Applied to linux-kbuild/fixes.


Thanks!


-- 
Best Regards
Masahiro Yamada
