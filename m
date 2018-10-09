Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24524C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC57C2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="biaPpnSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC57C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeJIMMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:12:03 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33271 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeJIMMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:12:03 -0400
Received: by mail-yw1-f68.google.com with SMTP id m127-v6so132380ywb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 21:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKOdz1WoF9+ASgSxpoT05XJYq3BadarNrkSIFhl6RUM=;
        b=biaPpnSqZ0b3rxKbfqxmynR45nl0Mnuy3JuGqb0IEeMlWRJRC8tZOrqOFrr+XOsD83
         s/+Mbq0oWKqWafovVZgLJbpmCb5HI/oIsa8dAEUxThdF0GAWAYHcgIRdbjMrHb0L6atu
         Hzjk/dGhK1vmXzV7Ilw5MoGXrWExjqlKlQrLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKOdz1WoF9+ASgSxpoT05XJYq3BadarNrkSIFhl6RUM=;
        b=ff3OxGiQrmk4Jy4llo0AtxpEGuINSj3vwDQNxz/dLoM0+tOVSBg5P1QR7lrW9HVxHC
         LZgwkU/FSjOYj562cnxX5jpviK2oTUYzsB7A7cw7slqUT3+ehgO4t6Xh1e035RGilQoB
         E15Osr3wS9aOdRS/9UqSWUhF3LJEWeMrer1t5JVbpCESvxIDaIEObSpCgnvrxIUQ5CKz
         cgycgD1vzTN7cvoTst1V0PlxtX8LNtCQoMdEFR5Rt0J+2BC2Ubp0sY2bSyOG/zJWYJox
         Bmb3vkBPrHhEqc8Dj/OrcgNh7+sSu7DUyhxINuAuhkZ3zji3XpgvvvPxYdHDpQlG4lM4
         u/RQ==
X-Gm-Message-State: ABuFfohI5oNbg49e9u1sLn80trlDazMQGFmIU6b6rhTVZSwAilZaaX3R
        c7ImABPCcsEgC93J8NozDZKdbODgBD3aTkGILVrf/A==
X-Google-Smtp-Source: ACcGV62TstXx0m4zSrATHTl2Tse6yweHH3yBvgC3Mox2RmVAGv5kFXes5AhzQuNanY4IeBz5MkG5ZKD1lMpA5Yt+Wbk=
X-Received: by 2002:a81:21c1:: with SMTP id h184-v6mr14816471ywh.367.1539061020087;
 Mon, 08 Oct 2018 21:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-5-git-send-email-firoz.khan@linaro.org> <b1883a34-f256-0940-4e92-574ba48b5ca8@gmx.de>
In-Reply-To: <b1883a34-f256-0940-4e92-574ba48b5ca8@gmx.de>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 9 Oct 2018 10:26:48 +0530
Message-ID: <CALxhOnhtrzyxH3ACQHFVTc4=Tn+BuVtJpYz1EHErYCADVemU4A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] parisc: uapi header and system call table file generation
To:     Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

On Tue, 9 Oct 2018 at 01:13, Helge Deller <deller@gmx.de> wrote:
>
> On 08.10.2018 07:16, Firoz Khan wrote:
> > System call table generation script must be run to generate
> > unistd_32/64.h and syscall_table_32/64/c32.h files. This patch
> > will have changes which will invokes the script.
> >
> > This patch will generate unistd_32/64.h and syscall_table_
> > 32/64/c32.h files by the syscall table generation script
> > invoked by arch/parisc/Makefile and the generated files against
> > the removed files will be identical.
> >
> > The generated uapi header file will be included in uapi/asm/
> > unistd_32/64.h and generated system call table support file will
> > be included by arch/sparc/kernel/syscall_table_32/64.S file.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ...
> > diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
> > index f10d065..76e3a3b 100644
> > --- a/arch/parisc/include/uapi/asm/unistd.h
> > +++ b/arch/parisc/include/uapi/asm/unistd.h
> > @@ -2,374 +2,13 @@
> >  #ifndef _UAPI_ASM_PARISC_UNISTD_H_
> >  #define _UAPI_ASM_PARISC_UNISTD_H_
> >
> ...
> > -
> > -#ifdef __KERNEL__
> > -#define __NR_syscalls           351
> > +#define __NR_Linux           0
> > +#ifdef CONFIG_64BIT
>
> You can't use CONFIG_64BIT in an uapi header file.
> It's only defined inside the kernel when building the kernel.
> Please use
>         #ifdef __LP64__
> instead here.

Sure.  Thanks!
Firoz

>
> > +#include <asm/unistd_64.h>
> > +#else
> > +#include <asm/unistd_32.h>
> >  #endif
