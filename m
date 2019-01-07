Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278F5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EE42087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WuU8zn25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfAGKNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:13:12 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:26054 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfAGKNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:13:12 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x07ACl75007961;
        Mon, 7 Jan 2019 19:12:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x07ACl75007961
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546855968;
        bh=u9TU8/l/Cfrv+vLf0dS/Oj1MbzOzDK4gjlbMirfG1CM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WuU8zn25qVLSuJTyGnhuqWNEB3JHHOVVx9VEZsQjXXB8Oe9oTHshcVXH+iWTdntf9
         tr+sHdsV6Z5gJ410Gy2VkPIycNe93bve4ADCnHOI69At7X74B3Cxt8FME97CZCbGj4
         ggFgRODe/PbQUsf7MpaLPENopmcOd6FoFDDONAc9rS5rirkp71VnbQ6figoaM9Yx5f
         4Ityh6mVMzW9xy4XOg+38ULp70lYZyQav9JzgIbv0guXYpyhDNweQ7QQG8/8yWI+3E
         6xzd98fQTT6s7P4eL438dZ55c6ygTaucBLhnQ+/OGvPULDwvPI1N+qOX7gUpZwix/4
         MhkZYOjvkHl9g==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id j3so13985680uap.3;
        Mon, 07 Jan 2019 02:12:47 -0800 (PST)
X-Gm-Message-State: AJcUukd8j5InxO4J1XdcD91luBUdyXSmWn6obrDVZt2r6MUt88AjdUjN
        MMZ+sAqrbK9IbIIDMezjDn8BkdYayIBuUBmBOUY=
X-Google-Smtp-Source: ALg8bN7fKjFTjyRlkJeJ0XVZjSMBifIpcF+m8ARLb+6QPZCWZtgbkcE5KIoVUnfRXMsk2EE+VEs58HLoSP/6t0rQeOg=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr21599624uaj.42.1546855966538;
 Mon, 07 Jan 2019 02:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20190104195714.30045-1-labbott@redhat.com> <874lakc09x.fsf@concordia.ellerman.id.au>
In-Reply-To: <874lakc09x.fsf@concordia.ellerman.id.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 7 Jan 2019 19:12:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQLEYc=czrJvzK8UXeXYm08TuLB62uMN2kFedkcW9b1pw@mail.gmail.com>
Message-ID: <CAK7LNAQLEYc=czrJvzK8UXeXYm08TuLB62uMN2kFedkcW9b1pw@mail.gmail.com>
Subject: Re: [PATCH] vfio_pci: Add local source directory as include
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Laura Abbott <labbott@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 6:18 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Laura Abbott <labbott@redhat.com> writes:
> > Commit 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2]
> > subdriver") introduced a trace.h file in the local directory but
> > missed adding the local include path, resulting in compilation
> > failures with tracepoints:
> >
> > In file included from drivers/vfio/pci/trace.h:102,
> >                  from drivers/vfio/pci/vfio_pci_nvlink2.c:29:
> > ./include/trace/define_trace.h:89:42: fatal error: ./trace.h: No such file or directory
> >  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >
> > Fix this by adjusting the include path.
> >
> > Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
> > Signed-off-by: Laura Abbott <labbott@redhat.com>
> > ---
> > I'd still like to echo my sentiment that this should not be a def_bool.
> > We hit this error on our internal testing and we couldn't even turn
> > off the driver until we fixed this.
>
> I assume there's some reason you can't commit a patch to your tree to
> change it to bool, or turn it off entirely? That would change the SHA
> which is perhaps reason enough.
>
> In general we have far too many options and most of them never get
> turned off (or on), so it just creates testing/bug surface for not much
> benefit. This is one that will probably be turned on in all distro
> kernels for example.
>
> But I have no real objection to making it user configurable.
>
>
> Alex I assume you'll merge this fix via the vfio tree?
>
> cheers
>
> > diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> > index 9662c063a6b1..08d4676a8495 100644
> > --- a/drivers/vfio/pci/Makefile
> > +++ b/drivers/vfio/pci/Makefile
> > @@ -1,3 +1,4 @@
> > +ccflags-y                               += -I$(src)
> >
> >  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
> >  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> > --
> > 2.20.1


Hi.

If I correctly understand the usage of TRACE_INCLUDE_PATH,
the correct fix should be like follows:


diff --git a/drivers/vfio/pci/trace.h b/drivers/vfio/pci/trace.h
index 228ccdb..4d13e51 100644
--- a/drivers/vfio/pci/trace.h
+++ b/drivers/vfio/pci/trace.h
@@ -94,7 +94,7 @@ TRACE_EVENT(vfio_pci_npu2_mmap,
 #endif /* _TRACE_VFIO_PCI_H */

 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH ../../drivers/vfio/pci
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace









-- 
Best Regards
Masahiro Yamada
