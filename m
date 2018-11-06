Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F11FC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CAD20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CAD20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbeKGDsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:48:24 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38112 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388331AbeKGDsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:48:24 -0500
Received: by mail-vs1-f68.google.com with SMTP id x64so7887409vsa.5;
        Tue, 06 Nov 2018 10:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxIqxB0327pzJ8ANWt+zQRQn3WyXeLhB6H8k8Fa3edM=;
        b=jiR85BlhbpdKP7SOVsH3IL7fJM7xhDe5KCr4t37Ot/oDRqr9RHxLk9wGxu/v/xlJi6
         n3rkJ2eEMsAT5XZxXi+/rU57JsWrgnmPw3OgJasPDRxS4Y3xLjOexR/V/7v4eZeCC5v3
         ciGQhwA56s+2gbM7z1UkQdTZO/gXU2PxIHxoeOeJuikvW/CBKSG/ZjoWWEiqyMmiu+xg
         oxVOhMM5EZSozPt65o92dOuTVDnnhlzZtX4G2i6tYj/acgJVqFKoqe+HIWpaVGStBZGd
         X+dqc4z1bhsYCrLuBnmNSnnrXssoO/V9GMhNqL8adzFaFAQxUCClp5x0jB+H/1cTJcke
         WC3g==
X-Gm-Message-State: AGRZ1gK4oeocC9JM1SMLMfmZl7UwOb6QkBQBCwEqQlxyzN14eNTlTUQh
        D/SgEG1CRxO1cPyBc2hu17SMRZevwoDFWoMyvY8=
X-Google-Smtp-Source: AJdET5dZQ/ME4Bw5plX5SgfJoIwpR3dltefVde8xjYPoFPWelTDRmwCESrLdLi3ZryScufoBPUnFmMoDYY9snImTFRI=
X-Received: by 2002:a67:b404:: with SMTP id x4mr11805539vsl.152.1541528513627;
 Tue, 06 Nov 2018 10:21:53 -0800 (PST)
MIME-Version: 1.0
References: <20181106175142.27988-1-broonie@kernel.org>
In-Reply-To: <20181106175142.27988-1-broonie@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Nov 2018 19:21:41 +0100
Message-ID: <CAMuHMdVYK0SwkTDKrU+bfmCiQ2N5qERuGcqoaXzAsn-aPcCW=w@mail.gmail.com>
Subject: Re: [PATCH] sh: Provide prototypes for PCI I/O mapping in asm/io.h
To:     Mark Brown <broonie@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Nov 6, 2018 at 6:52 PM Mark Brown <broonie@kernel.org> wrote:
> Most architectures provide prototypes for the PCI I/O mapping operations
> when asm/io.h is included but SH doesn't currently do that, leading to
> for example warnings in sound/pci/hda/patch_ca0132.c when pci_iomap() is
> used on current -next.  Make SH more consistent with other architectures

Also on v4.20-rc1, cfr.
http://kisskb.ellerman.id.au/kisskb/buildresult/13576888/

> by including asm-generic/pci_iomap.h in asm/io.h.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks for your patch!

> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -24,6 +24,7 @@
>  #define __IO_PREFIX     generic
>  #include <asm/io_generic.h>
>  #include <asm/io_trapped.h>
> +#include <asm-generic/pci_iomap.h>

Is this sufficient?

include/asm-generic/pci_iomap.h provides the dummies if CONFIG_PCI=n and
CONFIG_GENERIC_PCI_IOMAP=y, while arch/sh/Kconfig selects GENERIC_PCI_IOMAP
only if PCI is enabled. Hence it's not set in the failing config
(sh/allyesconfig).

Probably SH should select GENERIC_PCI_IOMAP unconditionally, like most other
architectures do (alpha and powerpc select it conditionally, though)?

>  #include <mach/mangle-port.h>
>
>  #define __raw_writeb(v,a)      (__chk_io_ptr(a), *(volatile u8  __force *)(a) = (v))

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
