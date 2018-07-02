Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA47C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92C325177
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCE8U6aU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92C325177
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753657AbeGBV4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:56:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53799 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbeGBV4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:56:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id b188-v6so235413wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qibBM+30K2a5QarUPOZub4Nik/43CmDJciNQxoH1+fg=;
        b=ZCE8U6aU9pOCN8RnxNeeUHFxFIlKSfOCDvLu9Ix67zdjS+l6Hx8XI5k0Sjje/3SwOg
         Mpccwf4jEaJ8Q/MHumE31BkLunHvQwc2HUkADeti/TpLpWVtlXXxjlI0SpNpd3g6tkKm
         iXDvM6qDEec1b5GwMXm/50ZzmSDwW1MRgLHWZLEspjMNb1CDNFZXPJ03qMe11L5NhIvD
         ZVw1gG5eV66PiaPYMlTqQyxMhXU4omObdvDVTHZfP/0w9d8Pv7n54ZgxKZ/7TRFkZ5T3
         VFEBfnMJx3epiBZ2Me8wd47zzMh4M3yUPh8NMzqJAapmQagfdCk4ChBDM8/5eJh3pWcN
         mvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qibBM+30K2a5QarUPOZub4Nik/43CmDJciNQxoH1+fg=;
        b=Yq0f9o4iiBGo6jp7byl8zU4P38m7XY6ocx6AiHWDX/9mtScIbMVqaxXnzh4LWJKb1b
         CgTYT08tPHMNqDJO0KzZKT2AIyD8ixjtvD7ap8/3msmk+NielitnO+QB/TymenjpJQ56
         ftbpgxvQpoIjTHM5NuULJOn/ZIpAsMDmACBZ82c49Obd5LRyK/JTD1GxjjhOewQH7mpI
         FKopOSbEgqWW4rXLMeUKtcZCjRw9pavhBxVZkwXODDruX7sjOIDToSeVCr67wct/J2UZ
         Vcj/xlIwJ/z+5kyIhWFvQrH9pVIaCAG2X9WbQ2yUKAWU/xJPvrkYmTNlRH6GVsCn/lzF
         Gklg==
X-Gm-Message-State: APt69E3uU68f0zaOrDd/xeuqlFFMsK0I1wtkxWWPJDYZEZGyPqO6I5Vw
        bGMB6Z37a+/3ZKpgj/R3gcgznVkViLrUNP0VXMzutWCP
X-Google-Smtp-Source: AAOMgpf/VYSQp2fiCLzMsJmm9oxEXqv0WTIts/26XmivPezekhf8/9WVRDk3EqQx650XztLWDpcMmz5BuY/HWZzlK9w=
X-Received: by 2002:a1c:9106:: with SMTP id t6-v6mr9593467wmd.2.1530568582599;
 Mon, 02 Jul 2018 14:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180627191250.209150-2-shakeelb@google.com> <20180702215439.211597-1-shakeelb@google.com>
In-Reply-To: <20180702215439.211597-1-shakeelb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 2 Jul 2018 14:56:10 -0700
Message-ID: <CALvZod6uGK+hYxwnVWbwj6LDxq4Aqd-D2jwp=QyKNTaJH0e4vw@mail.gmail.com>
Subject: Re: [PATCH] fs-fsnotify-account-fsnotify-metadata-to-kmemcg.patch.cleanup
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 2:54 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> Hi Andres, this is a small cleanup to the patch "fs: fsnotify: account

*Andrew*

> fsnotify metadata to kmemcg". Please squash.
>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  fs/notify/fanotify/fanotify.c        | 2 +-
>  fs/notify/inotify/inotify_fsnotify.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 6ff1f75d156d..eb4e75175cfb 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -142,7 +142,7 @@ struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
>                                                  const struct path *path)
>  {
>         struct fanotify_event_info *event = NULL;
> -       gfp_t gfp = GFP_KERNEL | __GFP_ACCOUNT;
> +       gfp_t gfp = GFP_KERNEL_ACCOUNT;
>
>         /*
>          * For queues with unlimited length lost events are not expected and
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index 52e167d04b11..f4184b4f3815 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -101,7 +101,7 @@ int inotify_handle_event(struct fsnotify_group *group,
>
>         /* Whoever is interested in the event, pays for the allocation. */
>         memalloc_use_memcg(group->memcg);
> -       event = kmalloc(alloc_len, GFP_KERNEL | __GFP_ACCOUNT);
> +       event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT);
>         memalloc_unuse_memcg();
>
>         if (unlikely(!event)) {
> --
> 2.18.0.399.gad0ab374a1-goog
>
