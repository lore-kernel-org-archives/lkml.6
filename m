Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F97BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3B221855
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548388358;
	bh=QjJfJAWb0FZ5pqq41y0/x0xjclMd9L8cJJNHUvy33U4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qAqY9BGIQwf0fto6eEy/Fgi6leHGoeoX98mfoUi05hBjAZ0KDok3r0yHixvu9P4RT
	 HoYDJ/MildDATkoZpFOQJuczmbFmhkMYJUGVaBxy1CSHEt4MjQbv4BjurVwLZKPSvi
	 XGebwHoYEeimgnhiok+mIo+gyg5Iv2chVP3I9slg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfAYDwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfAYDwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:52:35 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E5F4218DE;
        Fri, 25 Jan 2019 03:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548388354;
        bh=QjJfJAWb0FZ5pqq41y0/x0xjclMd9L8cJJNHUvy33U4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gb1CXkOycEV5lU97KyTzF1Fn8MVf0CwXq/0vWC5zlyx97oMpW9OCads+gBzFqCQs5
         P5mu0iMPQv94pABP91vGkYLQQniMqqkY2I7NY7IWx8h7XTH6R94yMK9E9xRGwO6vS5
         EhXJ0i9glgU7mKDCDYD+yVnMQa4jVZ4xXT6epW8s=
Received: by mail-wr1-f50.google.com with SMTP id s12so8778303wrt.4;
        Thu, 24 Jan 2019 19:52:34 -0800 (PST)
X-Gm-Message-State: AJcUukfDMyC0qGL6LdcpDTPvR1NATnK75OHVQ0WTHOlkKj6MhjafT+rw
        KFNARj0wrEGJnbaOuDITqVxi4XQrBmc7/iriy6g=
X-Google-Smtp-Source: ALg8bN5yvgt59covVG6lIFn3cW7Zt6kKnn0KEC8w6n6KayED8ss+qwnOw9vxugt3wTC3U75xUMkQtbxwtm+rsoQbPpk=
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr9370428wru.291.1548388353048;
 Thu, 24 Jan 2019 19:52:33 -0800 (PST)
MIME-Version: 1.0
References: <1548326680-16454-1-git-send-email-shun-chih.yu@mediatek.com> <1548326680-16454-2-git-send-email-shun-chih.yu@mediatek.com>
In-Reply-To: <1548326680-16454-2-git-send-email-shun-chih.yu@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 24 Jan 2019 19:52:21 -0800
X-Gmail-Original-Message-ID: <CAGp9LzofToojhoXL9DpbrF-GKcxnGX7VBKrTq27SF8uGYnQOMg@mail.gmail.com>
Message-ID: <CAGp9LzofToojhoXL9DpbrF-GKcxnGX7VBKrTq27SF8uGYnQOMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: Add MediaTek Command-Queue
 DMA controller bindings
To:     shun-chih.yu@mediatek.com
Cc:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        srv_wsdupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You dropped the version tag that doesn't reflect that is a newer one
and that would be easily ignored by other people

On Thu, Jan 24, 2019 at 2:46 AM <shun-chih.yu@mediatek.com> wrote:
>
> From: Shun-Chih Yu <shun-chih.yu@mediatek.com>
>
> Document the devicetree bindings for MediaTek Command-Queue DMA controller
> which could be found on MT6765 SoC or other similar Mediatek SoCs.
>
> Signed-off-by: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

otherwise, Acked-by: Sean Wang <sean.wang@kernel.org>

> ---
>  .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt
>
> diff --git a/Documentation/devicetree/bindings/dma/mtk-cqdma.txt b/Documentation/devicetree/bindings/dma/mtk-cqdma.txt
> new file mode 100644
> index 0000000..fb12927
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mtk-cqdma.txt
> @@ -0,0 +1,31 @@
> +MediaTek Command-Queue DMA Controller
> +==================================
> +
> +Required properties:
> +
> +- compatible:  Must be "mediatek,mt6765-cqdma" for MT6765.
> +- reg:         Should contain the base address and length for each channel.
> +- interrupts:  Should contain references to the interrupts for each channel.
> +- clocks:      Should be the clock specifiers corresponding to the entry in
> +               clock-names property.
> +- clock-names: Should contain "cqdma" entries.
> +- dma-channels: The number of DMA channels supported by the controller.
> +- dma-requests: The number of DMA request supported by the controller.
> +- #dma-cells:  The length of the DMA specifier, must be <1>. This one cell
> +               in dmas property of a client device represents the channel
> +               number.
> +Example:
> +
> +        cqdma: dma-controller@10212000 {
> +               compatible = "mediatek,mt6765-cqdma";
> +               reg = <0 0x10212000 0 0x1000>;
> +               interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
> +                       <GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
> +               clocks = <&infracfg CLK_IFR_CQ_DMA>;
> +               clock-names = "cqdma";
> +               dma-channels = <2>;
> +               dma-requests = <32>;
> +               #dma-cells = <1>;
> +       };
> +
> +DMA clients must use the format described in dma/dma.txt file.
> --
> 1.7.9.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
