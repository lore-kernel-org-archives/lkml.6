Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07739C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AB82086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AB82086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeIJO4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:56:12 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43950 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIJO4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:56:12 -0400
Received: by mail-ua1-f68.google.com with SMTP id f4-v6so16835983uao.10;
        Mon, 10 Sep 2018 03:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLGvK5UnXwfJ7Hd4kccWjtoqgBpaT3rVySJjyGcv13k=;
        b=Kzc7Hxf5uj2IGu0gkHq1nZrrhwkRzAD39eWaw+Wpx7qS0n6vk8wEozpe/BcTiv2VvM
         tOnbmCXBLl3+msM5XD0Ye7kuLp7lY0QK5+GGteXWr6ZJ4g98hMd6aN2koa45LOIehav4
         XH1nBvA/wQE6YasipTIMqpKaSnJMFKJpyAylOCMhEcciZj2gggGH7AMvUQ8aGfiI3noT
         YC9kEhlIKDFrqih8UnDHMqu/bTlX9pfoUq7J+AYb+z2Qdu9/GVeyJrwQu6tjFw0i7uzN
         JtXqmgyXmwu1vm1Vn3tlG96Ym9mPD6t6eeJs7OA6G2iE8w/a4Jzv4zT3cE9Qth2K+lUG
         GF8Q==
X-Gm-Message-State: APzg51BR8JTH3C3okg/HO6f9L3SQE0pkgGf8WDrxfrgBcs1t2R92BAkH
        gmQiPwN9kn13Mf0/uV4l0CZx2IIZCh0OWZ8sgDalI6fg
X-Google-Smtp-Source: ANB0Vdb3OBA4yAh9oI2qAU25WpAwfoYVnzFvIfdcUCEDF4YY8Izl4DECX9ymQQKvkdpW9x5jS8xvhBvgGNUNovG/m8I=
X-Received: by 2002:ab0:13c7:: with SMTP id n7-v6mr6758575uae.47.1536573775362;
 Mon, 10 Sep 2018 03:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <1536548104-57453-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1536548104-57453-1-git-send-email-zhongjiang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Sep 2018 12:02:43 +0200
Message-ID: <CAMuHMdWxmUpw7M=qBtcELX67eSy7C-o_j8bdmozchi3YsRFTxg@mail.gmail.com>
Subject: Re: [PATCH] sh: mm: Use dma_zalloc_coherent instead of
 dma_alloc_coherent + memset
To:     zhongjiang@huawei.com
Cc:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 5:07 AM zhong jiang <zhongjiang@huawei.com> wrote:
> dma_zalloc_coherent has taken the dma_alloc_coherent() and memset() into
> account. Therefore, just use dma_zalloc_coherent to replace the open code.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
