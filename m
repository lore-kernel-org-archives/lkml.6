Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335ACC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 15:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6D32080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 15:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4YH+vLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6D32080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeKSCQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:16:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37981 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeKSCQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 21:16:05 -0500
Received: by mail-io1-f66.google.com with SMTP id e9-v6so5210956iob.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 07:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVpHVlN8yMb+8QBmHy6R38Io2Rvx7iOnFnXQ1i2RcB0=;
        b=U4YH+vLZlLB+8Lk1fLwwL9SqcRVKdWwEYNRWI29Tc2kuUJ6m4LvNFoAYY88XZbezRI
         jL+Uj+gZ15vaSPqfe1C5w38l7H/tUnQhdPqsTe5oC8bnov+61JhICme1/RWg1ppqNiZI
         ziqrJ5EiU8nbt66gD7FcGQ/P+iO/KFV8ZVSec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVpHVlN8yMb+8QBmHy6R38Io2Rvx7iOnFnXQ1i2RcB0=;
        b=PaPzZACPeyI93w8XssX0LaWVXo1Fahaa1T9B3FnAjFK7Vc1VPcAuUQ/DR7BmMXO2SE
         3lk6uc8CKlzAR8aY08XSjDPCA/pZU+AZUBIr1NtGNG+AWBgyeywcVZYx+iNqPYF4n/G7
         fDcGncsghg8NMJJ0RKX40tgUvlyYh6gvThxV0WcIKLX0k0r97v2FcOVvIopDiy+XMMFh
         0t7Wjp7r8gR0WQt/Tc7bV7OPR+NTdnTwN2R52LfLtm/JCi1bN6sZnXb23cqv7/4XHMG8
         y83UumDOC9CKnPBfswlvJKzOSDkF+NrBNP8+np9EgV2hHcOAqykx958dW4HO0kE7G3m4
         NpLg==
X-Gm-Message-State: AGRZ1gJDMzcGAsgM3CJfTItSB1VYNmNTesz65nALGGHI+v9SMLKwpNTL
        7YpRYLxTmvpQdbc6vmltt29+6IP4GBJWOXdbLLbMMg==
X-Google-Smtp-Source: AFSGD/VNKyUsHCOcVEU25YMknGotPrNhpWyqf/fQRCqaqAvE2Nbcuc3zJbxkUkBaiT2Ul2zjAYDD4rvDQg2QpnI523o=
X-Received: by 2002:a6b:37c2:: with SMTP id e185-v6mr15113497ioa.173.1542556525869;
 Sun, 18 Nov 2018 07:55:25 -0800 (PST)
MIME-Version: 1.0
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
 <20181117185715.25198-3-ard.biesheuvel@linaro.org> <CAH3MdRV85imzia+=irgbjL48wqFdorB-F1=BkwBgJgi3Z-XAKA@mail.gmail.com>
In-Reply-To: <CAH3MdRV85imzia+=irgbjL48wqFdorB-F1=BkwBgJgi3Z-XAKA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 18 Nov 2018 07:55:14 -0800
Message-ID: <CAKv+Gu9hB3a5LfFQskNzXZDmgps_+9dewbC1E5GFndcQZ-KgQg@mail.gmail.com>
Subject: Re: [PATCH 2/4] net/bpf: refactor freeing of executable allocations
To:     ys114321@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux@vger.kernel.org,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2018 at 23:47, Y Song <ys114321@gmail.com> wrote:
>
> On Sat, Nov 17, 2018 at 6:58 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > All arch overrides of the __weak bpf_jit_free() amount to the same
> > thing: the allocated memory was never mapped read-only, and so
> > it does not have to be remapped to read-write before being freed.
> >
> > So in preparation of permitting arches to serve allocations for BPF
> > JIT programs from other regions than the module region, refactor
> > the existing bpf_jit_free() implementations to use the shared code
> > where possible, and only specialize the remap and free operations.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/mips/net/bpf_jit.c           |  7 ++-----
> >  arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
> >  arch/powerpc/net/bpf_jit_comp64.c |  9 +++------
> >  arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
> >  kernel/bpf/core.c                 | 15 +++++----------
> >  5 files changed, 14 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> > index 1b69897274a1..5696bd7dccc7 100644
> > --- a/arch/mips/net/bpf_jit.c
> > +++ b/arch/mips/net/bpf_jit.c
> > @@ -1261,10 +1261,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
> >         kfree(ctx.offsets);
> >  }
> >
> > -void bpf_jit_free(struct bpf_prog *fp)
> > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       if (fp->jited)
> > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > -
> > -       bpf_prog_unlock_free(fp);
> > +       module_memfree(hdr);
> >  }
> > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > index a1ea1ea6b40d..5b5ce4a1b44b 100644
> > --- a/arch/powerpc/net/bpf_jit_comp.c
> > +++ b/arch/powerpc/net/bpf_jit_comp.c
> > @@ -680,10 +680,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
> >         return;
> >  }
> >
> > -void bpf_jit_free(struct bpf_prog *fp)
> > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       if (fp->jited)
> > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > -
> > -       bpf_prog_unlock_free(fp);
> > +       module_memfree(hdr);
> >  }
> > diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> > index 84c8f013a6c6..f64f1294bd62 100644
> > --- a/arch/powerpc/net/bpf_jit_comp64.c
> > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > @@ -1021,11 +1021,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> >         return fp;
> >  }
> >
> > -/* Overriding bpf_jit_free() as we don't set images read-only. */
> > -void bpf_jit_free(struct bpf_prog *fp)
> > +/* Overriding bpf_jit_binary_free() as we don't set images read-only. */
> > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       if (fp->jited)
> > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > -
> > -       bpf_prog_unlock_free(fp);
> > +       module_memfree(hdr);
> >  }
> > diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
> > index 01bda6bc9e7f..589950d152cc 100644
> > --- a/arch/sparc/net/bpf_jit_comp_32.c
> > +++ b/arch/sparc/net/bpf_jit_comp_32.c
> > @@ -756,10 +756,7 @@ cond_branch:                       f_offset = addrs[i + filter[i].jf];
> >         return;
> >  }
> >
> > -void bpf_jit_free(struct bpf_prog *fp)
> > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       if (fp->jited)
> > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > -
> > -       bpf_prog_unlock_free(fp);
> > +       module_memfree(hdr);
> >  }
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 1a796e0799ec..29f766dac203 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -646,25 +646,20 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
> >         return hdr;
> >  }
> >
> > -void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > +void __weak bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       u32 pages = hdr->pages;
> > -
> > +       bpf_jit_binary_unlock_ro(hdr);
> >         module_memfree(hdr);
> > -       bpf_jit_uncharge_modmem(pages);
> >  }
> >
> > -/* This symbol is only overridden by archs that have different
> > - * requirements than the usual eBPF JITs, f.e. when they only
> > - * implement cBPF JIT, do not set images read-only, etc.
> > - */
>
> Do you want to move the above comments to
> new weak function bpf_jit_binary_free?
>

Perhaps. But one thing I don't understand, looking at this again, is
why we have these overrides in the first place. module_memfree() just
calls vfree(), which takes down the mapping entirely (along with any
updated permissions), and so remapping it back to r/w right before
that seems rather pointless imo.

Can we get rid of bpf_jit_binary_unlock_ro() entirely, and along with
it, all these overrides for the free() path?
