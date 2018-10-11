Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CC8C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56DF2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+zbE3D9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56DF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeJKP5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:57:11 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46429 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeJKP5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:57:11 -0400
Received: by mail-yb1-f193.google.com with SMTP id o8-v6so3280667ybk.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77a3+sGNoQVrIAubEjBxwOmYBxL3bilu8H6ROnB7DuA=;
        b=X+zbE3D9TIQ3dBP1JkFS6pJf/06Z0haJiV+7xTdnfovH3D8b7xfsgg/DAXG5I+QfPP
         oHnJO7WuzSxaR0qiuljWB9KsanVdK21BBx1VeraFD+Ox4lOj50ktU7nPTaa6ZRC9Vdzi
         Z5yvaopbFa0LmeuAFWJKm551f1VcZjYp9NF40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77a3+sGNoQVrIAubEjBxwOmYBxL3bilu8H6ROnB7DuA=;
        b=iS6HbzRkxgXjEHdkdQePiGstmOv6THydcu7R/h2eLiZ18DXMKHCH26ungjxFh6xwz8
         ZDrQZZnNi+PKR6VKcxUIz+d6BQgxlG8H/WzYlyg8QxrX6BzeuxnlL35pCm+7Fek55Ho4
         zYikhcpIzBcyhlh/IXYCExYofK1XUHVnOWzBq4usEyoecvFyvx+Zcaa8cpWzmFm0GWWf
         38EbAVoVAp1mCe2ZSBex+bgHyMY2ag7UJtTFTO1LlsRq1jtQVQ8+/n2XoscrXz5bQIWA
         eJtjhBAh9MNxBAsRza+YBhV5S+ES+y1CkfOL/8eLLZ2jGBeKlzlhPjFRGEwxZ6GgQw1L
         U9aA==
X-Gm-Message-State: ABuFfojwZ8z9QtLGYRW8+FJ3wwMttJEZdQwxQ/zrtWXtWiQmSD1gYdcE
        dmurbbYq3HtCrj5I9/QNORE3/I6wg9PCcHLSnsSEOQ==
X-Google-Smtp-Source: ACcGV6072nGxYuJbFaZ+B/1CCnK3OAXdAp24RAhPgmAz7lTM+3+6w8Q3qJD0XqKSIAAMa36v+/Ze8Ivfcq4uO6WF1QU=
X-Received: by 2002:a25:b127:: with SMTP id g39-v6mr237179ybj.483.1539246656992;
 Thu, 11 Oct 2018 01:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-5-git-send-email-firoz.khan@linaro.org> <20181009201321.GA28911@ls3530.fritz.box>
 <CALxhOnjxkq1-N59i81+ra58tZhx7Gik6iPyUsNFJY9wEJA+D1w@mail.gmail.com> <CAK8P3a1DAEFR+PQAAediEKq1XPpxutS82SgW93_--xbjVn5wuw@mail.gmail.com>
In-Reply-To: <CAK8P3a1DAEFR+PQAAediEKq1XPpxutS82SgW93_--xbjVn5wuw@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 11 Oct 2018 14:00:45 +0530
Message-ID: <CALxhOnhEwzBHNhqV-qfigTi6ABnPufieA7EKgpkDZNDw0==b=w@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] parisc: uapi header and system call table file generation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, 11 Oct 2018 at 12:37, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 11, 2018 at 8:10 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Wed, 10 Oct 2018 at 01:48, Helge Deller <deller@gmx.de> wrote:
> > >
> > > * Firoz Khan <firoz.khan@linaro.org>:
> > > > System call table generation script must be run to generate
> > > > unistd_32/64.h and syscall_table_32/64/c32.h files. This patch
> > > > will have changes which will invokes the script.
> > > >
> > > > This patch will generate unistd_32/64.h and syscall_table_
> > > > 32/64/c32.h files by the syscall table generation script
> > > > invoked by arch/parisc/Makefile and the generated files against
> > > > the removed files will be identical.
> > > >
> > > > The generated uapi header file will be included in uapi/asm/
> > > > unistd_32/64.h and generated system call table support file will
> > > > be included by arch/sparc/kernel/syscall_table_32/64.S file.
> > > >
> > > > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > > > ---
> > > >  arch/parisc/Makefile                  |   4 +
> > > >  arch/parisc/include/asm/Kbuild        |   3 +
> > > >  arch/parisc/include/uapi/asm/Kbuild   |   2 +
> > > >  arch/parisc/include/uapi/asm/unistd.h | 373 +--------------------------
> > > >  arch/parisc/kernel/syscall.S          |  12 +-
> > > >  arch/parisc/kernel/syscall_table.S    | 459 ----------------------------------
> > >
> > >
> > > Can we please get rid of those two new files:
> >
> > Yes, we don't need those files some of the architecture and other
> > architecture does have same/similar files. That's why I added below
> > files, so every architecture implementation looks same.
> >
> > I feel it is better to remove these files.
> > Arnd, Do u have any comment on this?
>
> I agree with Helge. This was a big different in a previous version where
> you generated the syscall_table.S file from syscalls.tbl, but now that
> you generade the syscall_table.h file instead, we no longer need to
> keep the .S file synchronized across architectures.
>
> Having a separate .S file would make it easier to replace that with
> a .c file later, but it's also easier to split it out after your series than
> as part of it.

Sure. Thanks for your comments.

Firoz

>
>       Arnd
