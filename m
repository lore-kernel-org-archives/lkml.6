Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE86ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F73B20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ska-ac-za.20150623.gappssmtp.com header.i=@ska-ac-za.20150623.gappssmtp.com header.b="pzCmRl9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F73B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ska.ac.za
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbeGRPHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:07:33 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:43047 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbeGRPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:07:33 -0400
Received: by mail-ua0-f169.google.com with SMTP id x24-v6so3047616ual.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ska-ac-za.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xaZeO0/nXuMr+aH/Wydv4gzxFs8NElauDU8ije0PCTM=;
        b=pzCmRl9+cdS4GL5SvIQ2VOHPviwR9knVvikGmtMN87gYVzICnTvBw3OWtwnWRMSnDy
         XBdKqBhS0fFKyHdmxYuQDIEvH2jHz8QUxGXSdaZtU7e5KaIR7ObvpDt77WNRwzXbGr+y
         qR2QyRZmAn1zhdOmykYmCUv/cYx3NPggXT1gQEt4/FGT1SdsHGPynyxIQDexJw8lL1Ma
         UYzHp0qc1cP/+7uHHUtpFACM3toCYO3IpjQEcI+SWbaWtSmn7A0qqiuo53Sba9PVSHI1
         /c85eZj7MUrt/clpLWwOGXx2yuiFJrtuaGx+YNbrWcQFs+Ytx69VPiFpD8QecBpNDoWX
         I0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xaZeO0/nXuMr+aH/Wydv4gzxFs8NElauDU8ije0PCTM=;
        b=m1ABSXUbkeO3sx/XRVAXsKBnxbgvYWo+dPzF7uBXmMrupU+1q2thjccuZ0q5oRAkxt
         D7weqiLa51Vj87bsfVNXCaUnSGuIAxXa9kPvbggQk3dNIUADEkQxXOa5a2ZqxS4pHMin
         gDosZLKlTe8TBMEPQm8HQQnxxLXVRCfbRMlmi7wV373+PFMLg5d3jKWainVjUyXi8SNG
         /9NivjNJl/zwZ03Q+c2pXszitFfP45c3JgpHyEn2+icl7VlKPw2MDodjm3bYe2VjOriO
         2WAPJf2R1JITwoJcGLL9xuhj6J7Boa5E7/QptmOCaEO4/5oK12izJNBXE3CwL4ah4zuj
         kKgw==
X-Gm-Message-State: AOUpUlFBRnzDUh5LbwbBqdCYNlHo/N+BG/itW5OS3qTeMOgRfyyhmsoc
        mftxnGzn+yA433Mzo2ZH/UAPM5wEHPd9Lak/8ael9w==
X-Google-Smtp-Source: AAOMgpcaN7DK/3nAA4NOhrwDwaEmueFMgGLJD2cVaXD4XWUNEwQmZxqdhpVGiMAClle/3e71IGmzJD0M3gQLVE01JSM=
X-Received: by 2002:ab0:210b:: with SMTP id d11-v6mr4044601ual.108.1531924160963;
 Wed, 18 Jul 2018 07:29:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:d97:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 07:29:20 -0700 (PDT)
In-Reply-To: <20180718104230.GC1431@dhcp22.suse.cz>
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org> <20180718104230.GC1431@dhcp22.suse.cz>
From:   Bruce Merry <bmerry@ska.ac.za>
Date:   Wed, 18 Jul 2018 16:29:20 +0200
Message-ID: <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some machines
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 12:42, Michal Hocko <mhocko@kernel.org> wrote:
> [CC some more people]
>
> On Tue 17-07-18 21:23:07, Andrew Morton wrote:
>> (cc linux-mm)
>>
>> On Tue, 3 Jul 2018 08:43:23 +0200 Bruce Merry <bmerry@ska.ac.za> wrote:
>>
>> > Hi
>> >
>> > I've run into an odd performance issue in the kernel, and not being a
>> > kernel dev or knowing terribly much about cgroups, am looking for
>> > advice on diagnosing the problem further (I discovered this while
>> > trying to pin down high CPU load in cadvisor).
>> >
>> > On some machines in our production system, cat
>> > /sys/fs/cgroup/memory/memory.stat is extremely slow (500ms on one
>> > machine), while on other nominally identical machines it is fast
>> > (2ms).
>
> Could you try to use ftrace to see where the time is spent?

Thanks for looking into this. I'm not familiar with ftrace. Can you
give me a specific command line to run? Based on "perf record cat
/sys/fs/cgroup/memory/memory.stat"/"perf report", I see the following:

  42.09%  cat      [kernel.kallsyms]  [k] memcg_stat_show
  29.19%  cat      [kernel.kallsyms]  [k] memcg_sum_events.isra.22
  12.41%  cat      [kernel.kallsyms]  [k] mem_cgroup_iter
   5.42%  cat      [kernel.kallsyms]  [k] _find_next_bit
   4.14%  cat      [kernel.kallsyms]  [k] css_next_descendant_pre
   3.44%  cat      [kernel.kallsyms]  [k] find_next_bit
   2.84%  cat      [kernel.kallsyms]  [k] mem_cgroup_node_nr_lru_pages

> memory_stat_show should only scale with the depth of the cgroup
> hierarchy for memory.stat to get cumulative numbers. All the rest should
> be simply reads of gathered counters. There is no locking involved in
> the current kernel. What is the kernel version you are using, btw?

Ubuntu 16.04 with kernel 4.13.0-41-generic (so presumably includes
some Ubuntu special sauce).

Some new information: when this occurred on another machine I ran
"echo 2 > /proc/sys/vm/drop_caches" to drop the dentry cache, and
performance immediately improved. Unfortunately, I've not been able to
deliberately reproduce the issue. I've tried doing the following 10^7
times in a loop and while it inflates the dentry cache, it doesn't
cause any significant slowdown:
1. Create a temporary cgroup: mkdir /sys/fs/cgroup/memory/<name>.
2. stat /sys/fs/cgroup/memory/<name>/memory.stat
3. rmdir /sys/fs/cgroup/memory/<name>

I've also tried inflating the dentry cache just by stat-ing millions
of non-existent files, and again, no slowdown. So I'm not sure exactly
how dentry cache is related.

Regards
Bruce
-- 
Bruce Merry
Senior Science Processing Developer
SKA South Africa
