Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F420C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AFD2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmJ6NXOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AFD2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeJKCfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:35:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50816 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbeJKCfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:35:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id i8-v6so6579567wmg.0;
        Wed, 10 Oct 2018 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hKtcyhbWHVsrPzOxvwmoUwsYt7qkgtSWd46HwOIfqk=;
        b=tmJ6NXOV2fIuNDwz2bcTyA/1i0721ohyDeyXWQTHdHnlZ7/AV1Q+N4tgLOXwkT7KtE
         x0hasPR9r/93yJeear/+BHCRa67wlAjNkrUlgkDgFnW0vsQEYkTdLk1oLEWYkIydaHtc
         R4cD/lKXLMc6VW5/+xfwpkNUrbDiLl2X+EgYTBiKdJ2h6Rj0fRWvekm6Pp3zpsRpDIdY
         Aeem6LTLnsuiw0fQQkMPp1KXmI+1NCYSnMtXvoZroqClCrVvVkMLWC0epESwrxFnCDHa
         6ocmwewEDLgqHS7yREGT7zx0xNlJyfXXg96ZbjuWOPPofHaqJkMnQAwBbtLGgEtPGmbp
         FpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hKtcyhbWHVsrPzOxvwmoUwsYt7qkgtSWd46HwOIfqk=;
        b=GKQXGLp9eSpvmMYnlXCLUK0mXUCs9Tj5C/vAfAoLcSe/bjIvzhj53PF12KDckz9ah2
         q2OphiYv8bDuy/XzGflaSW0BDUT5hlSAyq4G/8P2Qe1NalJI/xEssiBbIf7t/GRfi5e2
         6nwl3uo2BhZez5fFVr+K+AXM2wWqI41RlTh/YWn9HTBCJxdGbNPtvai6VOmtQQwwS6Fd
         4P9uCMKoehezW0V6hmA8rQb+JFjl4Z3o8NEF6QyaAQpLOYF8Rh9L/tbMzDvDqhGToFCO
         BRdbT3iE3yOGrLY+nzPccr9rFeAktqyWvDK/BPki3uWe23L1IWsf2s7RQI8avIaqEPzP
         TAzg==
X-Gm-Message-State: ABuFfog9wvF5jVd/aoRwnUgVNk7Ve7MPNmCqRdmfbJq7tt82CrRr+lB4
        oeRqLibax0eNol9bLsyHddd/c5XQ5ywOPsHFknA=
X-Google-Smtp-Source: ACcGV63UfgxWD3L/vz+XIhZYN0p0/FFoprj+ME63G3gcCUk2L+DQUcPoxszsB+EJNUozndqt8EbF++P0L+NvpvSl198=
X-Received: by 2002:a1c:c1c7:: with SMTP id r190-v6mr1910720wmf.72.1539198710459;
 Wed, 10 Oct 2018 12:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <1539049980-186978-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1539049980-186978-1-git-send-email-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 10 Oct 2018 15:11:38 -0400
Message-ID: <CADnq5_MdvZ0DHJ+fRWqw2V595f_kGYRAV1_790OAAiFAsu8hCg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdkfd: Remove set but not used variable 'preempt_all_queues'
To:     yuehaibing@huawei.com
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 3:37 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c: In function 'destroy_queue_cpsch':
> drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:1366:7: warning:
>  variable 'preempt_all_queues' set but not used [-Wunused-but-set-variable]
>
> It never used since introduct in
> commit 992839ad64f2 ("drm/amdkfd: Add static user-mode queues support")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 4f22e74..06d38b7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1363,9 +1363,6 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>  {
>         int retval;
>         struct mqd_manager *mqd_mgr;
> -       bool preempt_all_queues;
> -
> -       preempt_all_queues = false;
>
>         retval = 0;
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
