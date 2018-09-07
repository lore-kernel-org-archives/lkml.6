Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5ECC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465C62083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="F84FBNhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465C62083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeIGVaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:30:15 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:24650 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeIGVaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:30:15 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w87Gm5ie012973;
        Sat, 8 Sep 2018 01:48:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w87Gm5ie012973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536338886;
        bh=wER4gBuQUeE7HQITJpS3mJUP8Y3qHolw1TuwBhE/iqI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=F84FBNhg/mJz6e6fsFV5lTBTHTYcUCW9/L+OYBJN66n/uTI6/Q529uSVuixScsqD1
         GJQ84j8N967wKve5e1nIrmptQ+sK5e0UkcXuLW7j21o0SBa66Kt/WLXAkKyJ5zZUx8
         Xld/eytmM3EQ+G7P8Qp4/kbJovKdM8iuXur7RFeNitqUFukxhL9+dUprcodxS/VIUP
         rqnkmt38K2G9FB6KyeETR9SstgECrHZAj6+nfZNod0bo17ab1QgbahG5HsN47jW5+X
         t/gEMEJxfNYpRwNJ5P2pGE++F2i/xlIegfQcqnC4FbgtX60NRqNEItry/ZfJ2Ya/7n
         wbTS63NGXRKWg==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id g18-v6so12440586uam.6;
        Fri, 07 Sep 2018 09:48:05 -0700 (PDT)
X-Gm-Message-State: APzg51DfYj2KqhEYggWugbMn0fPQeqh28B7EwzQ7vyGQCvhMRqa0fo48
        YsL8wzL8y5NKSaHrGTRUsoJfA55ngD4dwtA++JI=
X-Google-Smtp-Source: ANB0Vda1iV4jA/DcLlagLHBfvqa+ZqMczlOlnz9SP2B+IST05W4tmfZ9SEgHslKqiPWNuMqe+vswrU8FGBwrixRSQkQ=
X-Received: by 2002:a9f:3e87:: with SMTP id x7-v6mr3146609uai.53.1536338884570;
 Fri, 07 Sep 2018 09:48:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 09:47:24 -0700 (PDT)
In-Reply-To: <CAL_JsqJeTqxFPxZfuusPxuOTsVbVk_Uhue6NXwpotkwZWHrCDw@mail.gmail.com>
References: <20180905235327.5996-1-robh@kernel.org> <20180905235327.5996-7-robh@kernel.org>
 <CAK7LNARD+_kV=XtJ66mZBU-CPMQgWF+oQtv4bGKaGGARNwzXiQ@mail.gmail.com> <CAL_JsqJeTqxFPxZfuusPxuOTsVbVk_Uhue6NXwpotkwZWHrCDw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 8 Sep 2018 01:47:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNATqTh4oxG5uz2Z4gk0J=kXP62UX2r3cP9Kd2aCSTXzTuA@mail.gmail.com>
Message-ID: <CAK7LNATqTh4oxG5uz2Z4gk0J=kXP62UX2r3cP9Kd2aCSTXzTuA@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] kbuild: consolidate Devicetree dtb build rules
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

2018-09-07 21:17 GMT+09:00 Rob Herring <robh@kernel.org>:
> On Fri, Sep 7, 2018 at 5:33 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> 2018-09-06 8:53 GMT+09:00 Rob Herring <robh@kernel.org>:
>> > There is nothing arch specific about building dtb files other than their
>> > location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
>> > The dependencies and supported targets are all slightly different.
>> > Also, a cross-compiler for each arch is needed, but really the host
>> > compiler preprocessor is perfectly fine for building dtbs. Move the
>> > build rules to a common location and remove the arch specific ones. This
>> > is done in a single step to avoid warnings about overriding rules.
>> >
>> > The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
>> > These pull in several dependencies some of which need a target compiler
>> > (specifically devicetable-offsets.h) and aren't needed to build dtbs.
>> > All that is really needed is dtc, so adjust the dependencies to only be
>> > dtc.
>> >
>> > This change enables support 'dtbs_install' on some arches which were
>> > missing the target.
>> >
>> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > Cc: Michal Marek <michal.lkml@markovi.net>
>> > Cc: Vineet Gupta <vgupta@synopsys.com>
>> > Cc: Russell King <linux@armlinux.org.uk>
>> > Cc: Catalin Marinas <catalin.marinas@arm.com>
>> > Cc: Will Deacon <will.deacon@arm.com>
>> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> > Cc: Michal Simek <monstr@monstr.eu>
>> > Cc: Ralf Baechle <ralf@linux-mips.org>
>> > Cc: Paul Burton <paul.burton@mips.com>
>> > Cc: James Hogan <jhogan@kernel.org>
>> > Cc: Ley Foon Tan <lftan@altera.com>
>> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > Cc: Paul Mackerras <paulus@samba.org>
>> > Cc: Michael Ellerman <mpe@ellerman.id.au>
>> > Cc: Chris Zankel <chris@zankel.net>
>> > Cc: Max Filippov <jcmvbkbc@gmail.com>
>> > Cc: linux-kbuild@vger.kernel.org
>> > Cc: linux-snps-arc@lists.infradead.org
>> > Cc: linux-arm-kernel@lists.infradead.org
>> > Cc: uclinux-h8-devel@lists.sourceforge.jp
>> > Cc: linux-mips@linux-mips.org
>> > Cc: nios2-dev@lists.rocketboards.org
>> > Cc: linuxppc-dev@lists.ozlabs.org
>> > Cc: linux-xtensa@linux-xtensa.org
>> > Signed-off-by: Rob Herring <robh@kernel.org>
>> > ---
>> > Please ack so I can take the whole series via the DT tree.
>> >
>> > v2:
>> >  - Fix $arch/boot/dts path check for out of tree builds
>> >  - Fix dtc dependency for building built-in dtbs
>> >  - Fix microblaze built-in dtb building
>>
>>
>> This breaks parallel building
>> because two threads could descend into scripts/dtc
>> at the same time.
>>
>> 'all' depends on both 'scripts' and 'dtc'.
>>
>> * 'scripts' target -- descends into scripts/, then scripts/dtc
>> * 'dtc' target     -- descents into scripts/dtc directly
>
> Any suggestions for how to fix given the problem with depending on
> scripts? I suppose I could make scripts depend on dtc instead, but I'd
> be back to needing to fix cleaning.

How about making 'prepare' depend on 'dtc'?

Then, remove
subdir-$(CONFIG_DTC)         += dtc
from scripts/Makefile

but, add dtc to subdir-


> Or I could just skip removing the
> cross compiler dependency for now.

I want to build scripts/
without target compiler.

modpost is a special host-program
that depends on $(CC).

I will take a look at it
when I find some time.


-- 
Best Regards
Masahiro Yamada
