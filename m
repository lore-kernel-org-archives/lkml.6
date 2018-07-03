Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ED8C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0662404A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjeP91SM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0662404A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752933AbeGCUGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:06:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33907 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753185AbeGCUFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:05:00 -0400
Received: by mail-lf0-f66.google.com with SMTP id n96-v6so2580947lfi.1;
        Tue, 03 Jul 2018 13:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xr+2qGqYxeGmPM10hhroGKobS/ccdJCJg/CUzWlPBpw=;
        b=RjeP91SMwXYdjjQydW6j8bbLKbPtIiV78eQLEqu72QDuR15Kf2hp7lhOpMt8q/ZWyP
         JCWpFBx2mI3KaFmbNHKVFlJTMbboOGxUr4ObE+oO4Ez91t4aFRkZXzlAtBtDLrubb6UF
         Wf7OBv0laL7WKqCjfyK/xXw92mDzo3hEk6uVTG6ysPVN9AsAx71M+6Pg7VuipyXpj8oH
         Q32xqCYzZDbnzdMZv3kiRk9faWvJRM1qHVlvs6pDPvDP4gz9Tixzuj7cxpIHm0AbmBeo
         oRrfxB7NutmdU+LfVnLtTT2wGfgliacOw2jijnoBV2pTcwAmjPWhACb+c5VAvwg1ISKy
         mzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xr+2qGqYxeGmPM10hhroGKobS/ccdJCJg/CUzWlPBpw=;
        b=iH1iR6Wmas0/Bh0pvbsGtYW6BwcKglN31nwxiF04h11fF3nTBX/a4mYNyY3AJ60kS4
         vlT2B2c6QwGUZzw/9Ue0TCiw0fXNF/PKzkVwiLfTYK1MDFV8gK+z23uXQQD9MFQBM8cb
         qchHARonLcPlLhIVtUR+V/ddltqxP1Vf00CGVq4lrcwStJkKKoNd8hy5bEaiELu/qfuJ
         uHE8SXWxGxR9TACD+68ImxM7VmULMj2wwVhQthme6qJyHy9uk5f5LD0u5BpWpi8mJT7p
         RpubaB5iFkvcVbmSsQQ7A5L2SSSz9t7zVkX12qYnpq/K3DZdjkpcDztwBkC3GVfTKvxT
         SCWA==
X-Gm-Message-State: APt69E2IYDCU2FmQhZoR+SpvTBp0kWpl6TNnlLlqJHkJa9L4wbfGi7aY
        rjqM16XyYSSAQrdAEUp1ICwNNON3vs1tZsUGyAU=
X-Google-Smtp-Source: AAOMgpdQ7WEFiG/EFEefjdzrbtj3gYZGr6sUMcLq+rZZLYYTfuNDnsqFtKdj6YrjFEk6m9iYDSbErs/dm8uSqyFkYQQ=
X-Received: by 2002:a19:9710:: with SMTP id z16-v6mr21669879lfd.17.1530648298643;
 Tue, 03 Jul 2018 13:04:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 13:04:57 -0700 (PDT)
In-Reply-To: <7a1490b307d8e62cebe80ebc03fea6bad8b0f227.1530465326.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com> <7a1490b307d8e62cebe80ebc03fea6bad8b0f227.1530465326.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Jul 2018 22:04:57 +0200
X-Google-Sender-Auth: OSqotaHHgy46wrTyW5vTBxKQG3E
Message-ID: <CAK8P3a3jqib-GiWcRVo6ds8Q50nZTaRmC3ACW5xJJVJzV6=7NA@mail.gmail.com>
Subject: Re: [PATCH V2 13/19] csky: Library functions
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org,
        Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 7:30 PM, Guo Ren <ren_guo@c-sky.com> wrote:
>
> diff --git a/arch/csky/kernel/cskyksyms.c b/arch/csky/kernel/cskyksyms.c
> new file mode 100644
> index 0000000..3f13594
> --- /dev/null
> +++ b/arch/csky/kernel/cskyksyms.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <asm/cacheflush.h>
> +
> +/*
> + * Defined in libgcc
> + *
> + * See arch/csky/Makefile:
> + *     -print-libgcc-file-name
> + */
> +extern void __ashldi3 (void);
> +extern void __ashrdi3 (void);
> +extern void __lshrdi3 (void);
> +extern void __muldi3 (void);
> +extern void __ucmpdi2 (void);
> +EXPORT_SYMBOL(__ashldi3);
> +EXPORT_SYMBOL(__ashrdi3);
> +EXPORT_SYMBOL(__lshrdi3);
> +EXPORT_SYMBOL(__muldi3);
> +EXPORT_SYMBOL(__ucmpdi2);

It's better to avoid relying on libgcc here. Please use the
CONFIG_GENERIC_LIB_ASHLDI3/ASHRDI3/LSHRDI3/etc
helpers that we already have in the kernel.

       Arnd
