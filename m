Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488BCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B4421720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7HAkcuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbeLTQxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:53:15 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:40512 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeLTQxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:53:14 -0500
Received: by mail-wm1-f51.google.com with SMTP id f188so2955564wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r2+EgIQAxCYEsIRbctRRHbC8UUQiqSsxU05KB413KXI=;
        b=b7HAkcuZXX0gF4D8zr3dDODfDtC27xmNl+cexFPApP6KKanTs/pqAVXqq/MbuM2Fxo
         T323n4OuotiKLEvUGLR0UdZngdj4x59JgJeGQIvnClYUNVCvVO0i/SdtjNPoStCUm8w9
         Uw3ZZpblMqBsLTt3cgmIjdtrhrlm6882JjLSMhVKMpAB6YXDZFVSnV3haEafEUJRdPR+
         psh6LCg8+e34HbLISWztZ3Z2F/Dz+zQAtGG3bNYZAB2IeqVviJOS1/VqwpyAX8SkKJu4
         b8ZulYHETIX1kM0L6y2DHyvmmotCHyLzi6xUXTwND2+fngNCj4cE5pL4T8NSUCyi+UCd
         N0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2+EgIQAxCYEsIRbctRRHbC8UUQiqSsxU05KB413KXI=;
        b=r/j/5RBRShgWa6YBs/ClZ8We8zq068qXQxsLaxPPcwamrcDIOoUykgFv9NBDqLeYGj
         R9yw2cv1D4qFt1jU0rbYQeM/1GfWF50ebSsnv6ju14sxXK20Uo/BB27CHnklaC6T43Ua
         m3/khFfDyC6F8ihVkxUWhj3mooFyzY4RkYqwI0l69/8yz68M7/X6Oe50i6hGA+JoMjwl
         YbbI25/zuuQwbU0tUhj4EAquIbdV0lS1F3wFbThW7RZxXeBxLA3H7/O7vm6gzR7uQyVx
         RQ8Yv+BFMQNVGMmX+rWQzdU8RKb50rMifaQ3F5pRdsWyWTiw4wcziLsGdPM7ZqkrcT56
         K1YQ==
X-Gm-Message-State: AA+aEWaq1Snf4l7rCbRmgV83rjdtJE8Ji4U26H78J8STbT6SrYZK/5oj
        qdWfUXx+A3ZFasFB/VMfX+RAI6U/1IIi91PE5TM=
X-Google-Smtp-Source: AFSGD/XQ9/LQ/MKAUrEcR+N39Pa4MjbDb3CFcW2COhZAoiMdF1nInm5+9SG5CS8sOCugF5nq2IhgN9MSN/iUnFDUJs8=
X-Received: by 2002:a1c:47:: with SMTP id 68mr11675494wma.89.1545324792020;
 Thu, 20 Dec 2018 08:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20181219075713.GA2259@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181219075713.GA2259@hp-pavilion-15-notebook-pc-brajeswar>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 Dec 2018 11:52:59 -0500
Message-ID: <CADnq5_P6b3-gAKGkmKnXyXEaNqqhSd=K8VKLPNbSqQUQuoqEyQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicate header
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>, eric.bernstein@amd.com,
        Eric Yang <Eric.Yang2@amd.com>, Anthony.Koo@amd.com,
        nikola.cornij@amd.com,
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

On Wed, Dec 19, 2018 at 3:41 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove custom_float.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 193184affefb..3e21c2d26998 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -40,7 +40,6 @@
>  #include "ipp.h"
>  #include "mpc.h"
>  #include "reg_helper.h"
> -#include "custom_float.h"
>  #include "dcn10_hubp.h"
>  #include "dcn10_hubbub.h"
>  #include "dcn10_cm_common.h"
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
