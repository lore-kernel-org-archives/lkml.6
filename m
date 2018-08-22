Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD60CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B89217B4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pc/zZgFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B89217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeHVGU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 02:20:56 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42193 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbeHVGU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 02:20:56 -0400
Received: by mail-oi0-f66.google.com with SMTP id q204-v6so798139oig.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 19:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zwM9pVCB7kPNP+9WMo0dDlig9v/HPxM18HffxeaFBTc=;
        b=Pc/zZgFRjkFMPtfQDJwi329lRep17o81kTdvnq7gH7aMzKqxSCXalswnIlx22XxN9e
         meNHkAsmrlIQ38/kyjXYHOXn5rReWG/n/CH1vnwcueIicDGVgEFdgN2iaMbw8t0XTXoV
         W8Pf9MudYN82azqio1TkzR9T2JzstlJE+5SGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zwM9pVCB7kPNP+9WMo0dDlig9v/HPxM18HffxeaFBTc=;
        b=Uv/ZKaA/7aCczNlIDT+NSsjGrG+eaD1ai6zijOGPhaJRiBhjdZ5qePLWrx/SP+wWPx
         0te7DpzLIMJ/+vb2y7GtD3aRqJ/JFXJHZiu5Uapc9BZTliucD+sK97ESmHRUFhjIKcN4
         PiE2+Wn44CCnauZ1flLxrUCNfdq09SlMloNOHRmjqCdHt9v1SzPfTHB+41uveMXfZVDa
         lJjF64aiwZyGEk2nP/2W33z5B6VlfhEfksf3Dm6qp3t/mvWBRMVR+3TBvWe5WB3H/yo/
         nL4gclMnsaa+Ir3I8YKz+XaYvK3Wc7mcRFLkIdzwhZkU2etwiW2xXcDhmoMvDuEIWNIO
         u8SA==
X-Gm-Message-State: APzg51AtWMJR0mvOyaIpreX+8dtQHXWTO9ryKFgE4uZNZTFZWUwjEp1I
        ed0RWn3xJfGGVadHSGyx5lTHiORb7aF/NggAslw/KRo5834=
X-Google-Smtp-Source: ANB0VdbbYY2aYKOYPcgrB+pwgLlGqX8b3ObBXtKbptMcbCKtu8uD9MX4Wgr3yLxPXBsBUhystmvDRHzZHxcCJ365M+4=
X-Received: by 2002:aca:ef87:: with SMTP id n129-v6mr2175254oih.161.1534906685996;
 Tue, 21 Aug 2018 19:58:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:29:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 19:58:05 -0700 (PDT)
In-Reply-To: <020f43e52e007086169a19e253ede1828e4414d5.1533798144.git.baolin.wang@linaro.org>
References: <020f43e52e007086169a19e253ede1828e4414d5.1533798144.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 22 Aug 2018 10:58:05 +0800
Message-ID: <CAMz4ku+u5T-h9xK2t7b-2TFKQmv7bPZEnfjQhy=xCmhc4uz2WQ@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: sprd: Support DMA link-list mode
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Long <eric.long@spreadtrum.com>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 9 August 2018 at 15:05, Baolin Wang <baolin.wang@linaro.org> wrote:
> From: Eric Long <eric.long@spreadtrum.com>
>
> The Spreadtrum DMA can support the link-list transaction mode, which means
> DMA controller can do transaction one by one automatically once we linked
> these transaction by link-list register.
>
> Signed-off-by: Eric Long <eric.long@spreadtrum.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v1:
>  - Remove sprd_dma_fill_chn_desc() function.
>  - Remove the redundant validation of 'sglen' in sprd_dma_fill_linklist_desc().
>  - Add some comments make code more clear.
>  - Fix the typos.
> ---

Do you have any comments for the v2 patch? Thanks.

