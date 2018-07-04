Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC55C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6265121A74
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWuJCAIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6265121A74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeGDQzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:55:04 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39701 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbeGDQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:55:02 -0400
Received: by mail-pf0-f196.google.com with SMTP id s21-v6so3093143pfm.6;
        Wed, 04 Jul 2018 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CLVtE9tBMYNCflR+nwXAn0n1DWoQRkp13nTe5NUaLOY=;
        b=LWuJCAIzui93efOGX4DB2aRmUpBamY7Hl80RjLGEvq/2CLqgd5fULUK7tL8Tk/rBCs
         IVYv7BFpeMchapDmnlxJuGOMo58JWJAuMNGthdjrIUXD71Rll5IyHmn/0XGaoHZR7nfj
         0ZNub6mkM5RHE5xPgW8WI8/LjkgSY1fj629giwlHZQBdYGTkilNz4eAWa4GedAN85Qdy
         /dVXhqcRgrYO7+dqmxRdXQ4E+zEf8aCrhQLXznZtf9zVvG669gVqMyNVC5zBpTdz8DH/
         uGezMltnISZUfb1CnLIVT5XBkT10wTiJJ3tTrbD6nMaS9N+DP6Oa4mzuq97iJYpNazhW
         sCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CLVtE9tBMYNCflR+nwXAn0n1DWoQRkp13nTe5NUaLOY=;
        b=hQ5QnF4RY8ZlGuxKqXyx0MR2f5cfXij3/awSfNrl8eF/J5G0v6x52zy3fv3pAQQB1K
         2gdKPI7mLciEAzE3NisPVo71l5RPoI3Q/AmB9p2EgfMg+x1wkBvCke2yGxbVOitzxnci
         5O1aLLnauh6z8UNr3Q/+O0QfzFgYEoNe2KIK2q1RStnij5XiluZUBnfFYpqKCh0Ee35I
         3CXLkxVKmBusO/vNDEkUIG9lAjStCjl0AC6nDJXBdHdGSJZJvLQtQfqXDf8GMS+76jIn
         XPQ8WYSP9BX7cJrrVcRdgsrOfyMMvG9VoaKMevgGKZNDbEEqGJnN3+RfD2QsoWPmGzVI
         08Dg==
X-Gm-Message-State: APt69E1ZXyVSzSwudDcBHVI2rV3bkrCUf/KbSOeAGNeLJmH+vrjWx/HA
        Ledq3jSvYs8XYg2AiPud0aIMY4NOM/yTHidBHt8=
X-Google-Smtp-Source: AAOMgpdv043Syj+4PpiwDU4+kbPvrmHagETnjurg7riL88HkvrYqSfBKudT7prjg/3Ec+uaZ1Koc8IbRN5sud/nyJzY=
X-Received: by 2002:a63:a1a:: with SMTP id 26-v6mr2598157pgk.221.1530723301471;
 Wed, 04 Jul 2018 09:55:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2604:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:55:01
 -0700 (PDT)
In-Reply-To: <20180703123214.23090-7-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net> <20180703123214.23090-7-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 4 Jul 2018 22:25:01 +0530
Message-ID: <CANc+2y6HFNfbCtzfmfARJ4J6cnvGGZY0KGoeB_R=w-yj5MQYsw@mail.gmail.com>
Subject: Re: [PATCH 06/14] dmaengine: dma-jz4780: Add support for the JZ4725B SoC
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
> The JZ4725B has one DMA core starring six DMA channels.
> As for the JZ4770, each DMA channel's clock can be enabled with
> a register write, the difference here being that once started, it
> is not possible to turn it off.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/dma/jz4780-dma.txt | 1 +
>  drivers/dma/dma-jz4780.c                             | 6 ++++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> index d7ca3f925fdf..5d302b488e88 100644
> --- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> @@ -5,6 +5,7 @@ Required properties:
>  - compatible: Should be one of:
>    * ingenic,jz4780-dma
>    * ingenic,jz4770-dma
> +  * ingenic,jz4725b-dma
>    * ingenic,jz4740-dma
>  - reg: Should contain the DMA channel registers location and length, followed
>    by the DMA controller registers location and length.
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index ccadbe61dde7..922e4031e70e 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -134,6 +134,7 @@ struct jz4780_dma_chan {
>
>  enum jz_version {
>         ID_JZ4740,
> +       ID_JZ4725B,
>         ID_JZ4770,
>         ID_JZ4780,
>  };
> @@ -204,6 +205,8 @@ static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
>  {
>         if (jzdma->version == ID_JZ4770)
>                 jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
> +       else if (jzdma->version == ID_JZ4725B)
> +               jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKE, BIT(chn));
>  }
>
>  static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev *jzdma,
> @@ -249,6 +252,7 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
>
>  static const unsigned int jz4780_dma_ord_max[] = {
>         [ID_JZ4740] = 5,
> +       [ID_JZ4725B] = 5,
>         [ID_JZ4770] = 6,
>         [ID_JZ4780] = 7,
>  };
> @@ -804,12 +808,14 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>
>  static const unsigned int jz4780_dma_nb_channels[] = {
>         [ID_JZ4740] = 6,
> +       [ID_JZ4725B] = 6,
>         [ID_JZ4770] = 6,
>         [ID_JZ4780] = 32,
>  };
>
>  static const struct of_device_id jz4780_dma_dt_match[] = {
>         { .compatible = "ingenic,jz4740-dma", .data = (void *)ID_JZ4740 },
> +       { .compatible = "ingenic,jz4725b-dma", .data = (void *)ID_JZ4725B },
>         { .compatible = "ingenic,jz4770-dma", .data = (void *)ID_JZ4770 },
>         { .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
>         {},
> --
> 2.18.0
>
>

Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
