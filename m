Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72BBC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6ED2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6ED2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbeIFU0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:26:24 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36663 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbeIFU0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:26:23 -0400
Received: by mail-ua1-f65.google.com with SMTP id c12-v6so9184608uan.3;
        Thu, 06 Sep 2018 08:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4CoNjz5LWKVHNmcUkPM+OrYMGblOSGorYX19e/KK88=;
        b=DQnuO8aZrVO13+KYApwanUzzNhl/i/VJ3w/sBVmOQpt9JEbUn+j4QtqCOx/vIwoUAd
         I/O4HDGbxm4tqg9Syvlknw0Snk1fhDrtjbkSHKr2YawTbBh12dvrTPRd8P8rwVEHf9g0
         X7Dl8e8GYyH2Gplu63YjhHgL3s4XDeYYjrkP5bj1V3mMP+OTpFGu6mpnR9XEiTI6zhnJ
         gw695rUrncaEJrWzep0XfURUMB8+KptZmR3Q5pX/eU5C6DK8S5fOuiBeXs4KVGDLWR5S
         CErnAvHAGIqBWDCiPsZhXaNtSbILlGwccIdv9S1Mwqkwborrn6A0tq1iIWVUJ26ZZ1mT
         cWwg==
X-Gm-Message-State: APzg51BIEtm3SGY8ADVEbbdFB01laZshOYIZ4eTHhLG+0HS/M8SzOaw9
        QIss46Mxi433ze2SHgead77Br5EehWx7PNJpmn0=
X-Google-Smtp-Source: ANB0VdY9GvBYhbrlupj/EfpK9yyOw1O+Mfj23lqWMapidN3PY9m5xcdvVE8hA1HbLvTqldt/0+I3aY6cBWlZfPikV/8=
X-Received: by 2002:ab0:51ac:: with SMTP id g41-v6mr1307293uaa.155.1536249015473;
 Thu, 06 Sep 2018 08:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <37f9bd824ede529fdab291a40eef3415f99ec8aa.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a1xUhyQohifsvs_3th-iPCGL9WKDGj9qKoEaizuu19FeA@mail.gmail.com>
In-Reply-To: <CAK8P3a1xUhyQohifsvs_3th-iPCGL9WKDGj9qKoEaizuu19FeA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Sep 2018 17:50:02 +0200
Message-ID: <CAMuHMdW3GhYGPnPf0ph=ZbVpNqiYhAsSMni7SKTC1ZC9zTUUxw@mail.gmail.com>
Subject: Re: [PATCH V3 13/26] csky: Library functions
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <ren_guo@c-sky.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 4:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> > --- /dev/null
> > +++ b/arch/csky/abiv1/memset.c
> > @@ -0,0 +1,38 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > +#include <linux/types.h>
> > +
> > +void *memset(void *dest, int c, size_t l)
> > +{
> > +       char *d = dest;
> > +       int ch = c;
> > +       int tmp;
> > +
> > +       if ((long)d & 0x3)
> > +               while (l--) *d++ = ch;

while ((uintptr_t)d & 0x3) && l--)
        *d++ =ch;

and remove the else below?

> > +       else {
> > +               ch &= 0xff;
> > +               tmp = (ch | ch << 8 | ch << 16 | ch << 24);
> > +
> > +               while (l >= 16) {
> > +                       *(((long *)d)) = tmp;
> > +                       *(((long *)d)+1) = tmp;
> > +                       *(((long *)d)+2) = tmp;
> > +                       *(((long *)d)+3) = tmp;

s/long/u32/

> > +                       l -= 16;
> > +                       d += 16;
> > +               }
> > +
> > +               while (l > 3) {
> > +                       *(((long *)d)) = tmp;
> > +                       d = d + 4;
> > +                       l -= 4;
> > +               }
> > +
> > +               while (l) {
> > +                       *d++ = ch;
> > +                       l--;
> > +               }
> > +       }
> > +       return dest;
> > +}
>
> I see that we have a trivial memset() implementation in lib/string.c, but yours
> seems to be better optimized. Where did you get it from? Is this a version
> that works particularly well on C-Sky, or is this a generic optimized memset
> that others could use as well? In the latter case, we could add it to
> lib/string.c and let architectures select it in place of the triivial version.

Sounds good to me, after removing the 32-bit-isms.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
