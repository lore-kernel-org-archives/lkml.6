Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E061BECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EC320693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yukQfFts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EC320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbeGRCXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:23:24 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:33891 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbeGRCXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:23:24 -0400
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w6I1lp6E003450;
        Wed, 18 Jul 2018 10:47:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w6I1lp6E003450
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531878472;
        bh=HjgKPdaJvSBZTjRCsi1FCgvgS/t0ffLim93um5TbeLA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=yukQfFtsGg5KraUD1xf/M52AJ4lApVVgYGUIBCH2cWADshm7RR3F3Pak2HH4Z3blT
         zGclepurXrDVseWLB4g+vqMiIJg8nArrxZwqSFEnhUvehwr8JlEYmF1odj02XpwAYi
         fpesZgpthDxotF2mq/d2PPdZJWKfShc+T2WVTrxJMGxX9se1qmKDZyUkR3a/sgjBB+
         r9QzSfIyAlJ7CPwPBpaVxyxqLYMY9UENNOjnVtKdCu/Ccs8YluYMYN0Y6eRFy9EZV0
         Zo/CWfiSLL4CagtdCeFhr8W7xs+XsFjAvlAIdAxJ44RyCcOAquCdDYF9UYukMERSuk
         e/8TvFlxls/Mg==
X-Nifty-SrcIP: [209.85.217.173]
Received: by mail-ua0-f173.google.com with SMTP id y10-v6so1941946uao.4;
        Tue, 17 Jul 2018 18:47:52 -0700 (PDT)
X-Gm-Message-State: AOUpUlHUbUqMC1VLuUKsPUNrXKekqgvRO3p7yzPjzcn0BLtY82koYlfv
        Mq5WBlsf4ifK/yKgHrarrRBdrMopXEZnkc6Gun0=
X-Google-Smtp-Source: AAOMgpfwjB/PNWc7VEANUv9/s/lM5jQQPqz9OPVYPLrxm7pPSwO12mWyGHOW8KnnnV/mqXMnvF/gtTxHm4opHCpFvXY=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr2627654uaf.199.1531878471007;
 Tue, 17 Jul 2018 18:47:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 18:47:10
 -0700 (PDT)
In-Reply-To: <20180715215452.GA14040@gmail.com>
References: <20180622172212.199633-1-namit@vmware.com> <BA4C0931-A51D-41AE-B918-C37EFFF35840@vmware.com>
 <20180715215452.GA14040@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 18 Jul 2018 10:47:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQT02gDD8-1FuWd8Cv7pMTP-wg-9DNYDo4+Y3MGOxsnmg@mail.gmail.com>
Message-ID: <CAK7LNAQT02gDD8-1FuWd8Cv7pMTP-wg-9DNYDo4+Y3MGOxsnmg@mail.gmail.com>
Subject: Re: [kbuild ack?] Re: [PATCH v6 0/9] x86: macrofying inline asm for
 better compilation
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-16 6:54 GMT+09:00 Ingo Molnar <mingo@kernel.org>:
>
> * Nadav Amit <namit@vmware.com> wrote:
>
>> > I ran some limited number of benchmarks, and in general the performance
>> > impact is not very notable. You can still see >10 cycles shaved off some
>> > syscalls that manipulate page-tables (e.g., mprotect()), in which
>> > paravirt caused many functions not to be inlined. In addition this
>> > patch-set can prevent issues such as [1], and improves code readability
>> > and maintainability.
>
> Ok, that's good enough as a benefit, I suppose.
>
>> > Nadav Amit (9):
>> >  Makefile: Prepare for using macros for inline asm
>
> This non-trivial kbuild patch needs an Acked-by from Masahiro.


Sorry for delay.

I've issued Acked-by to 1/9 now.

Thanks.



> Thanks,
>
>         Ingo



-- 
Best Regards
Masahiro Yamada
