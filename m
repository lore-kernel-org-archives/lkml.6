Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CECC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E9B20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="crmRPRH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E9B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbeLGMpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:45:41 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39817 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeLGMpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:45:41 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so6806151itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IPMi7s8MsS9Oq2TJhPvjYVOvLQcMtk/ZoVNYUrufOfE=;
        b=crmRPRH2iEc0Ae29iyVjYqLc1EWe6N/lxQ/OFZj9FghtO38TGYr5is6+novf0PJVUz
         kD4XYeFXg0Dv7nqKjZsHTw6QuK60tgexjNEMKJ0uoucoqMasJ7UXAvICrhzsoOIE28lm
         MSQ+EI4ngL5J5E9PUn2lFxkzlI3v8VV9qBWeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IPMi7s8MsS9Oq2TJhPvjYVOvLQcMtk/ZoVNYUrufOfE=;
        b=is+bA0As4Ft5kYVl4FpAbPh/cm/uMxxMauA5X84XJ06zp+zeXJvxUsYClwCOXmHlET
         rvfVHKfsp/H/nWjfGo6htl9bSaEBOBzTYz9JiGtX3x6oZ0xhD+hhzvAP3NKvbftAIXGR
         Us8QJp0bYoAcw2ixbAB7ar32jDjtZF6kxvW6NpWs/hwTDaTIaEICUU5cLi3Srw2WbvR3
         f8FDGgZk97PpatLLEclw8ohNgCOYTX2bDuHWmi93/ATkME8GJ4lFi9ujABu3x7l0Pl0u
         xMiw6cmwjXCR+Tbeb+NeYwboqeTk9suKRk8jACMdBmNGQsChSG2v8OzioMaQv8xw7m8X
         gT7g==
X-Gm-Message-State: AA+aEWbcs5rThSdZpRBNm8hjYpl0bbcknIzLVG5JWhfka8Ho2PcXMZlv
        3m8sCDLgHHwyBVSkfi3hEau6fQdBDB4kuVFEAwV5ow==
X-Google-Smtp-Source: AFSGD/VroAGZAgSsRhcfMCUixFDdthX2uENkLdqk9Qt5++AkkmwnCYh+BjmCUDflXnDgtURZQAfwjkxWxtsLw8CQ4IU=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr1983278itk.71.1544186739850;
 Fri, 07 Dec 2018 04:45:39 -0800 (PST)
MIME-Version: 1.0
References: <1543517152-23969-1-git-send-email-cai@gmx.us> <20181206161633.36292-1-cai@gmx.us>
 <20181206175958.GS54495@arrakis.emea.arm.com> <CAKv+Gu97MU5kU878gF=KBLxQ5GjZatAbJ-LVdKv-QMgdPh3kZQ@mail.gmail.com>
 <1544119499.12945.48.camel@gmx.us> <CAKv+Gu9ugNxoST=cc9utWNtoYFdPng0FgNfV-Mw0UWyJiKqOLw@mail.gmail.com>
 <trinity-73766f32-cf87-4bcd-a655-9eaa40b9ee9c-1544185959983@msvc-mesg-gmx023>
In-Reply-To: <trinity-73766f32-cf87-4bcd-a655-9eaa40b9ee9c-1544185959983@msvc-mesg-gmx023>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Dec 2018 13:45:28 +0100
Message-ID: <CAKv+Gu-m-5ippngFrxm=ueLS=ziGmhvfrd2Uo2Hido+WjKo1Ag@mail.gmail.com>
Subject: Re: [RESEND PATCH] efi: let kmemleak ignore false positives
To:     Qian Cai <cai@gmx.us>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018 at 13:32, Qian Cai <cai@gmx.us> wrote:
>
>
> On 12/7/18 at 6:28 AM, Ard Biesheuvel wrote:
>
> > On Thu, 6 Dec 2018 at 19:05, Qian Cai <cai@gmx.us> wrote:
> > >
> > > On Thu, 2018-12-06 at 19:01 +0100, Ard Biesheuvel wrote:
> > > > On Thu, 6 Dec 2018 at 19:00, Catalin Marinas <catalin.marinas@arm.c=
om> wrote:
> > > > >
> > > > > On Thu, Dec 06, 2018 at 11:16:33AM -0500, Qian Cai wrote:
> > > > > > unreferenced object 0xffff8096c1acf580 (size 128):
> > > > > >   comm "swapper/63", pid 0, jiffies 4294937418 (age 1201.230s)
> > > > > >   hex dump (first 32 bytes):
> > > > > >     80 87 b5 c1 96 00 00 00 00 00 cc c2 16 00 00 00  ..........=
......
> > > > > >     00 00 01 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kk=
kkkkkk
> > > > > >   backtrace:
> > > > > >     [<000000001d2549ba>] kmem_cache_alloc_trace+0x430/0x500
> > > > > >     [<0000000093a6dfab>] efi_mem_reserve_persistent+0x50/0xf8
> > > > > >     [<000000000a730828>] its_cpu_init_lpis+0x394/0x4b8
> > > > > >     [<00000000edf04e07>] its_cpu_init+0x104/0x150
> > > > > >     [<000000004d0342c5>] gic_starting_cpu+0x34/0x40
> > > > > >     [<000000005d9da772>] cpuhp_invoke_callback+0x228/0x1d68
> > > > > >     [<0000000061eace9b>] notify_cpu_starting+0xc0/0x118
> > > > > >     [<0000000048bc2dc5>] secondary_start_kernel+0x23c/0x3b0
> > > > > >     [<0000000015137d6a>] 0xffffffffffffffff
> > > > > >
> > > > > > efi_mem_reserve_persistent+0x50/0xf8:
> > > > > > kmalloc at include/linux/slab.h:546
> > > > > > (inlined by) efi_mem_reserve_persistent at drivers/firmware/efi=
/efi.c:979
> > > > > >
> > > > > > This line,
> > > > > >
> > > > > > rsv =3D kmalloc(sizeof(*rsv), GFP_ATOMIC);
> > > > > >
> > > > > > Kmemleak has a known limitation that can only track pointers in=
 the kernel
> > > > > > virtual space. Hence, it will report false positives due to "rs=
v" will
> > > > > > only
> > > > > > reference to other physical addresses,
> > > > > >
> > > > > > rsv->next =3D efi_memreserve_root->next;
> > > > > > efi_memreserve_root->next =3D __pa(rsv);
> > > > > >
> > > > > > Signed-off-by: Qian Cai <cai@gmx.us>
> > > > >
> > > > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>\
> > > >
> > > > I don't see the patch and I wasn't cc'ed
> > >
> > > That is strange. Please see,
> > >
> > > https://lore.kernel.org/lkml/1543517152-23969-1-git-send-email-cai@gm=
x.us/
> >
> > OK, I found it in my spam folder, apologies for that.
> >
> > This kmalloc() will be replaced in the next merge window by a call to
> > __get_free_page(). Does kmemleak still require the kmemleak_ignore()
> > for that case? Or is it only for kmalloc()?
>
> Looks like kmemleak won=E2=80=99t be able to track page
> allocation, so it should be fine then without
> kmemleak_ignore().

OK, thanks Qian

I will take the patch for v4.20 and remove the kmemleak_ignore() again for =
v4.21
