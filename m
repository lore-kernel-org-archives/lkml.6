Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABA9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0279B208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v62vbgbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0279B208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeGaD1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 23:27:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34785 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeGaD1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 23:27:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so8219976pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 18:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WZ/VqO0Y5Z2+nzfW9+St0EhhfoPl1nEoc/n2L7EZdvw=;
        b=v62vbgbH5GsgDHdsy6Mq/eI38ml3TRq1766MlrSGtB2sDTnXNAQ5xUvFKvw7Q2UI/N
         gN1fn5uM7HKCATQoQKfRzPCbHLcxcaKSEem4XCYkXFai/qLCKW3fDnRg5P+7ofBO+VHn
         Q6GBh8YueSuve4eYKE945PUXTSmy30z97r3mOxzsEemJW7+havxUGAeOsVsR8lO8QB/r
         wDCx675DOrE3iNOvAPzlX2xwwaVAklDMCCMz+NAhGCkj0oJX2jZ0+vlQ/fPhkQRf3X2T
         jySyXpR6vJNtd6fIXwIQWyCQtUyJG1ezeTEF9gyEEs0NRq0IijBubLVmt9n57IIJZCVf
         9XvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WZ/VqO0Y5Z2+nzfW9+St0EhhfoPl1nEoc/n2L7EZdvw=;
        b=gbq/eeFpn3E27NX0S2YHx8/sMWmG7yhwMkQ5089QQVP3heqfef4Xhizv3UZHjAiP09
         h4ZFiqlTwXI/+qVuB5iZP3qOnvgrsKU5ZPLSrcGWm80gBUvQi185E6MzZKovjWDIo3gl
         6jwhDzrpavXlMapJAvQgRpGUuKOJWl2uhE4453URt5Q1KTRDm3NrLoIEck0h3GpeoAll
         M2SmxNQVjIYKY2LoeK6HNGHL0+V8Sl32C1w6w+wyjRWv0wHFj3CsqMYMYzImXYNNpVOL
         vSwiUi/2nbwM1KTADzT0m3R9J7JePPft2odxaJoQyB9RJuXuZbjTVPaq3zr5f5YMTIgd
         BHvg==
X-Gm-Message-State: AOUpUlFGK6KWZaD2AGcl3qowPJmizLvYaUPQ8uJ35np6tTLLxYU+pGzj
        3OmKtxWPDK0jBMYNKXvVhNah6w==
X-Google-Smtp-Source: AAOMgpcQVdnTwudSXKjUJrS7xYbvw0idYNJEFHNce7U1Wmtgr53ns25BkbMYpQT9QkOmpoUiOExs6w==
X-Received: by 2002:a63:8c0b:: with SMTP id m11-v6mr18581423pgd.372.1533001773137;
        Mon, 30 Jul 2018 18:49:33 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z10-v6sm17387799pfh.83.2018.07.30.18.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 18:49:32 -0700 (PDT)
Date:   Mon, 30 Jul 2018 18:49:31 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Roman Gushchin <guro@fb.com>
cc:     linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] introduce memory.oom.group
In-Reply-To: <20180730180100.25079-1-guro@fb.com>
Message-ID: <alpine.DEB.2.21.1807301847000.198273@chino.kir.corp.google.com>
References: <20180730180100.25079-1-guro@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018, Roman Gushchin wrote:

> This is a tiny implementation of cgroup-aware OOM killer,
> which adds an ability to kill a cgroup as a single unit
> and so guarantee the integrity of the workload.
> 
> Although it has only a limited functionality in comparison
> to what now resides in the mm tree (it doesn't change
> the victim task selection algorithm, doesn't look
> at memory stas on cgroup level, etc), it's also much
> simpler and more straightforward. So, hopefully, we can
> avoid having long debates here, as we had with the full
> implementation.
> 
> As it doesn't prevent any futher development,
> and implements an useful and complete feature,
> it looks as a sane way forward.
> 
> This patchset is against Linus's tree to avoid conflicts
> with the cgroup-aware OOM killer patchset in the mm tree.
> 
> Two first patches are already in the mm tree.
> The first one ("mm: introduce mem_cgroup_put() helper")
> is totally fine, and the second's commit message has to be
> changed to reflect that it's not a part of old patchset
> anymore.
> 

What's the plan with the cgroup aware oom killer?  It has been sitting in 
the -mm tree for ages with no clear path to being merged.

Are you suggesting this patchset as a preliminary series so the cgroup 
aware oom killer should be removed from the -mm tree and this should be 
merged instead?  If so, what is the plan going forward for the cgroup 
aware oom killer?

Are you planning on reviewing the patchset to fix the cgroup aware oom 
killer at https://marc.info/?l=linux-kernel&m=153152325411865 which has 
been waiting for feedback since March?
