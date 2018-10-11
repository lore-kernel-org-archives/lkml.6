Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D56C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A502085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A502085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeJKOdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:33:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36961 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeJKOdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:33:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id d14-v6so8704466qto.4;
        Thu, 11 Oct 2018 00:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2GV1rdaDCMKZT7FhNYHvOOlSnj9U9gOWskJaApXq+rI=;
        b=Nhne4RwgMnsbyWiOiJ4ZFI9Wm0lLZTW/FUib4scqwZNry4vMDWL5Zwwz1f4ZVnyWIU
         tUuIdO1iP9Z/f9ru+uiIwLEjPuEi4ZrVAYdWbgnAa10ws0SfqxC3h49i2l8df5Oz/M+p
         MIxilMdIvvHB3Fmw7Q29pWUSZQX0RETbDuQJj1v5GWsQrfDKaVAnuE5iAKBl/X3MeckP
         6bqZh1jridFtYIWxcbO2FUtexsK6U9McisZVk5RJfViVaRLBI9s67ceQffqLnIdNYZZg
         FuQSGw8F8bBHL6zU9A9cZ2deCp8Nd+Hl0BU4DzWcQ0kCqVWJE69m58ibo4hdzlZhAObL
         c7Aw==
X-Gm-Message-State: ABuFfogJp+jS9QOGR2cQ2nVXuqnymeksPnJ9swwPHjU+H/j1OHqisn0M
        onH1DF+ns8brQe7E8jiwxol4Oba43PF5l+sr0CA=
X-Google-Smtp-Source: ACcGV62chVKps3lsWailiktZCH9IWgGGbmYlV84sE2XeC1fshxUJACgm6Gnjp+s7+MC5jAMjI8G5nYLOfSv1VPxRb6M=
X-Received: by 2002:aed:35cd:: with SMTP id d13-v6mr360721qte.212.1539241655341;
 Thu, 11 Oct 2018 00:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-5-git-send-email-firoz.khan@linaro.org> <20181009201321.GA28911@ls3530.fritz.box>
 <CALxhOnjxkq1-N59i81+ra58tZhx7Gik6iPyUsNFJY9wEJA+D1w@mail.gmail.com>
In-Reply-To: <CALxhOnjxkq1-N59i81+ra58tZhx7Gik6iPyUsNFJY9wEJA+D1w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 09:07:18 +0200
Message-ID: <CAK8P3a1DAEFR+PQAAediEKq1XPpxutS82SgW93_--xbjVn5wuw@mail.gmail.com>
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

On Thu, Oct 11, 2018 at 8:10 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Wed, 10 Oct 2018 at 01:48, Helge Deller <deller@gmx.de> wrote:
> >
> > * Firoz Khan <firoz.khan@linaro.org>:
> > > System call table generation script must be run to generate
> > > unistd_32/64.h and syscall_table_32/64/c32.h files. This patch
> > > will have changes which will invokes the script.
> > >
> > > This patch will generate unistd_32/64.h and syscall_table_
> > > 32/64/c32.h files by the syscall table generation script
> > > invoked by arch/parisc/Makefile and the generated files against
> > > the removed files will be identical.
> > >
> > > The generated uapi header file will be included in uapi/asm/
> > > unistd_32/64.h and generated system call table support file will
> > > be included by arch/sparc/kernel/syscall_table_32/64.S file.
> > >
> > > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > > ---
> > >  arch/parisc/Makefile                  |   4 +
> > >  arch/parisc/include/asm/Kbuild        |   3 +
> > >  arch/parisc/include/uapi/asm/Kbuild   |   2 +
> > >  arch/parisc/include/uapi/asm/unistd.h | 373 +--------------------------
> > >  arch/parisc/kernel/syscall.S          |  12 +-
> > >  arch/parisc/kernel/syscall_table.S    | 459 ----------------------------------
> >
> >
> > Can we please get rid of those two new files:
>
> Yes, we don't need those files some of the architecture and other
> architecture does have same/similar files. That's why I added below
> files, so every architecture implementation looks same.
>
> I feel it is better to remove these files.
> Arnd, Do u have any comment on this?

I agree with Helge. This was a big different in a previous version where
you generated the syscall_table.S file from syscalls.tbl, but now that
you generade the syscall_table.h file instead, we no longer need to
keep the .S file synchronized across architectures.

Having a separate .S file would make it easier to replace that with
a .c file later, but it's also easier to split it out after your series than
as part of it.

      Arnd
