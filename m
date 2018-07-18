Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39724ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34B52075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34B52075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbeGRMPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:15:15 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42093 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeGRMPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:15:15 -0400
Received: by mail-ua0-f194.google.com with SMTP id w7-v6so2693150uan.9;
        Wed, 18 Jul 2018 04:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hPulgwrdoC0YDznN5lpo6QhNvOqlUqEj1w+VeE9Dvc=;
        b=Djx/QJLY7EX3K/oKV3OPOwE1L8i4VusdAaQrgSQQ+trdz/LsEY1V1iylVSSziKUU3Y
         wmFVNU3NjOvN8rwZx14ZdjJ2k3vLQ29kONkSH7pGJp7mX9TGzMDgIgi8jW2wrWXjsecT
         XNigT8t4eSG3SC+B1OlN/D5wyF8qRcBPoRnNMROM8t5+ImRnghNvb51cFPpnsbezdFTT
         W3Rvytbc3Q79Cw5gjDc9IqFD/YCZ6U/d23qQIg1zgE05aPQ1C4z0Dwe5x42ERRKTetaY
         zPTCK2jBpOMhptGpIuUr+rO6+UY7HYj5JKQ5wDMwizS/UtW7KeMtZDlAF6rahoknhrbh
         WtKw==
X-Gm-Message-State: AOUpUlEQNHtK6538SGxJy3MsLvF6/y1dnuFkbWDOTWjYW+vHdksP0vPi
        3uMCar64j0zZ24pdGFiZ070q1Tqd1g43GTxu4KA=
X-Google-Smtp-Source: AAOMgpdAlT6vzIYTXwcYrRkMfn50nB0BwrmhQJpVvxYEu0Uqigp2pSDiUcsTeUrLL70IC6lwAfsiVVJXdwkbEpwCGQc=
X-Received: by 2002:ab0:1b6c:: with SMTP id n44-v6mr3565606uai.4.1531913865871;
 Wed, 18 Jul 2018 04:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180709093040.23597-1-geert@linux-m68k.org> <0f38c6fd-82f1-7211-3b2e-425bbd44b157@linux-m68k.org>
In-Reply-To: <0f38c6fd-82f1-7211-3b2e-425bbd44b157@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Jul 2018 13:37:34 +0200
Message-ID: <CAMuHMdVCA4C4TYfeM+McL2EhHzUrPDEfP14oinYVp10KdOoiBA@mail.gmail.com>
Subject: Re: [PATCH 0/5] m68k: IO Fixes and Cleanups
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        netdev <netdev@vger.kernel.org>, linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 3:48 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 09/07/18 19:30, Geert Uytterhoeven wrote:
> > This patch series contains fixes and cleanups for I/O accessors on m68k
> > platforms (with MMU).
> >
> > The first patch contains small fixes without any dependencies.
> > Patches 2 and 3 make small adjustments to drivers that are dependencies
> > for further cleanup.
> > Patch 4 and 5 complete the cleanup.
> >
> > Changes compared to v1:
> >    - Move ARCH_HAS_IOREMAP_WT to fix "ioremap_wt redefined" warnings with
> >      m5475evb defconfig,
> >    - Add Acked-by.
> >
> > Given the dependencies, I think it's easiest if the respective
> > maintainers would provide their Acked-by, so all patches can go in
> > through the m68k tree.
>
> Retested on ColdFire 5475, looks good.
> For the whole series:
>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Thanks, applied and queued for v4.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
