Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90381C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4650720685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXi5Pcei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4650720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbeKTRll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:41:41 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35008 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeKTRll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:41:41 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so2045374itj.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 23:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAts0Gb6wtX4+ypNYNFi2pnx4xhkIPqxi2UclCxVXU4=;
        b=MXi5PceiuS3IEkmo6XQnDpfTCUNgu2agTXBDwJOp9hqkvh1Ir2LiNV56RsnH/7hRIn
         6ppL2wpK4PqM9SlGd4PVWnK+5F4YOMYOMEdo9Vb3bfmQ/Hknn7qVMjeDlBWadDiLWClU
         q4DCEq4t8clyQFPrInyjMauFmKdLFTwWh5FwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAts0Gb6wtX4+ypNYNFi2pnx4xhkIPqxi2UclCxVXU4=;
        b=Aw3aiOCJF4249YITqVMLVP5BBbXofrVtpzyUwO0NKJmXo+wpMBvVrrTRcbl1HqtlnN
         X7q/QhIpSClD69emCVig/Qg3Tm6IkviStovcHLiy1+B4KPWB1xjApObwawh97joMkPe1
         aOK/J6Wud8f5gmiuLgQUtVXvawPI1C2+ur7Rfmk+25Taart/w137QiqSFiU4Ac5/f7gs
         aKm4nWYB1THJMmzE4MnqId+o8elB2ZgQO/GFojklyFTtlM2+K1TMrBQk4o/VFWe496ul
         lFuSbH/vGc0jBcwzyksEYe8LSwnVZHDg5JVXhC2eilenmysSbGCWYi1DLHLz5DCWMVLg
         Kg0w==
X-Gm-Message-State: AGRZ1gLwUFjdlU8lZxecJ+CXc8uaMJdPy2g/hodsok5AMqpPYuT0gR7I
        bA4/hOIUeOOdZFGQlPhT3p2cexcxvaLT8oMt5w7WDQ==
X-Google-Smtp-Source: AJdET5c/Uq29AUOy1iq0VOFObvACMMgpFoj9QZYyrR36nZhRYpM/cO+/cN+q8rcX4RotNwJFJ6J4A1cta8/BY8LWJAY=
X-Received: by 2002:a02:788:: with SMTP id f130-v6mr828954jaf.58.1542698044441;
 Mon, 19 Nov 2018 23:14:04 -0800 (PST)
MIME-Version: 1.0
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
 <1542262461-29024-5-git-send-email-firoz.khan@linaro.org> <20181119223524.gsvjkf5v24ic7ilj@pburton-laptop>
In-Reply-To: <20181119223524.gsvjkf5v24ic7ilj@pburton-laptop>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 20 Nov 2018 12:43:53 +0530
Message-ID: <CALxhOnjYzvDGdvuWitiOP46YuV6XViu9O3Fi0FU9u2jnV3W2EQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mips: add system call table generation support
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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

Hi Paul,

On Tue, 20 Nov 2018 at 04:05, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Thu, Nov 15, 2018 at 11:44:20AM +0530, Firoz Khan wrote:
> > diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
> > new file mode 100644
> > index 0000000..dc6bbb1
> > --- /dev/null
> > +++ b/arch/mips/kernel/syscalls/Makefile
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +kapi := arch/$(SRCARCH)/include/generated/asm
> > +uapi := arch/$(SRCARCH)/include/generated/uapi/asm
> > +
> > +_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')    \
> > +       $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
> > +
> > +syscallo32 := $(srctree)/$(src)/syscall_o32.tbl
> > +syscall64 := $(srctree)/$(src)/syscall_64.tbl
> > +syscalln32 := $(srctree)/$(src)/syscall_n32.tbl
> > +syshdr := $(srctree)/$(src)/syscallhdr.sh
> > +systbl := $(srctree)/$(src)/syscalltbl.sh
>
> Could we go with 'n64' instead of just '64'?
>
> When we get nanoMIPS support we'll be introducing the p32 ABI, and
> there's a reasonable chance that the equivalent p64 ABI may come along
> in the future. Using 'n64' now would avoid confusion in that case where
> we may have 2 different 64-bit ABIs.

Sure, will do.

Thanks
Firoz

>
> Thanks,
>     Paul
