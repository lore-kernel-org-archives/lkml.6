Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0259BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C577F217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550586527;
	bh=mbACBgK8AlicBJ9acnA6+42dWLobWs1pjQgRu/dXC1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ycnePzljw+VIrqPdaBmsL2DsilHmNZdo37xH4OyyMOZl98/Vz1fHtLiqs7DKVFAaL
	 MEfb9ySlh2JyJrU0FATafIx/U6QhbQ3sX2JX1xSRvuqahIhqk0aFlko/ZuG8JEXKIV
	 2eJ+/jQlDXwfYAyGv/ElADcfppkP/8X8PNthH2fY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfBSO2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:28:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40434 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfBSO2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:28:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id q1so22201787wrp.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 06:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXrUyJoCzKaaHCoUt3slywreurfOOxrTlRkYOAb7QFw=;
        b=EskcLpXeHZX2jJsNfcbwix3NpwTatk/6IAG+hfl7L9f+QQQGFMgEg7WvMrtkLqVjLh
         vqAwWnxxhY1iIekD7jNd64H/HuXHuIJ5gB6nc9Rk+5bGGKCr4te34NPMlJduC/Seavc4
         6DrMi+Ne5HpA3PPPuHLf3AM5crV3uyMnr7O/uedJHw35VfCi4Ej2Xk9FNLW77QcnROC0
         UA2WkQP8SIIhquGo6eIoqcrMDWsiMurXjPekEe4lrrTwWIW1+5y6yVQMfmCraqjnBHiy
         NtbIxxkdQk7f7sWCba0Kx1Yl67LIOjJ7eLD72VA32Ffy2YFY1BuaqLNFJQETrQgs+Cld
         pRpw==
X-Gm-Message-State: AHQUAuZDgb7QmSMfMr54PhYGWMbNLYy4Sg0fW63xdVFuuGyMRJ1Xob8S
        g/z8nicq5EuFMg4CNyKKGpNuj9TEWcgorydt1NE=
X-Google-Smtp-Source: AHgI3IYOZoqcGR0s5IzPNkjTCk6shHCBSQBTx6M0CJbFdX8+TMgq43Zatb5zi3luPMNyf1lGcSgSYrGw+RP4VTN7Hvg=
X-Received: by 2002:adf:9e0c:: with SMTP id u12mr20494909wre.216.1550586524032;
 Tue, 19 Feb 2019 06:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20190219095815.15931-1-jolsa@kernel.org>
In-Reply-To: <20190219095815.15931-1-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 19 Feb 2019 23:28:31 +0900
Message-ID: <CAM9d7cjJ59Uyv5TtosZYQBm4F5eFadyCpuxHioU99=3HH7xg9Q@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] perf tools: Assorted fixes
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jirka,

On Tue, Feb 19, 2019 at 6:58 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> sending assorted general fixes that queued
> up in my other branches.
>
> v3 changes:
>   - fix for fixes found by Namhyung
>   - new patch to use sysfs__mountpoint
>
> v2 changes:
>   - renamed the interface to struct cpu_topology/numa_topology
>     plus related changes in function names
>   - adding missing Fixes tag
>
> Also available in here:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/fixes
>
> thanks,
> jirka
>
>
> ---
> Jiri Olsa (4):
>       perf header: Fix wrong node write in NUMA_TOPOLOGY feature
>       perf tools: Add cpu_topology object
>       perf tools: Add numa_topology object
>       perf tools: Use sysfs__mountpoint() when reading cpu topology

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  tools/perf/util/Build     |   1 +
>  tools/perf/util/cputopo.c | 277 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/cputopo.h |  33 ++++++++++++++++++++++
>  tools/perf/util/header.c  | 269 ++++++++++++++++++++--------------------------------------------------------------------------------------------------------------------------------------------------------
>  4 files changed, 341 insertions(+), 239 deletions(-)
>  create mode 100644 tools/perf/util/cputopo.c
>  create mode 100644 tools/perf/util/cputopo.h
