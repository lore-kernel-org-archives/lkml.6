Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5026EC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1482120645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1482120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbeJLWOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:14:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38489 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeJLWOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:14:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id u197-v6so10029345oif.5;
        Fri, 12 Oct 2018 07:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xNsGhKaWzISIrxhmqLxOj3p3UqLyAN7cEJHul67dkHg=;
        b=bT1wuk6J2nhQanWdSga6eKY9jGCIl1TmyZGsgpM316zU/XG6YI4PwqMFRp8ZAY3Awd
         e07LhxpIWrAjsi8hTPFnR0zjQKhg2kB0JbJPNeQraop5tgZGxkMPULAURHiczp0nPk5l
         Qz+aybormIHkAHyx//Ltd4OnvvQbhM7AfL49PpgZwEqRvCrZkGzztE1J8OWuOcOqVwyE
         p0XTP0J2Il1w4qyEjLdnwP6zO7858BmF2Hm4bhc0DLNt0tRv5sPVKMsXsgEulyL0IU0m
         YRwLaJrDjYv2UiUWbOt3I2Gc6i+o0K7afsig9q5pyiAQlZ7bKPEsgDiPW/zIOxVpkVjj
         6X6g==
X-Gm-Message-State: ABuFfoiDdsPTqoFC7DGwB5FoFH1fF+ERMgDzhW13fT9VERoMZREvUuu7
        HFU8tScEMwm0GqS0IkV1sZvAS6U=
X-Google-Smtp-Source: ACcGV621i3MGD3qGlMv/xxezL2Jcow9EsdklG1+yKdTSkY42IDsodxwvQOhgox2pOuGUbxqpryqCnw==
X-Received: by 2002:aca:895:: with SMTP id 143-v6mr3465753oii.309.1539355326351;
        Fri, 12 Oct 2018 07:42:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 65sm366263ott.63.2018.10.12.07.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 07:42:05 -0700 (PDT)
Date:   Fri, 12 Oct 2018 09:42:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: stm32-dma: Add DMA/MDMA chaining
 support bindings
Message-ID: <20181012144204.GA13615@bogus>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-2-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538139715-24406-2-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 03:01:49PM +0200, Pierre-Yves MORDRET wrote:
> From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> 
> This patch adds dma bindings to support DMA/MDMA chaining transfer.
> 1 bit is to manage both DMA FIFO Threshold
> 1 bit is to manage DMA/MDMA Chaining features.
> 2 bits are used to specify SDRAM size to use for DMA/MDMA chaining.
> The size in bytes of a certain order is given by the formula:
>     (2 ^ order) * PAGE_SIZE.
> The order is given by those 2 bits.
> For cyclic, whether chaining is chosen, any value above 1 can be set :
> SRAM buffer size will rely on period size and not on this DT value.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Missing author S-o-b.

> ---
>   Version history:
>     v3:
>     v2:
>        * rework content
>     v1:
>        * Initial
> ---
> ---
>  .../devicetree/bindings/dma/stm32-dma.txt          | 27 +++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
