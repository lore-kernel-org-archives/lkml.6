Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE2FC31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4BE2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOHHR2OU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfAUSPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:15:31 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40054 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfAUSPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:15:30 -0500
Received: by mail-yw1-f68.google.com with SMTP id g194so8353304ywe.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dN5/s/XUWtr4R+hciq572ZMFFMmCWF9muiwkQY2A1Ro=;
        b=IOHHR2OUoewqIH50EfJYP38TnMfwXAc6OQbrMN10yRCubGK/CrShrmBLRquouKYDzH
         HB+oW5fQ4dHDEG91tlYJPdg3+AvI50J/zFqSr83RYPBgCg6tgfAvzopk+QezvWbu+M/Y
         OvsoHv5C/zTsRoUywlvpVm8N68TOtTCmC+mb/dUOG9JXvvLgLeKIDvjo5U8BJhaxfdwH
         zPdsGqdXPZPo3F/Cv/d4SeroUSE0gY39PbokFA34P8/cVzbsfWk1HrHyV5jJkmDso/sV
         FnZhdkF8IWFngwH8KhWwF+jK8h4QaR3J3sNWe9FlmVJIKWhHqL/6KvaHIUgDTzK72Pve
         UgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dN5/s/XUWtr4R+hciq572ZMFFMmCWF9muiwkQY2A1Ro=;
        b=L9l/AIVtfniv3UkxWhDw9uqkNZwlrkNXaLCLaHQw1T6yrCuQgq5ElmNh+U+cgUV/tC
         fjmecVmPR3+tYLhLw/HOvWi/6llCgVahTl+qFrZ8ZwDyxE7hL9ZDHVGRHv8pO0cNOTqD
         aJNGf7nhWp+WMgRQdqYJJ2+msC+2SmXd9+KM5AZScS7gpAy9kVh4SajOVXb+QcFre7t9
         Abf/DSZpIEG4eaFsQkrw4MtSQTbQIM95PpgFpS+mV1G8JH50lgVqjOI2cNb4pPTfcKrD
         /4YRLYMIgsPOvHdWgWb2xUNOyG7dIjuP+odrrw4+eMSKkv/sX5vN35aedFx8DXwZsHwb
         C+xw==
X-Gm-Message-State: AJcUuke/1oHoGsfpJ07Dmnh78/QKzf0r6/dFh1E8mMqycZxpUTjmgTT6
        zipwcPonZum4CyDuAUtv6SX+OH2Dv/8y/j4ZcoBrrQ==
X-Google-Smtp-Source: ALg8bN7SqatxKiefMH/BPS7xmsTYaT1b4vk3z48wm/xEAutSusia6vLNJKjGcO6boH3FpVwT4GnoKNuxWY8VHrQZfo8=
X-Received: by 2002:a81:60c4:: with SMTP id u187mr29062429ywb.345.1548094529269;
 Mon, 21 Jan 2019 10:15:29 -0800 (PST)
MIME-Version: 1.0
References: <20190120215059.183552-1-shakeelb@google.com> <201901210123.x0L1NLFJ043029@www262.sakura.ne.jp>
In-Reply-To: <201901210123.x0L1NLFJ043029@www262.sakura.ne.jp>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 21 Jan 2019 10:15:18 -0800
Message-ID: <CALvZod7OxOiGgXfC1xjQ0z5GrvMQCVCZ_1=B+B7Ggo-z3+BqEg@mail.gmail.com>
Subject: Re: [PATCH] mm, oom: remove 'prefer children over parent' heuristic
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 5:23 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Shakeel Butt wrote:
> > +     pr_err("%s: Kill process %d (%s) score %lu or sacrifice child\n",
> > +             message, task_pid_nr(p), p->comm, oc->chosen_points);
>
> This patch is to make "or sacrifice child" false. And, the process reported
> by this line will become always same with the process reported by
>
>         pr_err("Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
>                 task_pid_nr(victim), victim->comm, K(victim->mm->total_vm),
>                 K(get_mm_counter(victim->mm, MM_ANONPAGES)),
>                 K(get_mm_counter(victim->mm, MM_FILEPAGES)),
>                 K(get_mm_counter(victim->mm, MM_SHMEMPAGES)));
>
> . Then, better to merge these pr_err() lines?

Thanks, will remove the one in oom_kill_process.
