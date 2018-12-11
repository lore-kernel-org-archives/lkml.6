Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB61BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD4F20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="P50rlAyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD4F20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeLKPUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:20:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41921 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeLKPUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:20:35 -0500
Received: by mail-io1-f67.google.com with SMTP id s22so12067021ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 07:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irrjfb88dlEk0TZFlLM/kg3lIhZCBBds6j6a1aQVXwU=;
        b=P50rlAyVrkbKZzXRPU27VkZIk457kMsaQ0Br69WWcGu9jXF5C4xYdVJUrewqSWNMoE
         kiImIly6xEsKx/z7oemcUAulQ8zJD7OKviIIBXQJ93CPc4eeyGA7S4FHrBgSTVZuqaBZ
         FtqT4TgfFs2Jj5mlugSzdLLd5yxXKNLoF7H2ToyIG1tOzh6SPXP4Vx4lsODmJgzdvw8Y
         XvkuCknb56WOgUjQbvOJlFNNerybeLMUviNClajdsqF1DMLSSQAzvbqkC4lrel4TNB3U
         knTC76reBXdQfFXM8oigMZnVR8YDI6p3H2NfDWMdov12iXxJJj1/KB77ow88xldvc1dv
         bD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irrjfb88dlEk0TZFlLM/kg3lIhZCBBds6j6a1aQVXwU=;
        b=mdp1EUFhEeMzqZsTuuzBAHPPnNL66z2IQJBNHsAPtOqTtl/raLe2mI7AddF2jIYvH4
         QqE2hhuKYFyE2A7w8BnJTzNfP2GJpWeSPLvFomps+PUhCzXk1xRCQp1Qtp26d3BleeYK
         r9vYzQeR1Ps6NtI6QEOkcam89/05AnoZG2a3VRiY1d6fHEqCkby5aZmtEQHkyCgbpU89
         RFo+svS/QYMEpn9nBXtXMAcLXuqE5PuZFGg0Sb/juhD+twfG+bR0JdUXAeCcrqpSym/u
         hIYwH/6+zmHOh54VkjJh0c2KC6Q3hQZRgrh9uYrXK1RxviTgzxidLTrW0LDbgT7wD6g+
         1P1A==
X-Gm-Message-State: AA+aEWYjHWKtBjTWrqefnBSwlfSsFtDf0Vk25aw4+pxxXHWbjK4Ld5zR
        mw0ZeLtVjbnBwkVddrsmGyVZhX93zQ1mJdIwBR1Mxg==
X-Google-Smtp-Source: AFSGD/UnKaIkqPj7JLRAi+/ypiiHOB6dOp1BStn7ww+HDwFRrxwMRhM6H1GUfpokANxzDfpSrrnggyVBD2yO/zkRId0=
X-Received: by 2002:a6b:1414:: with SMTP id 20mr13378183iou.140.1544541633966;
 Tue, 11 Dec 2018 07:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20181210210139.3336002-1-arnd@arndb.de> <CAKfTPtDPjqdRjRTt=DH2UwzfDXKDt8jNvxdC9Lsh20SvteMpSQ@mail.gmail.com>
In-Reply-To: <CAKfTPtDPjqdRjRTt=DH2UwzfDXKDt8jNvxdC9Lsh20SvteMpSQ@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 11 Dec 2018 07:20:22 -0800
Message-ID: <CAOesGMg-ZYzU=mA21dozNsJkFXkVN54Uv3rYpGmLsJEaKjA7mA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: move capacity_margin definition into #ifdef
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Muchun Song <smuchun@gmail.com>, morten.rasmussen@arm.com,
        mgorman@techsingularity.net, srikar@linux.vnet.ibm.com,
        patrick.bellasi@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 11:46 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Arnd,
>
> On Mon, 10 Dec 2018 at 22:01, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Marking the variable static showed that it's only used for
> > SMP builds, as seen from this warning:
> >
> > kernel/sched/fair.c:119:21: error: 'capacity_margin' defined but not used [-Werror=unused-variable]
> >  static unsigned int capacity_margin   = 1280;
>
> Olof sent a similar patch 2 weeks ago: https://lkml.org/lkml/2018/11/26/115

Yeah, Ingo seems to be high latency right now. :( Anyone else able to
pick it up? Peter?


-Olof
