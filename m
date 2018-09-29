Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC746C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 03:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4EB20671
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 03:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6V2RsbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4EB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeI2KHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 06:07:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38013 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeI2KHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 06:07:36 -0400
Received: by mail-io1-f65.google.com with SMTP id y3-v6so5627459ioc.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 20:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T3ZcR3EmSfgXC/6CECU+ZOg5duXPeeCsMZ/Atxkqr3g=;
        b=C6V2RsbNGDsviqq71F8dpscuWQSRcwYRGIkt80yBD1+wNZmqU6cPWQfdWYWBH82G80
         y80CiGIgg4ANRW/w6xRUFknb8rQwE8zUzkk9sI/qqsOIov0k4T3j2ZILp2SYHs7nkDgk
         5fGw63l2ciSxT/cjeO3QflZijAiGGb7FfhwWQyeD0ixWF8xMMNm19vvVR53kGuDuioII
         +D8dKNVdcdJthwIId8PwCEMsZmabW6g/DQT3OkoYTLayD/2qiSsAD9KTn3za2CeSRhNt
         MlgxXPDX3dwH30+8JL3w1OI4nhP6S7gyJK01MN/tk26AozWmkrKtT1bTZkxNN0Yze+uE
         KFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T3ZcR3EmSfgXC/6CECU+ZOg5duXPeeCsMZ/Atxkqr3g=;
        b=HCECgAE06IjWE7VqaS2iaTOtSp5g8rKV3FpPj04KqSR4iU+QXRxPJb1AZk2xgmD7S9
         N6DPJ01oLaRj4gJxOrILQ33Ry67O7TOAmG+WcUrOarnIg4erPThB6KiXDL1ywsYF0vDx
         3Db/NLI8GDSn0Knj0yCQ8N2KziJncYSEWWDXd7PfpQ12DuIx6C/zmfjfUGpO3cSX3rwZ
         TamXOfEVdFDORQ1CtWUY0pMIHh/FuSMipUkkGEruGgU7IZnvk4L3IG/6Qtg7ig5jAZJ3
         VBOKF3o90HXHu6igoxj1dkSIcRUC72Mdq9F1LIW3eUij8EdERq2a35WUaugXqWHQ/Cc2
         /t8A==
X-Gm-Message-State: ABuFfoj2PxZtyv34skhXrnSP0y4ZNyJ2rAcuPNZg/0MnMjfsTS1ieIxR
        YO2TcJ5Z0+TU1TH3ni/XVhYnUsXxvzXWVQnERMM=
X-Google-Smtp-Source: ACcGV61PZeZGEWeJRtThiY8+IL3UUB6I59OLEgs+nOr8cOD58aJ+pvgBcsL2Yc3We+IcF1HZ1JVXrPugq5fF5q6rYQc=
X-Received: by 2002:a6b:e05:: with SMTP id 5-v6mr940023ioo.141.1538192449480;
 Fri, 28 Sep 2018 20:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537949825.git.zongbox@gmail.com> <mhng-1934187c-6fab-4000-af19-23a80173669d@palmer-si-x1c4>
In-Reply-To: <mhng-1934187c-6fab-4000-af19-23a80173669d@palmer-si-x1c4>
From:   Zong Li <zongbox@gmail.com>
Date:   Sat, 29 Sep 2018 11:40:37 +0800
Message-ID: <CA+ZOyagkLaikQjcwJzFumOs=o2Bhu0nzRcdb3a8fW7nT-HfprQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Fix some bugs on RV32 build fail and issue
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     hch@infradead.org, aou@eecs.berkeley.edu,
        Zong Li <zong@andestech.com>,
        Vincent Chen <vincentc@andestech.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@sifive.com> =E6=96=BC 2018=E5=B9=B49=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=887:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 26 Sep 2018 01:31:09 PDT (-0700), zongbox@gmail.com wrote:
> > This patches contain the modificaion as follows:
> > 1. Fix up the building fail on RV32.
> > 2. Add umoddi3 and udivmoddi4 functions for RV32.
> > 3. Fix ioremap problem on RV32.
> >
> > Changes in v2:
> >  - Retain the copyright notices from libgcc in umoddi3.c and udivmoddi4=
.c.
> >
> > Vincent Chen (1):
> >   RISC-V: Avoid corrupting the upper 32-bit of phys_addr_t in ioremap
> >
> > Zong Li (4):
> >   RISC-V: Build tishift only on 64-bit
> >   RISC-V: Use swiotlb on RV64 only
> >   lib: Add umoddi3 and udivmoddi4 of GCC library routines
> >   RISC-V: Select GENERIC_LIB_UMODDI3 on RV32
> >
> >  arch/riscv/Kconfig        |   1 +
> >  arch/riscv/kernel/setup.c |   3 +
> >  arch/riscv/lib/Makefile   |   3 +-
> >  arch/riscv/mm/ioremap.c   |   2 +-
> >  lib/Kconfig               |   3 +
> >  lib/Makefile              |   1 +
> >  lib/udivmoddi4.c          | 309 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  lib/umoddi3.c             |  34 +++++
> >  8 files changed, 354 insertions(+), 2 deletions(-)
> >  create mode 100644 lib/udivmoddi4.c
> >  create mode 100644 lib/umoddi3.c
>
> I like what this does, but there's a license issue here that Christoph po=
inted
> out.  It'd be great to have RV32I systems booting 4.19, do you think ther=
e's a
> chance you can sort this out next week so we can get it into the last RC?=
  That
> would help with the rv32i glibc process, as we'll actually be able to boo=
t an
> upstream kernel.
>
> It looks like the functions we have an issue with come from libgcc2.c, wh=
ich
> doesn't change very much.  As far as I can tell we might be able to get a=
way
> with these functions from 4.2.1, which was licensed under the GPLv2.  Her=
e's
> the relevant functions on GCC's github mirror
>
>     https://github.com/gcc-mirror/gcc/blob/gcc-4_2_1-release/gcc/libgcc2.=
c#L559
>     https://github.com/gcc-mirror/gcc/blob/gcc-4_2_1-release/gcc/libgcc2.=
c#L844
>
> These look very similar to what you send out.  As far as I can tell, if y=
ou
> base your code on the GPLv2 version then this should be fine to include.
>
> Thanks!

Thanks for the help and useful information. I will modify the
implementation and submit the next version.
