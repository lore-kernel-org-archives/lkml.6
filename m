Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6272CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0F5207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V142VsRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfBVHLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:11:43 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45469 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfBVHLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:11:43 -0500
Received: by mail-vk1-f194.google.com with SMTP id v187so271560vkf.12;
        Thu, 21 Feb 2019 23:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhLAHfzflm2SeC2SAU2XlwN6EpN/a+dT0/dsBvfZo2Q=;
        b=V142VsRYrAwr/dGtKdvh2vj82TnZbAa/yJtMJmeWsVjM3tQKlQH7jEmeg/KwKQSrIZ
         Mj6rfGaziV9oFr0zc6NhwREqsTaselcn3wskDrdbHnQhK7KLiTl6QYCYvq6DQBBrDzOx
         0LScCjC0+AQbccQbeGySGj2dpc8nATO85xRHIRjcl0reZcy1F9yoizf3BmBRDiTC2ULK
         qcdj0pX+Hi0eizBSqlTbFqjyeQ+jt94GGncni0V11ahEqfzLaHwuddEPzQsajJXReph1
         8TkonaZhvCGV3dQkd3RYfUpvwWRxayZXybGXaqb1wsaFh5blNA2Vlol0GScdRoV3tO5o
         WeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhLAHfzflm2SeC2SAU2XlwN6EpN/a+dT0/dsBvfZo2Q=;
        b=q+iGnw1wpBHmhpuh7cdeKL5kIQQAOAGMgJNXMYV4mdWvZC7aoUVytwvacb4NazEuj4
         138YkZg1mUg5URzRz4hyeuTOAYeTgLR1+a8EUWlWD0r7j2VApBjujSR2Dmw2cmO4CWzS
         ycr0iqqrEOn90TtUDQ2rLF2jKKZuIiI/28FjInKHKuWEi2YzkFza5GKRL+iG8S/jPuaz
         770jXMuTgxPJKXvTeStFbgykC/CeNcfLtOlg17Gtxbl/mjQ+CyXD2lHP08eqoAnOKQyU
         cjpS3Jjl41KrGCokKQIWrIGyWBQWsSiaO1N5sPxZ4O2Mis8qOdYXX16vm46JSKGelsGY
         uuUw==
X-Gm-Message-State: AHQUAub+YWqnHLqsrWeJTGux5D28CHplG51AUHvkbZOI4Go+Yr6gkB1y
        SvWbdFSv13JqcQflYvEjjDndwHlgItNCfc6yQXQUNA==
X-Google-Smtp-Source: AHgI3Ib6T5EWUwCrHImXAW3lK/xd/nJ6CUtAXHyNTCahWe5OvYPni3z7JfoaLBJ8Xa3sI+dkWxr0zv1VL8PXO6YoW1E=
X-Received: by 2002:a1f:13c4:: with SMTP id 187mr1423280vkt.17.1550819501869;
 Thu, 21 Feb 2019 23:11:41 -0800 (PST)
MIME-Version: 1.0
References: <20190222054601.4396-1-weiyongjun1@huawei.com> <20190222070450.GA22604@kroah.com>
In-Reply-To: <20190222070450.GA22604@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 22 Feb 2019 09:11:17 +0200
Message-ID: <CAFCwf10u1qR+GVk-B-uPU9wWgN8yVDmOmWVHRsY0ZdXDM-qiwg@mail.gmail.com>
Subject: Re: [PATCH -next] habanalabs: use GFP_ATOMIC under spin lock
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 9:04 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 22, 2019 at 05:46:01AM +0000, Wei Yongjun wrote:
> > A spin lock is taken here so we should use GFP_ATOMIC.
> >
> > Fixes: 0feaf86d4e69 ("habanalabs: add virtual memory and MMU modules")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/misc/habanalabs/memory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> > index 9236e52852c6..9e3491dc3b55 100644
> > --- a/drivers/misc/habanalabs/memory.c
> > +++ b/drivers/misc/habanalabs/memory.c
> > @@ -120,7 +120,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> >
> >       spin_lock(&vm->idr_lock);
> >       handle = idr_alloc(&vm->phys_pg_pack_handles, phys_pg_pack, 1, 0,
> > -                             GFP_KERNEL);
> > +                             GFP_ATOMIC);
> >       spin_unlock(&vm->idr_lock);
> >
> >       if (handle < 0) {
> >
> >
> >
>
> Ah, nice catch!
>
> Oded, any objection to me taking this patch?
>
> greg k-h
No, of course not.
This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
