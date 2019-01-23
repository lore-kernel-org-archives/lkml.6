Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF4EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FC821855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGCbI81j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfAWXOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:14:36 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38170 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfAWXOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:14:36 -0500
Received: by mail-yw1-f65.google.com with SMTP id d190so1644608ywb.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77nseqghbtkKnRpvB3e475OP+PoAx0CijNQ1xr4WOls=;
        b=uGCbI81jfiPjJKcNJOeEOOYc7D+GD5tAx5o4QqDcnN2jXkUw6RH7RZtHQT84tsntVh
         6tGdeExAIGA/05gxxWyhyckbR128hFtWJ4u8WdBxZ+dtJ+QNDHe3RRM8jgohOmOt/nXD
         BXmVp0sM2UnzA4l/Jt0lqcA9NcW+L+Dk1cFJneL5YS1QF6GwyalZlc382VyMuTPnMF4K
         taJCuZ9PVnjNnzvpp2ji+/FLFqXflAfQzzr1QiWbJbw58ibrqT40MxR4NKVw7Pmct/Gt
         sFvECnkjmmS1a0OndhB3jDCTfyFMoHCwEIGFARGXzkd/MTbhk3/IM6ezw6KdHQsx4srJ
         7fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77nseqghbtkKnRpvB3e475OP+PoAx0CijNQ1xr4WOls=;
        b=WGAfcEegvQKJK+B85zxrT6o8OLMgeITyMGtfrcY84lFTu+8rp3HlmFGpX7Nwl2IKCp
         iOBDxcBj48ElJDMm+AH/HAPNoJzesu+/Bq5AICkE7DJ5NaIIqlSQYu5DM9qB7YPZdpqe
         lxM2OM6MMXkqE6RsZQ4CQzIU0+ucSFVHB3HPS6Xwv+inUF3DoDqnuJnHbaFrqxOqj0aR
         2VTken05s3ylH/5ICMdG5tqK2hL2yuF0d58aW+TVRA7pipsnSd3X8NgJ5tS3bUo79aob
         qJYr96FOyd+tsNShR17f5GGjWLox9vD6/tG1tVM6duVSC/hfJKeFhLx6vz0vjNbW7SbM
         Mk7A==
X-Gm-Message-State: AJcUukcPMyBs+5haeDhgZv4S3rHVxxcPD6sN6P6ORZNh46R6vnWS/lse
        T4Zi5xfZGVnohEUKl+BR8Ci92o/qKlNHO3yHnwXhnQ==
X-Google-Smtp-Source: ALg8bN5/2AzYRxKLMu5LI/hDbLHSR/jN9IBZ4A2oLxjcFDGOySnrBCBRZaPkMbQWulmQXz9os4q4lrzOE3Th0laJ28c=
X-Received: by 2002:a81:ee07:: with SMTP id l7mr4081632ywm.489.1548285275451;
 Wed, 23 Jan 2019 15:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20190121215850.221745-1-shakeelb@google.com> <20190123225747.8715120856@mail.kernel.org>
In-Reply-To: <20190123225747.8715120856@mail.kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 23 Jan 2019 15:14:24 -0800
Message-ID: <CALvZod5h7fSoZTA+3bDTn93JuFgY=SUGEq=gpDYE8rdSfuNcPQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm, oom: fix use-after-free in oom_kill_process
To:     Sasha Levin <sashal@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stable@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 2:57 PM Sasha Levin <sashal@kernel.org> wrote:
>
> Hi,
>
> [This is an automated email]
>
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 6b0c81b3be11 mm, oom: reduce dependency on tasklist_lock.
>
> The bot has tested the following trees: v4.20.3, v4.19.16, v4.14.94, v4.9.151, v4.4.171, v3.18.132.
>
> v4.20.3: Build OK!
> v4.19.16: Build OK!
> v4.14.94: Failed to apply! Possible dependencies:
>     5989ad7b5ede ("mm, oom: refactor oom_kill_process()")
>

Very easy to resolve the conflict. Please let me know if you want me
to send a version for 4.14-stable kernel.

> v4.9.151: Build OK!
> v4.4.171: Build OK!
> v3.18.132: Build OK!
>
>
> How should we proceed with this patch?
>

We do want to backport this patch to stable kernels. However shouldn't
we wait for this patch to be applied to Linus's tree first.

Shakeel
