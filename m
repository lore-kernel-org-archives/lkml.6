Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEE2C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D261021479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfACMdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:33:50 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44849 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfACMdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:33:50 -0500
Received: by mail-vs1-f68.google.com with SMTP id z23so17397514vsj.11;
        Thu, 03 Jan 2019 04:33:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6E3wOfuIOPyL9tn2f5bySIyFFjUH4UJZizadSEeWfIk=;
        b=rkmKU8n4y9X8q2aWPQnVN0HJs4WofIg5Jwm4UKiRIcG8VKR+PqwO16li/gplejlhYq
         +qyD0a6tiFo1tgt4DzmlxpKGhLfR+N1mKssmbR9UGnMgCEpNXrcVu/3jxEmnTTSZgFBB
         XHdDyudDU4X379Eol3/60nqB/in1RYiqVM23sipk0vLS7rzLTo/DGdEg9oEzQPZOouj8
         /jQI5oGUVi2pkfZX0wSY0zy8hg8X12xIglK4LxazrUYm/ci2g5iSBpMcYTan1wOzuFWr
         rT3O/Ae5JpVaNhvQ7XRHYmG20bntBZmUFRTO9D04ufbHRSkHupVDD7q5zOZQz6MgnT8n
         FxTg==
X-Gm-Message-State: AA+aEWYYSECNzqu8mI8VoBDcSTS7w1+4MXVG6S77f/uUgeiUGFNjmXCx
        oBKjNkn4KcWfUm0bwVf88XNJCROBh58aLHIPSp8=
X-Google-Smtp-Source: AFSGD/XSkQrRqk4hj9gk1ROG/F92k4ZjaG9tEv0ijFlacym2ROe03p8NmoXVntjz04/rhItx9hYN+XNawS5s6+CnrEM=
X-Received: by 2002:a67:c202:: with SMTP id i2mr17130315vsj.11.1546518828987;
 Thu, 03 Jan 2019 04:33:48 -0800 (PST)
MIME-Version: 1.0
References: <1546439331-18646-1-git-send-email-firoz.khan@linaro.org>
 <CALxhOnjz3Qd-a0OWMDV9ShfPOUB8gNB5Ltp9HGZi01mauaxkuw@mail.gmail.com> <CALxhOni1b0hS1a7EHFBkzcCx9cT-Z+jy4azrLcFveu6KG944jg@mail.gmail.com>
In-Reply-To: <CALxhOni1b0hS1a7EHFBkzcCx9cT-Z+jy4azrLcFveu6KG944jg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Jan 2019 13:33:36 +0100
Message-ID: <CAMuHMdV=Bv8+_4AOCv5s8b=Azn7eO+g_KBoSWw8DAunZmR_QiQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: unify system call table generation scripts
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>, Helge Deller <deller@gmx.de>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Richard Henderson <rth@twiddle.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
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

Hi Firoz,

On Thu, Jan 3, 2019 at 12:55 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Thu, 3 Jan 2019 at 17:04, Firoz Khan <firoz.khan@linaro.org> wrote:
> > > +fileguard=_UAPI_ASM_`basename "$out" | sed \
> >
> > Currently, all but MIPS have the architecture name included in
> > the file guard.  Shouldn't that be retained?
>
> I was planning to do something similar to this:
> -fileguard=_UAPI_ASM_`basename "$out" | sed \
> +fileguard=_UAPI_ASM_${ARCH}_`basename "$out" | sed \
>
> But later I thought, the generated file will present inside arch
> directory (eg: arch/m68k/include/generated/uapi/asm/unistd.h).
> So Is that required to mention the architecture name in the file
> guard as it is generated inside the respective arch directory?

unistd_32.h is copied to /usr/include/asm/unistd_32.h by
"make headers_install", after which the architecture name is no longer present
in the path.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
