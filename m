Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9411EC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307BD21C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YEuoSs9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307BD21C2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeHIFz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 01:55:27 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33350 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHIFz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 01:55:27 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so7538880oip.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 20:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zWwyWUGto++RYf4LOKf3EMvTZa18AnADT4Odf69v8Aw=;
        b=YEuoSs9q1gWd/TII+7QNrHT8nJ5lrmGagr4aLIexkkW9JdHB9YQvu6nu1RAwZosERL
         2dSxmR85uFQ8UsVXWI/VpeGRSssn+3mkN5mX6g+0CrR1ZXyQr4P5n8RwTHo+mb827kPB
         dYL74oCyJc90dBisc3E9dd0aSXwTYDF87VXGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zWwyWUGto++RYf4LOKf3EMvTZa18AnADT4Odf69v8Aw=;
        b=SfyygBeg9RsbtKXCe9QbvK5NBTxxafO2Y1BrtMOxEyrcXu+3INZto5Av7bdU1SPq8p
         xwRpScpUMNYDxotYffqwQhz1PdPBeTO7V2AREiFhfUDfQCUrOcty0uXczbKFcc4Aer+x
         geIE8cUaDJvvS//8hKykgdHU/6KyP9z+UIwGPEf+Xukbjg+Q++MDhQ0HOrzxb2FVGSHx
         urve4QDUKeD47dAR95wuogX7Nz5HYPEzffqQDEgP/++jQatrPKT5M9+WtjMlr62xPjxi
         rD3ZPhP0euQyuwCuGZY7BpXBBHkt9eigjSDZcJS+fMTiM2l06HCjoapTno539OyzYC1V
         Eqgg==
X-Gm-Message-State: AOUpUlEgx6ZZSaPojxVnYv4YmAA7e9rsix/ZnB0vPfm1GsKo/FNACsGv
        itTrypGnAhtOpqcHpgnnht1+sFR4VuewENXcxUh1XA==
X-Google-Smtp-Source: AA+uWPwqvwTeYFB3S3Ty4pWxzEGZc1TB/7E0D68NYGixZC+olL1FMgxhIS0OKR97/eAWtm3Id2CFyUdrPKDb0vKbAY4=
X-Received: by 2002:aca:dd07:: with SMTP id u7-v6mr357505oig.177.1533785566566;
 Wed, 08 Aug 2018 20:32:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 20:32:46 -0700 (PDT)
In-Reply-To: <20180809023215.GO2395@vkoul-mobl>
References: <78730daa2eaa66fa8089f196a52b51ce62579d1f.1532591566.git.baolin.wang@linaro.org>
 <20180809023215.GO2395@vkoul-mobl>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 9 Aug 2018 11:32:46 +0800
Message-ID: <CAMz4kuKeW=Jfb0PMqvw03Ub3f08Os+O9Yy0ahELO-jpa+rMr9g@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sprd: Support DMA link-list mode
To:     Vinod <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

