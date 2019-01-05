Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B38C43444
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE3C21872
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/IYiBRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfAEAng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:43:36 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38734 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfAEAng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 19:43:36 -0500
Received: by mail-yb1-f193.google.com with SMTP id x9so6418648ybj.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 16:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snHqLQmz4nt+VNG034zl1FNOGYA7ZEBfLYfuKiNvzvE=;
        b=R/IYiBRYG+40WnMu2AApy0CGvAWBAXw3LLoHJhw/4mdSbXpsJqLtNIo2TdL28mKP2R
         jBdmt2yPvZH9c+sP9Gl0idk7S3bG7lO40H1TIFGD+FTiruxX2opueuOv4XNFU5saRzv6
         YJveZFBkl9SohMJxX44nJJNQirz7B6bh5plb/jFTUS2APj2WQ6fgZbglZ0eBoSrY5nzy
         LxTprWV6t7i/bDlhHN+Y5UfRIl3tcPTbtEuUh5OVRhboWUXx7sSz0YyB9dSSGqEE48au
         qxhMzGAyXhNVFr5hPA2d5iy4YvNHf+LuEPa34dSo+Vaxr9uzcmEN1v44fCeWaZuPmRhb
         AAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snHqLQmz4nt+VNG034zl1FNOGYA7ZEBfLYfuKiNvzvE=;
        b=NgEAsU921yKYio6QM7lkMtvhazojctzdJxy9us3PLJ3YSCui44yMuEo7bro/IL+WlP
         46Csqp2a1Qypy79oJkOe53u4Y7pSFRbHzuTzQTqf0aM6TFwxFUAMcx/OArV1qoqBhmUz
         Je6vVnLAS8wlWNfBAP7WWz9L6FFGGT+FOndBZOVVaf9yHWVdxJDlEDV6+vGsUaNNs67x
         z7LbP2Y7Ew8K8DCFbkrkWoESUYsfBNb8+QAiTFowqV9bw1xztKun4wyaT589W3EdKOfC
         DQ1FxtS074K+c3WpN9rTESb6hfxeuPgIop0JQQDglI/0rGldzA3omscBaosJUDsFPNFj
         J/Zg==
X-Gm-Message-State: AJcUukcIC95rXj3jY2bqu4bc1oEPVB3uvxU0YBe7L5BT0i7IzrS9HcVV
        gy6TLPFkSzpJOzad74tbqX1ivZYPOw5CxDFa9aikZsGOTkQ=
X-Google-Smtp-Source: ALg8bN7TM7HkFVP1EabeeX+prME1evMFy5HlgmxrURWGtISoIJw7J0auA1L+qAdydzGRcW7HuUvxmpPE86nTUj9QCKk=
X-Received: by 2002:a25:2743:: with SMTP id n64mr21202102ybn.164.1546649013690;
 Fri, 04 Jan 2019 16:43:33 -0800 (PST)
MIME-Version: 1.0
References: <1546647560-40026-1-git-send-email-yang.shi@linux.alibaba.com> <1546647560-40026-3-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1546647560-40026-3-git-send-email-yang.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 4 Jan 2019 16:43:22 -0800
Message-ID: <CALvZod5Fh0K-JKGPH90c+ONBSTdwo7Z8fUyyAMen=ZDzPqTAXQ@mail.gmail.com>
Subject: Re: [v2 PATCH 2/5] mm: memcontrol: do not try to do swap when force empty
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 4:21 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> The typical usecase of force empty is to try to reclaim as much as
> possible memory before offlining a memcg.  Since there should be no
> attached tasks to offlining memcg, the tasks anonymous pages would have
> already been freed or uncharged.  Even though anonymous pages get
> swapped out, but they still get charged to swap space.  So, it sounds
> pointless to do swap for force empty.
>
> I tried to dig into the history of this, it was introduced by
> commit 8c7c6e34a125 ("memcg: mem+swap controller core"), but there is
> not any clue about why it was done so at the first place.
>
> The below simple test script shows slight file cache reclaim improvement
> when swap is on.
>
> echo 3 > /proc/sys/vm/drop_caches
> mkdir /sys/fs/cgroup/memory/test
> echo 30 > /sys/fs/cgroup/memory/test/memory.swappiness
> echo $$ >/sys/fs/cgroup/memory/test/cgroup.procs
> cat /proc/meminfo | grep ^Cached|awk -F" " '{print $2}'
> dd if=/dev/zero of=/mnt/test bs=1M count=1024
> ping localhost > /dev/null &
> echo 1 > /sys/fs/cgroup/memory/test/memory.force_empty
> killall ping
> echo $$ >/sys/fs/cgroup/memory/cgroup.procs
> cat /proc/meminfo | grep ^Cached|awk -F" " '{print $2}'
> rmdir /sys/fs/cgroup/memory/test
> cat /proc/meminfo | grep ^Cached|awk -F" " '{print $2}'
>
> The number of page cache is:
>                         w/o             w/
> before force empty    1088792        1088784
> after force empty     41492          39428
> reclaimed             1047300        1049356
>
> Without doing swap, force empty can reclaim 2MB more memory in 1GB page
> cache.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index af7f18b..75208a2 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2895,7 +2895,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
>                         return -EINTR;
>
>                 progress = try_to_free_mem_cgroup_pages(memcg, 1,
> -                                                       GFP_KERNEL, true);
> +                                                       GFP_KERNEL, false);

I think we agreed not to change the behavior of force_empty. You can
customize 'force_empty on wipe_on_offline' to not swapout.

>                 if (!progress) {
>                         nr_retries--;
>                         /* maybe some writeback is necessary */
> --
> 1.8.3.1
>
