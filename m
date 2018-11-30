Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42721C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 05:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058B020863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 05:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpGGzU/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058B020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbeK3QVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 11:21:53 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34904 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeK3QVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 11:21:52 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so7477237itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 21:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmo2hKAV4jn2oX+2Bz4e22r9nBzpV0vdm9tze62b+HA=;
        b=hpGGzU/u7PfYM1VnObh0+9oBriyoH2mjS0JQQe4Qig3CO+dObRB5a+aYq2eD8CHY2l
         +oyXrImgXWa2bwQGodDcEzrPc6DfJbnxNRmA+7Sgs6iz9OsDa8w3didHc09u0iXNrERj
         DcnSOSChyirZ8sQBkKyi55vkCQkL6fm9+S3Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmo2hKAV4jn2oX+2Bz4e22r9nBzpV0vdm9tze62b+HA=;
        b=WII4AAcvGVY7S1XvPctBYNXNqqmJ7hUcX6wLETgwSgG6fFumFfJRmfQ4wt1hsQdMbu
         Op8frjLLpMEZ5brRFB+pwWHZam09f1Ja72Pg7YlGn1sQuz7Gm5/VfxhvEf5t0kCHGMYe
         s96yb7h7XLpUDI6Qu15kLhEsiIBykEYaevxjOO3VlNKFhtuKartTLu+jLgggLvemWXFb
         FAXc3nBIoxObTfQqI2FoN50hFhN4ldDFbNCVR2t1qe/I92df342g/q9HmkMTFHSdTENP
         bQTyzEqJHSa2FMWj6mP1Q5Oh5pyv5wxWvpILrQ128N7sQH81uVXR64uS+r317+TXxQkE
         EwLQ==
X-Gm-Message-State: AA+aEWYHm/zsYDWQNtt3d02te6/gbSPLE3z+TGdwkhYJKlaWS3hOJFAD
        nXWuD/HQATJzrtVP1ieyAhSS5R6hMj42Z08OXn7K/A==
X-Google-Smtp-Source: AFSGD/UT3ygBFYlKlGEqgjU/8qShMsQdIcuOqBWrAbUZIk5dzJ5UmupaZQojQxLBFdFpm5CEWxnpsPJHm8p8+d1tIBM=
X-Received: by 2002:a02:f42:: with SMTP id h63mr3942243jad.133.1543554827820;
 Thu, 29 Nov 2018 21:13:47 -0800 (PST)
MIME-Version: 1.0
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
 <1543481016-18500-7-git-send-email-firoz.khan@linaro.org> <CAK8P3a0rTwm_pCtQXyn_fyJttihKJ6Gpq97mw-r5ySUNBksCig@mail.gmail.com>
In-Reply-To: <CAK8P3a0rTwm_pCtQXyn_fyJttihKJ6Gpq97mw-r5ySUNBksCig@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 30 Nov 2018 10:43:36 +0530
Message-ID: <CALxhOnhkQo-qx54E-sbhQG=LiZcJS549sxYpzmGbiMn2YJVhkA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mips: generate uapi header and system call table files
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for the email,

On Thu, 29 Nov 2018 at 19:52, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 29, 2018 at 9:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> > diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
> > index 7a4becd..ed4bd03 100644
> > --- a/arch/mips/include/uapi/asm/Kbuild
> > +++ b/arch/mips/include/uapi/asm/Kbuild
> > @@ -1,5 +1,11 @@
> >  # UAPI Header export list
> >  include include/uapi/asm-generic/Kbuild.asm
> >
> > +generated-y += unistd_n32.h
> > +generated-y += unistd_n64.h
> > +generated-y += unistd_o32.h
> > +generated-y += unistd_nr_n32.h
> > +generated-y += unistd_nr_n64.h
> > +generated-y += unistd_nr_o32.h
> >  generic-y += bpf_perf_event.h
> >  generic-y += ipcbuf.h
>
> I'd argue that the unistd_nr_*.h headers should not be in the uapi directory
> but instead be included only from the in-kernel header.

That is also fine. I can update in v4.
Paul, Do you have any comment on this and could you confirm user
space doesn't need this macros - __NR_N32/N64/O32_Linux,
__NR_N32/N64/O32_Linux_syscalls ?

>
>
> > diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
> > new file mode 100644
> > index 0000000..402a085
> > --- /dev/null
> > +++ b/arch/mips/kernel/scall64-n64.S
> > @@ -0,0 +1,117 @@
> > +/*
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + *
> > + * Copyright (C) 1995, 96, 97, 98, 99, 2000, 01, 02 by Ralf Baechle
> > + * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> > + * Copyright (C) 2001 MIPS Technologies, Inc.
> > + */
> > +#include <linux/errno.h>
> > +#include <asm/asm.h>
> > +#include <asm/asmmacro.h>
> > +#include <asm/irqflags.h>
>
> It looks like you change and rename this file at the same time.
> Generally speaking, I would not do that in one patch. Either
> leave the slightly inconsistent name unchanged, or rename
> it in a separate patch.

Ah, you catch this one.I thought it will go with out notice.
Ok, I create one more patch in my v4.

Paul, FYI, you asked me to convert 64 to n64. Here I'm changing file
name - scall64-n64.S (previously it was scall64-64.S) also.

Thanks
Firoz


>
>          Arnd
