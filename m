Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC21FC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAA221987
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbBPx7xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAA221987
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeHGXeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:34:23 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33174 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeHGXeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:34:23 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so217630oip.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2cy9U1vTn9IA0+AqalecdRCMfJ1TM2uDfyi/7CKif+Y=;
        b=DbBPx7xpDdPeRb/pETjFwCMBlfb+OQUli9+5NEVpjfuzdACcKXpNXsgCtbhyy/snRm
         zrvkQ4rKhOEDQKrVVtLS8p9PToL2xAfufcESNdoPfN7BtKKgS/IsSImfgufdpGdkRtVm
         4/6NiqDsAVr6AOvB4J9vTDnysKFMmn3O9RC2w6GhbhCAsJgG2rAuX42kYhq50HjGA8l5
         nd5FeXIf5pSkWpHC0LoGjNXkS7ZZtzSCtwsJ+2GomDsxJO9y0pRk/iXuiIzJ9jfErFyF
         3Iknd0eA3NQyyc1Takb0kbbSXxNTULHWf5rHnWqy+1mAFZh0hIHqHG/kPRamDe+BPtcs
         k21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2cy9U1vTn9IA0+AqalecdRCMfJ1TM2uDfyi/7CKif+Y=;
        b=j4q5fMQblQpnM62HMPPRyoY8LaDJ40jmLKp6fef5e6Pp6BaxxVoQapzxbP2cJBOzuL
         df45lq+Z03nKcH+dY9vpBTwzSF+arusDVgLXZI75uhP5MFFI4Dkd8Cnw3R59wzvLhYzV
         piq7gsz9j5pkDvck6LUMR2SaKkUaIDOHhRDV2ISOLJAJB9TXSWVBqCwbYCrqnRsb4fgB
         1GiPz4EqAtLfwM1/3RWklo8mLrA4re/jRIKcVSJsPgJQozv7rhPcBenzDlsDpj819suJ
         bVvGeLu6HfWbwg+lbNrv8+iEurBLBtks5lqJ06GSH5QamBZHoFT8rn+07KOX0EucoUP5
         3Buw==
X-Gm-Message-State: AOUpUlEevqfpzBhN/oQOELCD+EJPQ0ob2mzRL9xCeHnVDZeS4XhrEXjg
        g0oyn3MhtK49J8o03AhZIzAh26neS9ANNUqAFlQ2eg==
X-Google-Smtp-Source: AA+uWPwNerdXISwXZveFlFtKfAeaijPLFWPvOPT9toz8axHAfobzDosVnucHQNF8y9L5wUVS/+D3oW3MxcC4a5byVls=
X-Received: by 2002:aca:180b:: with SMTP id h11-v6mr101517oih.91.1533676684002;
 Tue, 07 Aug 2018 14:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180807012257.20157-1-jannh@google.com> <C6369CAA-CBB8-420F-97DB-7A242D9650A8@amacapital.net>
In-Reply-To: <C6369CAA-CBB8-420F-97DB-7A242D9650A8@amacapital.net>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 7 Aug 2018 23:17:37 +0200
Message-ID: <CAG48ez3nEszuPN9SZ9vV2=ubzv348bMpJjT9b5Q_wx6uxV2zXg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] x86: WARN() when uaccess helpers fault on kernel addresses
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 4:55 AM Andy Lutomirski <luto@amacapital.net> wrote:
> > On Aug 6, 2018, at 6:22 PM, Jann Horn <jannh@google.com> wrote:
> >
> > There have been multiple kernel vulnerabilities that permitted userspac=
e to
> > pass completely unchecked pointers through to userspace accessors:
> >
> > - the waitid() bug - commit 96ca579a1ecc ("waitid(): Add missing
> >  access_ok() checks")
> > - the sg/bsg read/write APIs
> > - the infiniband read/write APIs
> >
> > These don't happen all that often, but when they do happen, it is hard =
to
> > test for them properly; and it is probably also hard to discover them w=
ith
> > fuzzing. Even when an unmapped kernel address is supplied to such buggy
> > code, it just returns -EFAULT instead of doing a proper BUG() or at lea=
st
> > WARN().
> >
> > This patch attempts to make such misbehaving code a bit more visible by
> > WARN()ing in the pagefault handler code when a userspace accessor cause=
s
> > #PF on a kernel address and the current context isn't whitelisted.
>
> I like this a lot, and, in fact, I once wrote a patch to do something sim=
ilar. It was before the fancy extable code, though, so it was a mess.  Here=
 are some thoughts:
>
> - It should be three patches. One patch to add the _UA annotations, one t=
o improve the info passes to the handlers, and one to change behavior.
>
> - You should pass the vector, the error code, and the address to the hand=
ler.
>
> - The uaccess handler should IMO WARN if the vector is anything other tha=
n #PF (which mainly means warning if it=E2=80=99s #GP). I think it should p=
r_emerg() and return false if the vector is #PF and the address is too high=
.

What about #MC? do_machine_check() sometimes invokes fixup handlers.
It looks like fixup_exception() is basically reached for anything that
can't be restarted (either MCG_STATUS_RIPV isn't set or the worst
severity is MCE_AR_SEVERITY), but doesn't reach MCE_PANIC_SEVERITY? In
particular for "Action required: data load in error recoverable area
of kernel", if I'm reading the code correctly. It seems like the code
is intentionally preventing memory errors during user access from
being treated as kernel memory errors? So perhaps #MC in user access
should not WARN()?

> - Arguably most non-uaccess fixups should at least warn for anything othe=
r than #GP and #UD.
