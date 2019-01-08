Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21905C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3E0206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xFqUudw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfAHDUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:20:10 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:46277 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfAHDUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:20:09 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x083K5mA015685;
        Tue, 8 Jan 2019 12:20:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x083K5mA015685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546917606;
        bh=a+86zybEjf1G0Z7C+9XqCQhInOTEfD3m7EouQ3r6vA8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xFqUudw7GrqCLDJ96WMs1/gSZyKv/bYCVPU2vbK7vmCYq3PnI9t2e8doeMv3A05Lc
         xm9kO2/v/nibVcK6GAAxS3dGqwM/aJdNMH/QWZINB60QZXz7Fd8+P28Ch4HEApm5ty
         vVsjWCuPL4mlb8Qf4cH955E6tsBvuaOm21x65rvJruhKz91ZgYRoo4lkAkl6MCoP31
         dkOLyrzsbkdPb1qEpMrBJ9vIzZGnfiOlOrS9Bb0T6KwQLnWWRMeSQskO1ZGqRK4nPO
         ASJVfTYz6UsRsCLe0HXOVQ1oDr6VZMW59zH4P0oWuG5w7TxJ2YQA9b4/ZnCOnI8HLR
         sQSA1n2XexqHw==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id v205so1621326vsc.3;
        Mon, 07 Jan 2019 19:20:05 -0800 (PST)
X-Gm-Message-State: AJcUukd9JhNLCUMtrzhngq/kETOcmzT+vWzxgv5hYQpqErNC/TsbBiWX
        +cwe35cCYy217ESsNGc/SO77zQtv30FYAepFf90=
X-Google-Smtp-Source: ALg8bN4NJk3bJGFN/EXmTB0G/arwYqrPDJk3cxHk/uSxaWSgcWjVL5FeUhW4IEFMLPM0G44b+cYXmHP6DGa4VukIXEk=
X-Received: by 2002:a67:f1c2:: with SMTP id v2mr24097vsm.181.1546917604398;
 Mon, 07 Jan 2019 19:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20190104195714.30045-1-labbott@redhat.com> <874lakc09x.fsf@concordia.ellerman.id.au>
 <CAK7LNAQLEYc=czrJvzK8UXeXYm08TuLB62uMN2kFedkcW9b1pw@mail.gmail.com>
 <20190107120716.51d95854.cohuck@redhat.com> <CAK7LNAQtsW5KoOQmOB4uSv2zHM80azmHnEMj=2BunikhJQEpig@mail.gmail.com>
 <20190107131341.00581863@x1.home> <4b9b6cf2-d39e-8dd2-9271-158489b03a61@ozlabs.ru>
 <20190107172437.0f0b5331@x1.home> <e906adde-3a5b-69f8-10b3-ad88ab530913@ozlabs.ru>
 <CAK7LNAQoxeRmTg5QBMuWQ1Z8QQBWG_72KOBGz8PD-2vFWZFwqA@mail.gmail.com> <34647ed9-6aa3-6e38-f3a5-87da87e9341a@ozlabs.ru>
In-Reply-To: <34647ed9-6aa3-6e38-f3a5-87da87e9341a@ozlabs.ru>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 8 Jan 2019 12:19:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNASNLW2YwY0SMsqeabzEr=xmjb_UCwmc9G3=A3q9PDv_8g@mail.gmail.com>
Message-ID: <CAK7LNASNLW2YwY0SMsqeabzEr=xmjb_UCwmc9G3=A3q9PDv_8g@mail.gmail.com>
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

