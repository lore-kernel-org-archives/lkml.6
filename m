Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C402C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEEE20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcCBzHr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEEE20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933485AbeFUM3m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:29:42 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:42657 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933262AbeFUM3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:29:41 -0400
Received: by mail-vk0-f68.google.com with SMTP id s187-v6so1742847vke.9;
        Thu, 21 Jun 2018 05:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBMwDzvdm6O0X3xnjKFRC/2Ebq4ydfYpWmZ3EctP80g=;
        b=PcCBzHr130IvUyNMP6C1S/fIPQjaIJFs2I0TuvMgt0sZXb24Btsr9wAebgzQ6PUSMl
         /gbkd0NO1RvSH1S5hREpDcaSjJ3kqLCe9YoD30JMz5ueqdIncBgml5ny66EPGg7CZDh4
         QyOJ7zZa53LCLjbzDKwv+0ElNL7WfDQUgoTKpo4qk21QP1xYoS+650q4iBe3h1kqvWzY
         VibF2xki2oz0CmXaCoN3B9QfRpGgyzdnucImw752t2DjFKHcI4a+49cLZEEbkzCmllRG
         gDDSbvxRvmCEDmIgr1gn6tNsAehECaIqWuYnq9vAoLadQGi9qlYzIwm1Zgq3uuxGtSwd
         Qxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBMwDzvdm6O0X3xnjKFRC/2Ebq4ydfYpWmZ3EctP80g=;
        b=ub3QVmp2NmGMOtXbWBX1n3rZdX919/LYJm+lKlnIXJC8zroGfuav5b3oFAt2E+iix1
         lKCT39HE78XbBi1mJprIxz3b2kvMCey4vG+C727ORJQqMizdK0vjaGIRpo/GtV7x7ZD/
         gScrMv14u4eQG8V2QCXtnTBpTU/1vnutMnoR04fW3EtJ7vut4xds8She7KO5sFq8r8mw
         wE9s2xrld4MxzqZtG6AbRAKsO+M8u6yuBN0X7CQfW3HJNXs0mbEm13BTn3YHd7T0lUeB
         eLnz5T327aiRB7AfSWpqYz7jcDX380hAfHJTpj2jKxowDP2mpuKuZ4erGfE/WjrN0sZN
         h59g==
X-Gm-Message-State: APt69E3zYI6Er2LAju0M0yfyUgFVyqaJnEZvMv3vkXTKYIC5eCYvdd7b
        x7nqVplmaUFWIbbQvZE3lcUlU/N1/eEGaDytrZE=
X-Google-Smtp-Source: ADUXVKJXkfoLBD+ZEaNs6P6ld9O9hoMJeG9anCZcBkrKSf4UEukq7/s/NbQp/PAP7enMt+wT+meNqBcg1escvHZg+uo=
X-Received: by 2002:a1f:62c4:: with SMTP id w187-v6mr14833236vkb.112.1529584180374;
 Thu, 21 Jun 2018 05:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180620155101.57685-1-arnd@arndb.de> <20180620155101.57685-2-arnd@arndb.de>
In-Reply-To: <20180620155101.57685-2-arnd@arndb.de>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Thu, 21 Jun 2018 20:29:28 +0800
Message-ID: <CAAM7YAk1WB_aVUbOdEMhNUYRNAVT-eq9vE3x2H5yr-hjja7qEg@mail.gmail.com>
Subject: Re: [PATCH 2/5] ceph: stop using current_kernel_time()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Zheng Yan <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Chengguang Xu <cgxu519@gmx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> ceph_mdsc_create_request() is one of the last callers of the
> deprecated current_kernel_time() as well as timespec_trunc().
>
> This changes it to use the timespec64 based interfaces instead,
> though we still need to convert the result until we are ready to
> change over req->r_stamp.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/ceph/mds_client.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index dc8bc664a871..69c839316a7a 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1779,6 +1779,7 @@ struct ceph_mds_request *
>  ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
>  {
>         struct ceph_mds_request *req = kzalloc(sizeof(*req), GFP_NOFS);
> +       struct timespec64 ts;
>
>         if (!req)
>                 return ERR_PTR(-ENOMEM);
> @@ -1797,7 +1798,9 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
>         init_completion(&req->r_safe_completion);
>         INIT_LIST_HEAD(&req->r_unsafe_item);
>
> -       req->r_stamp = timespec_trunc(current_kernel_time(), mdsc->fsc->sb->s_time_gran);
> +       ktime_get_coarse_real_ts64(&ts);
> +       req->r_stamp = timespec64_to_timespec(timespec64_trunc(ts,
> +                                               mdsc->fsc->sb->s_time_gran));
>

does current_time() internally uses ktime_get_coarse_real_ts64()?  If
not,  granularity difference may cause problem. see commit
56199016e8672feb7b903eda003a863d5bf2b8c4 for more information

Regards
Yan, Zheng

>         req->r_op = op;
>         req->r_direct_mode = mode;
> --
> 2.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
