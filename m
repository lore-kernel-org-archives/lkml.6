Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EC8C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC2123DCF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC2123DCF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbeFVGgM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:36:12 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36588 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeFVGgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:36:11 -0400
Received: by mail-vk0-f68.google.com with SMTP id o138-v6so3314179vkd.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 23:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CZFXLjcwpbOjNgE1NcyPLQZw4nLN57Jsr4M5Xqz7ZeA=;
        b=K3xMAQHz5UUKSGqz1r/ZkKTXwbqW/cFyDQU/P0vG2JkSG3Xx8C8yCCrMZwYW1QNOFh
         bNoVFRK96pu935BABuJ2F7UJspSy7/utPt8oU6Pbsd9ISrjr+zVGwFcsUXU6VCRgqMG6
         E4d4eY2TEdscasFStOp39miKstXYTI1+MGTm54VHRPP1X4ix9ifUY8VBNLEiEKqB0Ea5
         aHfJWfcur/viRN24lYpUr8xt0ii86yi21Fw+zAX/WPEyD0zE/cZQeSOs/b/iPdr+tKGB
         Tny+GZHpPt/p9VFExB3xnVy6KjvCAWokdrmko5SSWA4KvLMLQUD7yZQyo1Orz2LDRWin
         d33Q==
X-Gm-Message-State: APt69E1etehTwkFa4P4Z4EFJbE5UDXtYBFcyBAWQtRWUaUbcsWXDZ3W9
        UaPco6UK4UXhFJ+XsSYCC+UxOUo22RU1iHJJ0DD3tQ==
X-Google-Smtp-Source: ADUXVKImk7FyPleHhqyM9qq+6v0tJ3UfxXa80bkl5TRzwcj4Cfbjmz2dQCXONbvo/WC8ag4qUADiBin6ueRiaMvEuZY=
X-Received: by 2002:a1f:eecc:: with SMTP id m195-v6mr196564vkh.50.1529649370403;
 Thu, 21 Jun 2018 23:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180621203053.32047-1-geert@linux-m68k.org> <ecdf3bdf-6453-0c5f-1a72-b4df7148c867@linux-m68k.org>
In-Reply-To: <ecdf3bdf-6453-0c5f-1a72-b4df7148c867@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jun 2018 08:35:58 +0200
Message-ID: <CAMuHMdUhauqTLrjvrypfA+k=Sg7w4aJp53jeXHML0Gk3V_ynwA@mail.gmail.com>
Subject: Re: [PATCH v2] m68knommu: Fix typos in Coldfire 5272 DMA debug code
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Jun 22, 2018 at 2:20 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 22/06/18 06:30, Geert Uytterhoeven wrote:
> > If DEBUG_DMA is defined:
> >
> >      include/asm/dma.h: In function ‘set_dma_mode’:
> >      include/asm/dma.h:393: error: ‘dmabp’ undeclared (first use in this function)
> >      include/asm/dma.h:393: error: (Each undeclared identifier is reported only once
> >      include/asm/dma.h:393: error: for each function it appears in.)
> >      include/asm/dma.h: In function ‘set_dma_addr’:
> >      include/asm/dma.h:424: error: ‘dmawp’ undeclared (first use in this function)
> >
> > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Acked-by: Greg Ungerer <gerg@linux-m68k.org>
>
> Do you want me to take this via the m68knommu git tree?

Yes please. Thx!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
