Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5AFC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3062083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3062083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeJROeG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:34:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42516 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbeJROeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:34:06 -0400
Received: by mail-oi1-f195.google.com with SMTP id w81-v6so23119269oiw.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 23:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tb+a2A2yo+HKbh2+8CHwWioJMEJeOPzD5jgZVMkpjg0=;
        b=dPvT7yjRbueWfqG77py97bKN16MFG6r3nwZJ+QCk+FoTcmGbpNRAnL8XBKUIl/Sd1d
         vtw/TBkvX0Hx0MggV5MhScxd6bLj4B4/DaXltB2OtEh2EFev4Tndt3KKdJrrSSOsArXD
         uctV+hep0DN9MnZaZhMUoTOGIEP+hJRY6k42rQmfiDxBhb2252DiyIwwOa9xrjVo6fpL
         hVr8bRo9EbMUUctf5VCuLAaGvEJLVc0gNQB+JUXqdsUUxhTspU5521xA2rG1mxPg7+La
         PdGHBdyfMoDm7a7WTrwZ5wpltmWEPAXLj/hJIEaL4wN7DpuOXyFLmysVhmjg3QSUU+ss
         zseA==
X-Gm-Message-State: ABuFfogv0c3/EhBzrOOmO3LDWURx91ycQ1O8TeLON6qxZ64ni5v35HMT
        +gZARis5qzIAgsjEiAHwyK2jw81sEZcwUe7Tsm7HxcWk
X-Google-Smtp-Source: ACcGV63InGBrHIYYs3pbOsbcfC6xmpzajy95515nL7SLZkNKXK0P+L75d81QeLzB4p2judjsDB2yziiVB67zayZ4UAQ=
X-Received: by 2002:aca:aac7:: with SMTP id t190-v6mr16383981oie.218.1539844477965;
 Wed, 17 Oct 2018 23:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181017192558.8039-1-malat@debian.org> <373dd30b-70d1-5e06-c55e-45f8f6763edf@c-s.fr>
In-Reply-To: <373dd30b-70d1-5e06-c55e-45f8f6763edf@c-s.fr>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Thu, 18 Oct 2018 08:34:25 +0200
Message-ID: <CA+7wUswVQNRKbiyockD+xkAo3=0qXW9zMS=pXWT-xTxJi0hPfg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Add missing include <asm/stacktrace.h>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 6:37 AM Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 17/10/2018 à 21:25, Mathieu Malaterre a écrit :
> > In commit 88b0fe175735 ("powerpc: Add show_user_instructions()") the
> > function show_user_instructions was added.
> >
> > This commit adds an include of header file <asm/stacktrace.h> to provide
> > the missing function prototype. Silence the following gcc warning
> > (treated as error with W=1):
> >
> >    arch/powerpc/kernel/process.c:1302:6: error: no previous prototype for ‘show_user_instructions’ [-Werror=missing-prototypes]
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
>
> This is already fixed, see
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c9386bfd37d37f29588de9ea9add455510049c33

Excellent !

Sorry for the noise :(

> Christophe
>
> > ---
> >   arch/powerpc/kernel/process.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > index bb6ac471a784..1c64491e9702 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -65,6 +65,7 @@
> >   #include <asm/livepatch.h>
> >   #include <asm/cpu_has_feature.h>
> >   #include <asm/asm-prototypes.h>
> > +#include <asm/stacktrace.h>
> >
> >   #include <linux/kprobes.h>
> >   #include <linux/kdebug.h>
> >
