Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60F6C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6527320870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB4rFUSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6527320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeLJLOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:14:24 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38724 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeLJLOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:14:23 -0500
Received: by mail-io1-f65.google.com with SMTP id l14so8379287ioj.5;
        Mon, 10 Dec 2018 03:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9TMhNozQqHbA08pE2WjLjvAZD1L8IN3UjBBwzGYzzw=;
        b=eB4rFUSp+HnWCsFErQwDPW1UyHhSVTCUDEoMvYQ8kKWwLzOn0vRMmtwuBxD3h+goiV
         Ms+ygNkyiQSSrThV7SPDyMD8+MXKdTrRMfGsxruKVinju5sYoAm5TVp2URjH4dZ9Eic4
         btTbke6o540KdCqPGDRSsQh6QYtXJdBgxySIpW9skaWM38Vkkc52EceV598fh+zPOCew
         Ob+YXiCtv/yo92jGzoU9nTslqH5pd/zRkOB0jqLAnHrneMApthgLEJoQ8C+Ve6kqZtkO
         x0r8M6V5ytBUz9HVQOiVkp8LkIql+iseHjI4zMIFMURALWhqFp2//ZMbSXem/wfZ+VG8
         siHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9TMhNozQqHbA08pE2WjLjvAZD1L8IN3UjBBwzGYzzw=;
        b=SHryM3vld46aQnDJIkqN9j9FN8Zv30dCtLO60aLglxWcXUQnA9bGFMyoTGBePb+W7Q
         gamGXC/px0pYdfDuuWt3oEB3Mcpn/6DJItfZR45+7GJH9Usl8oisS2UvNE7WcrFjWLGt
         cFIv47fmoos0vPuZxYuLjSfpSgQPs3E416nmffvUKXniVwbuQ8u3rVz29Jyf4Adsgmxb
         q5omMFN6Eod4lOp+KkT4s3U0jx5vYsrgQ4yzrxqKeu1J805GBSK9MwM62SaiVrgfYUvt
         FJD5GGI6RRHcOoB9JLQRWsBLOjlAtU1JGgr6iEEckK7QqoDi3ZjMatOSKYW1QsaM734L
         GaEg==
X-Gm-Message-State: AA+aEWbqGV4v7aoie5/0lseiXQyJbJOpcxqEblSJLVmZqZmDyf/YrX9C
        vdVLM3RAAQtlV4r3k4hn348LunyVojHdSGk9TGs=
X-Google-Smtp-Source: AFSGD/UPDZsjF/zyY8s+BleHIPEv7vEDcDEUoBsj2khPCIVvDtJHqm/vVSrnn1Ju894p/JwRbsIIyioK6k0RNeO4mlY=
X-Received: by 2002:a6b:2b95:: with SMTP id r143mr9477175ior.217.1544440462853;
 Mon, 10 Dec 2018 03:14:22 -0800 (PST)
MIME-Version: 1.0
References: <20181210102312.31364-1-lhenriques@suse.com>
In-Reply-To: <20181210102312.31364-1-lhenriques@suse.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 10 Dec 2018 12:14:11 +0100
Message-ID: <CAOi1vP87vHcjmUXxzQAOuhrPrB==em9tXAocgfRsSWo5M3jtXw@mail.gmail.com>
Subject: Re: [PATCH] ceph: make 'nocopyfrom' a default mount option
To:     Luis Henriques <lhenriques@suse.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Gregory Farnum <gfarnum@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 11:23 AM Luis Henriques <lhenriques@suse.com> wrote:
>
> Since we found a problem with the 'copy-from' operation after objects have
> been truncated, offloading object copies to OSDs should be discouraged
> until the issue is fixed.
>
> Thus, this patch adds the 'nocopyfrom' mount option to the default mount
> options which effectily means that remote copies won't be done in
> copy_file_range unless they are explicitly enabled at mount time.
>
> Link: https://tracker.ceph.com/issues/37378
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/super.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index c005a5400f2e..79a265ba9200 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -42,7 +42,9 @@
>  #define CEPH_MOUNT_OPT_NOQUOTADF       (1<<13) /* no root dir quota in statfs */
>  #define CEPH_MOUNT_OPT_NOCOPYFROM      (1<<14) /* don't use RADOS 'copy-from' op */
>
> -#define CEPH_MOUNT_OPT_DEFAULT    CEPH_MOUNT_OPT_DCACHE
> +#define CEPH_MOUNT_OPT_DEFAULT                 \
> +       (CEPH_MOUNT_OPT_DCACHE |                \
> +        CEPH_MOUNT_OPT_NOCOPYFROM)
>
>  #define ceph_set_mount_opt(fsc, opt) \
>         (fsc)->mount_options->flags |= CEPH_MOUNT_OPT_##opt;

Thanks Luis, I'll pick it up for 4.20.

                Ilya