(Comments from Eric Long)
On 9 August 2018 at 10:32, Vinod <vkoul@kernel.org> wrote:
> On 26-07-18, 16:00, Baolin Wang wrote:
>> From: Eric Long <eric.long@spreadtrum.com>
>>
>> The Spreadtrum DMA can support the link-list transaction mode, which means
>> DMA controller can do transaction one by one automatically once we linked
>> these transaction by link-list register.
>>
>> Signed-off-by: Eric Long <eric.long@spreadtrum.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/dma/sprd-dma.c       |   82 ++++++++++++++++++++++++++++++++++++++----
>>  include/linux/dma/sprd-dma.h |   69 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 144 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
>> index 55df0d4..649bd2c 100644
>> --- a/drivers/dma/sprd-dma.c
>> +++ b/drivers/dma/sprd-dma.c
>> @@ -68,6 +68,7 @@
>>
>>  /* SPRD_DMA_CHN_CFG register definition */
>>  #define SPRD_DMA_CHN_EN                      BIT(0)
>> +#define SPRD_DMA_LINKLIST_EN         BIT(4)
>>  #define SPRD_DMA_WAIT_BDONE_OFFSET   24
>>  #define SPRD_DMA_DONOT_WAIT_BDONE    1
>>
>> @@ -103,7 +104,7 @@
>>  #define SPRD_DMA_REQ_MODE_MASK               GENMASK(1, 0)
>>  #define SPRD_DMA_FIX_SEL_OFFSET              21
>>  #define SPRD_DMA_FIX_EN_OFFSET               20
>> -#define SPRD_DMA_LLIST_END_OFFSET    19
>> +#define SPRD_DMA_LLIST_END           BIT(19)
>>  #define SPRD_DMA_FRG_LEN_MASK                GENMASK(16, 0)
>>
>>  /* SPRD_DMA_CHN_BLK_LEN register definition */
>> @@ -164,6 +165,7 @@ struct sprd_dma_desc {
>>  struct sprd_dma_chn {
>>       struct virt_dma_chan    vc;
>>       void __iomem            *chn_base;
>> +     struct sprd_dma_linklist        linklist;
>>       struct dma_slave_config slave_cfg;
>>       u32                     chn_num;
>>       u32                     dev_id;
>> @@ -582,7 +584,8 @@ static int sprd_dma_get_step(enum dma_slave_buswidth buswidth)
>>  }
>>
>>  static int sprd_dma_fill_desc(struct dma_chan *chan,
>> -                           struct sprd_dma_desc *sdesc,
>> +                           struct sprd_dma_chn_hw *hw,
>> +                           unsigned int sglen, int sg_index,
>>                             dma_addr_t src, dma_addr_t dst, u32 len,
>>                             enum dma_transfer_direction dir,
>>                             unsigned long flags,
>> @@ -590,7 +593,6 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>>  {
>>       struct sprd_dma_dev *sdev = to_sprd_dma_dev(chan);
>>       struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
>> -     struct sprd_dma_chn_hw *hw = &sdesc->chn_hw;
>>       u32 req_mode = (flags >> SPRD_DMA_REQ_SHIFT) & SPRD_DMA_REQ_MODE_MASK;
>>       u32 int_mode = flags & SPRD_DMA_INT_MASK;
>>       int src_datawidth, dst_datawidth, src_step, dst_step;
>> @@ -670,12 +672,58 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>>       temp |= (src_step & SPRD_DMA_TRSF_STEP_MASK) << SPRD_DMA_SRC_TRSF_STEP_OFFSET;
>>       hw->trsf_step = temp;
>>
>> +     /* link-list configuration */
>> +     if (schan->linklist.phy_addr) {
>> +             if (sg_index == sglen - 1)
>> +                     hw->frg_len |= SPRD_DMA_LLIST_END;
>> +
>> +             hw->cfg |= SPRD_DMA_LINKLIST_EN;
>> +             hw->llist_ptr = schan->linklist.phy_addr +
>> +                     ((sg_index + 1) % sglen) * sizeof(*hw) +
>> +                     SPRD_DMA_CHN_SRC_ADDR;
>> +     } else {
>> +             hw->llist_ptr = 0;
>> +     }
>> +
>>       hw->frg_step = 0;
>>       hw->src_blk_step = 0;
>>       hw->des_blk_step = 0;
>>       return 0;
>>  }
>>
>> +static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
>> +                                    unsigned int sglen, int sg_index,
>> +                                    dma_addr_t src, dma_addr_t dst, u32 len,
>> +                                    enum dma_transfer_direction dir,
>> +                                    unsigned long flags,
>> +                                    struct dma_slave_config *slave_cfg)
>> +{
>> +     struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
>> +     struct sprd_dma_chn_hw *hw;
>> +
>> +     if (sglen < 2 || !schan->linklist.virt_addr)
>> +             return -EINVAL;
>
> why the limitation of 2 here?

Spreadtrum DMA link-list mode needs more than 2 link-list
configurations. If there is only one sg, it doesn't need to fill the
link-list configuration. Moreover, we have valided the sg length in
sprd_dma_prep_slave_sg(), so will remove the redundant validation
here.

>
>> +
>> +     hw = (struct sprd_dma_chn_hw *)(schan->linklist.virt_addr +
>> +                                     sg_index * sizeof(*hw));
>> +
>> +     return sprd_dma_fill_desc(chan, hw, sglen, sg_index, src, dst, len, dir,
>> +                               flags, slave_cfg);
>> +}
>> +
>> +static int sprd_dma_fill_chn_desc(struct dma_chan *chan,
>> +                               struct sprd_dma_desc *sdesc,
>> +                               dma_addr_t src, dma_addr_t dst, u32 len,
>> +                               enum dma_transfer_direction dir,
>> +                               unsigned long flags,
>> +                               struct dma_slave_config *slave_cfg)
>> +{
>> +     struct sprd_dma_chn_hw *hw = &sdesc->chn_hw;
>> +
>> +     return sprd_dma_fill_desc(chan, hw, 0, 0, src, dst, len, dir,
>> +                               flags, slave_cfg);
>> +}
>
> this fn does not do much, so why not call sprd_dma_fill_desc() instead
> from caller!

OK, will fix it.

>
>> +
>>  static struct dma_async_tx_descriptor *
>>  sprd_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>>                        size_t len, unsigned long flags)
>> @@ -744,10 +792,20 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>>       u32 len = 0;
>>       int ret, i;
>>
>> -     /* TODO: now we only support one sg for each DMA configuration. */
>> -     if (!is_slave_direction(dir) || sglen > 1)
>> +     if (!is_slave_direction(dir))
>>               return NULL;
>>
>> +     if (context) {
>> +             struct sprd_dma_linklist *ll_cfg =
>> +                     (struct sprd_dma_linklist *)context;
>> +
>> +             schan->linklist.phy_addr = ll_cfg->phy_addr;
>> +             schan->linklist.virt_addr = ll_cfg->virt_addr;
>> +     } else {
>> +             schan->linklist.phy_addr = 0;
>> +             schan->linklist.virt_addr = 0;
>> +     }
>> +
>>       sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
>>       if (!sdesc)
>>               return NULL;
>> @@ -762,10 +820,20 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>>                       src = slave_cfg->src_addr;
>>                       dst = sg_dma_address(sg);
>>               }
>> +
>> +             if (sglen < 2)
>> +                     break;
>
> ?

