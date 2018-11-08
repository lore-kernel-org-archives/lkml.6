Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4106ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B7620825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B7620825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeKHXUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:20:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34868 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeKHXUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:20:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so1475299qka.2;
        Thu, 08 Nov 2018 05:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmW3VXBdEG/An6Vi6pFiTiY5lFgggTsH1mO/MwSlq9k=;
        b=JhGFGSjpughrHVEqMEP6G7xqFHl5sbMeyHcI0pqWLd20fO6r3SDH+idj6NEdB/Nhi3
         INHv1Ni6INfqF5EiWtFChpMdHxo+ybMlyoGStj9hRfev+IrzEr6ZHZILccgJqBtwkcOj
         jPs0BN1lxQxWWkOc3NtkK0jNXie7f2HNowY0n881gl5p5Y6LFUtdrtzA9gn2AEEP43u3
         3i+lS4SVlZf645OF2VxognBv7/hsylio5X3BAVpq7hk3tQM5546AjzkHrut/WnQzdxTx
         RN/DZwhCGHEMqeZ3XQFGNobpgd0wie7KZGW14XyFhyjEvv8rBaFIN6q9BLA67l11Dda0
         XR3A==
X-Gm-Message-State: AGRZ1gKa/t7/qrcLwB+dQyIQdPmVH8U7xXZOHpJIiUMkdXyGAlfBMRhK
        ODWIAhJ/8Nus3lw5BNRfjRLf/VcoqOonbvIYoyM=
X-Google-Smtp-Source: AJdET5fVFXI5FFsDLjGADTBKpuZKZ2LNMIKKK8HeFv2JxkMSeS5HSi7WbTZUrXcPYsIKIc0UYAUM0d9zY0FEkbjQfg4=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr4247384qtr.319.1541684677976;
 Thu, 08 Nov 2018 05:44:37 -0800 (PST)
MIME-Version: 1.0
References: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
 <1540530552-3652-4-git-send-email-firoz.khan@linaro.org> <a04a6d10-d6d7-3ead-3b1e-68d87e1ea931@monstr.eu>
 <CALxhOnjWHVfVVi5aN5OAr4AN13NfktNVOarvnoAAWYgj9fYr6g@mail.gmail.com>
In-Reply-To: <CALxhOnjWHVfVVi5aN5OAr4AN13NfktNVOarvnoAAWYgj9fYr6g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Nov 2018 14:44:21 +0100
Message-ID: <CAK8P3a2h1sdM62r6TjwWf9E-h9A4pUNR69XbbGbPSpPaub7DVg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] microblaze: generate uapi header and system call
 table files
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Mon, Nov 5, 2018 at 11:26 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Mon, 5 Nov 2018 at 14:46, Michal Simek <monstr@monstr.eu> wrote:
> > On 26. 10. 18 7:09, Firoz Khan wrote:

> > > -     .long sys_rseq
> > > +#include <asm/syscall_table.h>
> > > +#undef __SYSCALL
> > >
> >
> > I still don't think this is correct.
> >
> > I have done these steps
> >
> > make mrproper
> > make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/ && move
> > Applied 1/3
> > make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/ && move
> > Applied 2/3
> > make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/ && move
> > Applied 3/3
> > make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/ && move
> >
> > And compare all these versions. Till 2/3 all is fine but when 3/3 is
> > applied
> >
> > include/asm/unistd.h contains
> > #include <asm/unistd_32.h>
> >
> > Then include/asm/unistd_32.h contains
> > #include <asm-generic/unistd_32.h>
> > which is different syscalls table.
> >
> > I didn't play with it for a long time but removing generic unistd_32.h
> > is fixing it. Please take a look.
>
> Sure, I'll check and update you ASAP.
>
> >
> > diff --git a/arch/microblaze/include/uapi/asm/Kbuild
> > b/arch/microblaze/include/uapi/asm/Kbuild
> > index cda864f4b62e..2c6a6bffea32 100644
> > --- a/arch/microblaze/include/uapi/asm/Kbuild
> > +++ b/arch/microblaze/include/uapi/asm/Kbuild
> > @@ -28,4 +28,3 @@ generic-y += termbits.h
> >  generic-y += termios.h
> >  generic-y += types.h
> >  generic-y += ucontext.h
> > -generic-y += unistd_32.h
>
> AFAIK, If I apply the above fix; the generated file - unistd_32.h will
> get removed.
> No longer present in arch/microblaze/include/generated/uapi/asm.

It certainly must be 'generated-y', not 'generic-y', since you are
generating an architecture specific file, not taking the one
from asm-generic. I think this was correct in an earlier version.

       Arnd
