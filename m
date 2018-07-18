Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99E7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7214520854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ska-ac-za.20150623.gappssmtp.com header.i=@ska-ac-za.20150623.gappssmtp.com header.b="Os3HbFF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7214520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ska.ac.za
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbeGRQGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:06:04 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41648 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbeGRQGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:06:04 -0400
Received: by mail-ua0-f195.google.com with SMTP id t14-v6so3172323uao.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ska-ac-za.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DoSAuWgIi+ec2kZ1NmcZ3VjRsJGbr3zrbcNzm+RM9kg=;
        b=Os3HbFF9oUHOqIMAcAvzdL1VGWuGb0LbVhYPyxj+Il7IHxDPMLcdZ6/ltPmEUMRR73
         xkvnLG4n337wljtm9tSYoVw/iAKfgTXrdsB3rRahxABUTmRFG60fp64Gb9aNm6X/wuk1
         KVTQA7BbW9uT0jRVE4ueQVqxAWJdrEpHE+HnIyI/p5Y/oGPg4GmwUsiHrVs1+5yayIR/
         IUcr+2FOz7Oj4ebWX5/iWqu53xNe9P+Yr4zPkAwkG3CmXFxHQSxo4RUacJEZLy9Babyu
         cHJNTTpr585cnEB8HiSTroVwuYGIHz5trrezQW13K3/685sFW2z7bX4HEnJ/EebRoMng
         t3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DoSAuWgIi+ec2kZ1NmcZ3VjRsJGbr3zrbcNzm+RM9kg=;
        b=SZhYuHo1EQ69REFLHDQcTFpeR4pdDAFV6M1PhEWT90+OlZV6UCG2VyG1s4/5QNwtQ6
         NlejNN5djd0YqgoVNRjKJ0irRCFSzxVoCIR2M2XHWk+NYAFJTyrJgnPjCOdtHHNWR5Ax
         eBdhErhKbU3JaoxCu9+e8DZnnt9wSOsvU+/NP6+Yvvp57SFnE/s3W4XX42C1UiVG/dxq
         F9JMyfOmWz0wWmP3fbfcN6EL+l3RuVBeGT1MTMbs6R4wt18TMMTS90D+jmvK1YpKoP0N
         OSDyA7NQiwa+DWYsgluRRphN0TFZMLzoIjJGuP7/TBLETIZLYy7mp96fTHH+a2mNF1O7
         BZcg==
X-Gm-Message-State: AOUpUlE6Sl28RXv3rQ43Sc198eQ9vUCMkV6A5JC61RCD/nbqnfucW+yy
        v5vbZlnLbe9vHSwKigk5Pw+qyqAzkk9nJV+M19S+fA==
X-Google-Smtp-Source: AAOMgpc0kMFw6CLGe5bt8hsNLfIbHE46p/UAdH/xwtJ4Z+K4SaTLRGv4NnLT/bZ1sD8+FBnvMEklvpbmUrKYQENhMRg=
X-Received: by 2002:ab0:3352:: with SMTP id h18-v6mr4162572uap.10.1531927658193;
 Wed, 18 Jul 2018 08:27:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:d97:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 08:27:37 -0700 (PDT)
In-Reply-To: <20180718144710.GI7193@dhcp22.suse.cz>
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz> <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <20180718144710.GI7193@dhcp22.suse.cz>
From:   Bruce Merry <bmerry@ska.ac.za>
Date:   Wed, 18 Jul 2018 17:27:37 +0200
Message-ID: <CAOm-9aqLopJouRFd6sQr95yYTJmuoE6y9=VoMEJeyr_OVfQxnw@mail.gmail.com>
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

On 18 July 2018 at 16:47, Michal Hocko <mhocko@kernel.org> wrote:
>> Thanks for looking into this. I'm not familiar with ftrace. Can you
>> give me a specific command line to run? Based on "perf record cat
>> /sys/fs/cgroup/memory/memory.stat"/"perf report", I see the following:
>>
>>   42.09%  cat      [kernel.kallsyms]  [k] memcg_stat_show
>>   29.19%  cat      [kernel.kallsyms]  [k] memcg_sum_events.isra.22
>>   12.41%  cat      [kernel.kallsyms]  [k] mem_cgroup_iter
>>    5.42%  cat      [kernel.kallsyms]  [k] _find_next_bit
>>    4.14%  cat      [kernel.kallsyms]  [k] css_next_descendant_pre
>>    3.44%  cat      [kernel.kallsyms]  [k] find_next_bit
>>    2.84%  cat      [kernel.kallsyms]  [k] mem_cgroup_node_nr_lru_pages
>
> I would just use perf record as you did. How long did the call take?
> Also is the excessive time an outlier or a more consistent thing? If the
> former does perf record show any difference?

I didn't note the exact time for that particular run, but it's pretty
consistently 372-377ms on the machine that has that perf report. The
times differ between machines showing the symptom (anywhere from
200-500ms), but are consistent (within a few ms) in back-to-back runs
on each machine.

>> Ubuntu 16.04 with kernel 4.13.0-41-generic (so presumably includes
>> some Ubuntu special sauce).
>
> Do you see the same whe running with the vanilla kernel?

We don't currently have any boxes running vanilla kernels. While I
could install a test box with a vanilla kernel, I don't know how to
reproduce the problem, what piece of our production environment is
triggering it, or even why some machines are unaffected, so if the
problem didn't re-occur on the test box I wouldn't be able to conclude
anything useful.

Do you have suggestions on things I could try that might trigger this?
e.g. are there cases where a cgroup no longer shows up in the
filesystem but is still lingering while waiting for its refcount to
hit zero? Does every child cgroup contribute to the stat_show cost of
its parent or does it have to have some non-trivial variation from its
parent?

Thanks
Bruce
-- 
Bruce Merry
Senior Science Processing Developer
SKA South Africa
