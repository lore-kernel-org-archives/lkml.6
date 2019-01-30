Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EC9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737F220844
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEKa6klV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbfA3N7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:59:06 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54380 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfA3N7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:59:05 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so10334313ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vdYmqWfG2cQ+WGZyG/2QVUErhPH/bvrFqIoYL8e7lS8=;
        b=aEKa6klVQQeM/tzIrQ2wRRgxgygnwvhP3wMPxTDvMDY6ofCuFN58rrvHVVHS4oJqpK
         fkFSjzkU1gj293zQk4JVkWhlUIq2rXr+ez8HiP4bnQGeUq/oQgFKoAIQVAxVEiz7Su5b
         BxTyntqZKtO2XHnPSh1Ops9xqCuv+S6kQ0vTJilKKPHcsd58Ht7YRE67mPqYWVf6v0Ws
         SdSIE2pYO/KMw3KBCyNfH14O7HNpNOyV3rb3StNYqS0KeCdzjtS1GbZ55jjPpQoyCax3
         5/Ze/QNaVeywHEGVsScqwNOEjRdq/Fpa8+LuBWCwwN7EhuRCViJ6I4QZU3NXDlBKd9rO
         4JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdYmqWfG2cQ+WGZyG/2QVUErhPH/bvrFqIoYL8e7lS8=;
        b=mvzh9D2y+r+F8o2NzVJ7+iXLb2jFFPZunph0F18FVBM0N5mOC6qPK2W9HEdNcQkWhl
         Cgd0W8RjQyebclUc7ixfLZOzFu2xK9oDTWk9zlKMnSElwQzVl/X/b13uHvXuAkrAdeix
         By4AEP3RST/wxmkHRGQb13XDwPKkMjP2A8aedK9KzJg+r7eD0ZR+VxSKvkB/Z8qXyvn0
         H/yQYF/qC1n85sM2msRELZ1NyowgFBee4S9W9S6ivBHNmH4z1d+nlCNiolgfMV2cLF0K
         k3z5/Bzs2HWL6TMsK7EYU2wxocya6SXeqnfJtS//gTPUPPBX6beww7y79gUaWeIWAGzI
         mcKg==
X-Gm-Message-State: AJcUukednhEWhUoTAEIbusYBySCWDCLLMmMtUB+qDWX+8oFllVlkemf5
        kX0vxxaZnWDJ2/24KU8ScynuA8bF5oQKoWS8e7A=
X-Google-Smtp-Source: ALg8bN4Bi87pAx1+VH1c66JL5syAWHNIaB8eKO2bJgDyNW3mwhGFQV/qzEcVEr7/EJFM29FYX9HtvO+aygAUwjzE+Bg=
X-Received: by 2002:a05:660c:a45:: with SMTP id j5mr15773919itl.83.1548856744568;
 Wed, 30 Jan 2019 05:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20181221091853.GA2319@hp-pavilion-15-notebook-pc-brajeswar> <CAFqt6zbRVuJ2=5nMb1S3am86tPE6117cSU32Rtyrwf8Ajk_Xrg@mail.gmail.com>
In-Reply-To: <CAFqt6zbRVuJ2=5nMb1S3am86tPE6117cSU32Rtyrwf8Ajk_Xrg@mail.gmail.com>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Wed, 30 Jan 2019 19:28:52 +0530
Message-ID: <CAFqtX7kxWzxF9uMoQR2wRU-D0oS3+fHaFScWdVxdJbw51q8hiQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     rex.zhu@amd.com, evan.quan@amd.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, airlied@linux.ie,
        Hawking.Zhang@amd.com, ray.huang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 6:06 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Dec 21, 2018 at 2:49 PM Brajeswar Ghosh
> <brajeswar.linux@gmail.com> wrote:
> >
> > Remove hwmgr_ppt.h which is included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> > ---
> Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

If no further comment, can we get this patch in queue for 5.1 ?

>
> >  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > index e5a60aa44b5d..07d180ce4d18 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > @@ -28,7 +28,6 @@
> >  #include "hardwaremanager.h"
> >  #include "hwmgr_ppt.h"
> >  #include "ppatomctrl.h"
> > -#include "hwmgr_ppt.h"
> >  #include "power_state.h"
> >  #include "smu_helper.h"
> >
> > --
> > 2.17.1
> >
