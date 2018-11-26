Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB9DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E05120672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlxKzK/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E05120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeKZRnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 12:43:18 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43621 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeKZRnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 12:43:18 -0500
Received: by mail-lj1-f195.google.com with SMTP id 83-v6so15454013ljf.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 22:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNaQqFbP+i6ZYzSTAwbTrhZcZNcw09b+84lnEigfb1w=;
        b=RlxKzK/jJ1k4r+/JjGN/emLNCuLJoZnDjO7ly9DroOCakSeuiY/orEO22RoQUwZfyP
         uYoQgp8berjSfXRa+xYnoNYGR7QrgK4mcD4L18AlFPTyNv2wHgSty75UL4Cs0uP5wseE
         mKfiXv0LuF0BF+ToTcdVgrRjUqi6OAxCZkl7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNaQqFbP+i6ZYzSTAwbTrhZcZNcw09b+84lnEigfb1w=;
        b=LcEMAQYCKpCyZO2kX6BkS9dcl1fnLhyhPtLCX/aqiO/4+Xg9ZLkK4VF1L/mg1imM9S
         /j/CIZT2Q/hfEN3eWvezHU1t6Df65L4MEgqJqLMcT0KwrMoaYYxo9dphe+oIpqn3l8nV
         gOzRQttx1rPAmqG3uxqfLJjacH1Y+yyta1xeMOCKGrZhJa9ppuJuy38RSGFVqmSpeu0Z
         s9bDnQCD8+k3rRDqKl2YWhHR2ip2rG6ZOz2CnYHp5gotrALk9+gnOxQkwbrhXjWNzJcW
         CfZN+Hsgc2ncVDFkE/9SjcYaIwvlQeGUmK3S9QVsi3+7Q5W+paXPGp936UyjzQKef/jK
         h3mg==
X-Gm-Message-State: AA+aEWbPN+w1ppA6GsvM0QELnCH+2GAGKM/3D+9OymzV1cwR3APShqez
        eqqkCDhYyvkGUHA7OzeAJUqWSJKaluDAxgAQ/HBT6A==
X-Google-Smtp-Source: AFSGD/VIpt27N6dLFV1V5g21fX8g2/gxoCgYDiNgsPBxWqSLUwXXP4eUino0TbZZE+FATESqSoJp5fj0FRhFuNyws88=
X-Received: by 2002:a2e:5c86:: with SMTP id q128-v6mr16883404ljb.119.1543215009419;
 Sun, 25 Nov 2018 22:50:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541480353.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 26 Nov 2018 14:49:58 +0800
Message-ID: <CAMz4kuJTN2Qt3HCBdOjyBb9KZ3FJx1iey7L7=3Bjd2NN=ybgrA@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/7] Add some fixes and new feature for SPRD DMA
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, eric.long@unisoc.com
Cc:     Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Tue, 6 Nov 2018 at 13:01, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> This patchset removes the direction usage from struct dma_slave_config,
> and add one new field to save the direction. It also fixes some issues
> for link-list transfer. Moreover this patchset adds new 2-stage transfer
> support for our DMA.

Any comments for this patch set? Thanks.

>
> Baolin Wang (1):
>   dmaengine: sprd: Remove direction usage from struct dma_slave_config
>
> Eric Long (6):
>   dmaengine: sprd: Get transfer residue depending on the transfer
>     direction
>   dmaengine: sprd: Fix the last link-list configuration
>   dmaengine: sprd: Set cur_desc as NULL when free or terminate one dma
>     channel
>   dmaengine: sprd: Support DMA link-list cyclic callback
>   dmaengine: sprd: Support DMA 2-stage transfer mode
>   dmaengine: sprd: Add me as one of the module authors
>
>  drivers/dma/sprd-dma.c       |  152 +++++++++++++++++++++++++++++++++++++-----
>  include/linux/dma/sprd-dma.h |   62 ++++++++++++++++-
>  2 files changed, 194 insertions(+), 20 deletions(-)
>
> --
> 1.7.9.5
>


--
Baolin Wang
Best Regards
