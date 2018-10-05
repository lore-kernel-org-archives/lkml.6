Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00FCC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858CC206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpgsJjsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858CC206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeJEVCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:02:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37969 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJEVCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:02:47 -0400
Received: by mail-io1-f68.google.com with SMTP id n5-v6so381395ioh.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HVMWWg/mFD5PXPFOehRjIN8RzKVxwNX8V7J9t8QauFE=;
        b=XpgsJjsg0FQXAuT8PNue7Tqx3IR/J7a+g2BQ5zLsVJlb0YPhU/wYgioDt6tNxMhgcU
         druYByvNgzYVkAL45oandJmyT3StCL1JRuYruX4NW+bzqzuDwp/wjAqZgjEOo/fAYm6x
         2rJXfvq8L0mjZuY5qa38LF7rvY5cOMZmy6K+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HVMWWg/mFD5PXPFOehRjIN8RzKVxwNX8V7J9t8QauFE=;
        b=KycIcn0y5tERRBO7X3kuGDrvK3pSgLox98JqEG/mp6k1suJs4ThbgxZBzP+f8ytscI
         Eu7opPaClUTUE5XoUpz6lJkXn1AFHHimRVpy9ahuFnOon7Iyz+mVI2zaR95ByeX+L3gN
         MTzMPTGdMcKgXPzv0EwzQOM/lPWMoC4QsdQrcpK0QkZgOA7l0ymVqGfrWhhUYLs8YJh3
         ePbXHlF0SvaYqAMfQqWsLg2fJqTVS95SqrFor24nSFetyeycwoGC3r2TDU6T6XR2L86j
         AISElGeXtF1813CjBpuekGBdUnr5ZKKx4PwUD5XK31Pb80GzpWy+9vFGVsQJN5aUfRS2
         vYRw==
X-Gm-Message-State: ABuFfohC0x7MXVaWtCchghV95bFzPNtA/+SMx9eiQ9yh64zloezBd/zp
        1bsHCk017RyNtyk9EWuorF7vzT48hTuJSCGLrOQWcLKN
X-Google-Smtp-Source: ACcGV63juOXPe0juD5jLlbDdJbMKdA9iBER8Rm2251M2tj+Tkwv5IKEybrjAbu7JDMaRntevXql60hB48ivGgkWsKi4=
X-Received: by 2002:a6b:3787:: with SMTP id e129-v6mr8267883ioa.60.1538748234165;
 Fri, 05 Oct 2018 07:03:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 07:03:53 -0700 (PDT)
In-Reply-To: <20181005135728.GR19272@hirez.programming.kicks-ass.net>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org> <20181005135728.GR19272@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 5 Oct 2018 16:03:53 +0200
Message-ID: <CAKv+Gu_GpeqvTHC0E341ehvbYVyEiXMxirijhFTJrwo0OMrdAg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function pointers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 October 2018 at 15:57, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
>> Add a function pointer abstraction that can be implemented by the arch
>> in a manner that avoids the downsides of function pointers, i.e., the
>> fact that they are typically located in a writable data section, and
>> their vulnerability to Spectre like defects.
>>
>> The FFP (or fast function pointer) is callable as a function, since
>> the generic incarnation is simply that. However, due to the fact that
>> C does not distinguish between functions and function pointers at the
>> call site, the architecture can instead emit it as a patchable sequence
>> of instructions consisting of ordinary branches.
>
> This is basically a static_key, except for indirection function calls?

Yes, that is why I put you on cc :-)

> So why not call the thing static_func or static_call or something like
> that?

Yep that sounds better.
