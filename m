Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BDF75C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DA42086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baJZAMMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DA42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932674AbeFLFcM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:32:12 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:39884 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753584AbeFLFcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:32:10 -0400
Received: by mail-yw0-f193.google.com with SMTP id 81-v6so7105709ywb.6;
        Mon, 11 Jun 2018 22:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5SP2n5WBdA+IozLYtV2m690qBT9t4zUE1sxh2Fu2vQQ=;
        b=baJZAMMBentMrgyOIG8410RtMDLvsOFVhFlrlB5v7qFf3+0rPZR6044zVmJjTjDjiZ
         INSTujkr0OYMduff3BmFNMdozRkyfH9r8kQKzaK/nd0ZMSq61pGn0irK9qeex5q/iOP7
         qj9vMK543TbfaDJ9dasf/9X4qWEpUilcw3F96LsmIv7dQ6z56wPMyvpZYPjTE/6Te0Y3
         Z0wpnDy5vel/0L4F5un1NZDWxLcRx3DQGTCQxzKa0zo6zelpUinOfWIMgxgQxuOYIZhy
         zSPiaxHFcMss03pfOVt8nh1QNPkSLOQNjuBWO5V2QS9R+i1mU5rke0D7Bd7rb9oCPY88
         dMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5SP2n5WBdA+IozLYtV2m690qBT9t4zUE1sxh2Fu2vQQ=;
        b=hBntX7kckQVB6EFrFSazwsrUIa05lAXKtU9v7M21nOY60yG5V2EzKTroXuZ4R4Mhmq
         nd5gUYNS4qphTj3APfnF1UzEjiEPV4C5BRySROGGlrvW1q+PYJ5drn7eULPEQ7E+UXNu
         gpK0sN68k1sD5bu3ggIHJnizubCQ1P5LOmfYIFR/Fnttu+dbwAiiM+ozB0bYRKH3QwKW
         ETffr8r5ViZkb7TlWBgyQNSiTMZJyYhlXknc5c4cFnTtL/yWHElU2q4m4CKe2H8fOojX
         G4LZmBjI2ufDrOJgzKjhteC7RyNd1HQ0BzsfVSvRlEXdndYeOOSwpFxOAdnxQhDtD3rM
         YN4w==
X-Gm-Message-State: APt69E1Hm2+syvcBOZjDPn3Bn4InX/5cs1vPAcIPdxo1mL3enbaCbROe
        12Y0CZXc2rV+bdDEF3sF2eXSpjYSQ4kjdeBwrCA=
X-Google-Smtp-Source: ADUXVKLXsLgntPq99H9ANBDi8APzM8LCxt5R1DgE9W7Hy1AvpxC0PBubYortwWdOG4qzePqQX6BNTKFSGwdtVNyg3tQ=
X-Received: by 2002:a81:168a:: with SMTP id 132-v6mr828013yww.183.1528781529894;
 Mon, 11 Jun 2018 22:32:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:79cf:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 22:32:09
 -0700 (PDT)
In-Reply-To: <1528776964-39826-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528776964-39826-1-git-send-email-jiazhouyang09@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 Jun 2018 08:32:09 +0300
Message-ID: <CAOQ4uxgUoPB4jOCro4nDs7wby_GN593iuh8QhD9cGwSQJZJxdQ@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: add error handling for kmem_cache_create
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 7:16 AM, Zhouyang Jia <jiazhouyang09@gmail.com> wrote:
> When kmem_cache_create fails, the lack of error-handling code may
> cause unexpected results.
>
> This patch adds error-handling code after calling kmem_cache_create.
>
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  fs/notify/dnotify/dnotify.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index 63a1ca4..216b411 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -387,6 +387,9 @@ static int __init dnotify_init(void)
>         dnotify_struct_cache = KMEM_CACHE(dnotify_struct, SLAB_PANIC);
>         dnotify_mark_cache = KMEM_CACHE(dnotify_mark, SLAB_PANIC);
>
> +       if (!dnotify_struct_cache || !dnotify_mark_cache)
> +               return -ENOMEM;
> +

If only one failed need to free the other.

>         dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops);
>         if (IS_ERR(dnotify_group))
>                 panic("unable to allocate fsnotify group for dnotify\n");
> --
> 2.7.4
>
