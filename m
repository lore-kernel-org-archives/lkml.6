Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD8DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1622420823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7qcptHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1622420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeKTCBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:01:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52384 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbeKTCBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:01:48 -0500
Received: by mail-it1-f196.google.com with SMTP id i7so2686060iti.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 07:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HovDyLoW9JgP2dOMddyLtoMQVzEDX+zbCzhvdFpRmKg=;
        b=D7qcptHPzcuFLxZJDKf3/4DYoAkuBIC1/vhhevIzPorrX0vffSlkOwDgxtkWOJQ5at
         HawzLKIlQZPHhzcg/ht+WOn2/Bwzx35gGjNcBaHjt33qZAinytdLYzklmhvd92e87Qpx
         QdcvOzwwWfj2RygLc+IHYXpaaAK0ppUfMF4FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HovDyLoW9JgP2dOMddyLtoMQVzEDX+zbCzhvdFpRmKg=;
        b=jTDx4wbYUqgsbOTTbuLMZZC5BazOly0eHjKEIksXrQg8kvzYiYHQvM0cUMHCmnLQ+y
         YN0xIGO4Cx1Wr/PettxblC+JEsaF2A4iHWKpEZUkTUDzQvgcQTHP3A8F18H+IQ+Hu1sY
         sl4Pgk/vbSx9sU7pU6Xyqx4LIa/ZuPh7P0unAjcU77lHqCxer2q0xuvBFpbL/X1U5qiY
         zHtXunUP83FTbkFyL2M1jBLc2mQgoCMec6p4CmvERCEOr0qnYMKRSlJGMIs/xlGoAlyh
         eKqif7s1XSFkUVndpVOCxs4ZI9XQCS0umCPAg1SykNoG3znpLi4g6/xlbZpSHYkcZNMk
         MSTw==
X-Gm-Message-State: AA+aEWY37xH6IqVGtll8jk79eUrq2EiEZflJ4Wetkz7wXO1YMNe1o+is
        AXef8kZJdE0yPlrFL19e+09N5pujBVxQ2+U000RgCA==
X-Google-Smtp-Source: AFSGD/XYGCOxtGQjZNHVynlMGnMqP3y8k20/U+DJFyEKBYt23Zja/1TkjR662SNXidQ9wGwqBoa2EOaNRg2lDyTv3Xs=
X-Received: by 2002:a24:710:: with SMTP id f16mr1015081itf.121.1542641871167;
 Mon, 19 Nov 2018 07:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
 <20181117185715.25198-2-ard.biesheuvel@linaro.org> <b37c3411-7950-dcb3-f0c3-6d9f589d36ab@iogearbox.net>
In-Reply-To: <b37c3411-7950-dcb3-f0c3-6d9f589d36ab@iogearbox.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 19 Nov 2018 07:37:39 -0800
Message-ID: <CAKv+Gu8mo+WkJ356wByidUDoA-xHrUH99od5N_yJoqtX_28_5g@mail.gmail.com>
Subject: Re: [PATCH 1/4] bpf: account for freed JIT allocations in arch code
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

On Mon, 19 Nov 2018 at 02:37, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 11/17/2018 07:57 PM, Ard Biesheuvel wrote:
> > Commit ede95a63b5e84 ("bpf: add bpf_jit_limit knob to restrict unpriv
> > allocations") added a call to bpf_jit_uncharge_modmem() to the routine
> > bpf_jit_binary_free() which is called from the __weak bpf_jit_free().
> > This function is overridden by arches, some of which do not call
> > bpf_jit_binary_free() to release the memory, and so the released
> > memory is not accounted for, potentially leading to spurious allocation
> > failures.
> >
> > So replace the direct calls to module_memfree() in the arch code with
> > calls to bpf_jit_binary_free().
>
> Sorry but this patch is completely buggy, and above description on the
> accounting incorrect as well. Looks like this patch was not tested at all.
>

My apologies. I went off into the weeds a bit looking at different
versions for 32-bit and 64-bit on different architectures. So indeed,
this patch should be dropped.

> The below cBPF JITs that use module_memfree() which you replace with
> bpf_jit_binary_free() are using module_alloc() internally to get the JIT
> image buffer ...
>

Indeed. So would you prefer for arm64 to override bpf_jit_free() in
its entirety, and not call bpf_jit_binary_free() but simply call
bpf_jit_uncharge_modmem() and vfree() directly? It's either that, or
we'd have to untangle this a bit, to avoid having one __weak function
on top of the other just so other arches can replace the
module_memfree() call in bpf_jit_binary_free() with vfree() (which
amount to the same thing on arm64 anyway)
