Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DE7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409332086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jXAsEaqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbfBARLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:11:52 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54356 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBARLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:11:52 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so10195835ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+J7yRLBQE0TBdd/yck4E6h6UbQ5K4WQbe6ljSPQuKE=;
        b=jXAsEaqfu1fUd8kiFG6dW9IQ4g+pQuij44JvJ+YvhrXCcsjttyRAwI/MnfGCB3xxh+
         TB+h+6Dr5+frc5rEA29bGzU1a98AXaNb1vZSus1V2HTm45emDXqsHwP+qvmMY+HTGTZ2
         mTfl+YWEySAcIdfuoWX/MWDE0k5yjMJHnUy10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+J7yRLBQE0TBdd/yck4E6h6UbQ5K4WQbe6ljSPQuKE=;
        b=Sv8FghNaKv83b1MP5Ayf2eYScXDameB7dDIRi1YxwkSqMzyi+tNRsfhe9+/sMKIWqG
         1Udz3hxAEYfP3sjqfrop7+Yw5deLq+82n92/+DCYkMJU6CeI/XjdP/xv++44emRlVxi6
         yoErRf/ww/YP/uNNRVGZKMZhvDKz5aIfjJ/1GIBBCW6pACD7x96+6Sd2TfyFVVHo/yTU
         4E43OZWOG4RHWmUij/nyQ0kevyuVuAbq6m+3DT3fWV+DDcvywn4ECBXj7pcDUnmXOtMg
         quVJJftNIvg2HvXawCyR1PMa14dGVpCFX1hVljXknohAvxzmVrpZIBM+89jb2nsCyqcs
         aSbA==
X-Gm-Message-State: AHQUAuZ1TMqFWvq7uo6n18iqpikfaOip5nMed7Utx0uOecHT6H4ZWtVA
        x5OYyJWb0nHRfCpK6PgBpOdziKwhNes=
X-Google-Smtp-Source: AHgI3IaNI6HBFAA8yUI9erPGONNjrdkgd2JhEnJ41sGcepPFnVMbZ7KhVIL2Rswqk+5+RwBEEiT4Mw==
X-Received: by 2002:a24:fc86:: with SMTP id b128mr2134958ith.93.1549041110840;
        Fri, 01 Feb 2019 09:11:50 -0800 (PST)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id c75sm1494537itd.1.2019.02.01.09.11.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:11:50 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id k2so6255708iog.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:11:49 -0800 (PST)
X-Received: by 2002:a6b:b589:: with SMTP id e131mr8287426iof.41.1549041109341;
 Fri, 01 Feb 2019 09:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-14-thgarnie@chromium.org>
 <20190201111532.3oszgzj4grdyej5q@kshutemo-mobl1>
In-Reply-To: <20190201111532.3oszgzj4grdyej5q@kshutemo-mobl1>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Fri, 1 Feb 2019 09:11:37 -0800
X-Gmail-Original-Message-ID: <CAJcbSZGa2=YLaFxqoZ79h1Gh794DPWpuCArSMirYVbHLYzBu5w@mail.gmail.com>
Message-ID: <CAJcbSZGa2=YLaFxqoZ79h1Gh794DPWpuCArSMirYVbHLYzBu5w@mail.gmail.com>
Subject: Re: [PATCH v6 13/27] x86/boot/64: Build head64.c as mcmodel large
 when PIE is enabled
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kristen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 3:15 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Thu, Jan 31, 2019 at 11:24:20AM -0800, Thomas Garnier wrote:
> > The __startup_64 function assumes all symbols have relocated addresses
> > instead of the current boot virtual address. PIE generated code favor
> > relative addresses making all virtual and physical address math incorrect.
> > If PIE is enabled, build head64.c as mcmodel large instead to ensure absolute
> > references on all memory access. Add a global __force_order variable required
> > when using a large model with read_cr* functions.
> >
> > To build head64.c as mcmodel=large, disable the retpoline gcc flags.
> > This code is used at early boot and removed later, it doesn't need
> > retpoline mitigation.
> >
> > Position Independent Executable (PIE) support will allow to extend the
> > KASLR randomization range below 0xffffffff80000000.
> >
> > Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
> > ---
> >  arch/x86/kernel/Makefile | 6 ++++++
> >  arch/x86/kernel/head64.c | 3 +++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> > index 00b7e27bc2b7..1f98f52eab9f 100644
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -22,6 +22,12 @@ CFLAGS_REMOVE_early_printk.o = -pg
> >  CFLAGS_REMOVE_head64.o = -pg
> >  endif
> >
> > +ifdef CONFIG_X86_PIE
> > +# Remove PIE and retpoline flags that are incompatible with mcmodel=large
> > +CFLAGS_REMOVE_head64.o += -fPIE -mindirect-branch=thunk-extern -mindirect-branch-register
> > +CFLAGS_head64.o = -mcmodel=large
> > +endif
> > +
> >  KASAN_SANITIZE_head$(BITS).o                         := n
> >  KASAN_SANITIZE_dumpstack.o                           := n
> >  KASAN_SANITIZE_dumpstack_$(BITS).o                   := n
> > diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> > index 16b1cbd3a61e..22e81275495b 100644
> > --- a/arch/x86/kernel/head64.c
> > +++ b/arch/x86/kernel/head64.c
> > @@ -63,6 +63,9 @@ EXPORT_SYMBOL(vmemmap_base);
> >
> >  #define __head       __section(.head.text)
> >
> > +/* Required for read_cr3 when building as PIE */
> > +unsigned long __force_order;
> > +
>
> I believe it only needed for GCC < 5. Newer GCC can eliminate the
> reference. See my comment in arch/x86/boot/compressed/pgtable_64.c.
>
> Maybe we should expand the comment here too?

Make sense, I will add a similar comment in the next iteration. Thanks
for pointing that out.

>
> --
>  Kirill A. Shutemov
