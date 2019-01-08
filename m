Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC2AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF54C2070C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SZa0v2G/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfAHCjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:39:14 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:49250 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfAHCjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 21:39:10 -0500
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x082coBK024989;
        Tue, 8 Jan 2019 11:38:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x082coBK024989
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546915132;
        bh=v6PtAFpx0s+xQpxb5yN+utZgCQLN8oxhJpZ9ly5eSVI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SZa0v2G/ZFw4iOzp8r0BQIOuoF520KZv04K0S/7aGidTczFb8YtElkedyl8Fe4waE
         Va3rKampfW9c6Z6tpGJ3IikQxy6vF3TPFx7ryo8wCENJ98eyFAv8MTUMNKSiZD/qzI
         PQZi8f+tPU38mg0o8kKSoMxSi9Wbda//b7uF+DFC+ts8nz/qjS2VLao96HD70t76y/
         eW67FEzZP7GgF0SIrjs1TuFTQXiVpjx6ce/zWa5V1AyyXiBBS7fZfEehF6ZwJtfCXt
         4KIjJeh4VCh2sqJb0w4prPhNngQ6Ospu5v5YfZgGEwN3L7Z3rlF9FF/C73Grx0SHOF
         J+3xf9/ZefSQw==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id t127so553364vke.8;
        Mon, 07 Jan 2019 18:38:51 -0800 (PST)
X-Gm-Message-State: AJcUukeGQQVSRBjgdWAsk5u1JD11JE1xD3s/haOXoUlY4SGkUuSp84Al
        SclR443RIqA7XZRmRq9PvZAUAbuo/zEjND8vuO4=
X-Google-Smtp-Source: ALg8bN58MC+Va1QKXa57dVCkrvx8uYkM2pHxWf+7sxdTAkrXScWZcI85lcKs4pd7LE0jIx7cCTWRHg7DEXkQ+NOk/Js=
X-Received: by 2002:a1f:4d47:: with SMTP id a68mr22904590vkb.34.1546915130339;
 Mon, 07 Jan 2019 18:38:50 -0800 (PST)
MIME-Version: 1.0
References: <20190104195714.30045-1-labbott@redhat.com> <874lakc09x.fsf@concordia.ellerman.id.au>
 <CAK7LNAQLEYc=czrJvzK8UXeXYm08TuLB62uMN2kFedkcW9b1pw@mail.gmail.com>
 <20190107120716.51d95854.cohuck@redhat.com> <CAK7LNAQtsW5KoOQmOB4uSv2zHM80azmHnEMj=2BunikhJQEpig@mail.gmail.com>
 <20190107131341.00581863@x1.home> <4b9b6cf2-d39e-8dd2-9271-158489b03a61@ozlabs.ru>
 <20190107172437.0f0b5331@x1.home> <e906adde-3a5b-69f8-10b3-ad88ab530913@ozlabs.ru>