Like I said above, dma link-list mode needs more than 2
configurations, I will add some comments to explain why.

>
>> +
>> +             ret = sprd_dma_fill_linklist_desc(chan, sglen, i, src, dst, len,
>> +                                               dir, flags, slave_cfg);
>> +             if (ret) {
>> +                     kfree(sdesc);
>> +                     return NULL;
>> +             }
>>       }
>>
>> -     ret = sprd_dma_fill_desc(chan, sdesc, src, dst, len, dir, flags,
>> -                              slave_cfg);
>> +     ret = sprd_dma_fill_chn_desc(chan, sdesc, src, dst, len, dir, flags,
>> +                                  slave_cfg);
>>       if (ret) {
>>               kfree(sdesc);
>>               return NULL;
>> diff --git a/include/linux/dma/sprd-dma.h b/include/linux/dma/sprd-dma.h
>> index b0115e3..c51c705 100644
>> --- a/include/linux/dma/sprd-dma.h
>> +++ b/include/linux/dma/sprd-dma.h
>> @@ -58,4 +58,73 @@ enum sprd_dma_int_type {
>>       SPRD_DMA_CFGERR_INT,
>>  };
>>
>> +/*
>> + * struct sprd_dma_linklist - DMA link-list address structure
>> + * @virt_addr: link-list virtual address to configure link-list node
>> + * @phy_addr: link-list physical address to link DMA transfer
>> + *
>> + * The Spreadtrum DMA controller supports the link-list mode, that means slaves
>> + * can supply several groups configurations (each configuration represents one
>> + * DMA transfer) saved in memory, and DMA controller will link these groups
>> + * configurations by writing the physical address of each configuration into the
>> + * link-list register.
>> + *
>> + * Just as shown below, the link-list pointer register will be pointed to the
>> + * phycial address of 'configuration 1', and the 'configuration 1' link-list
>
> /s/phycial/physical

Sorry for typos and will fix.

>
>> + * pointer will be pointed to 'configuration 2', and so on.
>> + * Once trigger the DMA transfer, the DMA controller will load 'configureation
>
> /s/configureation/configuration

Will fix.

>
>> + * 1' to its registers automatically, after 'configuration 1' transation is
>
> /s/transation/transaction

Will fix.

>
>> + * done, DMA controller will load 'configuration 2' automatically, until all
>> + * DMA transactions are done.
>> + *
>> + * Note: The last link-list pointer should point to the physical address
>> + * of 'configuration 1', which can avoid DMA controller loads incorrect
>> + * configuration when the last configuration transaction is done.
>> + *
>> + *     DMA controller                    linklist memory
>> + * ======================             -----------------------
>> + *|                      |           |    configuration 1    |<---
>> + *|   DMA controller     |   ------->|                       |   |
>> + *|                      |   |       |                       |   |
>> + *|                      |   |       |                       |   |
>> + *|                      |   |       |                       |   |
>> + *| linklist pointer reg |----   ----|    linklist pointer   |   |
>> + * ======================        |    -----------------------    |
>> + *                               |                               |
>> + *                               |    -----------------------    |
>> + *                               |   |    configuration 2    |   |
>> + *                               --->|                       |   |
>> + *                                   |                       |   |
>> + *                                   |                       |   |
>> + *                                   |                       |   |
>> + *                               ----|    linklist pointer   |   |
>> + *                               |    -----------------------    |
>> + *                               |                               |
>> + *                               |    -----------------------    |
>> + *                               |   |    configuration 3    |   |
>> + *                               --->|                       |   |
>> + *                                   |                       |   |
>> + *                                   |           .           |   |
>> + *                                               .               |
>> + *                                               .               |
>> + *                                               .               |
>> + *                               |               .               |
>> + *                               |    -----------------------    |
>> + *                               |   |    configuration n    |   |
>> + *                               --->|                       |   |
>> + *                                   |                       |   |
>> + *                                   |                       |   |
>> + *                                   |                       |   |
>> + *                                   |    linklist pointer   |----
>> + *                                    -----------------------
>> + *
>> + * To support the link-list mode, DMA slaves should allocate one segment memory
>> + * from always-on IRAM or dma coherent memory to store these groups of DMA
>> + * configuration, and pass the virtual and physical addess to DMA controller.
>
> /s/addess/address

Will fix in next version. Thanks for your comments.

-- 
Baolin Wang
Best Regards
