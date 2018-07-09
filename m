Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00306C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B592089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8MYiiEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B592089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933178AbeGIWt5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:49:57 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33850 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932685AbeGIWtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:49:55 -0400
Received: by mail-pl0-f68.google.com with SMTP id z9-v6so6678835plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 15:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=PNtm2kG90euFft8QWr7crmO0ot8N2x6U5jLBbpaYZWU=;
        b=s8MYiiEhtAzrHbGH0xejdr7SwhUJ38XWVCSIBQr70tVIiGStPNJvyk9MlIs+FQjztN
         0qN6CSSkjR4BxlHcxkjpOUvvBrwwHCOO6uzuUdkYYVuG/Gl/Xg1evMsZ8W2aXsmnuj9z
         7/9iajbqA9RwXU2Z1E/1IIj50CMO6Z8KRsZjGDtgpAnuyAUqoidypTO17w34o7hpPUOu
         d4S9NDi3BxW2SXr2nrACjV5mnSb9guq7tqN+niwfukWxc7ndhaM5VGKIhu3uyL35xlpT
         923iTBFKNOkgPjP1vI9KMzg8yQxCEnF1fmK3WfV+L6tuxB8+aG5WvIa7VeZ2VjMFLArs
         wpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=PNtm2kG90euFft8QWr7crmO0ot8N2x6U5jLBbpaYZWU=;
        b=m42WSFbbCyuflCPGQDbeuqn+Ds9B1ZIIuM32efo9eXwtTiEgdhkJL+qySC7Vm57SOa
         EG9hR4l2jdoA2cLEJ6Yd/rWdYH4nwEb9MiT1yws7uQHX/vVYkkoRdLgF/DaW8j1k+1wu
         1lR3fjTXaWn6fIWiGLo5iaf9qBA6laUo+0LY0QmuYSWWsHlVt2A87zAb/b1hO7l1cPy9
         wf9f/+DsjT2tY4Ri8m47SIcuS2nEObr/UrbC/Xj9asH4acawwQkMBI0wwL+mGsKaf5qj
         uhmc5bkKQzuVtPQXUIClbffw2q8R7sLn/9dtW5aXvUgnkG3DaMVwOfQ5JJZo2F6STFKY
         cxRg==
X-Gm-Message-State: APt69E31xqB6f1w7pVP8cl1WMLvDgdZ7dHFY2li9VTip6Z77sWG8OVyz
        0ARxQnchg3G2puoQCuwIULddKRSwRcc=
X-Google-Smtp-Source: AAOMgpedluUlv81Cuc62r9ANrwt2WVz4znvL+Tht5olXo93v5MOqZPkly1xO0i9+8lNYBhhyw1zjyA==
X-Received: by 2002:a17:902:c85:: with SMTP id 5-v6mr22371901plt.126.1531176595218;
        Mon, 09 Jul 2018 15:49:55 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h8-v6sm22117666pgq.35.2018.07.09.15.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 15:49:54 -0700 (PDT)
Date:   Mon, 9 Jul 2018 15:49:53 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm, oom: remove sleep from under oom_lock
In-Reply-To: <20180709074706.30635-1-mhocko@kernel.org>
Message-ID: <alpine.DEB.2.21.1807091548280.125566@chino.kir.corp.google.com>
References: <20180709074706.30635-1-mhocko@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> Tetsuo has pointed out that since 27ae357fa82b ("mm, oom: fix concurrent
> munlock and oom reaper unmap, v3") we have a strong synchronization
> between the oom_killer and victim's exiting because both have to take
> the oom_lock. Therefore the original heuristic to sleep for a short time
> in out_of_memory doesn't serve the original purpose.
> 
> Moreover Tetsuo has noticed that the short sleep can be more harmful
> than actually useful. Hammering the system with many processes can lead
> to a starvation when the task holding the oom_lock can block for a
> long time (minutes) and block any further progress because the
> oom_reaper depends on the oom_lock as well.
> 
> Drop the short sleep from out_of_memory when we hold the lock. Keep the
> sleep when the trylock fails to throttle the concurrent OOM paths a bit.
> This should be solved in a more reasonable way (e.g. sleep proportional
> to the time spent in the active reclaiming etc.) but this is much more
> complex thing to achieve. This is a quick fixup to remove a stale code.
> 
> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

This reminds me:

mm/oom_kill.c

 54) int sysctl_oom_dump_tasks = 1;
 55) 
 56) DEFINE_MUTEX(oom_lock);
 57) 
 58) #ifdef CONFIG_NUMA

Would you mind documenting oom_lock to specify what it's protecting?