In-Reply-To: <e906adde-3a5b-69f8-10b3-ad88ab530913@ozlabs.ru>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 8 Jan 2019 11:38:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQoxeRmTg5QBMuWQ1Z8QQBWG_72KOBGz8PD-2vFWZFwqA@mail.gmail.com>
Message-ID: <CAK7LNAQoxeRmTg5QBMuWQ1Z8QQBWG_72KOBGz8PD-2vFWZFwqA@mail.gmail.com>
Subject: Re: [PATCH] vfio_pci: Add local source directory as include
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Laura Abbott <labbott@redhat.com>, kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 11:22 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
>
>
> On 08/01/2019 11:24, Alex Williamson wrote:
> > On Tue, 8 Jan 2019 10:52:43 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >
> >> On 08/01/2019 07:13, Alex Williamson wrote:
> >>> On Mon, 7 Jan 2019 20:39:19 +0900
> >>> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >>>
> >>>> On Mon, Jan 7, 2019 at 8:09 PM Cornelia Huck <cohuck@redhat.com> wrote:
> >>>>>
> >>>>> On Mon, 7 Jan 2019 19:12:10 +0900
> >>>>> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >>>>>
> >>>>>> On Mon, Jan 7, 2019 at 6:18 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >>>>>>>
> >>>>>>> Laura Abbott <labbott@redhat.com> writes:
> >>>>>>>> Commit 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2]
> >>>>>>>> subdriver") introduced a trace.h file in the local directory but
> >>>>>>>> missed adding the local include path, resulting in compilation
> >>>>>>>> failures with tracepoints:
> >>>>>>>>
> >>>>>>>> In file included from drivers/vfio/pci/trace.h:102,
> >>>>>>>>                  from drivers/vfio/pci/vfio_pci_nvlink2.c:29:
> >>>>>>>> ./include/trace/define_trace.h:89:42: fatal error: ./trace.h: No such file or directory
> >>>>>>>>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >>>>>>>>
> >>>>>>>> Fix this by adjusting the include path.
> >>>>>>>>
> >>>>>>>> Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
> >>>>>>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
> >>>>>
> >>>>> (...)
> >>>>>
> >>>>>>> Alex I assume you'll merge this fix via the vfio tree?
> >>>>>>>
> >>>>>>> cheers
> >>>>>>>
> >>>>>>>> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> >>>>>>>> index 9662c063a6b1..08d4676a8495 100644
> >>>>>>>> --- a/drivers/vfio/pci/Makefile
> >>>>>>>> +++ b/drivers/vfio/pci/Makefile
> >>>>>>>> @@ -1,3 +1,4 @@
> >>>>>>>> +ccflags-y                               += -I$(src)
> >>>>>>>>
> >>>>>>>>  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
> >>>>>>>>  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> >>>>>>>> --
> >>>>>>>> 2.20.1
> >>>>>>
> >>>>>>
> >>>>>> Hi.
> >>>>>>
> >>>>>> If I correctly understand the usage of TRACE_INCLUDE_PATH,
> >>>>>> the correct fix should be like follows:
> >>>>>>
> >>>>>>
> >>>>>> diff --git a/drivers/vfio/pci/trace.h b/drivers/vfio/pci/trace.h
> >>>>>> index 228ccdb..4d13e51 100644
> >>>>>> --- a/drivers/vfio/pci/trace.h
> >>>>>> +++ b/drivers/vfio/pci/trace.h
> >>>>>> @@ -94,7 +94,7 @@ TRACE_EVENT(vfio_pci_npu2_mmap,
> >>>>>>  #endif /* _TRACE_VFIO_PCI_H */
> >>>>>>
> >>>>>>  #undef TRACE_INCLUDE_PATH
> >>>>>> -#define TRACE_INCLUDE_PATH .
> >>>>>> +#define TRACE_INCLUDE_PATH ../../drivers/vfio/pci
> >>>>>>  #undef TRACE_INCLUDE_FILE
> >>>>>>  #define TRACE_INCLUDE_FILE trace
> >>>>>
> >>>>> Going from the comments in samples/trace_events/trace-events-sample.h,
> >>>>> I think both approaches are possible, and I see both used in various
> >>>>> places.
> >>>>>
> >>>>> Personally, I'd prefer Laura's patch, as it doesn't involve hardcoding
> >>>>> a path.
> >>>
> >>> Numbering options for clarity:
> >>>
> >>> 1)
> >>>> ccflags-y += -I$(src)
> >>>> would add the header search path for all files in drivers/vfio/pci/
> >>>> whereas only the drivers/vfio/pci/vfio_pci_nvlink2.c needs it.
> >>>>
> >>>
> >>> 2)
> >>>> CFLAGS_vfio_pci_nvlink2.o += -I$(src)
> >>>> is a bit better.
> >>>> However, it is not obvious why this extra header search path is needed
> >>>> until you find vfio_pci_nvlink2.c including trace.h
> >>>>
> >>>
> >>> 3)
> >>>> #define TRACE_INCLUDE_PATH ../../drivers/vfio/pci
> >>>> clarifies the intention because the related code is all placed in trace.h
> >>>>
> >>>>
> >>>>
> >>>> From the comment in include/trace/define_trace.h
> >>>> TRACE_INCLUDE_PATH is relative to include/trace/define_trace.h
> >>>
> >>> In my scan of the tree, the most common solution seems to be 2) as this
> >>> is essentially recommended in the sample file.  3) is well represented,
> >>> with much fewer examples of 1), though it might depend how liberally
> >>> we grep out or examine the use cases.  Choice 1) also seems to be the
> >>> most shotgun approach, adding to the search path for all files.
> >>
> >>
> >> The shotgun approach is always used when compiling out of tree which is
> >> what many people do anyway without realizing that there are additional
> >> -I. Why do not we make in-tree behave the same way? Thanks,
> >
> > Are you suggesting bandaging this individual leaf directory, as in
> > choice 1), because it's no worse than what happens for an out-of-tree
> > build anyway,
>
>
> I suggest making in-tree and out-of-tree behavior equal - both either
> fail or compile. Just makes sense to me.
>
> Since out-of-tree adds extra -I, then there should have been a reason
> for that at the time (before 2005 though). Unfortunately git blame does
> not say why it was done this way for out-of-tree so imho the safest
> thing is to add -I for in-tree as well. Or ditch extra -I and do 2) or
> 3) - this is fine too and can count as an impressive compile
> optimization, although... look below :)


