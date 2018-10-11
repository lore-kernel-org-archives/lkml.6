Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45431C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CB220835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CB220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeJKOaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:30:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35864 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeJKOaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:30:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id a85-v6so4813863qkg.3;
        Thu, 11 Oct 2018 00:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWAeOueLWI6lFotF64qNbOYUAzO3t7+RU2k/feXJ6jM=;
        b=ORyNOMKv4Przd6/YEW4Z5P5l+lfyiestvYr3TfUvaMXGoSSIf3SCyRWhm1zAuoV5MZ
         fcxTsnblqA1gjBd9PJJjYrDHJn0H8wvoymJXwb1jNgJvV6XguFbvxwwSamMXOepuoege
         aLPhMx4BoUYG4qpzdTvQRusJ/nm335eC862dDbDxCJPA1VR7nycFI2O/o1D/4i9irpkE
         lBZd4HhQszXreNhx9HTcf2Ryf78FSbGP/fQ/hMRPITUANmiUn44CePGCN2JbcX0h0Cfu
         /1scHtgRjHF5W7dcExKudSzWUgT4yWKRg+xW5y7pZXq5wkkZSCvZBwP0rGy6oNs0XVA2
         GpXw==
X-Gm-Message-State: ABuFfoh5jHs0AVX8sBQnmVeDpndhvoO25MPIBfQPk04keIdsUecti61J
        580At7EZ/bt2FQkx13SJrs1NDmho2yJSc033tZE=
X-Google-Smtp-Source: ACcGV63yMcUWrTz09LuRZqGTc/npGjDEVbrH+p+BxAqhbcT5RGn4VPoohfd8buisN/ZK+j1r40bKiPXCwp/wBaUnn68=
X-Received: by 2002:ae9:d801:: with SMTP id u1-v6mr180441qkf.291.1539241447902;
 Thu, 11 Oct 2018 00:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-5-git-send-email-firoz.khan@linaro.org> <20181009201321.GA28911@ls3530.fritz.box>
 <CALxhOnjxkq1-N59i81+ra58tZhx7Gik6iPyUsNFJY9wEJA+D1w@mail.gmail.com> <CALxhOnj1SnTO9Sm-1cAL9B8gEmYrOHr03K6OqF4qqt5Oh0x+4g@mail.gmail.com>
In-Reply-To: <CALxhOnj1SnTO9Sm-1cAL9B8gEmYrOHr03K6OqF4qqt5Oh0x+4g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 09:03:51 +0200
Message-ID: <CAK8P3a1Kbxue2PXRL87-Saiotyq-+v=Uc3vL9KArRuLqCwC4bw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] parisc: uapi header and system call table file generation
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
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

On Thu, Oct 11, 2018 at 8:48 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Thu, 11 Oct 2018 at 11:40, Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Wed, 10 Oct 2018 at 01:48, Helge Deller <deller@gmx.de> wrote:

> > > +
> > > +ENTRY(sys_call_table)
> > > +#if defined(CONFIG_64BIT)
> > > +#include <asm/syscall_table_c32.h>     /* compat syscalls */
> > > +#else
> > > +#include <asm/syscall_table_32.h>      /* 32-bit native syscalls */
> > > +#endif
> > > +END(sys_call_table)
> > > +
> > >  #ifdef CONFIG_64BIT
> > > -#define SYSCALL_TABLE_64BIT
> > > -#include "syscall_table_64.S"
> > > +ENTRY(sys_call_table64)
> > > +#include <asm/syscall_table_64.h>      /* 64-bit native syscalls */
> > > +END(sys_call_table64)
> > >  #endif
> > >
> > >         /*
>
> I could see a patch (commit 47514da3ac20150cdf764466fbc2010c0fca0163)
> which will perform a compile-check when adding a new syscall. My patches
> will remove this feature. Is that fine?

I think it's ok: You are automating it so the bug can no longer happen,
which is better than adding checks to prevent human errors.

        Arnd
