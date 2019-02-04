Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E260DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 03:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA162073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 03:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+Z6jz9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfBDD0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 22:26:36 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39770 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfBDD0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 22:26:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id u47so14022518qtj.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 19:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qa1UdjtlFiDfcU890MHuWM3DLuLCo/MmLvwhdwynJ8c=;
        b=c+Z6jz9aGKzH7SN16gsq5vbW+AKnKzYVMyfalmjXWFVSZEBi3E/CyfFYjGxsuKF3Ae
         QK8UOkxKSsmoXQBHtN2XCNhInWcga1+MzTN0x1g5XcUxlD2BY04SDwclBDmML1k7s1vM
         9yE71hAQtr3LNA/2FTNhU1KXRZ4ZbKTLu2jKKeEeTvEy2oOgOBqdmS9Q82b6BYBRBXmv
         D5z9acr3jzlINb9usyIMff17K7xWPblRULdo13JY+oumOxgV7MePumARhi7V9vUMuEKP
         in8Uk42TN2HL0BtrzlHxco5NVkqtXbRriWa0r/ykhanawPon/nvMRWcq2ML7+V2Z0wto
         ZkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qa1UdjtlFiDfcU890MHuWM3DLuLCo/MmLvwhdwynJ8c=;
        b=CaQpd4l3fCjQjIfxFZOQ9E+eqUBAoTyZyzUN8pLmojwnYs0F3ULteg5jM8rV6cGkBn
         EulZNNvOxThFfPfmzrYmv7WXbB+X/SFaCdt1K7ms9+XvQERZb/ue2I6A5ouFXkXBGqxM
         alf/AdSwQbjZHcKTtWsTZAp2drsEj5FvM7GjrNNjizi4a1W2VxN+QekzXSvHiFOBYpkX
         Q+fY+PJoQefV3xg/56Gd02C7v3jzRDLIzX35RMI7VKrkZ/YKDGfwlPduMTLzkdZRIBhb
         Ajb7N4SnLwYYxGUgrN/mUZsj7iHL5bO4lKvWX3cYPiYlgDliKmdRPROQMliYIr6Gt70L
         NMjQ==
X-Gm-Message-State: AHQUAubg0D+qdVfd0t9D0+ckd2++usfJ0suGgjwKmUhXJg0o3lGEfbyr
        wReNqlPZkwM9UG44UzmSlhHRgTQMP99VOn6+Qow=
X-Google-Smtp-Source: AHgI3IaMEMUpUwC4ZOvVige0DavzPYmClhb8+PdBC05kDywF2CRCcPo8NNSA0Yc1ERgdGvUuDjIkPAx/JTbthBjPdKQ=
X-Received: by 2002:ac8:882:: with SMTP id v2mr9893262qth.297.1549250794525;
 Sun, 03 Feb 2019 19:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20190121223516.24340-1-natechancellor@gmail.com>
 <20190121235214.28455-1-natechancellor@gmail.com> <7a6ce2e6-620e-ca73-d21d-207c8f9248ce@amd.com>
In-Reply-To: <7a6ce2e6-620e-ca73-d21d-207c8f9248ce@amd.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 4 Feb 2019 13:26:22 +1000
Message-ID: <CAPM=9twPOMX=b4WHX=_E+8mJL4zRSLmD+YGqDbPvdiktUedhHw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix if preprocessor statement above kfd_fill_iolink_info_for_cpu
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Mark Nutter <Mark.Nutter@arm.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex,

can you get this into next and resend the pull?

I don't like adding warnings.

Dave.

On Fri, 1 Feb 2019 at 06:10, Kuehling, Felix <Felix.Kuehling@amd.com> wrote:
>
> Thank you, Nathan. I applied your patch to amd-staging-drm-next.
>
> Sorry for the late response. I'm catching up with my email backlog after
> a vacation.
>
> Regards,
>    Felix
>
> On 2019-01-21 6:52 p.m., Nathan Chancellor wrote:
> > Clang warns:
> >
> > drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:866:5: warning:
> > 'CONFIG_X86_64' is not defined, evaluates to 0 [-Wundef]
> > #if CONFIG_X86_64
> >      ^
> > 1 warning generated.
> >
> > Fixes: d1c234e2cd10 ("drm/amdkfd: Allow building KFD on ARM64 (v2)")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > Resending as I forgot to add the lists...
> >
> >   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > index 5d85ff341385..2e7c44955f43 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -863,7 +863,7 @@ static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
> >       return 0;
> >   }
> >
> > -#if CONFIG_X86_64
> > +#ifdef CONFIG_X86_64
> >   static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
> >                               uint32_t *num_entries,
> >                               struct crat_subtype_iolink *sub_type_hdr)
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
