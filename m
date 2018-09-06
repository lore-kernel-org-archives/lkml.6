Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3227EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C546F206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C546F206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbeIFTBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:01:03 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:39165 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbeIFTBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:01:03 -0400
Received: by mail-qt0-f179.google.com with SMTP id o15-v6so12431675qtk.6;
        Thu, 06 Sep 2018 07:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctR1dcDAHtbRU+PPJ3lprKnXzJPh4hAEr4eUNfmeKvk=;
        b=Qy6eoXqqmrTbwZ/7IrSixuTBx3F72oRghJ97Y0RWkitgeRIRhoFuc3+lc+wOjTRxXZ
         wx61FbpeX7DgHGzV9Kf3f7WSmErTr8wJvOyXVZSc/VMAr3RvzHbbupsMQ0TNLxbt6gSX
         RXj6izccFqoFtpbarYwGyYwo+Kj1R5SsZKoAPccqJLVqhjv0/87ornGSMS8YVWSnakLm
         2uZGJSH/NNU0sFJKCxA+eSgXW0pMK0AD84lP0PF7jwAUf2sUv08QAmxbOu18ZHz8hLv0
         kGC0FQnyKclljKoOrZu3qLp5Qk4eBwyITCgChNprBibgvSrpHpSDSV6NZDk9PsWLATc0
         CmWg==
X-Gm-Message-State: APzg51AT3ooRbUp6ZutboXSkVTuyarvA0lRopKVg/Ph49UBJHf+GsP2d
        JVAUEbh8lHzdfk11xeMI5EL5X77nE5QgItSrnYl6Kg==
X-Google-Smtp-Source: ANB0VdbvRVL+e80lyYRx07mLa4NqYIo85oO/Si5zp6QQwO49gwhQqefNeI2gOegdDzX2+KvwlrwWRxDGBVzOVbcZuYk=
X-Received: by 2002:a0c:885b:: with SMTP id 27-v6mr2247779qvm.115.1536243915853;
 Thu, 06 Sep 2018 07:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <37f9bd824ede529fdab291a40eef3415f99ec8aa.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <37f9bd824ede529fdab291a40eef3415f99ec8aa.1536138304.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 16:24:59 +0200
Message-ID: <CAK8P3a1xUhyQohifsvs_3th-iPCGL9WKDGj9qKoEaizuu19FeA@mail.gmail.com>
Subject: Re: [PATCH V3 13/26] csky: Library functions
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
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

On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:

> --- /dev/null
> +++ b/arch/csky/abiv1/memset.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#include <linux/types.h>
> +
> +void *memset(void *dest, int c, size_t l)
> +{
> +       char *d = dest;
> +       int ch = c;
> +       int tmp;
> +
> +       if ((long)d & 0x3)
> +               while (l--) *d++ = ch;
> +       else {
> +               ch &= 0xff;
> +               tmp = (ch | ch << 8 | ch << 16 | ch << 24);
> +
> +               while (l >= 16) {
> +                       *(((long *)d)) = tmp;
> +                       *(((long *)d)+1) = tmp;
> +                       *(((long *)d)+2) = tmp;
> +                       *(((long *)d)+3) = tmp;
> +                       l -= 16;
> +                       d += 16;
> +               }
> +
> +               while (l > 3) {
> +                       *(((long *)d)) = tmp;
> +                       d = d + 4;
> +                       l -= 4;
> +               }
> +
> +               while (l) {
> +                       *d++ = ch;
> +                       l--;
> +               }
> +       }
> +       return dest;
> +}

I see that we have a trivial memset() implementation in lib/string.c, but yours
seems to be better optimized. Where did you get it from? Is this a version
that works particularly well on C-Sky, or is this a generic optimized memset
that others could use as well? In the latter case, we could add it to
lib/string.c and let architectures select it in place of the triivial version.

       Arnd
