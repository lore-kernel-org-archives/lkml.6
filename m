Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456A9C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B34B20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B34B20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeILT1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:27:10 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39581 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeILT1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:27:10 -0400
Received: by mail-qt0-f194.google.com with SMTP id o15-v6so2003640qtk.6;
        Wed, 12 Sep 2018 07:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jjhJdG/8sHKN4Xjf8myNoLMcCGjTRT6Mdvqr1ds01k=;
        b=YvZy3eHF1vhs6wrKtUI+lBngHb/iF3rGRR65BiYmnP2hJmkONttpKNoIOXAFNdprm2
         J9CY0OAHpyu6cq1Sf7kljz6czZDaAM4aQI6JIJRw1jMZ8SOp+VZdLsb0ZCjmTJAu6Mc/
         q+OrCWl2qg1pcm9O/rFHnKOXo0rPP1VSyim8wMk//MMUBkmvCOn78t9hWAT7mTPUUMMd
         aRIIVEw5FU3DCzDaOTi1nsZLPAkEhp7Nz7SSmfS3lsO61j81YD8QZ84RHhkCOYzgbXkQ
         tlOnh+CVtWf9sLtOXzE7TVjJg1jTLrtglH8NgaHRQui6PmXh7MU6go/dBKQR+rFLssHp
         yX/w==
X-Gm-Message-State: APzg51DxxziU0JIxcm+7u1le2fUWuZXbHy9jA8pkY3xoQnViQJdqmX1p
        m20ja7wMQ21kf51ZKkIBtJGmID7Mdes9oD67Enw=
X-Google-Smtp-Source: ANB0VdbhRESGHdsbxOvAKqwcTk8DnVKYvUanEfjBSx+dzitAn4Bp9Y5BQw55tb96KOEkj2xcACxIidZMUecpdm05lmQ=
X-Received: by 2002:ac8:6959:: with SMTP id n25-v6mr1693346qtr.9.1536762146322;
 Wed, 12 Sep 2018 07:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536757532.git.ren_guo@c-sky.com> <abb46d366b513b814f7af234d560306a818b7324.1536757532.git.ren_guo@c-sky.com>
In-Reply-To: <abb46d366b513b814f7af234d560306a818b7324.1536757532.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Sep 2018 16:22:10 +0200
Message-ID: <CAK8P3a13wWsFX2DR4LD0L4rZV0k3zszSyOX1_kPquJKaTt7StQ@mail.gmail.com>
Subject: Re: [PATCH V3 17/27] csky: Misc headers
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        DTML <devicetree@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Peter Zijlstra <peterz@infradead.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> diff --git a/arch/csky/boot/dts/qemu.dts b/arch/csky/boot/dts/qemu.dts
> new file mode 100644
> index 0000000..c6643b1
> --- /dev/null
> +++ b/arch/csky/boot/dts/qemu.dts
> @@ -0,0 +1,77 @@

Did you consider renaming the file as I suggested? I think that would help
in the long run when you get new qemu versions that have a different set
of devices and that may provide their own dtbs.

> diff --git a/arch/csky/include/asm/compat.h b/arch/csky/include/asm/compat.h
> new file mode 100644
> index 0000000..59f9297
> --- /dev/null
> +++ b/arch/csky/include/asm/compat.h
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#ifndef __ASM_CSKY_COMPAT_H
> +#define __ASM_CSKY_COMPAT_H
> +
> +#ifdef CONFIG_COMPAT
> +#define COMPAT_UTS_MACHINE "csky\0\0"
> +#endif
> +
> +#endif /* __ASM_CSKY_COMPAT_H */

Just noticed this one. I assume there won't be a csky64 architecture,
so you can probably just delete this header.

         Arnd
