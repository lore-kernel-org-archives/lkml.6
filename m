Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26119C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF031222D2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437476AbfBNIDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:03:14 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42176 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfBNIDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:03:14 -0500
Received: by mail-ua1-f66.google.com with SMTP id d21so1719656uap.9;
        Thu, 14 Feb 2019 00:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NF+3L53BNvZkogBeIQvWy8YJNldDSZkGj555Q/LewKU=;
        b=CvgQRPL//9O70LhvkmKZzRuFEE6tctlJb3aYromcQIwxHf9wCyvYOKxQCz4pPCtcWA
         by2ofWJu2uio2QKuhVykg91OoSQr/z2IT3XkwMhh2MiQ+s5slVYJmKuwooVsWsjS+Pxs
         Rb+0RCpFLHSQke1DrMXghgVqF2MrGvZqbwwnF8pdyhFDCOKw39iyRo4QIbN0LzbAEBKc
         bmsSS8uHnH9sc+Ux9y6eZN6SgQ5Vtw9zD8P0nQXv6GIb5LnMKeFOmnzmGlRrpJ7+xO7Z
         lFncokEw6bwBpom3S3/+NzTRz0uANVxTHQh1Th5fira5D3EErcDfqUHSxOQvHuP09chj
         ZyFg==
X-Gm-Message-State: AHQUAua5LrPZYFfUAgZhMKOLyMle9cHIA7vC3MI8HUHyA4bC4BmOQbDk
        xPXcCMN7idRVidweIMXIjuwe3gwe2lg6Ln5hbyk=
X-Google-Smtp-Source: AHgI3IYuwLbFH4xBoLJND8KWDgiGKKBj02ToPLGU+20FyrmwcFmKg50xLpk/vXNoc6k9cTcyD9Hb8gWxJbpWMgOdiZA=
X-Received: by 2002:a9f:2726:: with SMTP id a35mr1272618uaa.75.1550131393111;
 Thu, 14 Feb 2019 00:03:13 -0800 (PST)
MIME-Version: 1.0
References: <20190213174621.29297-1-hch@lst.de> <20190213174621.29297-8-hch@lst.de>
In-Reply-To: <20190213174621.29297-8-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Feb 2019 09:03:01 +0100
Message-ID: <CAMuHMdX0oJeGO90E9O=vVoDjahS5M8Rku+JGD1Tt+t-oKHnPJQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] initramfs: proide a generic free_initrd_mem implementation
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:09 AM Christoph Hellwig <hch@lst.de> wrote:
> For most architectures free_initrd_mem just expands to the same
> free_reserved_area call.  Provide that as a generic implementation
> marked __weak.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/mm/init.c       | 7 -------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
