Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D63C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D062086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D062086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeLJNGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:06:42 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39194 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLJNGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:06:42 -0500
Received: by mail-vs1-f65.google.com with SMTP id h78so6559685vsi.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5vQahMV4WYKGn0Mr5IGV4Ah2NCJ7y1jxVoY6HAJnk8=;
        b=q3xgaembBg4wn3i0HrwEaTX2Sfl1vzlCgPcIrgqlqzwGXukXR+I1Oc8cjzy0N5PttW
         QFPyusZi97TK7GooDFR4Z3X9spTYnzCYxz2YPsvULuJc/PdR7g9pEWwJNkmprXa6UqCn
         zKlO3uHclW/irTRFlCAfmtUfmH2etyOYJLz9181ajAPzNcvoj6Ui+WKTM3n2gl/UOk15
         u2xjrs8lYTq9w8n1akoMeferyPawFIBePR1K3NrI0urxn7KzkO4kyVradSszR+GfY8fS
         z/E7K45TJJz9yjfPZ0s5cn5yuGH6LrCu7mLUENxdaWZJt1kCmLAgc9REF66VOkodarkG
         8XlA==
X-Gm-Message-State: AA+aEWbmx1Ek0VBUNuhQCYY4PacrVeoCoQRYeU48HwskDLTrB1jff69N
        Gco+Waab3Upd7ccQR3PT7SaYNW/TPN77sK4WoSA=
X-Google-Smtp-Source: AFSGD/XcesQXkOSl3QYxTS2IL+wHJpjPFV+BEA1GopxF7MfYjoFjQNUXdTECQNAvr9am7Vz46Ux7hqrTjBundJPNLWo=
X-Received: by 2002:a67:f43:: with SMTP id 64mr5320587vsp.166.1544447200462;
 Mon, 10 Dec 2018 05:06:40 -0800 (PST)
MIME-Version: 1.0
References: <20181210042352.GA6092@altlinux.org> <20181210043010.GM6131@altlinux.org>
 <CAMuHMdVYq_2P=gb_zbSGFkPWASTds6uSPTyyhyNAgp2Qm5+feQ@mail.gmail.com> <20181210124059.GA11942@altlinux.org>
In-Reply-To: <20181210124059.GA11942@altlinux.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Dec 2018 14:06:28 +0100
Message-ID: <CAMuHMdW8ejp4gm2Xh-8inSQngQ5zRQ9bfsg1SG+BAD8RFV8xcA@mail.gmail.com>
Subject: Re: [PATCH v5 13/25] m68k: add asm/syscall.h
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, Eugene Syromiatnikov <esyr@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Dec 10, 2018 at 1:41 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Mon, Dec 10, 2018 at 09:45:42AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > syscall_get_* functions are required to be implemented on all
> > > architectures in order to extend the generic ptrace API with
> > > PTRACE_GET_SYSCALL_INFO request.
> > >
> > > This introduces asm/syscall.h on m68k implementing all 5 syscall_get_*
> > > functions as documented in asm-generic/syscall.h: syscall_get_nr,
> > > syscall_get_arguments, syscall_get_error, syscall_get_return_value,
> > > and syscall_get_arch.
> > >
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > Cc: linux-m68k@lists.linux-m68k.org
> > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > ---
> > >
> > > Notes:
> > >     v5: added syscall_get_nr, syscall_get_arguments, syscall_get_error,
> > >         and syscall_get_return_value
> > >     v1: added syscall_get_arch
> >
> > > --- /dev/null
> > > +++ b/arch/m68k/include/asm/syscall.h
> > > @@ -0,0 +1,39 @@
> >
> > > +static inline void
> > > +syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> > > +                     unsigned int i, unsigned int n, unsigned long *args)
> > > +{
> > > +       BUG_ON(i + n > 6);
> >
> > Does this have to crash the kernel?
>
> This is what most of other architectures do, but we could choose
> a softer approach, e.g. use WARN_ON_ONCE instead.
>
> > Perhaps you can return an error code instead?
>
> That would be problematic given the signature of this function
> and the nature of the potential bug which would most likely be a usage error.

Of course to handle that, the function's signature need to be changed.
Changing it has the advantage that the error handling can be done at the
caller, in common code, instead of duplicating it for all
architectures, possibly
leading to different semantics.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
