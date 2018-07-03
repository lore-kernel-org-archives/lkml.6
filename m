Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853C3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473142086B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473142086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932823AbeGCHlw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:41:52 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39291 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbeGCHlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:41:50 -0400
Received: by mail-ua0-f194.google.com with SMTP id n4-v6so612607uad.6;
        Tue, 03 Jul 2018 00:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lo5QfrQYlpMYzMVN8UsWUKjOsGlYwde+su3qxFYumiE=;
        b=tSlDl8kyQvjzN/gAKhiot9zwBtN4nGRfL4QHZ/h7MaNQr2PkrRPb3fir3U+Q6FiMcG
         sTVkTiUnRYm9U2yyEmCSaAP30btlb4+GwSBI8PtaU+db8Bz4YH9iPu1EfzMnrm4kdEDq
         v8fMPCmogMh4MGR6PJ5uMq7qZDmpP38UIioS6KhO1eVzpovo9BC2SntOJnCz+k+sI4vs
         u/6CqFzk9YyoRlqOI9Vttntpnm9x/OtnAToSAapjJEL46Z0EelyHLGIMICFcu/bbIxz7
         SkONHkDV8heQv6I9v8kZ+oEmg4U1HaNi93fMU5giJgDb8LwV5SV/oTgB030dh4PJNIqk
         zcQA==
X-Gm-Message-State: APt69E3DlvvhFszQ/e27syiSL2dMcMjzvkk30GoMDb5YROc1fVUMEimF
        fLNY8uLq+IcIQQ0gA29RJ9L9V8AOdBOjJ3iBILY=
X-Google-Smtp-Source: AAOMgpdwUVQ1wxa7qlPSjFbP2wxzZV4DQqnZNgGvJn1UWAPWnJsDfvHmvVadSElyftMOg8HROk6fW7fK/Uz4SYCFyRA=
X-Received: by 2002:ab0:265:: with SMTP id 92-v6mr19136263uas.26.1530603709901;
 Tue, 03 Jul 2018 00:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180702133532.5412-1-geert@linux-m68k.org> <20180702133532.5412-2-geert@linux-m68k.org>
 <1349f685-e4a2-5e04-8227-dd55e11153f6@linux-m68k.org>
In-Reply-To: <1349f685-e4a2-5e04-8227-dd55e11153f6@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Jul 2018 09:41:38 +0200
Message-ID: <CAMuHMdUHmWiZOofGRFz6Qqphi4iChHa+TY-me_hKEN-xnrrvnA@mail.gmail.com>
Subject: Re: [PATCH 1/5] m68k/io: Add missing ioremap define guards, fix typo
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        netdev <netdev@vger.kernel.org>, linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Jul 3, 2018 at 4:13 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 02/07/18 23:35, Geert Uytterhoeven wrote:
> >    - Add missing define guard for ioremap_wt(),
> >    - Fix typo s/ioremap_fillcache/ioremap_fullcache/,
> >    - Add define guard for iounmap() for consistency with other
> >      architectures.
> >
> > Fixes: 9746882f547d2f00 ("m68k: group io mapping definitions and functions")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> If I build for the m5475evb defconfig then I get warnings like this:
>
>    CC      init/main.o
> In file included from ./include/asm-generic/io.h:19:0,
>                   from ./arch/m68k/include/asm/io_no.h:147,
>                   from ./arch/m68k/include/asm/io.h:3,
>                   from ./include/linux/bio.h:28,
>                   from ./include/linux/blkdev.h:21,
>                   from init/main.c:80:
> ./include/asm-generic/iomap.h:79:0: warning: "ioremap_wt" redefined
>   #define ioremap_wt ioremap_nocache
>   ^
> In file included from ./arch/m68k/include/asm/io_no.h:145:0,
>                   from ./arch/m68k/include/asm/io.h:3,
>                   from ./include/linux/bio.h:28,
>                   from ./include/linux/blkdev.h:21,
>                   from init/main.c:80:
> ./arch/m68k/include/asm/kmap.h:37:0: note: this is the location of the previous definition
>   #define ioremap_wt ioremap_wt
>   ^

Thanks, I did some m68knommu compile tests, but didn't see this warning, which
happens for Coldfire+MMU only.

The issue is that there are two ways to declare an architecture has
ioremap_wt():
  1. By defining ioremap_wt,
  2. By defining ARCH_HAS_IOREMAP_WT.

1 is done in arch/m68k/include/asm/kmap.h.
2 is done in arch/m68k/include/asm/io_mm.h. Moving that to kmap.h fixes
the warning. Will send an update shortly.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