On Tue, Jan 8, 2019 at 11:59 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
>
>
> On 08/01/2019 13:38, Masahiro Yamada wrote:
> > On Tue, Jan 8, 2019 at 11:22 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>
> >>
> >>
> >> On 08/01/2019 11:24, Alex Williamson wrote:
> >>> On Tue, 8 Jan 2019 10:52:43 +1100
> >>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>
> >>>> On 08/01/2019 07:13, Alex Williamson wrote:
> >>>>> On Mon, 7 Jan 2019 20:39:19 +0900
> >>>>> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >>>>>
> >>>>>> On Mon, Jan 7, 2019 at 8:09 PM Cornelia Huck <cohuck@redhat.com> wrote:
> >>>>>>>
> >>>>>>> On Mon, 7 Jan 2019 19:12:10 +0900
> >>>>>>> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >>>>>>>
> >>>>>>>> On Mon, Jan 7, 2019 at 6:18 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >>>>>>>>>
> >>>>>>>>> Laura Abbott <labbott@redhat.com> writes:
> >>>>>>>>>> Commit 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2]
> >>>>>>>>>> subdriver") introduced a trace.h file in the local directory but
> >>>>>>>>>> missed adding the local include path, resulting in compilation
> >>>>>>>>>> failures with tracepoints:
> >>>>>>>>>>
> >>>>>>>>>> In file included from drivers/vfio/pci/trace.h:102,
> >>>>>>>>>>                  from drivers/vfio/pci/vfio_pci_nvlink2.c:29:
> >>>>>>>>>> ./include/trace/define_trace.h:89:42: fatal error: ./trace.h: No such file or directory
> >>>>>>>>>>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >>>>>>>>>>
> >>>>>>>>>> Fix this by adjusting the include path.
> >>>>>>>>>>
> >>>>>>>>>> Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
> >>>>>>>>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
> >>>>>>>
> >>>>>>> (...)
> >>>>>>>
> >>>>>>>>> Alex I assume you'll merge this fix via the vfio tree?
> >>>>>>>>>
> >>>>>>>>> cheers
> >>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> >>>>>>>>>> index 9662c063a6b1..08d4676a8495 100644
> >>>>>>>>>> --- a/drivers/vfio/pci/Makefile
> >>>>>>>>>> +++ b/drivers/vfio/pci/Makefile
> >>>>>>>>>> @@ -1,3 +1,4 @@
> >>>>>>>>>> +ccflags-y                               += -I$(src)
> >>>>>>>>>>
> >>>>>>>>>>  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
> >>>>>>>>>>  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> >>>>>>>>>> --
> >>>>>>>>>> 2.20.1
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Hi.
> >>>>>>>>
> >>>>>>>> If I correctly understand the usage of TRACE_INCLUDE_PATH,
> >>>>>>>> the correct fix should be like follows:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/vfio/pci/trace.h b/drivers/vfio/pci/trace.h
> >>>>>>>> index 228ccdb..4d13e51 100644
> >>>>>>>> --- a/drivers/vfio/pci/trace.h
> >>>>>>>> +++ b/drivers/vfio/pci/trace.h
> >>>>>>>> @@ -94,7 +94,7 @@ TRACE_EVENT(vfio_pci_npu2_mmap,
> >>>>>>>>  #endif /* _TRACE_VFIO_PCI_H */
> >>>>>>>>
> >>>>>>>>  #undef TRACE_INCLUDE_PATH
> >>>>>>>> -#define TRACE_INCLUDE_PATH .
> >>>>>>>> +#define TRACE_INCLUDE_PATH ../../drivers/vfio/pci
> >>>>>>>>  #undef TRACE_INCLUDE_FILE
> >>>>>>>>  #define TRACE_INCLUDE_FILE trace
> >>>>>>>
> >>>>>>> Going from the comments in samples/trace_events/trace-events-sample.h,
> >>>>>>> I think both approaches are possible, and I see both used in various
> >>>>>>> places.
> >>>>>>>
> >>>>>>> Personally, I'd prefer Laura's patch, as it doesn't involve hardcoding
> >>>>>>> a path.
> >>>>>
> >>>>> Numbering options for clarity:
> >>>>>
> >>>>> 1)
> >>>>>> ccflags-y += -I$(src)
> >>>>>> would add the header search path for all files in drivers/vfio/pci/
> >>>>>> whereas only the drivers/vfio/pci/vfio_pci_nvlink2.c needs it.
> >>>>>>
> >>>>>
> >>>>> 2)
> >>>>>> CFLAGS_vfio_pci_nvlink2.o += -I$(src)
> >>>>>> is a bit better.
> >>>>>> However, it is not obvious why this extra header search path is needed
> >>>>>> until you find vfio_pci_nvlink2.c including trace.h
> >>>>>>
> >>>>>
> >>>>> 3)
> >>>>>> #define TRACE_INCLUDE_PATH ../../drivers/vfio/pci
> >>>>>> clarifies the intention because the related code is all placed in trace.h
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> From the comment in include/trace/define_trace.h
> >>>>>> TRACE_INCLUDE_PATH is relative to include/trace/define_trace.h
> >>>>>
> >>>>> In my scan of the tree, the most common solution seems to be 2) as this
> >>>>> is essentially recommended in the sample file.  3) is well represented,
> >>>>> with much fewer examples of 1), though it might depend how liberally
> >>>>> we grep out or examine the use cases.  Choice 1) also seems to be the
> >>>>> most shotgun approach, adding to the search path for all files.
> >>>>
> >>>>
> >>>> The shotgun approach is always used when compiling out of tree which is
> >>>> what many people do anyway without realizing that there are additional
> >>>> -I. Why do not we make in-tree behave the same way? Thanks,
> >>>
> >>> Are you suggesting bandaging this individual leaf directory, as in
> >>> choice 1), because it's no worse than what happens for an out-of-tree
> >>> build anyway,
> >>
> >>
> >> I suggest making in-tree and out-of-tree behavior equal - both either
> >> fail or compile. Just makes sense to me.
> >>
> >> Since out-of-tree adds extra -I, then there should have been a reason
> >> for that at the time (before 2005 though). Unfortunately git blame does
> >> not say why it was done this way for out-of-tree so imho the safest
> >> thing is to add -I for in-tree as well. Or ditch extra -I and do 2) or
> >> 3) - this is fine too and can count as an impressive compile
> >> optimization, although... look below :)
> >
> >
> > For the out-of-tree building,
> > scripts/Makefile.lib adds -I$(srctree)/$(src) and -I$(obj).
> >
> >
> > In my understanding, -I$(srctree)/$(src) is for
> > including check-in headers from generated C files.
> >
> > -I$(obj) is for including generated headers from check-in C files.
> >
> >
> > One example of the correct usage of this is,
> >
> >   crypto/rsa_helper.c     (check-in file)
> >
> > includes
> >
> >   crypto/rsapubkey.asn1.h (generated fle)
> >
> >
> >
> > Those extra header search paths are unneeded for in-tree building
> > since generated files and check-in files exist in the same tree.
> >
> >
> >
> > You just happened to find it works for out-of-tree building.
> >
> >
> > We are talking about how to make include/trace/define_trace.h
> > include  drivers/vfio/pci/trace.h
> >
> > The build system cannot (should not)
> > cater to such a particular case.
>
>
> Oh well, thanks for the explanation.
>
> Alex, how do we proceed now? I like 2) + comment as in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/misc/ocxl/Makefile?h=v4.20#n8

It is clear, but
3) TRACE_INCLUDE_PATH solution
is self-documenting.


> better than 3) as relative paths make it dependable on what file
> actually includes it and it is not clear what is that and what happens
> if that file moves deeper in the tree (unlikely to happen though).


From the build system PoV, I'd like to discourage people
from adding crappy header search path like this.

Both 2) and 3) have pros and cons.

I just sent 3) patch, but it is the maintainer's call after all.



>
>
>
>
> --
> Alexey



-- 
Best Regards
Masahiro Yamada
