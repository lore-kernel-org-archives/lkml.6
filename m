Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A76C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76382098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcQQeFbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76382098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeJRR3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:29:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44022 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbeJRR3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:29:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id r8-v6so27046048ljc.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YFH9pFRXluxPNu/YYLTUn3Lkxhl/ttUHuGZwdRPk9Yc=;
        b=GcQQeFbgI/J3aWeVRZYMT8IcY9PVWCNR2vhSOlwC9BNx+ym0V3ehS/rWBhpKbhdeij
         QfbStSueRJOHYrLaxFjo5JPsCkFOOyAupt95KtdWkuI1905zyEntoSrPphuTWpt/Qh0f
         IxacBj/rG0BKwFuiSwOrhj5znUcd98xYiCwIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YFH9pFRXluxPNu/YYLTUn3Lkxhl/ttUHuGZwdRPk9Yc=;
        b=MNedmARJDIklsN/fI+wlF26LzRFMgYh3Vdths908Xcep2Y0ecMyELXiO791wW2U3Ub
         jLokkzHqVWqtpOh6tJmbFLypqHnJwC/mxCv301QnYih4VweMZYBEvAovcjP8tUutaZwl
         KXQ1O2iTK7TAqK7C4VpXMxOX4zGbUlTK/HKZTii83gpFKrj1SduyhgMubcVPWdIl6G2o
         IQHPsefauWDkJnmKs4OOZjWOf6Jv2+H6Twyo7qexSJfzuOlBj6wY++/RTmodqLPQb9vy
         4tLog2/8g+G2S1gbJoFnuqrw0QNf7NycKDjqjd7B9ECXpKr8dOmlgoa8SHwAHV+ZVXby
         Cv1w==
X-Gm-Message-State: ABuFfohdzo94AslhtginKiJjuMDIspnkG6+JLhKa98GpedRhBDp3hfgE
        3DY2iVL015MTtZjtgeATdVv3ya0I7ac8/NRfpS0d5Q==
X-Google-Smtp-Source: ACcGV61rEoSEQGmEABs+QfKCTtVwVhbs6P630uRUcsUrujk5m3CnSSCBhEm6FsKCjvMu0wPWU6dTS6sMPdL2h/bF3V8=
X-Received: by 2002:a2e:2f1b:: with SMTP id v27-v6mr18906846ljv.31.1539854974486;
 Thu, 18 Oct 2018 02:29:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 02:29:33
 -0700 (PDT)
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 18 Oct 2018 17:29:33 +0800
Message-ID: <CAMz4kuKFtbLMmNEbQ0oVgW87HPRwJuwFJH9cXVymz=6jH7xzOA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add some fixes and new feature for SPRD DMA
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Long <eric.long@spreadtrum.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 29 September 2018 at 13:48, Baolin Wang <baolin.wang@linaro.org> wrote:
> This patchset removes the direction usage from struct dma_slave_config,
> and add one new field to save the direction. It also fixes some issues
> for link-list transfer. Moreover this patchset adds new 2-stage transfer
> support for our DMA.

Do you have any comments for this patchset? Thanks a lot.

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
