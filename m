Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC016C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7ECB21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548322363;
	bh=fhy1RiMMv7O0B8kgR+D7cbta1wJy/Rqf55vbyr6oGlk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MlkuoDoU+C+5Vny68sco7XdvbDt4FJr5FgE/zM2A2Q+H4VicyLxkyJvWqnPECf57o
	 oeraBLnBOewEl9vN78vlMqh4Rf/x3UiPA4Hb6lOO1DZP+lyO0iee2h9R/ZyaBFHYKa
	 p8IpBYgRKMXfhvmIAXnNVf6qsmO8pTNQhg7W3zbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfAXJcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:32:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfAXJcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:32:41 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E1821872;
        Thu, 24 Jan 2019 09:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548322359;
        bh=fhy1RiMMv7O0B8kgR+D7cbta1wJy/Rqf55vbyr6oGlk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BcBMPq0uMSMX4b3ncEzSSKlAHQd5iz+vpgrvVe6fWU8KFgE1Q2kMS0CiW7nPX1oX5
         1Gnyj9VnksqPQlzcm658hmAPPAqKHM3lP0BMDAJvGJj3/qR9W8ir3DYH3pHTDmT+jU
         eA61/fuUfOj9yNDvUJD3T59qceyyyybsDeneOUrk=
Received: by mail-wr1-f53.google.com with SMTP id p7so5704617wru.0;
        Thu, 24 Jan 2019 01:32:39 -0800 (PST)
X-Gm-Message-State: AJcUukcTeXh+GFntmMKVHgwCL1lupdYjyy7GvwjDO+hk7ITuyxmnoLkg
        qPdU8Yt19Db3ksN+ZBPNXR2Ql+IXa/Ni9+4A8lY=
X-Google-Smtp-Source: ALg8bN4aUHzg3ISzP/wUfub2hpAjEJh3tf4xOVOq9ajY467CUvzkM4YRQCi1jgBZjh55ND3KCNbk/Ke8L8FP+9sACZ8=
X-Received: by 2002:adf:f28d:: with SMTP id k13mr6634956wro.78.1548322357680;
 Thu, 24 Jan 2019 01:32:37 -0800 (PST)
MIME-Version: 1.0
References: <1548314060-4833-1-git-send-email-shun-chih.yu@mediatek.com>
In-Reply-To: <1548314060-4833-1-git-send-email-shun-chih.yu@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 24 Jan 2019 01:35:01 -0800
X-Gmail-Original-Message-ID: <CAGp9LzqMbYOXCEmHOEcCboQLfpXwxH7zcJ3snj4a8NBLiHhQdg@mail.gmail.com>
Message-ID: <CAGp9LzqMbYOXCEmHOEcCboQLfpXwxH7zcJ3snj4a8NBLiHhQdg@mail.gmail.com>
Subject: Re: [PATCH v5] add support for Mediatek Command-Queue DMA controller
 on MT6765 SoC
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

Hi Shun-Chih,

the driver seems already be applied since v5.0-rc1

I suggest these improvements you made in the recent version can be
split into several patches and then be applied on the top of the base
driver.

On Wed, Jan 23, 2019 at 11:15 PM <shun-chih.yu@mediatek.com> wrote:
>
> This patchset introduces support for MediaTek Command-Queue DMA controller.
>
> MediaTek Command-Queue DMA controller (CQDMA) on MT6765 SoC is dedicated to memory-to-memory transfer through queue-based descriptor management.
>
> There are only 3 physical channels inside CQDMA, while the driver is extended to support 32 virtual channels for multiple dma users to issue dma requests onto the CQDMA simultaneously.
>
> dmatest result:
> dmatest: dma0chan0-copy2: summary 5000 tests, 0 failures 3500 iops 28037 KB/s (0)
> dmatest: dma0chan0-copy4: summary 5000 tests, 0 failures 3494 iops 27612 KB/s (0)
> dmatest: dma0chan0-copy1: summary 5000 tests, 0 failures 3491 iops 27749 KB/s (0)
> dmatest: dma0chan0-copy7: summary 5000 tests, 0 failures 3673 iops 29092 KB/s (0)
> dmatest: dma0chan0-copy6: summary 5000 tests, 0 failures 3763 iops 30237 KB/s (0)
> dmatest: dma0chan0-copy0: summary 5000 tests, 0 failures 3730 iops 30131 KB/s (0)
> dmatest: dma0chan0-copy3: summary 5000 tests, 0 failures 3717 iops 29569 KB/s (0)
> dmatest: dma0chan0-copy5: summary 5000 tests, 0 failures 3699 iops 29302 KB/s (0)
>
> Changes since v4:
> - remove redundant queue structure in mtk_cqdma_pchan
> - remove redundant completion management
> - fix wrong residue assignment in mtk_cqdma_tx_status
> - fix typos
>
> Changes since v3:
> - simplify the ISR and management on descriptors by removing tasklet and ASYNC_TX_ENABLE_CHANNEL_SWITCH
> - remove useless field in mtk_cqdma_vdesc structure
> - change dev_info to dev_dbg
> - fix typos
>
> Changes since v2:
> - fix build warning for kernel with DMA address in 32-bit
>
> Changes since v1:
> - remove unused macros, typos
> - leverage ASYNC_TX_ENABLE_CHANNEL_SWITCH to maintain DMA descriptor list
>
> Shun-Chih Yu (2):
>   dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller
>     bindings
>   dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for
>     MT6765 SoC
>
>  .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 +
>  drivers/dma/mediatek/Kconfig                       |   12 +
>  drivers/dma/mediatek/Makefile                      |    1 +
>  drivers/dma/mediatek/mtk-cqdma.c                   |  748 ++++++++++++++++++++
>  4 files changed, 792 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt
>  create mode 100644 drivers/dma/mediatek/mtk-cqdma.c
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
