Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC62C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B460921855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf8ABKvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfAWWcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:32:17 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34780 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfAWWcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:32:16 -0500
Received: by mail-vk1-f196.google.com with SMTP id y14so892995vkd.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+zp7PxO+/xU8Opo0WDDu4w6vRsV8TAqdqaRfU8eb6I=;
        b=Mf8ABKvDceM6UqpovAMHhFJniZfPSPAqoyoW5388S2NtYsdtVcnF2H5OvHZC8PAaKR
         9xQb+e4tj+ahNB5H2Pgnds/AzLujcYvb7JH1zU76gCKBZ0Bt3TD0bzMWmlGainYB5Qli
         5Qlea3ohrN4AYyffaxdVr/JBdo429iblxH2HDU9sYXflr9xmFXI2uUjIkJR2yPpU2s9O
         CJkgR6ic0yIAvLM47aHkLY06HyktLPypPQNTlL2Bn1A5ZbYHcN4Ki2Kzek/EWTZk29P1
         uH99YUhlbMy+bnp3iz5SdAYIs60Bbq2zpak2d7JJjXAtK6i6ai9+6deLDChBCl4wRIZj
         SZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+zp7PxO+/xU8Opo0WDDu4w6vRsV8TAqdqaRfU8eb6I=;
        b=D6iU056vHIyQU5kNnVpsn0N1KUggNNPdc9wHpyAjkGMXjCb0PePC4RdChv2U750kny
         Z5Cmh60jXO32gWqQzc5BnvCpef5PBAYYNFZm4I0IkBXIsUBOvGpblnaOjRD19ka4b/kf
         xckXw6TvO1+1aRHEnFrf31m8lDcUYCjqFze+VMjMEuVth9X4iGUCfIXwXViZHHlARpxQ
         8tlbYlFZ3jA6ZImQcp/V1z+RlY634l+39q2v0wyadQ8aEOyjdIsKHucsUI1QRkRsjdDf
         ofuY/9C3FdUOYGGYp1fp66nILvqF4LI+IPKMcak3LO6IcBSsLlvdcniPb7HJBWdJ0hah
         Gjdg==
X-Gm-Message-State: AJcUukf1P46tvm9+dfgjomtg+4l7/wwxE/dkaheQ5L0DAEshQH0rGer2
        nLb03fWtEWdQnsB6mn3D2a9dReo5LczTI04vhpE=
X-Google-Smtp-Source: ALg8bN4hztNcjfpA/jX6xcYAj9GE47ctUVU31VrrS8XSLME5yKYu2QfnMfNGhpfnaN/vSuE7uroCShgy5/5W3+J2DQ0=
X-Received: by 2002:a1f:ab17:: with SMTP id u23mr1652892vke.73.1548282734960;
 Wed, 23 Jan 2019 14:32:14 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <CAPM=9tybcYSR_xu773W-cV1JfFg1Rcb9NajXhZd+zfZE8+XMRg@mail.gmail.com>
In-Reply-To: <CAPM=9tybcYSR_xu773W-cV1JfFg1Rcb9NajXhZd+zfZE8+XMRg@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 24 Jan 2019 00:31:49 +0200
Message-ID: <CAFCwf12FGkc3hDtgeFCn4Z4cgjL8wAf+SRkWqA+04WtuaEdpBA@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, fbarrat@linux.ibm.com,
        andrew.donnellan@au1.ibm.com, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 12:02 AM Dave Airlie <airlied@gmail.com> wrote:
>
> Adding Daniel as well.
>
> Dave.
>
> On Thu, 24 Jan 2019 at 07:57, Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Wed, 23 Jan 2019 at 10:01, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
> > > for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
> > > Habana Labs since its inception two and a half years ago.
> >
> > Hey Oded,
> >
> > So this creates a driver with a userspace facing API via ioctls.
> > Although this isn't a "GPU" driver we have a rule in the graphics
> > drivers are for accelerators that we don't merge userspace API with an
> > appropriate userspace user.
> >
> > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
> >
> > I see nothing in these accelerator drivers that make me think we
> > should be treating them different.
> >
> > Having large closed userspaces that we have no insight into means we
> > get suboptimal locked for ever uAPIs. If someone in the future creates
> > an open source userspace, we will end up in a place where they get
> > suboptimal behaviour because they are locked into a uAPI that we can't
> > change.
> >
> > Dave.

Hi Dave,
While I always appreciate your opinion and happy to hear it, I totally
disagree with you on this point.

First of all, as you said, this device is NOT a GPU. Hence, I wasn't
aware that this rule might apply to this driver or to any other driver
outside of drm. Has this rule been applied to all the current drivers
in the kernel tree with userspace facing API via IOCTLs, which are not
in the drm subsystem ?  I see the logic for GPUs as they drive the
display of the entire machine, but this is an accelerator for a
specific purpose, not something generic as GPU. I just don't see how
one can treat them in the same way.

Second, I talked to Greg a couple of weeks ago about this driver and I
definitely didn't get any such requirement from him. Had I gotten such
a requirement, I would have planned this differently.

Third, I think this requirement, while maybe valid for drivers that
are inside an established framework with common userspace library,
such as drm, doesn't apply to a standalone driver which is not part of
any subsystem. There is no way that "someone" will create a userspace
for our H/W without the intimate knowledge of the H/W or without the
ISA of our programmable cores. Maybe for large companies this request
is valid, but for startups complying to this request is not realistic.

To conclude, I think this approach discourage other companies from
open sourcing their drivers and is counter-productive. I'm not sure
you are aware of how difficult it is to convince startup management to
opensource the code...

Thanks,
Oded
