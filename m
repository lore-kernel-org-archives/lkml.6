Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9174C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF3B208FA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ3B4Qr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF3B208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeFZHNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:13:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54084 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeFZHNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:13:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id x6-v6so567954wmc.3;
        Tue, 26 Jun 2018 00:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r0onC42aN+dYabb++xCvoAUWD1+8p9AoAIGvqkVYeWU=;
        b=DZ3B4Qr1k/0h2x4JmMW7cnnqCnoxzFEYK9Rcl4Gxryj1PXfgXJK3bTM+4ui6vbGuGr
         WohckqcPl/rLSwScoZmLX+hkJnw1o8oL1SArkwxc/wGSwcLDINqFXZyEUSrXD+e6ob+6
         2WzJ8nJId9reofe3++Fwp6pkI5TxorDEf5LMzauHxLqTMtqKvjUU3MMLDD9dfJPsEl9c
         eXD+Iam8zUFOLAbgdku0m+uGftL4Rx8xBLAoO2SXbckJ6OMGidE2cNZdTMjO2pcVXraJ
         Pezd0oGbedSlH+mvZPdN/JRB+Pkx0OQZfH1MKxJT+C9F3laR4nTSuLx8191B+41hKBMk
         eumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r0onC42aN+dYabb++xCvoAUWD1+8p9AoAIGvqkVYeWU=;
        b=KHb9/EfDUDB7fiukKCkBAxMIYCIjrn/YvU+Xg6rTvaTjKDzL1qACrPiTbij13xINZ4
         ndFhUqvZIwv1OH/XOx54qpTG5Gd7X6ccBe2ljOPUF3AHRdEi5tBKkv2QhvCyCtInw3+m
         NvydIxSzALPB8AH3iGV7l12BFGaGUFIUPPntHKMoMc7kG9T5g0TdpQrNvzzbI9xI7vGO
         G7oAreWoMzgN0svOjtgZStkSmuDpo511o8LlES0KC0a5pGVnjb2WkTlzNwKTwTz6es7d
         GjBZHYBmXfibi+msS50R+Je59JnT+AyugklgwZzeqxiPrJz5BXu+ow5IUIQ3+KNS5HKB
         ZQqw==
X-Gm-Message-State: APt69E20aXmgDsHy5I+QIa7NLQJQVary4W2pMxfOxM2vBUbaGItsasEc
        AwTU6wJPPJwxnUTQ9KcQUWM=
X-Google-Smtp-Source: AAOMgpeVuU+rDfPuxFRyu0oEvlKshS0uOSmi3F3OXASPiSMF/ndiGt9lUQVbT9JSrq7dltTceKbbcA==
X-Received: by 2002:a1c:28c6:: with SMTP id o189-v6mr595059wmo.102.1529997209864;
        Tue, 26 Jun 2018 00:13:29 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x6-v6sm842832wmc.42.2018.06.26.00.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 00:13:29 -0700 (PDT)
Date:   Tue, 26 Jun 2018 09:13:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hpa@zytor.com,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, Arnd Bergmann <arnd@arndb.de>,
        David Rientjes <rientjes@google.com>, acme@redhat.com,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        boris.ostrovsky@oracle.com, "J. Kiszka" <jan.kiszka@siemens.com>,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>, thomas.lendacky@amd.com,
        Thiebaud Weksteen <tweek@google.com>, mjg59@google.com,
        joe@perches.com, andrea.parri@amarulasolutions.com
Subject: Re: [PATCH v6 3/3] x86: paravirt: make native_save_fl extern inline
Message-ID: <20180626071325.GA25751@gmail.com>
References: <20180621162324.36656-1-ndesaulniers@google.com>
 <20180621162324.36656-4-ndesaulniers@google.com>
 <20180622022402.GA24194@gmail.com>
 <CAKwvOdn5gnB5cK=cy6weKyxAn4SNEdZTT_MtT_D_nHRG5EDZ4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn5gnB5cK=cy6weKyxAn4SNEdZTT_MtT_D_nHRG5EDZ4g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Thu, Jun 21, 2018 at 7:24 PM Ingo Molnar <mingo@kernel.org> wrote:
> > * Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > > native_save_fl() is marked static inline, but by using it as
> > > a function pointer in arch/x86/kernel/paravirt.c, it MUST be outlined.
> >
> > > --- a/arch/x86/include/asm/irqflags.h
> > > +++ b/arch/x86/include/asm/irqflags.h
> > > @@ -13,7 +13,7 @@
> > >   * Interrupt control:
> > >   */
> > >
> > > -static inline unsigned long native_save_fl(void)
> > > +extern inline unsigned long native_save_fl(void)
> > >  {
> > >       unsigned long flags;
> > >
> >
> > What's the code generation effect of this on say a defconfig kernel vmlinux with
> > paravirt enabled?
> 
> Starting with this patch set applied:
> $ make CC=gcc-8 -j46
> $ objdump -d vmlinux | grep native_save_fl --context=3
> ffffffff81059140 <native_save_fl>:
> ffffffff81059140: 9c                    pushfq
> ffffffff81059141: 58                    pop    %rax
> ffffffff81059142: c3                    retq
> $ git checkout HEAD~3
> $ make CC=gcc-8 -j46
> $ objdump -d vmlinux | grep native_save_fl --context=3
> ffffffff81079410 <native_save_fl>:
> ffffffff81079410: 9c                    pushfq
> ffffffff81079411: 58                    pop    %rax
> ffffffff81079412: c3                    retq
> 
> Mainly, this is to prevent the compiler from adding a stack protector
> to the outlined version, as the stack protector clobbers %rcx, but
> paravirt expects %rcx to be preserved. More info can be found:
> https://lkml.org/lkml/2018/5/24/1242--

Ok!

Acked-by: Ingo Molnar <mingo@kernel.org>

What's the planned upstreaming route for these patches/fixes?

Thanks,

	Ingo
