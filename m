Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA22C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581AD21A33
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrlXaqZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581AD21A33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbeHFWkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:40:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37093 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732544AbeHFWkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:40:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so15602369wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 13:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FJgiz9th4BMVyOX11V+JMAmzNBMDenfA8DcsZu9xsrs=;
        b=ZrlXaqZTuezmmz/IRNEkWnQ8ajOjKCVSA+h82GTFt4/TlEkDaC/1nnYzk2euC1SKfb
         F84MbMJQheCnDz6BmJnjYhMs3n8vXHUKnxfcH9L2TFaBL18Cd5iIKSfmizO/rg39fGIp
         f4GocafvNg59VJ2CgOW8Te14piWYfj/AwURHSoQKrGQTca23+xj8fgAHzxqHshoarfX4
         9VYt4527dkrxtnr7hbPZiS58Sf+PsyH2HrJh/+P7+W2NVkdrnXpd//tQ+gZS1Nd7tN0L
         IhuB54YAsTLgYMvgosr50v5Q5pCLat7EfG4hGb0GNxLYF3fpFO1wXwcr5Tt6pQmNWQfv
         O9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FJgiz9th4BMVyOX11V+JMAmzNBMDenfA8DcsZu9xsrs=;
        b=pETqHkPBFk3B/CukJks7ligKDWGyyskTrx/0izG8gCEyTBEfRe5YcW63YcJNMjtuvu
         7i1FFHX6YKbQqpecAlKI2ni2wpafc7H07SDQTA71zGXJO+mS9+rRj/Zb/GsqFZp1OZG6
         sA1e+QbwEbxWE+2TxXsBfTpPzjzjQBdL0UYrT9wovte9r+Fva4sJdR66600jfaI0oALs
         dnueVWNjHO0sJ9bb0XaqKUehxSrGS3Xc2gYI2OcC4gBkqzzhZzx8B5o265gvX/4Oettt
         qW9iBNg4lN6stBh90QMEck5vWl95v/YlhKmlW2vhgz0vUT6aiZvQATPJD5SsMCXIDEsl
         1ZEg==
X-Gm-Message-State: AOUpUlH2CqZiwtKemIY0VyeD9xkdmmWr1fwPkjyVBII7zgeMl/nwXzE6
        F1i7kHw2/jRVr5gp2vgSIrnhhPg442Z7PeW/ABE=
X-Google-Smtp-Source: AAOMgpdm8UWS25dzC7gHpOyDdLgJqOoO8HRmw81Nu067Qgjf1fbbDUzSHrCUvuAb94EK/cyWHgb04IPfi2s62p4Or3s=
X-Received: by 2002:a1c:d750:: with SMTP id o77-v6mr12436431wmg.67.1533587369582;
 Mon, 06 Aug 2018 13:29:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:979e:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 13:29:29 -0700 (PDT)
In-Reply-To: <20180804000102.17737-1-baijiaju1990@gmail.com>
References: <20180804000102.17737-1-baijiaju1990@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Aug 2018 16:29:29 -0400
Message-ID: <CADnq5_Mzn3FO8vu5TtTLZxbjighaQ6MJ__5AeuNNRsJhTgnuUA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: radeon: radeon_test: Replace mdelay() with msleep()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 8:01 PM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> radeon_test_ring_sync() and radeon_test_ring_sync2() are never
> called in atomic context.
> They call mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().
>
> This is found by a static analysis tool named DCNS written by myself.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_test.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_test.c b/drivers/gpu/drm/radeon/radeon_test.c
> index f5e9abfadb56..411efa303f54 100644
> --- a/drivers/gpu/drm/radeon/radeon_test.c
> +++ b/drivers/gpu/drm/radeon/radeon_test.c
> @@ -347,7 +347,7 @@ void radeon_test_ring_sync(struct radeon_device *rdev,
>         if (r)
>                 goto out_cleanup;
>
> -       mdelay(1000);
> +       msleep(1000);
>
>         if (radeon_fence_signaled(fence1)) {
>                 DRM_ERROR("Fence 1 signaled without waiting for semaphore.\n");
> @@ -368,7 +368,7 @@ void radeon_test_ring_sync(struct radeon_device *rdev,
>                 goto out_cleanup;
>         }
>
> -       mdelay(1000);
> +       msleep(1000);
>
>         if (radeon_fence_signaled(fence2)) {
>                 DRM_ERROR("Fence 2 signaled without waiting for semaphore.\n");
> @@ -441,7 +441,7 @@ static void radeon_test_ring_sync2(struct radeon_device *rdev,
>         if (r)
>                 goto out_cleanup;
>
> -       mdelay(1000);
> +       msleep(1000);
>
>         if (radeon_fence_signaled(fenceA)) {
>                 DRM_ERROR("Fence A signaled without waiting for semaphore.\n");
> @@ -461,7 +461,7 @@ static void radeon_test_ring_sync2(struct radeon_device *rdev,
>         radeon_ring_unlock_commit(rdev, ringC, false);
>
>         for (i = 0; i < 30; ++i) {
> -               mdelay(100);
> +               msleep(100);
>                 sigA = radeon_fence_signaled(fenceA);
>                 sigB = radeon_fence_signaled(fenceB);
>                 if (sigA || sigB)
> @@ -486,7 +486,7 @@ static void radeon_test_ring_sync2(struct radeon_device *rdev,
>         radeon_semaphore_emit_signal(rdev, ringC->idx, semaphore);
>         radeon_ring_unlock_commit(rdev, ringC, false);
>
> -       mdelay(1000);
> +       msleep(1000);
>
>         r = radeon_fence_wait(fenceA, false);
>         if (r) {
> --
> 2.17.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
