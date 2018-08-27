Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7629C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C27E208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtTaiK2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C27E208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeH0WGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:06:17 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45870 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:06:17 -0400
Received: by mail-qk0-f195.google.com with SMTP id z125-v6so11127840qkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0+QByKDfZfc7uugZ+ya6M2+5b0WBlp8DgVtfT/VpeZE=;
        b=ZtTaiK2Bu/WcMzfpm5S4Hog1PZuUSsyjMXH84Fg5kezKIUlNSCRU889B65ZvCxeGV3
         7wn5ylutvrOkLkqjBB2uaalzvQhp1eWFvzHmpEy+vPcmGpiiy5vmlAa3Ly02QPb/dzdx
         6K1DB7SUdHH8vnOBAQXUj2wJkDbzXeNT9vhnvgQhian2DSoIiHz17qbufRMZBVcVu3RP
         2GIw20pPePNezxN/MgmRbHSdxanRiqcmxYMl0N6ZFJ5VRmsPxPdpGU7zKGd+Aoazm/bW
         dSJ2PSnkzuzZBmDfhxolCzrZ1l7yhCOUUHCo0V4hk3FQZkU33SQgKmxcP3hMGqTPnITE
         /ILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0+QByKDfZfc7uugZ+ya6M2+5b0WBlp8DgVtfT/VpeZE=;
        b=YYjyWN+fkrfJwbHfN/rNhDdmnaWprnvcrHJYj+p+oqG1awTy23dqHnDptgT6ZsueXL
         DzxZ3DkuI08+ag/lYE4E7ETVFTAvCzd3yWEHM5XNHcRpzxrJBr1jSmHQwwxTj16SlMsL
         NjLo/gbZn+6EyqDNEaq9DYI4NIy7+GRxvQzMy95YPWqksYtMFFz0AmaXSk5PZcN43Bno
         kGN9cifGfmNNtNocAN1/raZz8EUKh3O1Kb5xxLxf9m3JGEq+pMSRttEusIhovU/0V+F2
         teIrCJ8TprcAW3ybOUMcMnM45pa3Cuned+5cHr9W2krBZ/R5+CM0V058ZAe7tuU1A8SJ
         7ZpA==
X-Gm-Message-State: APzg51Aw3X0QtUn9EWwJmMkd6DIrFKsL6BNXAlFCHTqPwVTloSwcNhGv
        ldRfjjdEQ6UXq6GWrWm5zmY=
X-Google-Smtp-Source: ANB0VdbKyn1WMtgOGpUyA1Eh+2xI3BafmJNHdDxQi4E4J74FRAI3gy5RlpZXsjl0z40FwUbhmqcXOA==
X-Received: by 2002:a37:10d1:: with SMTP id 78-v6mr14820917qkq.72.1535393915791;
        Mon, 27 Aug 2018 11:18:35 -0700 (PDT)
Received: from 0021ccb48c25 (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id d100-v6sm12999125qkh.34.2018.08.27.11.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 11:18:34 -0700 (PDT)
Date:   Mon, 27 Aug 2018 14:18:31 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 11/11] powerpc/svm: Increase SWIOTLB buffer size
Message-ID: <20180827181830.GB3834@0021ccb48c25>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
 <20180824162535.22798-12-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824162535.22798-12-bauerman@linux.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 01:25:35PM -0300, Thiago Jung Bauermann wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> SWIOTLB buffer default size (64MB) is not enough for large sequential write
> operations which eventually leads to kernel crash like here.
> 
> virtio-pci 0000:00:05.0: swiotlb buffer is full (sz: 327680 bytes)
> virtio-pci 0000:00:05.0: DMA: Out of SW-IOMMU space for 327680 bytes
> Kernel panic - not syncing: DMA: Random memory could be DMA read
> CPU: 12 PID: 3985 Comm: mkfs.ext4 Not tainted 4.18.0-rc4+ #285
> Call Trace:
> [c0000007d2a27020] [c000000000cfdffc] dump_stack+0xb0/0xf4 (unreliable)
> [c0000007d2a27060] [c000000000112a98] panic+0x140/0x328
> [c0000007d2a270f0] [c0000000001b4f88] swiotlb_full+0x108/0x130
> [c0000007d2a27180] [c0000000001b5f6c] swiotlb_map_page+0x25c/0x2c0
> [c0000007d2a271e0] [c0000000007bfaf8] vring_map_one_sg.isra.0+0x58/0x70
> [c0000007d2a27200] [c0000000007c08dc] virtqueue_add_sgs+0x1bc/0x690
> [c0000007d2a272f0] [d0000000042a1280] virtio_queue_rq+0x358/0x4a0 [virtio_blk]
> [c0000007d2a273d0] [c0000000006b5d68] blk_mq_dispatch_rq_list+0x1f8/0x6d0
> ..................
> 
> Increase the SWIOTLB size to 1GB on Ultravisor based secure guests.

Gosh, that is huge.

What about making the SWIOTLB be more dynamic? That is expand it's size
dynamically if it can?

> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig | 5 +++++
>  kernel/dma/swiotlb.c | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1466d1234723..fee7194ce9e4 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -457,6 +457,11 @@ config PPC_SVM
>  
>  	 If unsure, say "N".
>  
> +config SWIOTLB_DEFAULT_SIZE
> +       int "Size of Software I/O TLB buffer (in MiB)"
> +       default "1024"
> +       depends on PPC_SVM
> +
>  config PPC_TRANSACTIONAL_MEM
>         bool "Transactional Memory support for POWERPC"
>         depends on PPC_BOOK3S_64
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 04b68d9dffac..32dc67422d8a 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -146,8 +146,13 @@ void swiotlb_set_max_segment(unsigned int val)
>  		max_segment = rounddown(val, PAGE_SIZE);
>  }
>  
> +#ifdef CONFIG_SWIOTLB_DEFAULT_SIZE
> +#define IO_TLB_DEFAULT_SIZE ((unsigned long) CONFIG_SWIOTLB_DEFAULT_SIZE << 20)
> +#else
>  /* default to 64MB */
>  #define IO_TLB_DEFAULT_SIZE (64UL<<20)
> +#endif
> +
>  unsigned long swiotlb_size_or_default(void)
>  {
>  	unsigned long size;
> 
