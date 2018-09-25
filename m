Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BD3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04C920C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04C920C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeIYVfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:35:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42315 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbeIYVfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:35:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id h26-v6so24807114otl.9;
        Tue, 25 Sep 2018 08:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=coJqlR89j0WlKzSz/xB1RiZz125lTlarrdbRcaBser8=;
        b=Ofd8ASvLe3e/ZZmePKTSFJh9cVzV9jFs+JLjcFtwh6Jt9stWfVFPrCrVQfaiwEACcg
         j8U+dXqd6WcJap4MhC1PLKFUqbBjYHYcjnU3xjJdtfREmhObtJERwYys+0rTxuDrMUmu
         NI9ty7kx0fsG8MluzG2imhCmHG2H8iFz0OnBrb/qfm8IIzpWnULoobO/UMA2T/vWWJ0v
         saV3lpBPh6lIT7FoXO3Nn5srcziTyuv6gZb4wqoHbgBgy7eSo5Uu3TNUFYG9MyMfh886
         K/qIhLHYrD464BiqVSKSLouSbm0gAjKi0+Au8dbucMuOW3GgPKdcuyU3pZZae0VhPWRX
         zlIw==
X-Gm-Message-State: ABuFfohxY9JR/yL8kzEnC6Z4RrY3UJKLddjjbTdTWm7kpqRABTayMl6P
        dFXsCAP7AdCkXpaFg+RjQg==
X-Google-Smtp-Source: ACcGV63mpMNh7spi3H/ShRYfj3HPDEiNgZk9fRSwykGkiYu8vWNDspQC7K3vU2cHSoqDfbl2InZqOQ==
X-Received: by 2002:a9d:38d8:: with SMTP id k24-v6mr1146912ote.62.1537889255879;
        Tue, 25 Sep 2018 08:27:35 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o8-v6sm285190oic.19.2018.09.25.08.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 08:27:35 -0700 (PDT)
Date:   Tue, 25 Sep 2018 10:27:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        benjamin.gaignard@linaro.org, Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH V2 26/27] mmc: mmci: add DT bindings for STM32 sdmmc
Message-ID: <20180925152734.GA28148@bogus>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-27-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537523181-14578-27-git-send-email-ludovic.Barre@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 11:46:20AM +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> STM32 sdmmc variant has support to:
> -Indicate signal directions (only one property
> for d0dir, d123dir, cmd_dir)
> -Select command and data phase relation.
> -Select "clock in" from an external driver.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
> change v3:
> -remove space at end of "st,use-ckin "
> 
>  Documentation/devicetree/bindings/mmc/mmci.txt | 9 +++++++++

I acked v1. Please add acks when posting new versions.

>  drivers/mmc/host/mmci.c                        | 6 ++++++
>  drivers/mmc/host/mmci.h                        | 1 +
>  3 files changed, 16 insertions(+)
