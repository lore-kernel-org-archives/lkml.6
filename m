Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA2FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B889D2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atb2dYeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B889D2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933746AbeGDIp3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:45:29 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36806 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932148AbeGDIpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:45:25 -0400
Received: by mail-oi0-f66.google.com with SMTP id r16-v6so9297133oie.3;
        Wed, 04 Jul 2018 01:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YST6qulX/vyatAPq+jCRppbtsdEEj+C0FyV8UpL2j4s=;
        b=atb2dYeO8Mvqt35WZVkcvF6Au2YQmuSGQU+ei47/YMEvHIp27umq5lwv9uk5Ii65wd
         D9ZScSUx8omQvf1L57ZvQgfUhx/LCNaet5475PiPu027wrkzAyFAm/8TOVxf6m+3dzyM
         LZPZjSa2+xKMH77Sk+wngcdhUKjemw78/Lg876hEfWDgl93pWCt10CdKoY1RX4dyroc4
         o5RJvQiLY9/IQOFHVDXWwKG4n9Px2ZbfcSMttaoMZo8Jjl8/ebBYhQPPbLtAUyRoV1L9
         Rt+wstTKzbprxFMNxzoKv7n6IDbas8Hc7EEMuOWoQbBiurnJHeYxeBMsdlX238yKAebU
         fSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YST6qulX/vyatAPq+jCRppbtsdEEj+C0FyV8UpL2j4s=;
        b=UOWezrix9MThpUOEDuUWQj/hhkGp7c7Dci6HjL6ymIhs4hl0JY0jH/BMnrXyNBu0z+
         pOfetiRD7hDND2JCIHeamOn6iTIXazO3/sHBr+1uhiFWOmE/pqhYFQWRg4R30nV9SPm8
         99UAu923lqqQ/LT90DQooIphb4UluIsGLOvZgQ92MvAy0qJbN5l8Mre477nzAGIGs17p
         sBlRz4JslfbJwdAnYWAYvPJCasILiAMMJFpWINDusem246rUSAZyWcKKJmNTrVl+A9AS
         ekw6vM1pwzndyPUicNxwvKze7vgjxymWLzfqTE/2LSRsjvWG1d7RObKxxpK5pzWQ8hIK
         w+9Q==
X-Gm-Message-State: APt69E28rEHYK+LnJfLKSUqsPz9rlZRApwjnfxN1VIwNPSf1q9UTvFsU
        TzfKn2DRUN10Z0yMFrJ+XIl883E1ARmZkLam3/0=
X-Google-Smtp-Source: AAOMgpcBEjtVxtAYpJGpFni46MouW6KjuKS/kXg7ErJltuGuAhE6b6aU/FMCKd9ALVGG+uUEurDfctmQTzAUN1UYSz8=
X-Received: by 2002:aca:ed45:: with SMTP id l66-v6mr1249997oih.40.1530693924413;
 Wed, 04 Jul 2018 01:45:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:1e82:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 01:45:24 -0700 (PDT)
In-Reply-To: <c162ab8d-127d-d998-b92b-2d61511729ff@microchip.com>
References: <1530286269-32235-1-git-send-email-harini.katakam@xilinx.com>
 <1530286269-32235-2-git-send-email-harini.katakam@xilinx.com> <c162ab8d-127d-d998-b92b-2d61511729ff@microchip.com>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Wed, 4 Jul 2018 14:15:24 +0530
