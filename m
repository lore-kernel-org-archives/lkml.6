Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799D4C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDE22075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="eNpv9upD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDE22075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbeJWXHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:07:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41034 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWXHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:07:14 -0400
Received: by mail-qk1-f193.google.com with SMTP id g13-v6so957633qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 07:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=754/5ITZBbZDoTPrVkDyPmFe8QdpzTTFJC5+mfnnMVk=;
        b=eNpv9upDCPWwr/SKhtZ55Alah6gVZ7N6JRwxmdP7/RhzV8+/fQP5TE4yr+v2XL08xX
         xwnLJqzAtanbDbpfes+mxNPdb3JjscIPZap6r0IwF8s0OTCF/keP/fvjNvMge5oVlm65
         TJzQVDNu/ycG4oFJ9pyfz3HsE89onZ5RWfsis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=754/5ITZBbZDoTPrVkDyPmFe8QdpzTTFJC5+mfnnMVk=;
        b=kJ4QEuPT3stCwOneibDebRQqFVB4ZbWdc+ykFiSyfYYaDvxdQ7FskumAdejWTr64yw
         5VwRPCCDCm3tTvWjM/9KAB2bbDOTTC5uqTXf2F4KJHwbqAFFjI8Xk/d4zoU4Qrbd3cm2
         4v4jJIui5lS9aAukHnvnDPsZXOPA5/+IYQE8hq27eUqbRWtDkg8hu9t/LlsL2vlMHn7x
         ufGHq2VWtXQ4SsbB3BlpWPkTBb4cfUUELg9wGcrgGNx3/cXaQWhQQi43TIHwN/GIt9IX
         ys7T1ObvLioncHrm8SZQ7mwvrpdXF4sCS4/lPH63Je4ulz2FLI5u3REf04nhzw2LRIhl
         4Sgw==
X-Gm-Message-State: ABuFfog9uBieUCPQSKPhahcNoniubiXoSmK1MBYclIaNKBu8NbfTsG/5
        oPk1V8o+7LQPlrK25sil0G8PnND79zFkcicPrT26gA==
X-Google-Smtp-Source: ACcGV60mj9wurBJz3bhIb7CXEE5cVoMC8I4YpO1rO32fmjizO3YKseTNm+HxvJZwnpF+By6X/1KXIU5Lar3v4kFL3w4=
X-Received: by 2002:a37:5288:: with SMTP id g130-v6mr48964538qkb.124.1540305810040;
 Tue, 23 Oct 2018 07:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
 <20180929181725.GB27441@fifo99.com> <CAMT6-xiQ0vGcKpA+SiWHQWQFwU9Oo9j=Zin+UXDoPqKTz5fbeA@mail.gmail.com>
In-Reply-To: <CAMT6-xiQ0vGcKpA+SiWHQWQFwU9Oo9j=Zin+UXDoPqKTz5fbeA@mail.gmail.com>
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
Date:   Tue, 23 Oct 2018 17:43:18 +0300
Message-ID: <CAMT6-xj1rjVAy1AWFiMHc5wH36eu=TUSMtdKU=-qRtUbwr9bkg@mail.gmail.com>
Subject: Re: [PATCH 0/8] add generic builtin command line
To:     Daniel Walker <dwalker@fifo99.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 9:01 PM Maksym Kokhan
<maksym.kokhan@globallogic.com> wrote:
>
> Hi, Daniel
>
> On Sat, Sep 29, 2018 at 9:17 PM <dwalker@fifo99.com> wrote:
> >
> > On Thu, Sep 27, 2018 at 07:55:08PM +0300, Maksym Kokhan wrote:
> > > Daniel Walker (7):
> > >   add generic builtin command line
> > >   drivers: of: ifdef out cmdline section
> > >   x86: convert to generic builtin command line
> > >   arm: convert to generic builtin command line
> > >   arm64: convert to generic builtin command line
> > >   mips: convert to generic builtin command line
> > >   powerpc: convert to generic builtin command line
> > >
> >
> > When I originally submitted these I had a very good conversion with Rob Herring
> > on the device tree changes. It seemed fairly clear that my approach in these
> > changes could be done better. It effected specifically arm64, but a lot of other
> > platforms use the device tree integrally. With arm64 you can reduce the changes
> > down to only Kconfig changes, and that would likely be the case for many of the
> > other architecture. I made patches to do this a while back, but have not had
> > time to test them and push them out.
>
> Can you please share this patches? I could test them and use to improve this
> generic command line implementation.
>
> > In terms of mips I think there's a fair amount of work needed to pull out their
> > architecture specific mangling into something generic. Part of my motivation for
> > these was to take the architecture specific feature and open that up for all the
> > architecture. So it makes sense that the mips changes should become part of
> > that.
>
> This is really makes sense, and we have intentions to implement it
> afterward. It would be easier to initially merge this simple
> implementation and then develop it step by step.
>
> > The only changes which have no comments are the generic changes, x86, and
> > powerpc. Those patches have been used at Cisco for years with no issues.
> > I added those changes into my -next tree for a round of testing. Assuming there
> > are no issues I can work out the merging with the architecture maintainers.
> > As for the other changes I think they can be done in time, as long as the
> > generic parts of upstream the rest can be worked on by any of the architecture
> > developers.
>
> Thanks,
> Maksym

We still have no response to patches for x86, arm, arm64 and powerpc.
Is current generic command line implementation appropriate for these
architectures?
Is it possible to merge these patches in the current form (for x86,
arm, arm64 and powerpc)?

Thanks,
Maksym
