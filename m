Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BE8ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7AC20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7AC20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeINR32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:29:28 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33714 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeINR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:29:27 -0400
Received: by mail-vs1-f65.google.com with SMTP id y12-v6so414713vsm.0;
        Fri, 14 Sep 2018 05:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnAporKSKQZKo9BuIVGiI3H1Ktz29aeUJJ/WYAPWURM=;
        b=e0K5mgnQfC0Vu8xOPS5i81yBAF1Rvz9nvAwYSTPfwnB9g9p+Lmj8NojOHmvjt2AY62
         TJeESEoX1ndtKVxjWoocHBwNHgxMokHXrGIEh7arbaeFFHIKvzNvVzS2hdhCRtFsczBI
         xcAfk/mqoyrbPnUDQi1YyqVRW/M+d02KbP3u3v9OHs3wt2Shb3jYyT/HP8E5aWM1QMps
         4feRpDo7S1ycsLsgTtFj2xcoIcheXnrCqfVrxp+7WtyCq16BiIhUq6Wo0QPKWJdElqPh
         6GYpo3cnYSZmUDG4fLnXSpCwjjzP4IBv4+i03jYd1XOivRRnfb+sys+zFyOzvV7Lub4M
         4uoQ==
X-Gm-Message-State: APzg51B+ffDCRTAwP+7Id/0WzU/9+2+tWjc1sigTG2kXNzdK+sUArSGz
        Jzmwsca9maYEVSE0hyCroLfzT878AOBQNomzp1o=
X-Google-Smtp-Source: ANB0VdbU0e9s+tihQZa+5a+NhqeACj7QPK5Yu/v9tNu9Xv41MNSDtyRB2EqXFcCvQNJqS0rBWYaySkk0iUUS4ryf4as=
X-Received: by 2002:a67:cd07:: with SMTP id u7-v6mr4161634vsl.78.1536927313577;
 Fri, 14 Sep 2018 05:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com> <20180913151716.6333-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180913151716.6333-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Sep 2018 14:15:01 +0200
Message-ID: <CAMuHMdV_xpj62BkqwoTAaaugM3BkDRQTC=E0cEDqKBg3sUYNBg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] ARM: dma-mapping: update comment about handling
 dma_ops when detaching from IOMMU
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux IOMMU <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 5:18 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Update the comment because we don't set the pointer to NULL anymore.
> Also use the correct pointer name 'dma_ops' instead of 'dma_map_ops'.
>
> Fixes: 1874619a7df4 ("ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Nice catch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
