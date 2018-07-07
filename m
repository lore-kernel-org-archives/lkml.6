Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C4AC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4751C20C0A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkeC3tBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4751C20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932779AbeGGVNB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 17:13:01 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:37405 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbeGGVNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 17:13:00 -0400
Received: by mail-io0-f169.google.com with SMTP id z19-v6so13842970ioh.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 14:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7F1yK0yM2gpuHGU78TIxo2sQ6eBFe4mIPqhduco8i/Q=;
        b=dkeC3tBHAQVhiJYCQuBNjcBvTvy63tXSoiNoXV4ywLe1tl+OgAnOOfoGXGzYX+hFeM
         cd4Y4NAdi03854oiDJyDh5CsPIHnXGIuZl3hVDfhUHo9DwDizLD1Rpa2tmJA5GycBY0t
         ALZ4/yIzb4ZONtixJNOm0seIw7p8ihjM53BzQefZs+2Ze3yjFOYyQFSnrj4P1Op3pXwG
         C8spkLqG9PUo+KSD3nGSi7lywi6R4WXdBYD+7/sz2ec+5gWmdjqBLmqKQGj6k6aJDrbh
         n6im+N+A7nwo471/JgA6y9w7zhH2GyN2guRt6rgD0KmuyY0GKkEVohueGn+kEgadMCyP
         6c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7F1yK0yM2gpuHGU78TIxo2sQ6eBFe4mIPqhduco8i/Q=;
        b=RduatW62VFKObl32aT4Kw38bZ8Cc1WhNtFoc97hMqiD4xkvIjFMiCDEur/j5gNxh95
         M9gMjB3cbNV9Vf3vPWq5hD5+vwH4h8iKCU38dAsA2qiWnx5kFqxF/kp4ONtgruLIkyuY
         6SJ4mOeXW/2VBPUwcd7yS8Fj53r0xHqGn/oa0dMZ/UUlCWT+L8p4rqbkFh8QGsoMLM66
         8yl5IBx54hMQdVAc7msqtHTKeyjGHURGTpaE8XcrFBhRr1P7DJoJ9qL6WmCswdB6dWDU
         ImlaL1vnOlJ9LHYbzouDjUwdP6RbLAubs7HlyB4IJQtHFLtVDDvNFDPaFbVwTOREQGvq
         hFww==
X-Gm-Message-State: APt69E3VbfjYHi//CpaZna6envBwqz5coqQdjbqWt90p1KkFffr4W6wT
        jEHnkAB3CW3wtHLaGKFA3CWdfbO7aF39NgnqxUw=
X-Google-Smtp-Source: AAOMgpcwcn0vWMUKMwE3oGrqW2obnJcWqL5CrFCZQwrl0e5fCyPQJWq09dLmOsGlFu2mvzUuAL4Cs1Wb0iBy3MSQdLA=
X-Received: by 2002:a6b:2c82:: with SMTP id s124-v6mr12036468ios.136.1530997979438;
 Sat, 07 Jul 2018 14:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180622035151.6676-1-ying.huang@intel.com> <20180622035151.6676-3-ying.huang@intel.com>
In-Reply-To: <20180622035151.6676-3-ying.huang@intel.com>
From:   Dan Williams <dan.j.williams@gmail.com>
Date:   Sat, 7 Jul 2018 14:12:48 -0700
Message-ID: <CAA9_cmc2b97TCRAKz-r4Zhb9mq_hsr41Xwe1zQkyhsLUc5LWPg@mail.gmail.com>
Subject: Re: [PATCH -mm -v4 02/21] mm, THP, swap: Make CONFIG_THP_SWAP depends
 on CONFIG_SWAP
To:     ying.huang@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, hughd@google.com,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        n-horiguchi@ah.jp.nec.com, zi.yan@cs.rutgers.edu,
        daniel.m.jordan@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 8:55 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> From: Huang Ying <ying.huang@intel.com>
>
> It's unreasonable to optimize swapping for THP without basic swapping
> support.  And this will cause build errors when THP_SWAP functions are
> defined in swapfile.c and called elsewhere.
>
> The comments are fixed too to reflect the latest progress.

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