X-Google-Sender-Auth: gM1y0jpXQjsRU0XGZYG2eHjLfFQ
Message-ID: <CAFcVECL9McURN1xVhCxOFU6iTzBQW7Lsayt2AWhFddkGb3+mdA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] net: macb: Allocate valid memory for TX and RX BD prefetch
To:     Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Wed, Jul 4, 2018 at 1:52 PM, Claudiu Beznea
<Claudiu.Beznea@microchip.com> wrote:
> Hi Harini,
>
> Few comments below.
>
> Thank you,
> Claudiu Beznea
>
> On 29.06.2018 18:31, Harini Katakam wrote:
>> GEM version in ZynqMP and most versions greater than r1p07 supports
>> TX and RX BD prefetch. The number of BDs that can be prefetched is a
>> HW configurable parameter. For ZynqMP, this parameter is 4.
>>
>> When GEM DMA is accessing the last BD in the ring, even before the
>> BD is processed and the WRAP bit is noticed, it will have prefetched
>> BDs outside the BD ring. These will not be processed but it is
>> necessary to have accessible memory after the last BD. Especially
>> in cases where SMMU is used, memory locations immediately after the
>> last BD may not have translation tables triggering HRESP errors. Hence
>> always allocate extra BDs to accommodate for prefetch.
>> The value of tx/rx bd prefetch for any given SoC version is:
>> 2 ^ (corresponding field in design config 10 register).
>> (value of this field >= 1)
>>
>> Added a capability flag so that older IP versions that do not have
>> DCFG10 or this prefetch capability are not affected.
>>
>> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
>> ---
>>  drivers/net/ethernet/cadence/macb.h      | 11 +++++++++++
>>  drivers/net/ethernet/cadence/macb_main.c | 31 +++++++++++++++++++++++++------
>>  2 files changed, 36 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
>> index 8665982..b267a7b 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -166,6 +166,7 @@
>>  #define GEM_DCFG6            0x0294 /* Design Config 6 */
>>  #define GEM_DCFG7            0x0298 /* Design Config 7 */
>>  #define GEM_DCFG8            0x029C /* Design Config 8 */
>> +#define GEM_DCFG10           0x02A4 /* Design Config 10 */
>>
>>  #define GEM_TXBDCTRL 0x04cc /* TX Buffer Descriptor control register */
>>  #define GEM_RXBDCTRL 0x04d0 /* RX Buffer Descriptor control register */
>> @@ -490,6 +491,12 @@
>>  #define GEM_SCR2CMP_OFFSET                   0
>>  #define GEM_SCR2CMP_SIZE                     8
>>
>> +/* Bitfields in DCFG10 */
>> +#define GEM_TXBD_RDBUFF_OFFSET                       12
>> +#define GEM_TXBD_RDBUFF_SIZE                 4
>> +#define GEM_RXBD_RDBUFF_OFFSET                       8
>> +#define GEM_RXBD_RDBUFF_SIZE                 4
>> +
>>  /* Bitfields in TISUBN */
>>  #define GEM_SUBNSINCR_OFFSET                 0
>>  #define GEM_SUBNSINCR_SIZE                   16
>> @@ -635,6 +642,7 @@
>>  #define MACB_CAPS_USRIO_DISABLED             0x00000010
>>  #define MACB_CAPS_JUMBO                              0x00000020
>>  #define MACB_CAPS_GEM_HAS_PTP                        0x00000040
>> +#define MACB_CAPS_BD_PREFETCH                        0x00000080
>
> Rename it to MACB_CAPS_BD_RD_PREFETCH, since it is about read prefetch.
>
>>  #define MACB_CAPS_FIFO_MODE                  0x10000000
>>  #define MACB_CAPS_GIGABIT_MODE_AVAILABLE     0x20000000
>>  #define MACB_CAPS_SG_DISABLED                        0x40000000
>> @@ -1203,6 +1211,9 @@ struct macb {
>>       unsigned int max_tuples;
>>
>>       struct tasklet_struct   hresp_err_tasklet;
>> +
>> +     int     rx_bd_prefetch;
>> +     int     tx_bd_prefetch;
>
> Since it is about read prefetch I would say to rename these fields properly
> to describe this:
>         int     rx_bd_rd_prefetch;
>         int     tx_bd_rd_prefetch;
>
> or something similar as you did with macros.
>
>>  };
>>
>>  #ifdef CONFIG_MACB_USE_HWSTAMP
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index e56ffa9..a7612f6 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1811,6 +1811,7 @@ static void macb_free_consistent(struct macb *bp)
>>  {
>>       struct macb_queue *queue;
>>       unsigned int q;
>> +     int size;
>>
>>       bp->macbgem_ops.mog_free_rx_buffers(bp);
>>
>> @@ -1818,12 +1819,16 @@ static void macb_free_consistent(struct macb *bp)
>>               kfree(queue->tx_skb);
>>               queue->tx_skb = NULL;
>>               if (queue->tx_ring) {
>> -                     dma_free_coherent(&bp->pdev->dev, TX_RING_BYTES(bp),
>> +                     size = TX_RING_BYTES(bp) +
>> +                            (macb_dma_desc_get_size(bp) * bp->tx_bd_prefetch);
>> +                     dma_free_coherent(&bp->pdev->dev, size,
>>                                         queue->tx_ring, queue->tx_ring_dma);
>>                       queue->tx_ring = NULL;
>>               }
>>               if (queue->rx_ring) {
>> -                     dma_free_coherent(&bp->pdev->dev, RX_RING_BYTES(bp),
>> +                     size = RX_RING_BYTES(bp) +
>> +                            (macb_dma_desc_get_size(bp) * bp->rx_bd_prefetch);
>> +                     dma_free_coherent(&bp->pdev->dev, size,
>>                                         queue->rx_ring, queue->rx_ring_dma);
>>                       queue->rx_ring = NULL;
>>               }
>> @@ -1873,7 +1878,8 @@ static int macb_alloc_consistent(struct macb *bp)
>>       int size;
>>
>>       for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>> -             size = TX_RING_BYTES(bp);
>> +             size = TX_RING_BYTES(bp) +
>> +                    (macb_dma_desc_get_size(bp) * bp->tx_bd_prefetch);
>>               queue->tx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
>>                                                   &queue->tx_ring_dma,
>>                                                   GFP_KERNEL);
>> @@ -1889,7 +1895,8 @@ static int macb_alloc_consistent(struct macb *bp)
>>               if (!queue->tx_skb)
>>                       goto out_err;
>>
>> -             size = RX_RING_BYTES(bp);
>> +             size = RX_RING_BYTES(bp) +
>> +                    (macb_dma_desc_get_size(bp) * bp->rx_bd_prefetch);
>>               queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
>>                                                &queue->rx_ring_dma, GFP_KERNEL);
>>               if (!queue->rx_ring)
>> @@ -3794,7 +3801,7 @@ static const struct macb_config np4_config = {
>>  static const struct macb_config zynqmp_config = {
>>       .caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
>>                       MACB_CAPS_JUMBO |
>> -                     MACB_CAPS_GEM_HAS_PTP,
>> +                     MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_PREFETCH,
>>       .dma_burst_length = 16,
>>       .clk_init = macb_clk_init,
>>       .init = macb_init,
>> @@ -3855,7 +3862,7 @@ static int macb_probe(struct platform_device *pdev)
>>       void __iomem *mem;
>>       const char *mac;
>>       struct macb *bp;
>> -     int err;
>> +     int err, buff;
>
> I would use "val" instead of "buff"
>
>>
>>       regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>       mem = devm_ioremap_resource(&pdev->dev, regs);
>> @@ -3944,6 +3951,18 @@ static int macb_probe(struct platform_device *pdev)
>>       else
>>               dev->max_mtu = ETH_DATA_LEN;
>>
>> +     bp->rx_bd_prefetch = 0;
>> +     bp->tx_bd_prefetch = 0;
>
> No need for zero init since alloc_etherdev_mq() will allocate with
> __GFP_ZERO flag (actually, kvzalloc() will be called)
>
>> +     if (bp->caps & MACB_CAPS_BD_PREFETCH) {
>> +             buff = GEM_BFEXT(RXBD_RDBUFF, gem_readl(bp, DCFG10));
>> +             if (buff)
>> +                     bp->rx_bd_prefetch = 2 << (buff - 1);
>> +
>> +             buff = GEM_BFEXT(TXBD_RDBUFF, gem_readl(bp, DCFG10));
>> +             if (buff)
>> +                     bp->tx_bd_prefetch = 2 << (buff - 1);
>> +     }
>> +
>>       mac = of_get_mac_address(np);
>>       if (mac) {
>>               ether_addr_copy(bp->dev->dev_addr, mac);
>>
>
> With these you can add:
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Thanks for the review. I'll send a v2 with these changes.

Regards,
Harini