>  drivers/dma/sprd-dma.c       |   81 ++++++++++++++++++++++++++++++++++++++----
>  include/linux/dma/sprd-dma.h |   69 +++++++++++++++++++++++++++++++++++
>  2 files changed, 143 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 55df0d4..38d4e4f 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -68,6 +68,7 @@
>
>  /* SPRD_DMA_CHN_CFG register definition */
>  #define SPRD_DMA_CHN_EN                        BIT(0)
> +#define SPRD_DMA_LINKLIST_EN           BIT(4)
>  #define SPRD_DMA_WAIT_BDONE_OFFSET     24
>  #define SPRD_DMA_DONOT_WAIT_BDONE      1
>
> @@ -103,7 +104,7 @@
>  #define SPRD_DMA_REQ_MODE_MASK         GENMASK(1, 0)
>  #define SPRD_DMA_FIX_SEL_OFFSET                21
>  #define SPRD_DMA_FIX_EN_OFFSET         20
> -#define SPRD_DMA_LLIST_END_OFFSET      19
> +#define SPRD_DMA_LLIST_END             BIT(19)
>  #define SPRD_DMA_FRG_LEN_MASK          GENMASK(16, 0)
>
>  /* SPRD_DMA_CHN_BLK_LEN register definition */
> @@ -164,6 +165,7 @@ struct sprd_dma_desc {
>  struct sprd_dma_chn {
>         struct virt_dma_chan    vc;
>         void __iomem            *chn_base;
> +       struct sprd_dma_linklist        linklist;
>         struct dma_slave_config slave_cfg;
>         u32                     chn_num;
>         u32                     dev_id;
> @@ -582,7 +584,8 @@ static int sprd_dma_get_step(enum dma_slave_buswidth buswidth)
>  }
>
>  static int sprd_dma_fill_desc(struct dma_chan *chan,
> -                             struct sprd_dma_desc *sdesc,
> +                             struct sprd_dma_chn_hw *hw,
> +                             unsigned int sglen, int sg_index,
>                               dma_addr_t src, dma_addr_t dst, u32 len,
>                               enum dma_transfer_direction dir,
>                               unsigned long flags,
> @@ -590,7 +593,6 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>  {
>         struct sprd_dma_dev *sdev = to_sprd_dma_dev(chan);
>         struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> -       struct sprd_dma_chn_hw *hw = &sdesc->chn_hw;
>         u32 req_mode = (flags >> SPRD_DMA_REQ_SHIFT) & SPRD_DMA_REQ_MODE_MASK;
>         u32 int_mode = flags & SPRD_DMA_INT_MASK;
>         int src_datawidth, dst_datawidth, src_step, dst_step;
> @@ -670,12 +672,52 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>         temp |= (src_step & SPRD_DMA_TRSF_STEP_MASK) << SPRD_DMA_SRC_TRSF_STEP_OFFSET;
>         hw->trsf_step = temp;
>
> +       /* link-list configuration */
> +       if (schan->linklist.phy_addr) {
> +               if (sg_index == sglen - 1)
> +                       hw->frg_len |= SPRD_DMA_LLIST_END;
> +
> +               hw->cfg |= SPRD_DMA_LINKLIST_EN;
> +
> +               /* link-list index */
> +               temp = (sg_index + 1) % sglen;
> +               /* Next link-list configuration's physical address offset */
> +               temp = temp * sizeof(*hw) + SPRD_DMA_CHN_SRC_ADDR;
> +               /*
> +                * Set the link-list pointer point to next link-list
> +                * configuration's physical address.
> +                */
> +               hw->llist_ptr = schan->linklist.phy_addr + temp;
> +       } else {
> +               hw->llist_ptr = 0;
> +       }
> +
>         hw->frg_step = 0;
>         hw->src_blk_step = 0;
>         hw->des_blk_step = 0;
>         return 0;
>  }
>
> +static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
> +                                      unsigned int sglen, int sg_index,
> +                                      dma_addr_t src, dma_addr_t dst, u32 len,
> +                                      enum dma_transfer_direction dir,
> +                                      unsigned long flags,
> +                                      struct dma_slave_config *slave_cfg)
> +{
> +       struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> +       struct sprd_dma_chn_hw *hw;
> +
> +       if (!schan->linklist.virt_addr)
> +               return -EINVAL;
> +
> +       hw = (struct sprd_dma_chn_hw *)(schan->linklist.virt_addr +
> +                                       sg_index * sizeof(*hw));
> +
> +       return sprd_dma_fill_desc(chan, hw, sglen, sg_index, src, dst, len,
> +                                 dir, flags, slave_cfg);
> +}
> +
>  static struct dma_async_tx_descriptor *
>  sprd_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>                          size_t len, unsigned long flags)
> @@ -744,10 +786,20 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>         u32 len = 0;
>         int ret, i;
>
> -       /* TODO: now we only support one sg for each DMA configuration. */
> -       if (!is_slave_direction(dir) || sglen > 1)
> +       if (!is_slave_direction(dir))
>                 return NULL;
>
> +       if (context) {
> +               struct sprd_dma_linklist *ll_cfg =
> +                       (struct sprd_dma_linklist *)context;
> +
> +               schan->linklist.phy_addr = ll_cfg->phy_addr;
> +               schan->linklist.virt_addr = ll_cfg->virt_addr;
> +       } else {
> +               schan->linklist.phy_addr = 0;
> +               schan->linklist.virt_addr = 0;
> +       }
> +
>         sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
>         if (!sdesc)
>                 return NULL;
> @@ -762,10 +814,25 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>                         src = slave_cfg->src_addr;
>                         dst = sg_dma_address(sg);
>                 }
> +
> +               /*
> +                * The link-list mode needs at least 2 link-list
> +                * configurations. If there is only one sg, it doesn't
> +                * need to fill the link-list configuration.
> +                */
> +               if (sglen < 2)
> +                       break;
> +
> +               ret = sprd_dma_fill_linklist_desc(chan, sglen, i, src, dst, len,
> +                                                 dir, flags, slave_cfg);
> +               if (ret) {
> +                       kfree(sdesc);
> +                       return NULL;
> +               }
>         }
>
> -       ret = sprd_dma_fill_desc(chan, sdesc, src, dst, len, dir, flags,
> -                                slave_cfg);
> +       ret = sprd_dma_fill_desc(chan, &sdesc->chn_hw, 0, 0, src, dst, len,
> +                                dir, flags, slave_cfg);
>         if (ret) {
>                 kfree(sdesc);
>                 return NULL;
> diff --git a/include/linux/dma/sprd-dma.h b/include/linux/dma/sprd-dma.h
> index b0115e3..b42b80e5 100644
> --- a/include/linux/dma/sprd-dma.h
> +++ b/include/linux/dma/sprd-dma.h
> @@ -58,4 +58,73 @@ enum sprd_dma_int_type {
>         SPRD_DMA_CFGERR_INT,
>  };
>
> +/*
> + * struct sprd_dma_linklist - DMA link-list address structure
> + * @virt_addr: link-list virtual address to configure link-list node
> + * @phy_addr: link-list physical address to link DMA transfer
> + *
> + * The Spreadtrum DMA controller supports the link-list mode, that means slaves
> + * can supply several groups configurations (each configuration represents one
> + * DMA transfer) saved in memory, and DMA controller will link these groups
> + * configurations by writing the physical address of each configuration into the
> + * link-list register.
> + *
> + * Just as shown below, the link-list pointer register will be pointed to the
> + * physical address of 'configuration 1', and the 'configuration 1' link-list
> + * pointer will be pointed to 'configuration 2', and so on.
> + * Once trigger the DMA transfer, the DMA controller will load 'configuration
> + * 1' to its registers automatically, after 'configuration 1' transaction is
> + * done, DMA controller will load 'configuration 2' automatically, until all
> + * DMA transactions are done.
> + *
> + * Note: The last link-list pointer should point to the physical address
> + * of 'configuration 1', which can avoid DMA controller loads incorrect
> + * configuration when the last configuration transaction is done.
> + *
> + *     DMA controller                    linklist memory
> + * ======================             -----------------------
> + *|                      |           |    configuration 1    |<---
> + *|   DMA controller     |   ------->|                       |   |
> + *|                      |   |       |                       |   |
> + *|                      |   |       |                       |   |
> + *|                      |   |       |                       |   |
> + *| linklist pointer reg |----   ----|    linklist pointer   |   |
> + * ======================        |    -----------------------    |
> + *                               |                               |
> + *                               |    -----------------------    |
> + *                               |   |    configuration 2    |   |
> + *                               --->|                       |   |
> + *                                   |                       |   |
> + *                                   |                       |   |
> + *                                   |                       |   |
> + *                               ----|    linklist pointer   |   |
> + *                               |    -----------------------    |
> + *                               |                               |
> + *                               |    -----------------------    |
> + *                               |   |    configuration 3    |   |
> + *                               --->|                       |   |
> + *                                   |                       |   |
> + *                                   |           .           |   |
> + *                                               .               |
> + *                                               .               |
> + *                                               .               |
> + *                               |               .               |
> + *                               |    -----------------------    |
> + *                               |   |    configuration n    |   |
> + *                               --->|                       |   |
> + *                                   |                       |   |
> + *                                   |                       |   |
> + *                                   |                       |   |
> + *                                   |    linklist pointer   |----
> + *                                    -----------------------
> + *
> + * To support the link-list mode, DMA slaves should allocate one segment memory
> + * from always-on IRAM or dma coherent memory to store these groups of DMA
> + * configuration, and pass the virtual and physical address to DMA controller.
> + */
> +struct sprd_dma_linklist {
> +       unsigned long virt_addr;
> +       phys_addr_t phy_addr;
> +};
> +
>  #endif
> --
> 1.7.9.5
>



-- 
Baolin Wang
Best Regards
