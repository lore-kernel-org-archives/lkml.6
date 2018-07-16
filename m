Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9F0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 00:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB33A208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 00:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tykoyT+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB33A208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeGPBLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 21:11:02 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:43424 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeGPBLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 21:11:02 -0400
Received: by mail-vk0-f65.google.com with SMTP id d74-v6so20806325vke.10;
        Sun, 15 Jul 2018 17:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yurambUwyo5lk9xOE0PhFMvzvTkEWCM5v/C1JXkCHwY=;
        b=tykoyT+ATI9FomafQS29BnPd7KU5gmOov2shG8coqEmT7mtMXqCw6WweziMye5kEbg
         AgRYNxzagdVKu3sIN26DnqxCXYYYP/zprzYSHJP41nFycoVK2aGqk3ZZB1SY7+31c1aU
         0tRqNA3EO19Kk8yTbAM8xIhM2vgNxHYoW6t3cAMc6gt7XYqnQdNjyB+/pPDrF0jZz+Ms
         MP8QyHU/VXGHw8KY9bPEz7mmn7T4oSqLNEwdsr4tnkzTWW5yH/4wYhSd8Pg1RfpKdW5Q
         VOXJKkPznLUzdapZ0QwnnR4CpOEOynDcvGtUzklKcoCuwfsNdCaNGyJ5avNd5wvEnun9
         ORNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yurambUwyo5lk9xOE0PhFMvzvTkEWCM5v/C1JXkCHwY=;
        b=Y/GpyS72aLkHuNUt5B/84A/HmXYEA4UWb1BtlLyOsIchNfnNrgkzO692n2QWwzyKTi
         XIM6InIZ02+ElsNuncI/n8Ah15NxJJNuYBE/kQXIGvMb3lZMAd8eRB/hJ08f0VN24IG4
         HdQwKKWQPDOpoorAr1h2efrWc9L3wmj6IXpUeOqqGatKRhCnY5X2r79EXNpJf82zqd8o
         ZR2X/nbwRYpqAbfdsZEnwIxizk1/pKSvwDy814mEw0vpp4uNVPDH61JqGedPOEEVKrlG
         HdazTq/MM0XX352pGDX+wFykbvp5Cbtst25NgIOa4yOTAZN/JCwwsiwNpFuPospBPTFd
         XuqQ==
X-Gm-Message-State: AOUpUlGaL8paBsFOi/l3SoVbXRaaILGdUQ+2I5TCcMQI3WSgJ1l8vhja
        Sdtie7HsYnz35T8gNUvFTZw9JzNSXfPho7hZX4k=
X-Google-Smtp-Source: AAOMgpcjIhq0V/ltF2eaPjMJoTjtLRxGEAshNch+p4UNohYT6jCkVyRgjQO+qkksQ+tBNQvnqacdbMQnw7A9AgUNpnU=
X-Received: by 2002:a1f:844e:: with SMTP id g75-v6mr8347386vkd.16.1531701972271;
 Sun, 15 Jul 2018 17:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180713201923.3200799-1-arnd@arndb.de> <20180713201923.3200799-2-arnd@arndb.de>
In-Reply-To: <20180713201923.3200799-2-arnd@arndb.de>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Mon, 16 Jul 2018 08:46:01 +0800
Message-ID: <CAAM7YA=a00DHGm3CrGVy=tQm+7OBFYT1rmKY9wamVCYt0gqJKA@mail.gmail.com>
Subject: Re: [PATCH 2/5] ceph: stop using current_kernel_time()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>, Zheng Yan <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Chengguang Xu <cgxu519@gmx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cephfs part (patch 2~5) looks good for me.

Regards
Yan, Zheng


On Sat, Jul 14, 2018 at 4:21 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> ceph_mdsc_create_request() is one of the last callers of the
> deprecated current_kernel_time() as well as timespec_trunc().
>
> This changes it to use the timespec64 based interfaces instead,
> though we still need to convert the result until we are ready to
> change over req->r_stamp.
>
> The output of the two functions, ktime_get_coarse_real_ts64() and
> current_kernel_time() is the same coarse-granular timestamp,
> the only difference here is that ktime_get_coarse_real_ts64()
> doesn't overflow in 2038.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: add clarification that this is the same timestamp
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
>         req->r_op = op;
>         req->r_direct_mode = mode;
> --
> 2.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
