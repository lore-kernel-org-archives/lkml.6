Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5FFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DEB20645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qIb4Qp0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DEB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeK1MCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:02:53 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:57573 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeK1MCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 07:02:53 -0500
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wAS1316r032397;
        Wed, 28 Nov 2018 10:03:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wAS1316r032397
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543366982;
        bh=D97CGI90gL/nTViCyKYsk69JASJM+LyJoWpONhxQ/yM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qIb4Qp0yA+ghlRUlnuskDiX9Xgtts8sl9qyeZbIjWs8G2W++klOakndoKr0DxtEhu
         /zenDNK5jOkDE34DJV+DvY57Jt9wC87lcLsF6K4DkCaMyePsiWBkYujZizO5ys2AH2
         tXm8obEFVJTUZWfFTGfNvqaZi8DxldyD18UWrz/5gc53GCxGTcD+79mG9EH2qVU1Es
         AmFmMxHJHGd8us91jqq3Rnkht5t1NswmkUfAnI+JiITqLjESzHBt4/bnXa4B6dK9RV
         2dzxsk40e6Qxz+JHa4UB2rIIKl89R3DLWhGPJGzPImqj4L6Dn/Ij7OcFdtpxcvNTF/
         uKQVInmrWwBgg==
X-Nifty-SrcIP: [209.85.221.181]
Received: by mail-vk1-f181.google.com with SMTP id o130so5532529vke.10;
        Tue, 27 Nov 2018 17:03:01 -0800 (PST)
X-Gm-Message-State: AA+aEWats8uhyOWAiBQ7jn7lqoe9SF6nigR7Ep1+M4L1UfePpdyLGlP3
        jP/5yXw6dD4WYtHdrU5OPbZlkoXt+z8lhrpi03g=
X-Google-Smtp-Source: AFSGD/Uo6ACs1ohKEYMNMDWotiNVJM94cF5QZTdNdBjA7piXKQWR4pu2z/OeEdfg4i0opwHVNZLHrBVjYI2LOnuxl5k=
X-Received: by 2002:a1f:6bc8:: with SMTP id k69mr13930643vki.84.1543366980187;
 Tue, 27 Nov 2018 17:03:00 -0800 (PST)
MIME-Version: 1.0
References: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
 <20181124141616.GH3175@vkoul-mobl.Dlink> <CAK7LNAR8Tk9iXPLnv4XDM0E=kTWwv2+UGz+xmtA-eJyjRFjFRw@mail.gmail.com>
 <20181127145911.GC3175@vkoul-mobl.Dlink>
In-Reply-To: <20181127145911.GC3175@vkoul-mobl.Dlink>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 28 Nov 2018 10:02:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT1wxdpp7qUAf9YgJu8MfzqrgnWkXA-032nnpSBZR9o6A@mail.gmail.com>
Message-ID: <CAK7LNAT1wxdpp7qUAf9YgJu8MfzqrgnWkXA-032nnpSBZR9o6A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] dmaengine: add UniPhier MIO DMAC driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 12:01 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 25-11-18, 22:53, Masahiro Yamada wrote:
> > On Sat, Nov 24, 2018 at 11:16 PM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > On 12-10-18, 01:41, Masahiro Yamada wrote:
> > > > 1/2: DT-binding
> > > > 2/2: driver
> > >
> > > Applied this series, thanks
> >
> >
> > Thanks.
> >
> >
> > > While building I noticed that we get few warns when compiling with
> > > C=1, I would prefer you fix them. Please send fixes on top of the
> > > applied patches.
> >
> > My code is fine.
>
> Lets see..
>
> > If you are talking about the following, your sparse is too old.
> > Upgrade your sparse.
>
> Not really!!
>
> $ sparse --version
> 0.5.2
>
> .. is the last released version!
>
> Do you use from git?


Yes.

My version is v0.5.2-853-g06a4545


I only see './include/linux/slab.h:332:43: warning: dubious: x & !y'
in linux-next.


The warning in slab.h is already on the way in mm subsystem.



masahiro@pug:~/ref/linux-next$ git log --oneline -1
9d52999 Add linux-next specific files for 20181127
masahiro@pug:~/ref/linux-next$ make ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- C=2 defconfig
drivers/dma/uniphier-mdmac.o
*** Default configuration is based on 'defconfig'
#
# configuration written to .config
#
scripts/kconfig/conf  --syncconfig Kconfig
  CHECK   scripts/mod/empty.c
  CC      scripts/mod/empty.o
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  CC      scripts/mod/devicetable-offsets.s
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  UPD     include/generated/bounds.h
  UPD     include/generated/timeconst.h
  CC      arch/arm64/kernel/asm-offsets.s
  UPD     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
<stdin>:1338:2: warning: #warning syscall open_tree not implemented [-Wcpp]
<stdin>:1341:2: warning: #warning syscall move_mount not implemented [-Wcpp]
<stdin>:1344:2: warning: #warning syscall fsopen not implemented [-Wcpp]
<stdin>:1347:2: warning: #warning syscall fsconfig not implemented [-Wcpp]
<stdin>:1350:2: warning: #warning syscall fsmount not implemented [-Wcpp]
<stdin>:1353:2: warning: #warning syscall fspick not implemented [-Wcpp]
<stdin>:1356:2: warning: #warning syscall fsinfo not implemented [-Wcpp]
  CALL    scripts/atomic/check-atomics.sh
  LDS     arch/arm64/kernel/vdso/vdso.lds
  VDSOA   arch/arm64/kernel/vdso/gettimeofday.o
  VDSOA   arch/arm64/kernel/vdso/sigreturn.o
  VDSOL   arch/arm64/kernel/vdso/vdso.so.dbg
  VDSOSYM include/generated/vdso-offsets.h
  CHECK   drivers/dma/uniphier-mdmac.c
./include/linux/slab.h:332:43: warning: dubious: x & !y
  CC      drivers/dma/uniphier-mdmac.o




> > ./include/linux/overflow.h:285:13: error: undefined identifier
> > '__builtin_mul_overflow'
> > ./include/linux/overflow.h:285:13: error: incorrect type in conditional
> > ./include/linux/overflow.h:285:13:    got void
> > ./include/linux/overflow.h:287:13: error: undefined identifier
> > '__builtin_add_overflow'
> > ./include/linux/overflow.h:287:13: error: incorrect type in conditional
> > ./include/linux/overflow.h:287:13:    got void
> > ./include/linux/overflow.h:285:13: warning: call with no type!
> > ./include/linux/overflow.h:287:13: warning: call with no type!
>
> and I was also talking about:
>
> arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> include/linux/slab.h:332:43: warning: dubious: x & !y
>
> --
> ~Vinod



-- 
Best Regards
Masahiro Yamada
