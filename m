Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7457CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D37208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="o9Iv8jvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D37208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405054AbeHAT3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:29:23 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34414 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407105AbeHATPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:15:55 -0400
Received: by mail-qt0-f194.google.com with SMTP id m13-v6so20779023qth.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x7IBBbge8UGVC2hAhuLJB7s1DADr52Epb3KeW/cnCYk=;
        b=o9Iv8jvc0s9OueyKSgyAU9Cl/5JN0SkPMTmIZpV2peCN5NB7sA+rIsCl1FEulcdlG4
         W1ZHzzRtxVsblWYFNifeHfiz5ymb/eg4y9POolqiS/nFwLgJsihPlbTxzPFJ75N15C4C
         HxMZvEh4tUHSIJaLwWIVyVCVV8DR8AvvpM0zJItcynWSKYpc0DVxYi+RACGKKQp0Kg0G
         Xjuo4EsS3x7bkAaIDSpUeX1xmoJAi/BIWVWjq4XvINrkZ9yv1+TjcVxxdWuIYz5gkMFS
         cra2ICH3U6vt8GUEfZe0wvf7lKRXzGf1Hj6Ty2ex86ll9JhWYi41NzNGsIsX38flvbYi
         cgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x7IBBbge8UGVC2hAhuLJB7s1DADr52Epb3KeW/cnCYk=;
        b=kbAPkvJGyNr7jec4h6b+UmGUpDgZ2YKPVOXHM3dd1KpTwmzvCEUEPQcmQL5ebD82Gt
         jQfaxKpRns4/G9o6tOr5F/CcFYDXoApDirDiP79oO/H1JdqBDGOQ3D8xDLRmiSjsVGad
         Tuf68IBh9wsa/CrdyCAK44VW1hd/yPt7vbKtxCKpAFnkEYam+GhIL/Em5oWJXZVUsYUA
         BjLn3iREHHCR4wGbAQc8c4nw5aC2MCZ+jpurzRqhC/F2DLXLamx2juf27AGX9Wcu/bzr
         55teBs1SeXK3B6WUanlvCLo4tw8SIMl/7FQ1+HZcnxfeRBgIka4hMMFYtVVL5dGSXqWB
         2ayQ==
X-Gm-Message-State: AOUpUlH0M4RArEf2N+eB/+Y0BwKvDx2NWxtjKlzqg+h08c8uKKqHuIJ+
        6dLReOyR855QM7L3+azsFVeIUA==
X-Google-Smtp-Source: AAOMgpeLBxbZv4aeOT6kAPkvMnd6hCwzDh2iMHwA8ejnuEbbUjxXKlEW74/UIWgJDkmtkapLhztvhA==
X-Received: by 2002:aed:237a:: with SMTP id i55-v6mr26437206qtc.263.1533144551850;
        Wed, 01 Aug 2018 10:29:11 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id b83-v6sm12490429qkc.20.2018.08.01.10.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 10:29:10 -0700 (PDT)
Date:   Wed, 1 Aug 2018 13:32:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] mm, oom: refactor oom_kill_process()
Message-ID: <20180801173206.GB11386@cmpxchg.org>
References: <20180730180100.25079-1-guro@fb.com>
 <20180730180100.25079-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730180100.25079-3-guro@fb.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:00:59AM -0700, Roman Gushchin wrote:
> oom_kill_process() consists of two logical parts: the first one is
> responsible for considering task's children as a potential victim and
> printing the debug information.  The second half is responsible for
> sending SIGKILL to all tasks sharing the mm struct with the given victim.
> 
> This commit splits oom_kill_process() with an intention to re-use the the
> second half: __oom_kill_process().
> 
> The cgroup-aware OOM killer will kill multiple tasks belonging to the
> victim cgroup.  We don't need to print the debug information for the each
> task, as well as play with task selection (considering task's children),
> so we can't use the existing oom_kill_process().
> 
> Link: http://lkml.kernel.org/r/20171130152824.1591-2-guro@fb.com
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: David Rientjes <rientjes@google.com>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

This is pretty straight-forward.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
