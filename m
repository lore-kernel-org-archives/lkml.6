Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA1EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E97208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNrTMuX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E97208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeH0XOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:14:07 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33828 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeH0XOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:14:07 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so230189ois.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lYzA+d4biCHj8sFLEgcNtoxZxtZZzrw64J2XubgNzc=;
        b=mNrTMuX273IaJIqtlmt82ePp6Lbyg25b8vCfX5QxNwat2MGGjnQyEsw84y302sVEK+
         dm/jCsBuSasx6NpwJh4CPGUtCaCgqOE062u6JV4gLNR9pRbgCLGqGPzziNyeNh9SAQIq
         px9N2VEEZcvRZ0xZtq/S+cFhv9uv4qCq6YyScnldd992dHYYMX1xQkQNmLZ2t1i+fBbA
         9XTtEEDofFSyJh3GDlNHqZGSalB2tjSzQ8Ed3aaEESmFj6J8kCr4x9LgdF7UW/YWQ5XA
         Wi/hgermlvzzwL1+YLMeVqBmxx+kSezrUZpXcRl9OFQyvlGo3Q2oWq01026et0y6FTn4
         Ddjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lYzA+d4biCHj8sFLEgcNtoxZxtZZzrw64J2XubgNzc=;
        b=ZKv8HE/dYjPOlyiN/BdzfSBUMCNUiDWOdZtnPbB7Ow6gZjv2Qr2CiS9n0DfGYYLiW8
         JQeoz/2ec28uROyhRA/IhltlcVjl+Y+NLATXN3bWApqpm7oV7u6I734It0L8RzCXCe7m
         2VPG35TG1pLfZbrenTQtybVEHTLFgHuV837Ara3WQsb95rlcA1WF5Uvv+Ns8QqhX7ddJ
         Fmh2I5K8E68BKnSpBLWcPt7m38mvzsGABV/HDlPfOaa90C8UYpm1Iwd2c4aZjs2I9GQU
         nGpDbZsbejlo/VPUugEZORc+MehgJ3lG+9uCKdvXLvidRMoTDWk7sj/k924Bo8y3t4Kb
         MHrA==
X-Gm-Message-State: APzg51Byjnz0Cs7/WXQuCmYnWm9R6YVMj8gIat58GfY5p7UF4nW2NPhF
        zabVzo9U4c+GY8mOVrr/47/fGJvsx57B9MPLOFDuwQ==
X-Google-Smtp-Source: ANB0VdY8SKNvQ16wQyxwCXTHDxf1e25RPucAQZRtk/p6h+5YJjXPdDrGY3oR1wJDfjCoy5lx6fUGweD6yt8wAQhnJAk=
X-Received: by 2002:aca:a94c:: with SMTP id s73-v6mr40110oie.68.1535397971024;
 Mon, 27 Aug 2018 12:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180827185631.163506-1-jannh@google.com> <20180827185631.163506-6-jannh@google.com>
 <CALCETrXSfLVcGGPM5=XJ8hxaN_sO2faS7iu8JzJdeYDaWc_rPg@mail.gmail.com>
In-Reply-To: <CALCETrXSfLVcGGPM5=XJ8hxaN_sO2faS7iu8JzJdeYDaWc_rPg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 27 Aug 2018 21:25:44 +0200
Message-ID: <CAG48ez3BSns2W_7S=OR=K5eFCbjKn84xrbtp98oMqSkUtAEYyw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] x86: plumb error code and fault address through to
 fault handlers
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        tony.luck@intel.com, Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 9:09 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, Aug 27, 2018 at 11:56 AM, Jann Horn <jannh@google.com> wrote:
> > This is preparation for looking at trap number and fault address in the
> > handlers for uaccess errors.
> > This patch should not change any behavior.
>
> Confused.  $SUBJECT says you're plumbing the error code through, and
> you are sort of doing it:
>
> > -int fixup_exception(struct pt_regs *regs, int trapnr)
> > +int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
> > +                   unsigned long fault_addr)
> >  {
>
> It's available here...
>
> >         const struct exception_table_entry *e;
> >         ex_handler_t handler;
> > @@ -202,7 +212,7 @@ int fixup_exception(struct pt_regs *regs, int trapnr)
> >                 return 0;
> >
> >         handler = ex_fixup_handler(e);
> > -       return handler(e, regs, trapnr);
> > +       return handler(e, regs, trapnr, fault_addr);
>
> ... but you don't pass it into the handlers.  Is this intentional?

Whoops. No, that's not intentional. I'll fix it up for the next version.
