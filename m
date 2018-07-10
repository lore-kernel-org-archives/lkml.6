Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD04C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE1B208FA
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwOfcNOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE1B208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbeGJSzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:55:43 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40119 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732459AbeGJSzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:55:42 -0400
Received: by mail-pf0-f195.google.com with SMTP id e13-v6so3329329pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=oUcTQPJzSIJnS2T45OrSBkyAi4U5y/CIwwnKpblntmQ=;
        b=CwOfcNOcM1zwQiNvXCHI60/dgXOvBKCeoLvND+2gUmHDOkc6x1LvPenkNSx220Q483
         GBYAzxYrc7GPFpDmvGPcgYX1BWz131T6Y+/mlTz0FaIwgl4NaIROdLHlvmyhTQSLzynm
         R6htIIcv1FGVyvkA7a4v5IOejH9fw/dryfNt+VGU/wkX0pmE1tvcPR4WSxjxJmlXkJzn
         wtBoCrYYRK0ZQsE3L7KDFaJyKnTkpHpSgT2b0oMZbd0OMIMg+/VQJc/8IYqztiaJSLLC
         I0JPMEqp987TQmpN8roKZcEAQ1LwBYrtCzNbzTq46SCKhNb1h/Pti9nmhGqAFBTgeGUK
         v52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=oUcTQPJzSIJnS2T45OrSBkyAi4U5y/CIwwnKpblntmQ=;
        b=qfmm3fFWZ7dtJu+mQIdUCzXAtULvVEZ79OdxhSYrBK3irtG+Pjg9oj9wj8acVM4lI0
         x5QCCeuhG+mHIg6e2vBhZ+vZn4UCDIOVnlAy+ZDgQf+TGZPD8Gky3jN8/r0E9iDgBovD
         uIxv9DE06K5vbZJqj16U+MDJi2E1UMc7JWVDYlv394BFVB3HKf8QKnJJMhpvEHhLtn7w
         8CVuI54iDtqV7cYK7tapiTjwDSeWgpv7pdFqdzgx2Ve+ZSFFi2TZUE6ixuTu3rQ1wlrm
         /IgE0yps9413FoTQOZseRfULKj0974ZOov+ob7zrF0D1iBOKHv0zgMmu3WSJ3Ekv3dJR
         dEcQ==
X-Gm-Message-State: APt69E03gSFHIRZUbN7uNopKTBG4OV7ssC+V+Q/PcWsmhjORakKPTZ1C
        5q6ZPA5lRRq+k6O8J8eQ3c/JBObjFYU=
X-Google-Smtp-Source: AAOMgpe+yRG75jZ/M5zJbgnDx0ivzXYqFomPcLiflqE9xjVzyBDMC69/gNbGoFJNJSzeHt6nv8at+w==
X-Received: by 2002:a65:630e:: with SMTP id g14-v6mr3273759pgv.153.1531248922486;
        Tue, 10 Jul 2018 11:55:22 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l8-v6sm36993415pfb.102.2018.07.10.11.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 11:55:21 -0700 (PDT)
Date:   Tue, 10 Jul 2018 11:55:21 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, oom: remove sleep from under oom_lock
In-Reply-To: <20180710094341.GD14284@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1807101152410.9234@chino.kir.corp.google.com>
References: <20180709074706.30635-1-mhocko@kernel.org> <alpine.DEB.2.21.1807091548280.125566@chino.kir.corp.google.com> <20180710094341.GD14284@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018, Michal Hocko wrote:

> What do you think about the following?
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index ed9d473c571e..32e6f7becb40 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -53,6 +53,14 @@ int sysctl_panic_on_oom;
>  int sysctl_oom_kill_allocating_task;
>  int sysctl_oom_dump_tasks = 1;
>  
> +/*
> + * Serializes oom killer invocations (out_of_memory()) from all contexts to
> + * prevent from over eager oom killing (e.g. when the oom killer is invoked
> + * from different domains).
> + *
> + * oom_killer_disable() relies on this lock to stabilize oom_killer_disabled
> + * and mark_oom_victim
> + */
>  DEFINE_MUTEX(oom_lock);
>  
>  #ifdef CONFIG_NUMA

I think it's better, thanks.  However, does it address the question about 
why __oom_reap_task_mm() needs oom_lock protection?  Perhaps it would be 
helpful to mention synchronization between reaping triggered from 
oom_reaper and by exit_mmap().
