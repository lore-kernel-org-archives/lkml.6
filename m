Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B957DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D16213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tme3Y7JA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfB0JqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:46:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35837 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0JqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:46:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id p19so7760597plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 01:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hIRH/qZZQFepSPPF6RSdAwDvxI1hqxRONy4QI/yPfaI=;
        b=Tme3Y7JAzV5BUOoZpShYCHIngnnkWE8+9XA7UZupMtV2ZEmxrBx41GSSoFE0LWa57+
         6RT1L+YyqQT2hMx5TwAOXytMASKN4/sgXdRF2Am0nxfnI26T9zDTBv92o7a0fnGRLFaz
         9h/MRbK35Kj3/MWH949hB+Sssbpb+SEWx2FqhOm+D1DG2/TqqhfCEGqk855Cksnup1fJ
         AesFc81A9iPYA69QEbd8pR2krGKaU8fsUWzieW1eivowZ9mIpyC8N4xfjjL8tjgz2n1i
         EIZ3e6F4iFJGbdXmKnRZWsFrju0yHq4+iw2tMJu78DuzxgiDGpYCHLhrhpD2Tqy7bDTY
         6YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hIRH/qZZQFepSPPF6RSdAwDvxI1hqxRONy4QI/yPfaI=;
        b=YNbul5LMLgqNWYQntsQiFnyvLzYKIWxGjINu2uSGTVESAc575TT6lB4hdSic2gk9YV
         e3FfrRqYmXPHgBn5cZ1NiyKZfTAmiI5h1xAuPeAELBviSLqKdxEtqCkAm/yqTyrJ1HTv
         p3GhOQc/BVbj7Ho/wfw9Jb1mjC+0SHlo0dYpfGthBNtSPSDtUQZuyq6jOhg7+SoS5hkv
         k0JZjXrBy5vgbVzdt04X8kB9vyhtoAHcv2d9l97ygkVnU6YRKwnhc0v1tZMmkTGbYeCy
         GYXyqQg7zbqnWlw0Y+d4nYZbujOoue5Ri2+qeeYRo85KkkyoS6RIjxPgAJGUXo3d7KUW
         Y4ng==
X-Gm-Message-State: AHQUAubq5ZeOMa74Kmc2R5XYV9LWKSs7H1QWhFiehMz/wy2uRtli5exf
        MvUn7vJWhi9hw+7WTN8zpAVeDgTiPwlJ4vHh83IkfedA
X-Google-Smtp-Source: AHgI3IaSv1FHv9NXJ+aRAe9GlmJUpWJvAirg5TwDOaCgnkTQ/jHhwQwv9PV5J7Sin3tFqsEMG1NShjhj2U75vDlHOgM=
X-Received: by 2002:a17:902:a40d:: with SMTP id p13mr1215038plq.144.1551260782324;
 Wed, 27 Feb 2019 01:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20190227085050.30000-1-alexandru.ardelean@analog.com> <CAHp75VfsLJq1ei5U-jkgFc-zj-T6KCdTy8+Je+GnjB=KN4BS5w@mail.gmail.com>
In-Reply-To: <CAHp75VfsLJq1ei5U-jkgFc-zj-T6KCdTy8+Je+GnjB=KN4BS5w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Feb 2019 11:46:11 +0200
Message-ID: <CAHp75VdgwM_ybfymh28iqxu2qOfzZo79VOF+XE+brj70Aji6YQ@mail.gmail.com>
Subject: Re: [PATCH] lib/scatterlist: introduce sg_nents_for_dma() helper
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        bhole_prashant_q7@lab.ntt.co.jp, Kees Cook <keescook@chromium.org>,
        john.fastabend@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Vinod

On Wed, Feb 27, 2019 at 11:45 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Feb 27, 2019 at 10:51 AM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> > Sometimes the user needs to split each entry on the mapped scatter list
> > due to DMA length constrains. This helper returns a number of entities
> > assuming that each of them is not bigger than supplied maximum length.
> >
> > Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> Hmm... Usually we don't accept generic API without users.
> Do you have any use case in mind?
>
> > Patch was sent in 2016 initially to the DMA engine sub-system.
> > Link:
> >   https://patchwork.kernel.org/patch/9389821/
> > This was part of a larger series:
> >   https://patchwork.kernel.org/project/linux-dmaengine/list/?q=sg_nents_for_dma&archive=both&series=&submitter=&delegate=&state=*
> >
> > I'm not sure if this is supposed to go into DMAEngine or lib/scatterlist.
> > It doesn't look like lib/scatterlist is managed by DMAEngine, so (by using
> > the `get_maintainers.pl` script) I'm sending this patch to this group of
> > parties.
>
> The problem the patch tried to solve is much deeper and correct
> solution should be more generic, i.e.
> each channel should provide a set of parameters, such as DMA segment
> size, to the users (via DMA engine API) and users should prepare the
> SG list according to the limits of the channel.
> In that case we don't need to re-split/re-allocate given SG list at
> all, which would simplify DMA slave drivers and their users.
>
> We discussed this topic back in 2016 with Vinod on LPC, but seems it's
> not critical to solve. My case is to improve DMA performance for 8250
> UART.
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
