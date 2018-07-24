Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA7FC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4804520852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9sy+fUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4804520852
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388819AbeGXX76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:59:58 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:34212 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388506AbeGXX76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:59:58 -0400
Received: by mail-pf1-f173.google.com with SMTP id k19-v6so1196127pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gKaXTjgXYkSdXlL9MTpX2ecKQBsPD8OxiuvNYjQ85uQ=;
        b=h9sy+fUf3ohSY3gqM4KX/JIej5N5ICMTdgQKaKXISsmVpseRr5t6kLUQk6ec/XC+5W
         nvWEpsLYh3CL0wcy5cnq27IKM/JY9PeZ5DO+lhSCFmJ1S/OGYfWYwuneat6S7yfTtRXN
         3SLviORO1ar1lxosLVFQE65G/CjDEoOFfem5Tq2n3RYWtYFDqTNh2q/vJzbtrudgNA6p
         mOn4e2E+d4rYeOoTsjhQrFjw6bc3wuE8CDwq9AhEmezQ7AMCtfpEAJ8B7NHPmwB4T3Z0
         OB/WtJsAiaOQebjx5QA3RCJEFomjccM5tj3k39/27FmV/5M8Q77LuQ1mClqU3kzhtBWT
         Zs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gKaXTjgXYkSdXlL9MTpX2ecKQBsPD8OxiuvNYjQ85uQ=;
        b=h/C7bHdaWLV3RK5Gd5k4Qxb68mPBEgLZQcK7/ZJCeRRbsUkg/c3qbYmcAJ1X62wTah
         yWQ4kqtTEVh9ImrY7dUpkVFBYSjZEWmllCu3tZvYGBqUk6K9UnYn99+uKRnQ/2qFvp6/
         79ebClQbhXF+H3XPMKChqg4dIDVSsyLoAvZ2+8np55opysUlRUYQEE3XrxOuwPck/7tM
         9vG2QiDhcZ84vo6qfXPJu7z9XIWcCUv6GuUhbQdtxjnMAi968wORoA59PHDbv3TQtfDH
         TLclFA2j0mvBrydlxm2oLMk4MmwCLYtsnXhBXFiEonyNJwqZNSRtjK+baUoXaSPzoFut
         aA5Q==
X-Gm-Message-State: AOUpUlFcwR09DQVwkKVoApCnYlDNJ2/ANykgJa9DOGSjU6Z6t+DZt5rE
        5KgAdGADpLzFHcuKQLbTKK2nAQ==
X-Google-Smtp-Source: AAOMgpdyB9tpnZsUvVX8KMtAGO2Rh/VpkE+JOXAqJHZm0SbsP5C6dnCYOLLqpdZq5Ucy/azUTkTATg==
X-Received: by 2002:a63:4d06:: with SMTP id a6-v6mr17800394pgb.408.1532472675903;
        Tue, 24 Jul 2018 15:51:15 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id t76-v6sm20828481pfe.109.2018.07.24.15.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 15:51:15 -0700 (PDT)
Date:   Tue, 24 Jul 2018 15:51:14 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch v4] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <05dbc69a-1c26-adec-15c6-f7192f8d2ae0@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.1807241549420.215249@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com> <d19d44c3-c8cf-70a1-9b15-c98df233d5f0@i-love.sakura.ne.jp> <alpine.DEB.2.21.1807181317540.49359@chino.kir.corp.google.com> <a78fb992-ad59-0cdb-3c38-8284b2245f21@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807200133310.119737@chino.kir.corp.google.com> <alpine.DEB.2.21.1807201314230.231119@chino.kir.corp.google.com> <ca34b123-5c81-569f-85ea-4851bc569962@i-love.sakura.ne.jp> <alpine.DEB.2.21.1807201505550.38399@chino.kir.corp.google.com>
 <f8d24892-b05e-73a8-36d5-4fe278f84c44@i-love.sakura.ne.jp> <alpine.DEB.2.21.1807241444370.206335@chino.kir.corp.google.com> <05dbc69a-1c26-adec-15c6-f7192f8d2ae0@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018, Tetsuo Handa wrote:

> >> You might worry about situations where __oom_reap_task_mm() is a no-op.
> >> But that is not always true. There is no point with emitting
> >>
> >>   pr_info("oom_reaper: unable to reap pid:%d (%s)\n", ...);
> >>   debug_show_all_locks();
> >>
> >> noise and doing
> >>
> >>   set_bit(MMF_OOM_SKIP, &mm->flags);
> >>
> >> because exit_mmap() will not release oom_lock until __oom_reap_task_mm()
> >> completes. That is, except extra noise, there is no difference with
> >> current behavior which sets set_bit(MMF_OOM_SKIP, &mm->flags) after
> >> returning from __oom_reap_task_mm().
> >>
> > 
> > v5 has restructured how exit_mmap() serializes its unmapping with the oom 
> > reaper.  It sets MMF_OOM_SKIP while holding mm->mmap_sem.
> > 
> 
> I think that v5 is still wrong. exit_mmap() keeps mmap_sem held for write does
> not prevent oom_reap_task() from emitting the noise and setting MMF_OOM_SKIP
> after timeout. Since your purpose is to wait for release of memory which could
> not be reclaimed by __oom_reap_task_mm(), what if __oom_reap_task_mm() was no-op and
> exit_mmap() was preempted immediately after returning from __oom_reap_task_mm() ?
> 

If exit_mmap() gets preempted indefinitely before it can free any memory, 
we are better off oom killing another process.  The purpose of the timeout 
is to give an oom victim an amount of time to free its memory and exit 
before selecting another victim.
