Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DD8C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDA925E25
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDA925E25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeGBNwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:52:02 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:39304 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbeGBNwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:52:01 -0400
Received: by mail-vk0-f68.google.com with SMTP id v16-v6so6106259vkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SogqjdrYun7rmcasFCmUgPnBYnjHp1SewUmjyWkTqSs=;
        b=AaR7IJUxs0Wg2NNL3d+Je+6h6/7g2ZnyGnA17veinPbe5wRrJ13FO9L0PLj+FrvKgc
         bdU0WAi7yL8kz2yhoKjzLUNlv6QTAf0NSXTNgxNXuRqqAztWLzsmcYH9jvMoiOMuTue2
         U9jMgub2/M7N0JY/7kYIkE2apmsgDzJGnCogbKFWulsLeeA7iaz4Kko2f7k1ZNZohTnG
         u3aq0uTJQL/CBh3BGunwk4y6C9TyYWEKmBfFEfpIFmV6KN6Uu2MJpcgjaRfxW5QfH5IW
         n6ctZ0xCy8h+hNSQVRtckwZs7x7FkPlBltaLB3M2Jc30JcdC4U3T5LTYfdDF2tBbGuK7
         nA5w==
X-Gm-Message-State: APt69E3Cc0UiavtNRpgrOnv0vy4Oy8ZS48t8bXMRSLi0LIrNt6zxCrmh
        Phtxa8ibtXz4E0mTd8bcVG9bWDmbPYcGH5oMeYWqog==
X-Google-Smtp-Source: AAOMgpdn1/QkOUYq73wfj8/T3FS7xEibOFKlprLFSbE8SrZRDGHZzj4VLv1uTmny7llH9z8jWifXR6x21hHqmYh/jZM=
X-Received: by 2002:a1f:f44f:: with SMTP id s76-v6mr523212vkh.125.1530539520346;
 Mon, 02 Jul 2018 06:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <142066981b41910f4e645590a8b1734a1ea72fb8.1529926655.git.fthain@telegraphics.com.au>
In-Reply-To: <142066981b41910f4e645590a8b1734a1ea72fb8.1529926655.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Jul 2018 15:51:49 +0200
Message-ID: <CAMuHMdVjjonPUj=L1xQx9B55M05EW+Oe8ffguLZEiiU-5zXyBA@mail.gmail.com>
Subject: Re: [PATCH] nubus: Set default dma mask for nubus_board devices
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 1:45 PM Finn Thain <fthain@telegraphics.com.au> wrote:
> A 32-bit mask is used by default because a NuBus slot has 32
> address/data lines and a NuBus board is free to use all of them.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks, applied with Christoph's Rb, and queued for v4.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
