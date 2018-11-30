Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04D3C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFF22082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Mj+8EZE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFF22082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeLAIDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:03:37 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33312 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLAIDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:03:37 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so5663626ioi.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 12:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQT07zpH8VlhiwokL9dcy7hMdcyeQevUNzb6WWQalQE=;
        b=Mj+8EZE+z9/3QghjxxOt3fLkaVqGrB/sdkoB/zQbF4W95setXpSlETIcGE6rtiKLwN
         LX/TyPnuQ6KlJhO9SuPki2naKmoYJMhX+LR9UBN811z3sWyEpkQwixiqoqI7BIOycVIJ
         gK2gMI1nV541KDwqLi1B9jadcnDpdvn3WovP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQT07zpH8VlhiwokL9dcy7hMdcyeQevUNzb6WWQalQE=;
        b=dH+GaIL9zHL0t0m0C1GQbEpbICOEipnJa3IjB2iVmcPcuKXkyDQP1TBtUWcNjgcGNb
         k7bCkL5toKcqU1O4iSmA4sS8KHl8hHPO7PKEaMGD3AG/DDLZdsGLEa9cX/vPCkBegwnK
         E6Jg+zAWq15GELIjePpiiZ7OgIC6WbW1j0blUb7J1r+5OllwiM+3zmw6JXzc8StCa9ts
         lI9mbV2kyFAWJsdrN7ao20mRHB6i+peV8Er6wiJVNkHqNvUY+LZa/DKVqrwgDvGknq3U
         yd+AEL48461ombwHl2LOdtkLCrYHjFUNAF3FtN6OK9eu7iQHOZ5xmQVu5MzibQTf7Zoh
         C+qA==
X-Gm-Message-State: AA+aEWaLmZseqsr5l67kotDRp25K9stAoNrtM0JWug4NUsv10i5qeyqQ
        YNE9VnP/HytcS6HjE2CPVbyNg2CokVMMNWaCSh3J0A==
X-Google-Smtp-Source: AFSGD/W73ltGaQRPtDa5vfISb0T8LaPwIUNspdswy1zhuzk0xr4MKF2gB8Cy0I7p413sb8STqUp1p9MEKRNDGy1WTvs=
X-Received: by 2002:a5e:d514:: with SMTP id e20mr6761523iom.291.1543611184408;
 Fri, 30 Nov 2018 12:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20181130203232.5743-1-robh@kernel.org>
In-Reply-To: <20181130203232.5743-1-robh@kernel.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 30 Nov 2018 21:52:52 +0100
Message-ID: <CAKMK7uGrBnaip1E+vp6foGfvdRb2=bhPNOmmZfjTUt2HZPLQcA@mail.gmail.com>
Subject: Re: [RFC PATCH] of: Add a GitLab CI config file for unittests
To:     Rob Herring <robh@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 9:32 PM Rob Herring <robh@kernel.org> wrote:
>
> This adds a GitLab CI config file running the DT unittest in a usermode
> Linux build. The corresponding CI job can be found here:
>
> https://gitlab.com/robherring/linux-dt-unittest/pipelines
>
> This CI job can be duplicated by others by creating a kernel repo on a
> GitLab instance and configuring GitLab CI to use
> drivers/of/.gitlab-ci.yml config file.
>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Rob Herring <robh@kernel.org>

Adding dri-devel.

> ---
>  drivers/of/.gitlab-ci.yml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 drivers/of/.gitlab-ci.yml
>
> diff --git a/drivers/of/.gitlab-ci.yml b/drivers/of/.gitlab-ci.yml
> new file mode 100644
> index 000000000000..44a4824f5c33
> --- /dev/null
> +++ b/drivers/of/.gitlab-ci.yml
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +image: registry.gitlab.com/robherring/docker-images/ubuntu-kernel-build

I think it's better to include the docker recipe too. One because
shipping pre-built dockers is a license nightmare, second because
better hackability. For a full on example see:

https://gitlab.freedesktop.org/drm/igt-gpu-tools/blob/master/.gitlab-ci.yml

For the kernel I guess the question is where we should put all the
docker files. There's going to be some need for subsystem specific
tooling (e.g. we want something that has igt installed eventually for
anything drm), so maybe just keeping them in subsystem directories is
best. Was at least my plan with drivers/gpu.

Needs latest gitlab to make the build-on-demand stuff work, but
gitlab.com has that.
-Daniel
> +
> +variables:
> +  ARCH: um
> +
> +job-unittest:
> +  artifacts:
> +    paths:
> +      - "*.log"
> +
> +  script:
> +    - echo -e "CONFIG_OF=y\nCONFIG_OF_UNITTEST=y\nCONFIG_OF_OVERLAY=y" > kernel/configs/extra.config
> +    - make defconfig extra.config
> +    - make -s -j $(nproc) vmlinux | tee build.log
> +    - TMP=/tmp ./vmlinux > boot.log || true
> +    - grep -E '\#\#\# dt-test \#\#\# end of unittest - [0-9]* passed, 0 failed' boot.log
> --
> 2.19.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
