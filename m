Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340C6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE581214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIsJLLnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE581214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388727AbeKVGlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:41:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34738 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeKVGle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:41:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so7005934wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFkan6mE7vMeI42C5RbUH0MMzP2/ZQRbqowrjxUng/A=;
        b=uIsJLLnwxEIxGc2HOr5Hh++zPpKYa6Z41ufKycxwOyKIumWJB3aaaViVeQ2vQINRxZ
         wLPcf7mmYvnd6I6J65TfQcn0JpFZlx6Uyiv7b6BqQeU1OOoT4VOkGS1ESTnSed74yBPP
         E3w0l3QElvc2eAmgW9eeDnwYfjI2duWPBWrWpM8rSEArlXEHfblRDeRFmKLLjqIJ+IZz
         xCHfSRETPTBdqPtwA68sFgrv0NZ305BzWVcxxluHDvJ9YJboJ+zYdTqDBK8qfN84IN9P
         5slpNkTObb0FZBeMexTSUs3dkiFtnc4uGiYTQGagCfr8bYcrcfXznepUqEKXYasXZ5Dp
         HAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFkan6mE7vMeI42C5RbUH0MMzP2/ZQRbqowrjxUng/A=;
        b=FMw0eMQ5LfFCRvGZ2qncQQO38qSw/DQWjFrAuV7MgmFRo2KcSOQK9SBsOH3Sw8SA0Y
         XJAwgN1n4+bctaqKeCeDjrzBdHXSGEB/DsbJ8SWoM9wG9Q9h/tJN6GJ54I2u4x/uMltd
         cQ8odxxp8PRATUmje8SrG0yCvjq0lwlcvgvrlafYz83hUNuKkoWFhA2UEQEepne7tGAz
         55xA4QbH+mXrQfrAtToFlXw4friVq7WAWpTw1UMCvl9qSuUR7O03mq6SmmUyvMGtuTgW
         uH5iOFNCbSuH1s8lv6gZs++3Ev9O7G6pRLms4fApff4Qprzpz6eRZuODd7C4ii8Cu+IV
         wKJg==
X-Gm-Message-State: AA+aEWZtk94eyo9RPo4+X35xr6/ykuO7kIo9UaUUgKxGN+DgRceR/QHt
        +wsXJ3lo/iNAN2K5mHvUNqQGueZg0wwdBW8jQKQ=
X-Google-Smtp-Source: AFSGD/WksP5kWFvnHX4V/Ak5tcQZUyLIcSvoiPXy7i7i+hOYoZtRCzmNGVtgmOEUMMEv9ilE1Olax8DI3fxrDOlCPv4=
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr7014582wro.29.1542830748314;
 Wed, 21 Nov 2018 12:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20181121071103.GA2622@hp-pavilion-15-notebook-pc-brajeswar> <13613dd2-dfef-7a8e-4c27-5b5bed336a89@amd.com>
In-Reply-To: <13613dd2-dfef-7a8e-4c27-5b5bed336a89@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 21 Nov 2018 15:05:34 -0500
Message-ID: <CADnq5_PVK+zfpLEh2rL3Cs_bC8OuNXDOAfSr=gt8aHHykRiWcg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu/vce_v3_0.c: Remove duplicate header
To:     Junwei Zhang <Jerry.Zhang@amd.com>
Cc:     brajeswar.linux@gmail.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>, Leo Liu <leo.liu@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Emily Deng <Emily.Deng@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!
On Wed, Nov 21, 2018 at 3:16 AM Zhang, Jerry(Junwei)
<Jerry.Zhang@amd.com> wrote:
>
> On 11/21/18 3:11 PM, Brajeswar Ghosh wrote:
> > Remove gca/gfx_8_0_d.h which is included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > index 6dbd39730070..4e4289a06a53 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > @@ -37,7 +37,6 @@
> >   #include "gca/gfx_8_0_d.h"
> >   #include "smu/smu_7_1_2_d.h"
> >   #include "smu/smu_7_1_2_sh_mask.h"
> > -#include "gca/gfx_8_0_d.h"
> >   #include "gca/gfx_8_0_sh_mask.h"
> >   #include "ivsrcid/ivsrcid_vislands30.h"
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
