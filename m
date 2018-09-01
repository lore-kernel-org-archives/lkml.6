Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A70C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E2D2083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d1WZuKKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E2D2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeIAUqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 16:46:19 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39976 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeIAUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 16:46:19 -0400
Received: by mail-it0-f67.google.com with SMTP id h23-v6so10887582ita.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 09:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vz2Vp/Gg/7FvI1VspGNDSiGaWYbzIIsVj4gERLOLV+c=;
        b=d1WZuKKX8rVa1FRCBG6G77gM9xAK2hGPzloDy2R7jURnF7h3L1zvzuk4rZT/22Bt7Q
         Jp6rfBZWJSRzHAGsAZhVXOaFZKir+pF8RVI/Z4a1kS0F822ReZLZx30Aie8sSgl320CV
         /lFaO7oi/6r1/4hVHw2s7d7NLnsy2+6VNmsvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vz2Vp/Gg/7FvI1VspGNDSiGaWYbzIIsVj4gERLOLV+c=;
        b=hWAPYuS1sa7WLp91gL5uOnawDmipiXoqAxyTg5Bse+3DVV6wPPUbnJ58WOR3OjUaTJ
         AEcCTSPO4mYxmytGHeUu+pgrZxjGAXMfm8x0xofPQKJBsg8K8puMp0AbRTCwpFrHaU2B
         6V4BJMJyOEfdnp6WZWgXI5Mdz8txkHwRB9IqW7RM/IM+RsfHn/iUU2a8Zi9i8E7g06o6
         F7LHynTDzMWbaNRI0zjMppqoA+RF/UD5fmBiZwoHHbanensJbH39YMHklWZROsmJ3mHG
         Xj3xQdkVgeVTS7PUvhjJCMsksmkUJrpKV7Ne84aAqpj4uraJthTWcIRMctLVf2w8Nqmc
         nhZw==
X-Gm-Message-State: APzg51BOXY7LEFsZpKGp0/q95qTMqhrfbAuWkA8ekoEGEpMGkUEvq8zF
        YnfiZZRfURLWnlmC1OT9FtbqTO+84RU0bFspzAM=
X-Google-Smtp-Source: ANB0VdazBjTbcFnYLBlX4H80G1pV36yiyCzgML+I841L0bfbkTtx1Xw36yq3NnYGtfLQhjW58fu5vQCt4q0fipyqYVI=
X-Received: by 2002:a24:3046:: with SMTP id q67-v6mr1156193itq.9.1535819626282;
 Sat, 01 Sep 2018 09:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535753890.git.luto@kernel.org> <9d79fddf6bab2fc40c2472bdea47f864603c1bf4.1535753890.git.luto@kernel.org>
In-Reply-To: <9d79fddf6bab2fc40c2472bdea47f864603c1bf4.1535753890.git.luto@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Sep 2018 09:33:35 -0700
Message-ID: <CA+55aFwOMt7Qw4HFyBiSNpHXoP3kGRsrQhi3LA_=uxwuNz8G0Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/entry/64: Use the TSS sp2 slot for rsp_scratch
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 3:21 PM Andy Lutomirski <luto@kernel.org> wrote:
>
>  #ifdef CONFIG_X86_64
>  # define cpu_current_top_of_stack (cpu_tss_rw + TSS_sp1)
> +# define rsp_scratch (cpu_tss_rw + TSS_sp2)
>  #endif

Ugh. The above gets used by *assembler* code. I was really confused by how this:


> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -59,8 +59,6 @@
>  #include <asm/unistd_32_ia32.h>
>  #endif
>
> -__visible DEFINE_PER_CPU(unsigned long, rsp_scratch);
> -

could continue to work despite the accesses to "rsp_scratch" still
remaining in the asm files.

Can yu humor me, and just not do something quite that subtle. I must
have missed this the first time around.

Please get rid of the define, and just make the asm code spell out
what it actually does.

We already do that for TSS_sp0 for the normal case:

      movq    PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp

so I think this should just change

-     movq    %rsp, PER_CPU_VAR(rsp_scratch)
+     movq    %rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)

instead of having that subtle rsp_scratch thing.

And honestly, I think we should strive to do the same thing with
cpu_current_top_of_stack. There at least the #define currently makes
sense (because on 32-bit, it's actually a percpu variable, on 64-bit
it's that sp1 field).

But wouldn't it be nice to just unify 32-bit and 64-bit in this
respect, and get rid of that subtle difference?

But regardless of whether we eventually do that kind of unification
change, the cpu_current_top_of_stack #define has a _reason_ for it as
things stand now.

The new rsp_scratch thing does not. Just spell out what you're doing.

                  Linus
