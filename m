Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C15C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE5B20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUgQcXWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE5B20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeIDOZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:25:00 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39792 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeIDOZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:25:00 -0400
Received: by mail-it0-f66.google.com with SMTP id h1-v6so4040077itj.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WfNlQGfUqOSD2LMZY8vesgBIgskXMBXgl4LedrU26r4=;
        b=UUgQcXWOy7xq7OCi+8l0LNLku7cJmSHQFzFMsU1Y/OfVtZrDRLParlYVIF5WhvBeVO
         99JnQ0f2RXljhb0oIcQ5VW4A/IuQ26HJoEQn013ilZdgGBwAiq6AGkOxtE46AfbFGZTz
         aLwu4vi2KM7Gu3r65CzR1NFHooz5u6/zY4Mo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WfNlQGfUqOSD2LMZY8vesgBIgskXMBXgl4LedrU26r4=;
        b=oiMCFaTGKWfPiE5kM5OaiHLecM9k8YWGvRSS7SdrkXE17GGr3CB2kAsZ012PN2hrr3
         C423RcOts1z0c0ONjej683eaRV8fqOnCVAPUGK1BXo+1FEf5f6gLJW5yIH2kgVhdZo3/
         SZXMPIsjznT0O+gZ/FfTzBVrbJnXIyMcjwYyRAM4VsEACe2/rvQAp4tjCeJ/dIsCQlln
         YVsp3AYHTv83bnIB/miv6oSxEAhPy2i6BhOcZXNGHhdycycNyTUkpLflWsinL4qXrJtq
         Bcq+DKvh6GCR/Sci+BGdOIp1G03965gSy0BEQ4IPce0pW32iBw2w8PXLuUqvlho6iF/J
         oKbg==
X-Gm-Message-State: APzg51DMpJulRU1uolssfhJ5ptye86tgTM0kDDglTvhWAwoDl0/leAXI
        WsIXjDC/Zcsg47Nr6dqmUwJHmXR6zCXG7I35DmPScw==
X-Google-Smtp-Source: ANB0Vdb7oGBmcFIT3tvIZcUO0C8ZIPbSHs/G8LJzI3qb4EU+1iR2+FlB96+uaE1UnE1IRpoYi9TyHZpE2EUO2xYUKUg=
X-Received: by 2002:a24:5f92:: with SMTP id r140-v6mr7566242itb.45.1536055235946;
 Tue, 04 Sep 2018 03:00:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1bd8:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 03:00:35 -0700 (PDT)
In-Reply-To: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Sep 2018 12:00:35 +0200
Message-ID: <CAPDyKFqArwShaUZAit4fHa7F6UNC_z7Yc1GMpBuQcrkkwrB84g@mail.gmail.com>
Subject: Re: [PATCH 00/14] mmc: mmci: prepare dma callbacks with mmci_host_ops
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 August 2018 at 11:36, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch series prepares and adds callbacks for dma transfert at
> mmci_host_ops. This series is composed of 3 parts:
> -Internalize specific needs of legacy dmaengine.
> -Create and setup dma_priv pointer
> -Create generic callbacks  which share some features
> (like cookie...) and call specific needs

I have now reviewed part of this series and provided you with some
comments, but will stop at this point.

Overall, the comments are about renaming and picking better function
names. Those comments should be easy to address in a new version.

However, the other more important point is the number of variant
callbacks you are adding. It's of course a balance to pick the right
level, to get both flexibility but also to avoid open coding. In the
end we don't want to get too many callbacks, but then it's better to
share common mmci code for variants, through mmci.h.

Finally, I would like to see a patch on top adding the support for the
new ST variant, so I can see how the callbacks and changes really are
being used. Can you please add that?

>
> This patch series must be applied on top of
> "mmc: mmci: Add and implement a ->dma_setup() callback for qcom dml"
>
> Ludovic Barre (14):
>   mmc: mmci: fix qcom dma issue during mmci init with new dma_setup
>     callback
>   mmc: mmci: internalize dma map/unmap into mmci dma functions
>   mmc: mmci: internalize dma_inprogress into mmci dma functions
>   mmc: mmci: introduce dma_priv pointer to mmci_host
>   mmc: mmci: move mmci next cookie to mci host
>   mmc: mmci: merge prepare data functions
>   mmc: mmci: add prepare/unprepare_data callbacks
>   mmc: mmci: add get_next_data callback
>   mmc: mmci: modify dma_setup callback
>   mmc: mmci: add dma_release callback
>   mmc: mmci: add dma_start callback
>   mmc: mmci: add dma_finalize callback
>   mmc: mmci: add dma_error callback
>   mmc: mmci: add validate_data callback
>
>  drivers/mmc/host/mmci.c          | 458 ++++++++++++++++++++++++---------------
>  drivers/mmc/host/mmci.h          |  45 ++--
>  drivers/mmc/host/mmci_qcom_dml.c |  15 +-
>  3 files changed, 322 insertions(+), 196 deletions(-)
>
> --
> 2.7.4
>

Kind regards
Uffe
