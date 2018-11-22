Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F00C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093E820831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/pDGpSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093E820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405057AbeKVSlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:41:07 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40555 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392840AbeKVSlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:41:07 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so12639768ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 00:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GK/MWZZCGIGjTgrc3mmKl7oPXbkNjzS5FgkXVomfxG8=;
        b=J/pDGpSSTb4PDr3ntrTCOitxIUuQet0KlMJSmw73StHO1heJev9R8vzV6TgYeFOKj5
         XVDOZHGR0F3bU6WWFJEPjgoRim61B4GIeUG5ag9z2L9wMyb2iejfq+KLwSWN6LVHIYBG
         E5Wt0rYJI5DwvlRU4ZK7Kqz3utzqN7TMDbmQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GK/MWZZCGIGjTgrc3mmKl7oPXbkNjzS5FgkXVomfxG8=;
        b=YIyqQKCOyIDFdaCpenlvrITAEgmxoGkYXEKo1DoOQeLGWzoGxj7aqvDfw8kxHnX2Q9
         7ma/VJai93SIayddrQDYtq9BOmeOx4U9HOtHEIyH4KNgPWiDGyxjjCVuvq7qTs/qEu6D
         gc+w5qRbew+ZX32azdci0M0cEazcTlHhKjV8IU/ANy5fcKLwS7a//pfXl9vbQfkUQY3/
         j+4SCUXWfqja3LTGbi4Osvx8eAL0zPBZv8r6zYeLevpnGIUuJjaCVTopuOWz7ffifHyR
         uuslybemTtLP++B5/U6HYkD4cYKWnYNZly429q4OS+hTwjLVfLMnC5MlIh+wpOcc6bsn
         b9Aw==
X-Gm-Message-State: AGRZ1gKwB+SmF/6Sba/43xQ4xchaBpvMeLBVBMVqiS80zd2jXi7zy23O
        g2uZjWpSCCIUPGKR5ekiRvseh1IfPXetnC61MbNK9g==
X-Google-Smtp-Source: AJdET5e+Ime/J0w8Wt7sgTbMxUI1hfpIYEGhfzVHVGXk9IF5ocFQkYQ6Uxp3rFHY4KpB/aeUkZUZ9J+xeM7IegAUzas=
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr8742684jah.130.1542873768543;
 Thu, 22 Nov 2018 00:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
 <20181121131733.14910-3-ard.biesheuvel@linaro.org> <945415e1-0ff8-65ce-15fa-33cea0a7d1c9@iogearbox.net>
In-Reply-To: <945415e1-0ff8-65ce-15fa-33cea0a7d1c9@iogearbox.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 22 Nov 2018 09:02:39 +0100
Message-ID: <CAKv+Gu-UE0hR-iEkhUieGn+UO_PFs+cD535W1Rq9iyRkgEj=qA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 at 00:20, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 11/21/2018 02:17 PM, Ard Biesheuvel wrote:
> > The arm64 module region is a 128 MB region that is kept close to
> > the core kernel, in order to ensure that relative branches are
> > always in range. So using the same region for programs that do
> > not have this restriction is wasteful, and preferably avoided.
> >
> > Now that the core BPF JIT code permits the alloc/free routines to
> > be overridden, implement them by simple vmalloc_exec()/vfree()
> > calls, which can be served from anywere. This also solves an
> > issue under KASAN, where shadow memory is needlessly allocated for
> > all BPF programs (which don't require KASAN shadow pages since
> > they are not KASAN instrumented)
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/net/bpf_jit_comp.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > index a6fdaea07c63..f91b7c157841 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -940,3 +940,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> >                                          tmp : orig_prog);
> >       return prog;
> >  }
> > +
> > +void *bpf_jit_alloc_exec(unsigned long size)
> > +{
> > +     return vmalloc_exec(size);
> > +}
> > +
> > +void bpf_jit_free_exec(const void *addr)
> > +{
> > +     return vfree(size);
> > +}
>
> Hmm, could you elaborate in the commit log on the potential performance
> regression for JITed progs on arm64 after this change?
>

This does not affect the generated code, so I don't anticipate a
performance hit. Did you have anything in particular in mind?

> I think this change would also break JITing of BPF to BPF calls. You might
> have the same issue as ppc64 folks where the offset might not fit into imm
> anymore and would have to transfer it via fp->aux->func[off]->bpf_func
> instead.

If we are relying on BPF programs to remain within 128 MB of each
other, then we already have a potential problem, given that the
module_alloc() spills over into a 4 GB window if the 128 MB window is
exhausted. Perhaps we should do something like

void *bpf_jit_alloc_exec(unsigned long size) {
  return __vmalloc_node_range(size, MODULE_ALIGN,
    BPF_REGION_START, BPF_REGION_END,
    GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
    __builtin_return_address(0));
}

and make [BPF_REGION_START, BPF_REGION_END) a separate 128 MB window
at the top of the vmalloc space. That way, it is guaranteed that BPF
programs are within branching range of each other, and we still solve
the original problem. I also like that it becomes impossible to infer
anything about the state of the vmalloc space, placement of the kernel
and modules etc from the placement of the BPF programs (in case it
leaks this information in one way or the other)

That would only give you space for 128M/4K == 32768 programs (or
128M/64K == 2048 on 64k pages kernels). So I guess we'd still need a
spillover window as well, in which case we'd need a fix for the
BPF-to-BPF branching issue (but we need that at the moment anyway)