For the out-of-tree building,
scripts/Makefile.lib adds -I$(srctree)/$(src) and -I$(obj).


In my understanding, -I$(srctree)/$(src) is for
including check-in headers from generated C files.

-I$(obj) is for including generated headers from check-in C files.


One example of the correct usage of this is,

  crypto/rsa_helper.c     (check-in file)

includes

  crypto/rsapubkey.asn1.h (generated fle)



Those extra header search paths are unneeded for in-tree building
since generated files and check-in files exist in the same tree.



You just happened to find it works for out-of-tree building.


We are talking about how to make include/trace/define_trace.h
include  drivers/vfio/pci/trace.h

The build system cannot (should not)
cater to such a particular case.






>
> > or are you suggesting to fix the in-tree build behavior to
> > be as inefficient as the out-of-tree behavior in general?
>
> Inefficient you say. Hm.
>
> I tried this:
>
> --- scripts/Makefile.lib.old    2019-01-08 11:39:51.830983393 +1100
> +++ scripts/Makefile.lib        2019-01-08 13:09:54.199054981 +1100
> @@ -140,11 +140,6 @@
>  # If building the kernel in a separate objtree expand all occurrences
>  # of -Idir to -I$(srctree)/dir except for absolute paths (starting with
> '/').
>
> -ifeq ($(KBUILD_SRC),)
> -__c_flags      = $(_c_flags)
> -__a_flags      = $(_a_flags)
> -__cpp_flags     = $(_cpp_flags)
> -else
>
>  # -I$(obj) locates generated .h files
>  # $(call addtree,-I$(obj)) locates .h files in srctree, from generated
> .c files
> @@ -154,7 +149,6 @@
>                   $(call flags,_c_flags)
>  __a_flags      = $(call flags,_a_flags)
>  __cpp_flags     = $(call flags,_cpp_flags)
> -endif
>
>
> Compiled 3 times with the patch and without, "make clean ; time make
> -j200 vmlinux modules".
>
> No patch:
>
> real    4m33.047s       user    481m48.322s     sys     10m15.639s
> real    4m29.038s       user    480m22.873s     sys     10m11.394s
> real    4m34.373s       user    483m7.570s      sys     10m10.559s
>
> With the patch:
>
> real    4m32.008s       user    479m54.207s     sys     10m13.075s
> real    4m30.027s       user    479m46.272s     sys     10m15.886s
> real    4m31.548s       user    480m2.897s      sys     10m10.024
>
>
> which is slightly faster but I guess within accuracy.
>
>
>
> > It appears
> > to me that options 2) and 3) are the intended solutions for this issue
> > while 1) is more of a workaround.  Thanks,
> >
> > Alex
> >
> >>>  From a
> >>> maintenance perspective I agree that 2) seems more error prone,
> >>> especially when the build system only catches the error on in-tree
> >>> builds, something I rarely do.  Therefore I'm leaning towards option
> >>> 3).  The hardcoded path here doesn't seem much of an issue relative to
> >>> the negatives of the other approaches (how often do we move these
> >>> files?) and it keeps the trace support relatively self-contained.  Are
> >>> there further arguments for or against these options?  Otherwise who
> >>> wants to formally post the TRACE_INCLUDE_PATH version?  Thanks,
>
>
>
>
> --
> Alexey



-- 
Best Regards
Masahiro Yamada
