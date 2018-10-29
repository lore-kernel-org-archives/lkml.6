Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FB2C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BFE20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aI6cvGIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BFE20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbeJ3FBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:01:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34446 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeJ3FBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:01:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id f1-v6so10337514wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9uwkIJqD3/RJNs7O5413LjTAloFyUTySIaEkiJjKbCQ=;
        b=aI6cvGIJzGMnA5YygWXKsckcfxqVKdIuenSzwL4wozANm9NzgloiQFUU6o23trib3a
         KqwofM7ZvLAeMcBhfpm3Yxu0lNwDWnIQge2poCzudVe4JwYu9ZelN4yksQ6Skh3O2wrq
         xp/Mh7217J8FCUxNeRC8D7BPIK836PR23GsFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9uwkIJqD3/RJNs7O5413LjTAloFyUTySIaEkiJjKbCQ=;
        b=ddP5+o/g71E/bKhr/atDCy5vFF66F+4KAIzR/nC5F5TqCf7Jz2mEhqJqh16hu99nl/
         bkR3UNkebP0J3AnX/C7c8sqvkhacDLBT26B9b7VPjREFJq+LNU2UB1WBpX464EWK7pfv
         9P6/16k+AfZ1lB4gLOeJ0fzIHwFgPy8lAbvpObZ9lieAbJ4wh+apxFPfm+E5nk4qik/7
         j+2Lxja15XbwQijf5BcbCetcTT8VrzKQMflKFfYtjZ/NJB3kkzJqj/QnjmpXcvN/Gvt7
         smeLiDn4+E8v85XPLvfP+hWsxQopDG9tV12ccJZIrwvZPNYPARCL7BmwUb5/81YaQPlY
         Y5Aw==
X-Gm-Message-State: AGRZ1gLGPrs1Kvkqe3CeOymfB4q8O5LvBv6cuC4YO6INdQfqv9/3dKIM
        8pCPGe3hKraDKhYRmg+J/V6wdxTjhgwkU+XT/vtsOg==
X-Google-Smtp-Source: AJdET5ePZnIO2dRdz4RZMZ9nnhG26h3vddd2z6ztvoQH4d4kRrWkb0n10E955VZYVwOF7robqYYoEiGWv/INjJYjbT8=
X-Received: by 2002:a1c:607:: with SMTP id 7-v6mr14711905wmg.103.1540843896979;
 Mon, 29 Oct 2018 13:11:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9f47:0:0:0:0:0 with HTTP; Mon, 29 Oct 2018 13:11:36
 -0700 (PDT)
In-Reply-To: <20181029200920.28901-1-semen.protsenko@linaro.org>
References: <20181029200920.28901-1-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 29 Oct 2018 22:11:36 +0200
Message-ID: <CAKaJLVsgFABhXx-MeOinV0obS9DBt7CsQ-TvDhgf0yGCTsd+rA@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/SRCU: Fix ctags
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Oct 29, 2018 at 10:09 PM, Sam Protsenko
<semen.protsenko@linaro.org> wrote:
> ctags indexing ("make tags" command) throws this warning:
>
>     ctags: Warning: include/linux/notifier.h:125:
>     null expansion of name pattern "\1"
>
> This is the result of DEFINE_PER_CPU() macro exapansion. Fix that by
> getting rid of line break.
>
> Similar fix was already done in commit 25528213fe9f ("tags: Fix
> DEFINE_PER_CPU expansions"), but this one probably wasn't noticed.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

This one was sent some time ago, but there wasn't any response. Can
you please review it and merge if applicable?

Thanks!

>  include/linux/notifier.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> index f35c7bf76143..0096a05395e3 100644
> --- a/include/linux/notifier.h
> +++ b/include/linux/notifier.h
> @@ -122,8 +122,7 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
>
>  #ifdef CONFIG_TREE_SRCU
>  #define _SRCU_NOTIFIER_HEAD(name, mod)                         \
> -       static DEFINE_PER_CPU(struct srcu_data,                 \
> -                       name##_head_srcu_data);                 \
> +       static DEFINE_PER_CPU(struct srcu_data, name##_head_srcu_data); \
>         mod struct srcu_notifier_head name =                    \
>                         SRCU_NOTIFIER_INIT(name, name##_head_srcu_data)
>
> --
> 2.19.1
>
