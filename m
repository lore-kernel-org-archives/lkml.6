Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 71135C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2454C2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFYJuddY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2454C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932961AbeFLFhx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:37:53 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:42607 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbeFLFhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:37:51 -0400
Received: by mail-yb0-f193.google.com with SMTP id d123-v6so7505665ybh.9;
        Mon, 11 Jun 2018 22:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f1UKvr66Escybq5NeRGshx1FfsH9+fGZXqfNnU4A1fA=;
        b=WFYJuddYhso9Yd9QLPVxsk41uZP6J6l260XMnko2XO8/N2nt57z9n+IzPzt5gNupmk
         MDdnyurEYq7TbDCBLPpjY+9f/69QTLCXSm9VIieI7FDy0uOFhHoBLUdVjEclQjbfN3zz
         w9QxlM6UC2m0ktOCzxC/4KdWhG4XP9phapgu/KQjilqqWXzytp05sMj7ifib5xqTXFfb
         0pHgtLtmQnFWzXbpTy+AVFFwpc5N43lT53bvumV/usayX1n9LdtiDD+ZELCpttNMHJw1
         jXkNwBpZ3A30Z5rLe6ZmzPkRT6lL2a6UZqEZhd3gFKXOzkTCF3//Ak7gzWAG1luvucgS
         83pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f1UKvr66Escybq5NeRGshx1FfsH9+fGZXqfNnU4A1fA=;
        b=aduvKoa7t9XWkzaXEBOvFaBBVEqfzaSWj2+5IitGbIj4cwIQiLEQ8F2PU/NYMatau5
         hEvXWi2aFlGZmvnSVR8ibBcxtGCRPkIoqcYEB/nirvrN1De9SfabLGVn3CNrPCxXeIDK
         Vy70d9ZS3cGhtKmAN0hnracM+V2ty/rR3f2gwisXGs9j3dUM+ONpWZ9pgw3H34n61/3T
         +16c9kixPauEdNqs7xpWvNK4IGDpEacNYyi8hr+NPv3KFOaoigZgt9jKVAOHk1dgdx9h
         a4TOcQ/YPVASk0Qpld2FjPoCACLT6AEmj0fgrB1HlqFG3UMqkrfJkqJFezyQccp6i943
         Ujyg==
X-Gm-Message-State: APt69E0XhisXLlr5eKNNJXOFUH/vOD8qL8omiD9T1Y2S9uhm5x6jkkHu
        wNT9TkjpmB/X4yJ/8mNXv9sXb9cVdGGvizgjjQI=
X-Google-Smtp-Source: ADUXVKLgSAk/dVgbwzOyJ1fIv5Wwd2J8BXTq61BSFaB95qbIh6S7e5C29eIkhBbfah0rviEG9/QOtif38NmfiEjT2fA=
X-Received: by 2002:a25:9d86:: with SMTP id v6-v6mr887725ybp.252.1528781871309;
 Mon, 11 Jun 2018 22:37:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:79cf:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 22:37:50
 -0700 (PDT)
In-Reply-To: <1528777174-40045-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528777174-40045-1-git-send-email-jiazhouyang09@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 Jun 2018 08:37:50 +0300
Message-ID: <CAOQ4uxjbB9mtt6Fq=CLrH5AQm0fPHscrW2+91+3zgn89cxL=aQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: add error handling for kmem_cache_create
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 7:19 AM, Zhouyang Jia <jiazhouyang09@gmail.com> wrote:
> When kmem_cache_create fails, the lack of error-handling code may
> cause unexpected results.
>
> This patch adds error-handling code after calling kmem_cache_create.
>
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index ec4d8c5..e3fa861 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -959,9 +959,14 @@ static int __init fanotify_user_setup(void)
>  {
>         fanotify_mark_cache = KMEM_CACHE(fsnotify_mark, SLAB_PANIC);
>         fanotify_event_cachep = KMEM_CACHE(fanotify_event_info, SLAB_PANIC);
> +       if (!fanotify_mark_cache || !fanotify_event_cachep)
> +               return -ENOMEM;

If only one failed need to free the other.

> +
>         if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS)) {
>                 fanotify_perm_event_cachep =
>                         KMEM_CACHE(fanotify_perm_event_info, SLAB_PANIC);
> +               if (!fanotify_perm_event_cachep)
> +                       return -ENOMEM;

here as well.
best implement as goto fail

>         }
>
>         return 0;

fail:
           if (fanotify_mark_cache)
                            kmem_cache_destroy(fanotify_mark_cache);
           ...
           return -ENOMEM;

Thanks,
Amir.
