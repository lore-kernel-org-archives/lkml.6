Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB206ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C6E208EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVUG/kaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C6E208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbeGPRzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:55:39 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37761 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeGPRzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:55:39 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so15547515plc.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xhK/LZ/HbkVQQTBUpJLzDYdZXWDCZ3JdqZCBn49SWQ=;
        b=fVUG/kaC756tPMz1v+OeyAgm/7lE170Oy1m3BFpuoDyejD2Yt3dnweqJvoGY00B5TE
         wdeRqXxH2J4v8K+SgQjomI0J8slHXwglahFz0BhqMaVmOAosMBBQWcq/e1w2vMkcJq6A
         Ua2IVg0Ermo8ASRmpaCpN+axD3FBvLEtC+LI1Hr5//p3eioSMhXwHQ/fMoGMBzqzqt6T
         8CoS+9zAT64VtSKuoEOkgh9FNiJvXMRQZptQZm+TtxU7+N4e2rwD9XQosdVHazaFEZhx
         vgKIGonhUkfdQuhzwVvzKkj7EuZkaE71vJ1895nEl+XzdQ4e9w4S9rHFuRw+LmSAQrv4
         nFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xhK/LZ/HbkVQQTBUpJLzDYdZXWDCZ3JdqZCBn49SWQ=;
        b=sECjZQb3dxQwDwRXzrXli0JSoZk6R18EDad9PkMK85vZfAR9C+buJAdWyz99tMNvpY
         0vKfBEUUOMczzPdHMK1BKGDWz2CQUeuJlN26me/BsgJfG7STF0M2/v6oS8QAfrJ6qNvn
         QbvXnsapvobY8XNibllL/U3igrAeyXEwyd+D7RrMkzfaplMluOy598uVqcM+8mSNkaMF
         Y64dt42/0r7YGCzAA2RxMMpVeyFoJ4YthgD8IpxJisoAGejLUMC9be++jBvFSw1fXQ0H
         dWK+B94pkJzs0Ln6fTOU11I70yhuPHqZ483uR8tet0fauJHvgX0JD7YGxEW/CkDb4f38
         zV+g==
X-Gm-Message-State: AOUpUlGNmKXYzqxLVjcVLDAsZm5WWFI2hiXkU1L+pP1o1uNMwNg9QpS4
        fW5HBifA+VUPpCCxPrzshLBLWYNmCCkLEn6/9OWrEw==
X-Google-Smtp-Source: AAOMgpesbdae2xq2+P/i0NdmRBkJg8AHiNYqHiN9C4UHUzOTmt/+vmfpbI2ecDBmAzi7pTFLk2R4jem7famBlxQ7rHk=
X-Received: by 2002:a17:902:64c2:: with SMTP id y2-v6mr17449690pli.53.1531762035755;
 Mon, 16 Jul 2018 10:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180621162324.36656-1-ndesaulniers@google.com>
 <20180621162324.36656-4-ndesaulniers@google.com> <1e19dbef068b45a4a4e9eb4072e097be@AcuMS.aculab.com>
In-Reply-To: <1e19dbef068b45a4a4e9eb4072e097be@AcuMS.aculab.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Jul 2018 10:27:04 -0700
Message-ID: <CAKwvOdmFVnSos71vAUnayuocBDhxLg76tvGF0y3sj+4+s7TCcw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] x86: paravirt: make native_save_fl extern inline
To:     David.Laight@aculab.com
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>, mawilcox@microsoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        David Rientjes <rientjes@google.com>, acme@redhat.com,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        boris.ostrovsky@oracle.com, "J. Kiszka" <jan.kiszka@siemens.com>,
        rostedt@goodmis.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>, thomas.lendacky@amd.com,
        Thiebaud Weksteen <tweek@google.com>, mjg59@google.com,
        joe@perches.com, andrea.parri@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 3:15 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Nick Desaulniers
> > Sent: 21 June 2018 17:23
> >
> > native_save_fl() is marked static inline, but by using it as
> > a function pointer in arch/x86/kernel/paravirt.c, it MUST be outlined.
> >
> > paravirt's use of native_save_fl() also requires that no GPRs other than
> > %rax are clobbered.
> ...
> > diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> > index 89f08955fff7..c4fc17220df9 100644
> > --- a/arch/x86/include/asm/irqflags.h
> > +++ b/arch/x86/include/asm/irqflags.h
> > @@ -13,7 +13,7 @@
> > * Interrupt control:
> > */
> >
> > -static inline unsigned long native_save_fl(void)
> > +extern inline unsigned long native_save_fl(void)
>
> This is generating a the compilation warning (that we treat as an error):
> "no previous prototype for 'native_save_fl".
> Fixable by replicating the line with an appended ;

Thanks for the report and sorry for breaking things for you.  Just
curious about more information to try to reproduce the issue to make
sure I fix the issue correctly:
* What compiler and compiler version are you using?
* Are you setting any configs or enabling any warning CFLAGS to see this?
* Do you see this warning for other `extern inline` functions? (It
seems like the few other ones in the kernel are for non-x86 archs)

I would have guessed that extern inline functions with gnu_inline
semantics (gnu89 behavior) should not have a previous declaration, but
it probably doesn't hurt to add it.
-- 
Thanks,
~Nick Desaulniers
