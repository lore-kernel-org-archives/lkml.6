Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2690C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E615208E9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA5ZTVty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E615208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeGDQwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:52:30 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34179 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeGDQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:52:28 -0400
Received: by mail-pf0-f196.google.com with SMTP id e10-v6so3093831pfn.1;
        Wed, 04 Jul 2018 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fGWUjIyQjivT5mY8dhmiKszGTEUsn3DD9lSHrF6HmJE=;
        b=kA5ZTVtyRe0NIu4QfY3UFI7oxr9JkFjMxPLho5hKn8KbVX03amMSJqYYBlnl4ZMxwc
         NoiPbg3j6QHGoYaGwxMQ4AXMdhwZwHJFplXTBFI67tWA9/1PRQMap3w3+hFQGHmd+/nZ
         PprXYdxWuL8iDLeZ2AojI+yQMqTl0PReLbG8cMrqHCEM/F9rFNmDXjpbYU6f7KkKuo4a
         IwdM+Ejb44Kivqp3EfWtb9gXa9RqC3JxQy0yGh7u5lJP4nVsz4dlmSgNK6BITgpjHDvC
         HLNgCMhsRXBdrngqzVfl2yvc9EhkOYfWfqDxG4Q5TBUwC0jW/abe4ouAb3u1LbobyhLh
         DJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fGWUjIyQjivT5mY8dhmiKszGTEUsn3DD9lSHrF6HmJE=;
        b=ckwmFqgZsRxUZUjxbRWACX9UUTWPYTewFgjt/5bk3p58mKXqtL+rkvP78Y9ZMlSt/t
         39goUjUI1dXBsm4FKNVVg3jbxY7usSXHS8BzlID0KyULmXI32QrYdwGqN+uMBCnsYiju
         GwPWjZ3sDQ+arjTVsZNjYDLZdc6d786gwq7Lxg5foyc96f8qLaVaY49FjIRmijjkIhk0
         xPa3wpt7jbRvp2G+ycD/SvOJMe8PPiUASPgbNdr++hs2R+fW8fyMJMSkkRTW7/UwaQSO
         uO3kBqsp1J43LssFk6RNU53VlPQPQQYaTdx5+vFPzeKyFM2fy1hvOz3EtMjoYQqas9sF
         dDCg==
X-Gm-Message-State: APt69E276uCyNj1wKFkUbkY6WgpGZlUXVIjxUgwLJIJFg1fJOqoOmk4q
        1fcFjf+pYCtRl4S0+J7DyJm7o6bm4ilqGNIegDA=
X-Google-Smtp-Source: AAOMgpeaV4hJ1nP9OJ1yZJQflDSfZnXwRBYmWFmwbxjj+RKrn8u2C+K1KuywszG17+yJoVA+Sdbgv6nLE0SsL85Xcns=
X-Received: by 2002:a63:b349:: with SMTP id x9-v6mr2575063pgt.337.1530723148220;
 Wed, 04 Jul 2018 09:52:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2604:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:52:27
 -0700 (PDT)
In-Reply-To: <20180703123214.23090-6-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net> <20180703123214.23090-6-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 4 Jul 2018 22:22:27 +0530
Message-ID: <CANc+2y4L3WPUn39fmy+D=vYT7jwYcc+0Ox3sZ8V6cyM511UmhQ@mail.gmail.com>
Subject: Re: [PATCH 05/14] dmaengine: dma-jz4780: Add support for the JZ4740 SoC
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
> The JZ4740 SoC has a single DMA core starring six DMA channels.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/dma/jz4780-dma.txt | 1 +
>  drivers/dma/Kconfig                                  | 2 +-
>  drivers/dma/dma-jz4780.c                             | 4 ++++
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> index 0fd0759053be..d7ca3f925fdf 100644
> --- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> @@ -5,6 +5,7 @@ Required properties:
>  - compatible: Should be one of:
>    * ingenic,jz4780-dma
>    * ingenic,jz4770-dma
> +  * ingenic,jz4740-dma
>  - reg: Should contain the DMA channel registers location and length, followed
>    by the DMA controller registers location and length.
>  - interrupts: Should contain the interrupt specifier of the DMA controller.
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 48d25dccedb7..a935d15ec581 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -143,7 +143,7 @@ config DMA_JZ4740
>
>  config DMA_JZ4780
>         tristate "JZ4780 DMA support"
> -       depends on MACH_JZ4780 || MACH_JZ4770 || COMPILE_TEST
> +       depends on MACH_INGENIC || COMPILE_TEST
>         select DMA_ENGINE
>         select DMA_VIRTUAL_CHANNELS
>         help
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 7b8b2dcd119e..ccadbe61dde7 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -133,6 +133,7 @@ struct jz4780_dma_chan {
>  };
>
>  enum jz_version {
> +       ID_JZ4740,
>         ID_JZ4770,
>         ID_JZ4780,
>  };
> @@ -247,6 +248,7 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
>  }
>
>  static const unsigned int jz4780_dma_ord_max[] = {
> +       [ID_JZ4740] = 5,
>         [ID_JZ4770] = 6,
>         [ID_JZ4780] = 7,
>  };
> @@ -801,11 +803,13 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>  }
>
>  static const unsigned int jz4780_dma_nb_channels[] = {
> +       [ID_JZ4740] = 6,
>         [ID_JZ4770] = 6,
>         [ID_JZ4780] = 32,
>  };
>
>  static const struct of_device_id jz4780_dma_dt_match[] = {
> +       { .compatible = "ingenic,jz4740-dma", .data = (void *)ID_JZ4740 },
>         { .compatible = "ingenic,jz4770-dma", .data = (void *)ID_JZ4770 },
>         { .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
>         {},
> --
> 2.18.0
>
>

Patch looks good to me.
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>/
