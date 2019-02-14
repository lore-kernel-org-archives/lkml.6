Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E417F222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYW4QXUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393852AbfBNCJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:09:08 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35257 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390663AbfBNCJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:09:05 -0500
Received: by mail-vs1-f67.google.com with SMTP id e7so2723803vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2W8IxqwU5oOVLVpQ7/T8/p48+iqaHtvLrU3SqLj28mg=;
        b=vYW4QXUSSD3sHoPN6JSArtilgaYIscuK6k7qrKKHczyaYGVELCThNIv+iTnV93Y0fI
         3qCe3LosKtMzeRY+ElIXuzttv1SQ66a0zgklWPz6TvmoSjdJcZlOAlgpewAVKQrxQKsh
         yjFEelZSj4Jx2CjZQErkVE9LxYU6QLDv/uJkMyOcU67lLlH1oaAvDBLNrcXOD+jJphbO
         I3Cr/uAZTVAu99+PqDV5n28ZrFAYAjPu+frZLC9nzZv7PXzfrtplig8YNao5aqvH+Qy8
         QG8ydLxENnvhYbYlElK1Fg6eAyGw9jXArPid67Y17nikZTbNJSIUCqoYcEPQ7gkA/58o
         QeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2W8IxqwU5oOVLVpQ7/T8/p48+iqaHtvLrU3SqLj28mg=;
        b=Cgbk1YS8Sn2AtFnhkLMvZCIsfzTesH3QJqCGg1rfdTE3w9hAAzGAwGGAz+HWS2gg/P
         KhgaSDD3GfBZ/xu/Ot46aS5H/KPE77MwFNKweiOs4kn40PpYAwKcqkaxhMWm1G8eu1Yc
         AbbZiPe8BcG1NF1tGTCO49jjATcruYPaxFSo2spZHLq+qR0AsTBX/oUPaXwO3Qy6ftSi
         Z+YsTkKIhMEJXqiDt3hmgE1r8GQyCG7jbQwXMFaqX0Q0d6PH4qyK1G7IDYUFuQzWS3h2
         4T/onNxiyCNtBeHskpHiMqENBUq8yqsb4qjPP+nipPNCLY/PHd1+6v6EQ5RBE+jakYfj
         4jVg==
X-Gm-Message-State: AHQUAubAweyUF4gVI8ybL4Ij/u3+8OsmjecClTARPwKPrT2FAwBJXnMm
        wX6fZT8GXrxKyisElJQkN9yrWBCTq2WmrLCX3XkxHQulJXQ=
X-Google-Smtp-Source: AHgI3IYbRuIp7LSqt86c78634zDYSKMCDi0RfykMAiMoK1Zhg+aQr6Lmnf2heDvZfA090DQLW3pdF3xGfo8sb4QJwQ4=
X-Received: by 2002:a67:f715:: with SMTP id m21mr752031vso.51.1550110144476;
 Wed, 13 Feb 2019 18:09:04 -0800 (PST)
MIME-Version: 1.0
References: <1549955366-19930-1-git-send-email-jing.xia@unisoc.com> <19b0aefd-d265-2092-4787-34de20033ec1@redhat.com>
In-Reply-To: <19b0aefd-d265-2092-4787-34de20033ec1@redhat.com>
From:   jing xia <jing.xia.mail@gmail.com>
Date:   Thu, 14 Feb 2019 10:08:53 +0800
Message-ID: <CAN=25QPaHd9qpH-OK+0LL951=0hwf1frsC7H1O9hGimsyVUKVg@mail.gmail.com>
Subject: Re: [PATCH] staging: android: ion: Use low_order_gfp_flags for
 smaller allocations
To:     Laura Abbott <labbott@redhat.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, gregkh@linuxfoundation.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        puck.chen@hisilicon.com, devel@driverdev.osuosl.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, yuming.han@unisoc.com,
        zhaoyang.huang@unisoc.com, orson.zhai@unisoc.com,
        wenan.hu@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

On Thu, Feb 14, 2019 at 2:27 AM Laura Abbott <labbott@redhat.com> wrote:
>
> On 2/11/19 11:09 PM, Jing Xia wrote:
> > gfp_flags is always set high_order_gfp_flags even if allocations of
> > order 0 are made.But for smaller allocations, the system should be able
> > to reclaim some memory.
> >
> > Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> > Reviewed-by: Yuming Han <yuming.han@unisoc.com>
> > Reviewed-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > Reviewed-by: Orson Zhai <orson.zhai@unisoc.com>
> > ---
> >   drivers/staging/android/ion/ion_system_heap.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> > index 0383f75..20f2103 100644
> > --- a/drivers/staging/android/ion/ion_system_heap.c
> > +++ b/drivers/staging/android/ion/ion_system_heap.c
> > @@ -223,10 +223,10 @@ static void ion_system_heap_destroy_pools(struct ion_page_pool **pools)
> >   static int ion_system_heap_create_pools(struct ion_page_pool **pools)
> >   {
> >       int i;
> > -     gfp_t gfp_flags = low_order_gfp_flags;
> >
> >       for (i = 0; i < NUM_ORDERS; i++) {
> >               struct ion_page_pool *pool;
> > +             gfp_t gfp_flags = low_order_gfp_flags;
> >
> >               if (orders[i] > 4)
> >                       gfp_flags = high_order_gfp_flags;
> >
>
> This was already submitted in
> https://lore.kernel.org/lkml/1549004386-38778-1-git-send-email-saberlily.xia@hisilicon.com/T/#u
> (I'm also very behind on Ion e-mail and need to catch up...)
>
> Laura
