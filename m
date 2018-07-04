Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCCDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A652F21564
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im7yXsEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A652F21564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeGDRAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:00:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39084 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeGDRAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:00:44 -0400
Received: by mail-pl0-f66.google.com with SMTP id s24-v6so41881plq.6;
        Wed, 04 Jul 2018 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WmCNuQnfXIq3s1NgAiKKWmRRFnYRKumbuMn4+jV6W78=;
        b=Im7yXsELQES1mJg10768WCMLCLt3SALHdb5RZXFE/C08XTsIu7vHrGlzy080HaobSw
         6QnrNJXJH0pxfltqH2j+ezT7dtxk7dMV0vw+3ENb2U7GZl/HZQDJdkdvzQG6GzmCouEn
         GtvJC/0rRegzi4vd+4WnbDCRzXmVVhWIAV292iuSbU0+I1nIAHD3gVUJGLEW3RTmbHF2
         RGLrrist+G/q9OYltJQXgVF8hWrZ6khf3HFk6eTy+Z7nmWLIaTlgTVwjo6sKt2yUuLOD
         Rsd4sEPmGVBsevtwKipz1dQGuPvWDEzs4d9NKOfsFt9ISe35yffv5Ou+FfpZXujTi4la
         /0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WmCNuQnfXIq3s1NgAiKKWmRRFnYRKumbuMn4+jV6W78=;
        b=hb33+6YRFJKJFJOR8gExApivgA+2WqHn4od9kZGRRVTBvuf5iflNTW7OIh2W5hqnhP
         HC8sxwxu3/k95J1CLdX50gV8TyyiC6/gWCAvllddQjobWjMOo/mDdX3Bh67NSvojgWK5
         whGCGJtYWwGrtug+6RmTa/GOoJQDtv8c5lrX5+Z/GWfmeorun93LnL3a9j7N1I7mglSK
         nI/+H9eGmwSPLI2IIAIjywuyrrsui66ah3f/ndFRvsUascOLR2iWaaXD1xSNSzKeq62Y
         8IpuZjMcjj2TSVfV4sDvvc6JEhSrHoW7NgsbK/dF1So5tMHJY5Dn4f8DXW+HiiseZQ+B
         4JfQ==
X-Gm-Message-State: APt69E2b10GVj6mhhVipDIw0wGld+WgW22X9gpKS47MZLTCOjyReZRrA
        /M8UbWD3rbevLIkjpGtH6wsLYiDgK1ra7IqDdOg=
X-Google-Smtp-Source: AAOMgpeAiATEe0IiOPHxhAlzpHF+ycY8wKn3Ggl5XeHi1ess/mPTgJaqZCtQefREufpTlteM4DH9a2XvOJN2FvYQon8=
X-Received: by 2002:a17:902:9a4b:: with SMTP id x11-v6mr2815890plv.342.1530723644342;
 Wed, 04 Jul 2018 10:00:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2604:0:0:0:0 with HTTP; Wed, 4 Jul 2018 10:00:43
 -0700 (PDT)
In-Reply-To: <20180703123214.23090-8-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net> <20180703123214.23090-8-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 4 Jul 2018 22:30:43 +0530
Message-ID: <CANc+2y7BU5SmgP8yv46PQx2E1Bz1gb0dOQaM0wG=-iReCd8YyQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] dmaengine: dma-jz4780: Enable Fast DMA to the AIC
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 July 2018 at 18:02, Paul Cercueil <paul@crapouillou.net> wrote:
> With the fast DMA bit set, the DMA will transfer twice as much data
> per clock period to the AIC, so there is little point not to set it.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/dma/dma-jz4780.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 922e4031e70e..7ee2c121948f 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -52,6 +52,7 @@
>  #define JZ_DMA_DMAC_DMAE       BIT(0)
>  #define JZ_DMA_DMAC_AR         BIT(2)
>  #define JZ_DMA_DMAC_HLT                BIT(3)
> +#define JZ_DMA_DMAC_FAIC       BIT(27)
>  #define JZ_DMA_DMAC_FMSC       BIT(31)
>
>  #define JZ_DMA_DRT_AUTO                0x8
> @@ -929,8 +930,8 @@ static int jz4780_dma_probe(struct platform_device *pdev)
>          * Also set the FMSC bit - it increases MSC performance, so it makes
>          * little sense not to enable it.
>          */
> -       jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC,
> -                         JZ_DMA_DMAC_DMAE | JZ_DMA_DMAC_FMSC);
> +       jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC, JZ_DMA_DMAC_DMAE |
> +                              JZ_DMA_DMAC_FAIC | JZ_DMA_DMAC_FMSC);
>
>         if (jzdma->version == ID_JZ4780)
>                 jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMACP, 0);
> --
> 2.18.0
>
>

Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>.
