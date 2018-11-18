Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA9DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 07:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F08E2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 07:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7ls5kEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F08E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeKRSJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 13:09:01 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40727 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeKRSJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 13:09:01 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so44147818qki.7;
        Sat, 17 Nov 2018 23:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmUp9bVLzAjLxvxpuGqKyizUS3hwC0JQZLZ/D3xx8Dw=;
        b=E7ls5kEIfXFrL+O3NSrT0/OjSCJW5QTbXrKomsxzn2oupTGH3ZXPKGoQgkbSU8B5Zl
         gkc+zA/bX4ToSOFH2H5o6CtP4ricuUiCt2wanR+G6FwpSQOBW3YqB07UnpSrjYVgaH9L
         bIJlxpteq/vKIBBFHQdhciAJI7S0R4RQG3wd7Lk+SzhND9BeAx77n7nUVXQx5KdcEo3V
         suJgNmxMeltBkBRyRUxPQ+qYIFc1ZF/O/4h+UoJUTgM+gG3V0dlSfSlKhW8T/GatjXQD
         1Yp0kRC12IXkvaMP11VbHXkIvMeaXLe9Wc+4XDsFVSx4QSWlbZWXdcLNkeIww6Ur8c5r
         R9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmUp9bVLzAjLxvxpuGqKyizUS3hwC0JQZLZ/D3xx8Dw=;
        b=JkFQMLPcPOK10JKkrcygm/4pgmaPk9aI8xSy9LNUrsTJQaNz4dhCz256TkVgqL+c8Q
         H7h0M/BnCJbtKY/GLaiX5wAkxfZU8m/bD9HyWOYk8X6e1uCBll2JhsZsGj16ZUf94mR5
         HNaQokNfO2QW0vX/YPkHMk7gHfGEej8pjSVSMFatCLey7bRue8y26Fu//UUGTpt9IA8c
         wkr/9i8icEJghemmgejDMjOnEP0zeO+U3TNnvc1Hd3o+wNF8mPENSq1UhY8jd9wNskMU
         uPPxv4QlCvy11QXMSp5he221FB3NndjVY4OXfl1NXSEB9Z4tzdIJns7g2GFp2rlw3Tw2
         VQqw==
X-Gm-Message-State: AGRZ1gIafhudGwv188me4r8qeIqF2rA5MgIzq9Wm6Ev+XHRXo5Ah44AG
        mFtfmH88iAENfLXZ6ox9PYO6tg+BLLIVBChJtGE=
X-Google-Smtp-Source: AJdET5d3ZByMLTrTWsR1nu6Ai5Phm/hGfev7RqCiKZlcFDEKSwvvy/6aIFstM0swTZP2DkMUIuQ3wpj/VhhKU76VdPc=
X-Received: by 2002:a37:41d2:: with SMTP id o201mr16064899qka.24.1542527368265;
 Sat, 17 Nov 2018 23:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
From:   Y Song <ys114321@gmail.com>
Date:   Sun, 18 Nov 2018 07:48:59 +0000
Message-ID: <CAH3MdRX5MYv-QQGj25APd4-17syF3Vc_f0AWpEgUoL46qbHrGQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] bpf: permit JIT allocations to be served outside the
 module region
To:     ard.biesheuvel@linaro.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        rick.p.edgecombe@intel.com, eric.dumazet@gmail.com,
        jannh@google.com, Kees Cook <keescook@chromium.org>,
        jeyu@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au,
        David Miller <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 6:58 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On arm64, modules are allocated from a 128 MB window which is close to
> the core kernel, so that relative direct branches are guaranteed to be
> in range (except in some KASLR configurations). Also, module_alloc()
> is in charge of allocating KASAN shadow memory when running with KASAN
> enabled.
>
> This means that the way BPF reuses module_alloc()/module_memfree() is
> undesirable on arm64 (and potentially other architectures as well),
> and so this series refactors BPF's use of those functions to permit
> architectures to change this behavior.
>
> Patch #1 fixes a bug introduced during the merge window, where the new
> alloc/free tracking does not account for memory that is freed by some
> arch code.
>
> Patch #2 refactors the freeing path so that architectures can switch to
> something other than module_memfree().
>
> Patch #3 does the same for module_alloc().
>
> Patch #4 implements the new alloc/free overrides for arm64

Except a minor comment, the whole patch set looks good to me.
Acked-by: Yonghong Song <yhs@fb.com>

>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: sparclinux@vger.kernel.org
> Cc: netdev@vger.kernel.org
>
> Ard Biesheuvel (4):
>   bpf: account for freed JIT allocations in arch code
>   net/bpf: refactor freeing of executable allocations
>   bpf: add __weak hook for allocating executable memory
>   arm64/bpf: don't allocate BPF JIT programs in module memory
>
>  arch/arm64/net/bpf_jit_comp.c     | 11 ++++++++++
>  arch/mips/net/bpf_jit.c           |  7 ++-----
>  arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
>  arch/powerpc/net/bpf_jit_comp64.c | 12 +++--------
>  arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
>  kernel/bpf/core.c                 | 22 ++++++++++----------
>  6 files changed, 31 insertions(+), 35 deletions(-)
>
> --
> 2.17.1
>
