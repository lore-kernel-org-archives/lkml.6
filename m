Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3164C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965FC20663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOBknAHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965FC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeKXH62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:58:28 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43000 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeKXH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:58:28 -0500
Received: by mail-io1-f68.google.com with SMTP id x6so9627812ioa.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 13:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hKYhyXTjzMMCXATgr0JKyll+UYRT8qnO5I8pGehsi5Y=;
        b=FOBknAHDd7MwPj+2WURr7blbpi2kn9NW/0w4J2GHBaFSxWcXOnF5OwLrZ2L5PLausg
         NWZBqmbbZNSqqWnav5ZEa6pq3cKAtGAWEmlXZy9kFH3njG7MG1PJvWJX1R0GDeOLzkNf
         aJzjpMolvdFrpsTO22mgOZky+SDbJu9A8Pz8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hKYhyXTjzMMCXATgr0JKyll+UYRT8qnO5I8pGehsi5Y=;
        b=bk4/qK2s5f32hnaSHe6GucWi7e8+uvIGkUy8GUCxWYv61AQGViQPWpiGiAZyR+5PkR
         LxqLDhI75DBJ7ICf4T0lUGisFFTzFg4yN7FNEqtEwpVNed0SBo5NRZUP74WY9VIFj+J1
         PQMUDYbdnRPnWTwHMuwYuX9T1LXTN79LMhLa7bswnYrowc2lbD31Su2ozLlN5a0FnOxi
         3ScuYOIGz+GLsypyI+kmSuEXoLybYz90vEpZt4XLKCtvozPVNsIxiBzJk/gxUbpuL2FH
         zuKv7/IfR26/lsavx+UlmQ7A0CG3k1H4dqs1X8rjeOVIGLerg75cgtLZNj9tXeGa+kcR
         62Fw==
X-Gm-Message-State: AA+aEWZn0V9amfYcI6lW0IJEeTCDn92RIPase34QdJhGy0QQ7sGZvcxy
        4XS5NTmdvc1RcbBTBURSV2bQeaJhqSWRvU4IMo9dkg==
X-Google-Smtp-Source: AFSGD/XOfUoudjQ2ewnC0HzTUE8JJCkQIwaeiV2C+j2morwnDUsvC7BcY9DmlyS7jrUMBmbnKJV0jzogFHwK9cPquV0=
X-Received: by 2002:a6b:7a46:: with SMTP id k6mr13461825iop.60.1543007553706;
 Fri, 23 Nov 2018 13:12:33 -0800 (PST)
MIME-Version: 1.0
References: <20181123094152.21368-1-ard.biesheuvel@linaro.org>
 <20181123094152.21368-2-ard.biesheuvel@linaro.org> <a3e95c22-fcae-3550-2d3c-4d07eaad95ae@iogearbox.net>
In-Reply-To: <a3e95c22-fcae-3550-2d3c-4d07eaad95ae@iogearbox.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 23 Nov 2018 22:12:21 +0100
Message-ID: <CAKv+Gu9SwbXaoBxUGaFSrBocWkjSGY3qMUqFaqK=p_DoGz4tjA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add __weak hook for allocating executable memory
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 at 22:07, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 11/23/2018 10:41 AM, Ard Biesheuvel wrote:
> > By default, BPF uses module_alloc() to allocate executable memory,
> > but this is not necessary on all arches and potentially undesirable
> > on some of them.
> >
> > So break out the module_alloc() and module_memfree() calls into __weak
> > functions to allow them to be overridden in arch code.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  kernel/bpf/core.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 1a796e0799ec..572dd74c26e3 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -609,6 +609,16 @@ static void bpf_jit_uncharge_modmem(u32 pages)
> >       atomic_long_sub(pages, &bpf_jit_current);
> >  }
> >
> > +void *__weak bpf_jit_alloc_exec(unsigned long size)
> > +{
> > +     return module_alloc(size);
> > +}
> > +
> > +void __weak bpf_jit_free_exec(const void *addr)
> > +{
> > +     module_memfree(addr);
> > +}
> > +
> >  struct bpf_binary_header *
> >  bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
> >                    unsigned int alignment,
> > @@ -626,7 +636,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **ima=
ge_ptr,
> >
> >       if (bpf_jit_charge_modmem(pages))
> >               return NULL;
> > -     hdr =3D module_alloc(size);
> > +     hdr =3D bpf_jit_alloc_exec(size);
> >       if (!hdr) {
> >               bpf_jit_uncharge_modmem(pages);
> >               return NULL;
> > @@ -650,7 +660,7 @@ void bpf_jit_binary_free(struct bpf_binary_header *=
hdr)
> >  {
> >       u32 pages =3D hdr->pages;
> >
> > -     module_memfree(hdr);
> > +     bpf_jit_free_exec(hdr);
> >       bpf_jit_uncharge_modmem(pages);
>
> The const needs to be removed, this generates the following warning:
>
> # make -j8 kernel/bpf/
>   DESCEND  objtool
>   CALL    scripts/checksyscalls.sh
>   CC      kernel/bpf/core.o
>   CC      kernel/bpf/syscall.o
>   CC      kernel/bpf/verifier.o
>   CC      kernel/bpf/hashtab.o
>   CC      kernel/bpf/helpers.o
>   CC      kernel/bpf/inode.o
>   CC      kernel/bpf/arraymap.o
>   CC      kernel/bpf/lpm_trie.o
> kernel/bpf/core.c: In function =E2=80=98bpf_jit_free_exec=E2=80=99:
> kernel/bpf/core.c:619:17: warning: passing argument 1 of =E2=80=98module_=
memfree=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier from pointer ta=
rget type [-Wdiscarded-qualifiers]
>   module_memfree(addr);
>                  ^~~~
> In file included from kernel/bpf/core.c:28:0:
> ./include/linux/moduleloader.h:30:6: note: expected =E2=80=98void *=E2=80=
=99 but argument is of type =E2=80=98const void *=E2=80=99
>  void module_memfree(void *module_region);
>       ^~~~~~~~~~~~~~
>   CC      kernel/bpf/local_storage.o
> [...]
>
> Please respin with that fixed.
>

OK.

I'll respin the second patch as well, and move the BPF window to the
start of the vmalloc region. However, the arm64 maintainers need to
ack that as well since it modifies the layout of the kernel virtual
address space.
