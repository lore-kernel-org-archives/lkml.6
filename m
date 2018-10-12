Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397C8C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A30420865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A30420865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJMDPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:15:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37683 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeJMDPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:15:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id d14-v6so15085476qto.4;
        Fri, 12 Oct 2018 12:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+eOPKU0eRu/C8Nhwd98PT6Af0SYY7c2+X+f7G2/L1Ls=;
        b=fQ1MuwXIjUSNZ0DE5cRuDoODi2aVwZkjE++6+YX4irpGwwfUaWvBv9gB8jYjAHOAqP
         wqgdep9OPigDv/R45ASjezRLZcfvj2QEVJ+EsYzQP3V/RKczTiUW+jB9Np8fI6OaZqhL
         6i2x8PP9VWVcG1XTy3VxQDHqTLO7r76hXBNLJnMp9USWKTyWBrstd/2wyv4GIKKC0ClE
         +GgS+myVllITJIL7qJMOIY/28C9zDshkBF67laHWGvDi6gx9UVKb0QsnPgA1w0WX3hDG
         fl2hiI66yMvTitlBhigaAf8soZQaNKj7vFubad6EWnsxpYFShNi+pqs4UtfKOE8Y6JZh
         FJqQ==
X-Gm-Message-State: ABuFfojaNZpFB6kkrgT6PAPGAukQ2/n8jrlcrBzg2yiiKb80rfUV15UM
        jEBSwuCJ98F0c+6PFvmwbUyZKmdGdjB4bIXNj0U=
X-Google-Smtp-Source: ACcGV63NJlUKc2ZUlGqZx1GMzSfFGjMyxQ3PRHr+tbQU9Qug3bdCR9g+/fJWWqeRwVlcMnGyXaT5B7JiMqje2KF7mt8=
X-Received: by 2002:ac8:1d11:: with SMTP id d17-v6mr6877845qtl.343.1539373258267;
 Fri, 12 Oct 2018 12:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
 <3908561D78D1C84285E8C5FCA982C28F7D40F9DD@ORSMSX107.amr.corp.intel.com>
 <CALxhOngtGNP7MATzwtMZd_Xw+rqvdhP9NMtTxwCEgmzayZshOQ@mail.gmail.com> <3908561D78D1C84285E8C5FCA982C28F7D410C05@ORSMSX107.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D410C05@ORSMSX107.amr.corp.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Oct 2018 21:40:41 +0200
Message-ID: <CAK8P3a2uMx8eAa+WAGtePA3O=U_LXXBP7XX62fAO9g1NfpXgNQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] ia64: system call table generation support
To:     Tony Luck <tony.luck@intel.com>
Cc:     Firoz Khan <firoz.khan@linaro.org>, linux-ia64@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 6:12 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> > I suspect the offset logic in the system call generation script had a bug. That
> > I fixed it in this patch series.
> >
> > Arnd and Eugene had shared few comments on adding new system call entry in the
> > table and some other things. Appreciate if you can review this patch
> > series so I can
> > finalize system call table implementation for ia64 architecture.
>
> The net effect of these is just to make it easier to add new system calls. Just
> edit the table, instead of editing entry.S and unistd.h picking the next number
> (and remembering to increase  the NR_syscalls). Right?

The driving factor here is the addition of the new y2038 syscalls for 32-bit
architectures that we want to add everywhere at the same time. ia64
and alpha are obviously not affected by this as they are 64-bit only,
but to do it right, we should do all architectures together.

Another point is overall maintainability: it is very time-consuming and
error-prone to find out which architectures in which kernel version support
a specific system call or don't support it. Having a consistent way to
work on the tables should make this is a simple 'git grep'.

> I'm currently baffled at which linker magic makes the unsupported system
> calls alias to sys_ni_syscall.

This is the same method that x86, arm, and s390 have been using
for a while, by sorting the numbers and filling in the missing ones
in the script.

> I'm also uncertain whether allocating system call numbers and creating
> entry points for all the unsupported syscalls is the right thing to do. Might
> that puzzle and frustrate folks whose applications build, but then fail at
> run-time with -ENOSYS.

Again, we want this to be handled consistently across architectures
more than anything. At the moment, we have some architectures that
simply assign a number for each syscall added to x86, while others
don't. Similarly, some architectures drop the entries from unistd.h
if a syscall gets removed from the kernel, and others keep them.

I care less about which way we decide to go here, but I want it to
be done the same way for all architectures.

      Arnd
