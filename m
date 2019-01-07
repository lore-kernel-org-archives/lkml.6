Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FA8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F060F2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wsiUciDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfAGLkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:40:21 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:53084 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfAGLkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:40:21 -0500
X-Greylist: delayed 5229 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jan 2019 06:40:19 EST
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x07Bdum0006927;
        Mon, 7 Jan 2019 20:39:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x07Bdum0006927
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546861197;
        bh=1pce89Xuu/SQD6MUt0rAnmw+Cy8DMlkxYa3v11KkerM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wsiUciDZXXEFZuUKTgLKv68SHrxEjtY9DbfWBdNRB3XXGrtjMKUSUiZh+IjTmzpwf
         qfo0VuzM3WZhom+UK2kvQthyYqN5QRv3Q9xnUdeDMIvK+GRrInP1AXNPMlULCmpisW
         kELVnP+18mm2DrdX+XX8xah+jEZF445UKQ3JLN4SQar/ev5/WMnqv8Ybksnn3tLxzY
         9MAWfWJ3Djj8VdLezTY9M/nPTuBVXS6sEpsLHWOThuNQn2Zc5Y963oIVe/jzqPnVt6
         16NnkrFv2u/XJbn83VRKATtVXfZeNXnP8GHqSvZSouRdqr9rVLN5kOsO2PLTSbGPBz
         Y6VURk4gr+5sQ==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id t127so4215vke.8;
        Mon, 07 Jan 2019 03:39:57 -0800 (PST)
X-Gm-Message-State: AJcUuke+HEBDjr2gjYCeNHIMnbwSGvZR7eAS6WSHPm2QjahcN/EI52/o
        KX0vhGUmC/P0ZRH6c+gC9xNnDEEFe8U4S4w8EMk=
X-Google-Smtp-Source: ALg8bN5nsfKH0V1CCRhhCVEHPNosZ5eb+/lp/OYax5L8xtHB6QsepsCGxQNf5XhOTv8ngtTMiVi7pFB/Udid/OlUZss=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr22781451vkd.74.1546861196013;
 Mon, 07 Jan 2019 03:39:56 -0800 (PST)
MIME-Version: 1.0
References: <20190104195714.30045-1-labbott@redhat.com> <874lakc09x.fsf@concordia.ellerman.id.au>
 <CAK7LNAQLEYc=czrJvzK8UXeXYm08TuLB62uMN2kFedkcW9b1pw@mail.gmail.com> <20190107120716.51d95854.cohuck@redhat.com>
In-Reply-To: <20190107120716.51d95854.cohuck@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 7 Jan 2019 20:39:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQtsW5KoOQmOB4uSv2zHM80azmHnEMj=2BunikhJQEpig@mail.gmail.com>
Message-ID: <CAK7LNAQtsW5KoOQmOB4uSv2zHM80azmHnEMj=2BunikhJQEpig@mail.gmail.com>
Subject: Re: [PATCH] vfio_pci: Add local source directory as include
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Laura Abbott <labbott@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 8:09 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, 7 Jan 2019 19:12:10 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
> > On Mon, Jan 7, 2019 at 6:18 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > >
> > > Laura Abbott <labbott@redhat.com> writes:
> > > > Commit 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2]
> > > > subdriver") introduced a trace.h file in the local directory but
> > > > missed adding the local include path, resulting in compilation
> > > > failures with tracepoints:
> > > >
> > > > In file included from drivers/vfio/pci/trace.h:102,
> > > >                  from drivers/vfio/pci/vfio_pci_nvlink2.c:29:
> > > > ./include/trace/define_trace.h:89:42: fatal error: ./trace.h: No such file or directory
> > > >  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > > >
> > > > Fix this by adjusting the include path.
> > > >
> > > > Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
> > > > Signed-off-by: Laura Abbott <labbott@redhat.com>
>
> (...)
>
> > > Alex I assume you'll merge this fix via the vfio tree?
> > >
> > > cheers
> > >
> > > > diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> > > > index 9662c063a6b1..08d4676a8495 100644
> > > > --- a/drivers/vfio/pci/Makefile
> > > > +++ b/drivers/vfio/pci/Makefile
> > > > @@ -1,3 +1,4 @@
> > > > +ccflags-y                               += -I$(src)
> > > >
> > > >  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
> > > >  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> > > > --
> > > > 2.20.1
> >
> >
> > Hi.
> >
> > If I correctly understand the usage of TRACE_INCLUDE_PATH,
> > the correct fix should be like follows:
> >
> >
> > diff --git a/drivers/vfio/pci/trace.h b/drivers/vfio/pci/trace.h
> > index 228ccdb..4d13e51 100644
> > --- a/drivers/vfio/pci/trace.h
> > +++ b/drivers/vfio/pci/trace.h
> > @@ -94,7 +94,7 @@ TRACE_EVENT(vfio_pci_npu2_mmap,
> >  #endif /* _TRACE_VFIO_PCI_H */
> >
> >  #undef TRACE_INCLUDE_PATH
> > -#define TRACE_INCLUDE_PATH .
> > +#define TRACE_INCLUDE_PATH ../../drivers/vfio/pci
> >  #undef TRACE_INCLUDE_FILE
> >  #define TRACE_INCLUDE_FILE trace
>
> Going from the comments in samples/trace_events/trace-events-sample.h,
> I think both approaches are possible, and I see both used in various
> places.
>
> Personally, I'd prefer Laura's patch, as it doesn't involve hardcoding
> a path.



ccflags-y += -I$(src)
would add the header search path for all files in drivers/vfio/pci/
whereas only the drivers/vfio/pci/vfio_pci_nvlink2.c needs it.



CFLAGS_vfio_pci_nvlink2.o += -I$(src)
is a bit better.
However, it is not obvious why this extra header search path is needed
until you find vfio_pci_nvlink2.c including trace.h



#define TRACE_INCLUDE_PATH ../../drivers/vfio/pci
clarifies the intention because the related code is all placed in trace.h



From the comment in include/trace/define_trace.h
TRACE_INCLUDE_PATH is relative to include/trace/define_trace.h




-- 
Best Regards
Masahiro Yamada
