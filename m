Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-77513-1526664027-2-8094172038365372528
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526664027; b=OInYWCxD+qVD+CoYGNabWicAMx1CYFWsWzdDidnx9wq8g+gXvc
    L5H7vikJiKBV6ex4XkMS6si+6IDGO9oajg1sUnCSBQTZ3W2XrRbmn6HkPhW6jTBS
    XicCIjsminhkdl1/29i7GW19rD+36wVpTQtFNpv5fGXgl7w8CkT09ef7IZND7OU/
    QXF7sAR4DQTa/wSbIqk9Q2Bh76QpiAsm5Frf6VKd3+CuH96lWJ7EYZJwtbnM51aO
    5p4QKlK/dId3wU5CupXd6DXevhaIZFf5x6s0x29q44WizdSzpRcctAdO9lMtVRG0
    y/WvCFvqJzh/FO3pTMSHpQ1xYQhdIVC+p0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526664027;
    bh=7qt/uRuMBddCIDi/LL5ro+iuIru1sUYQlgY5nx+ekVM=; b=EsIXBcBHCwVQ
    o5rrc1bYNc842+sUn3DkBrYOI4eQaiQxmdNvn3Oc0IuLpXWYyNAUlS/eeaTy2dua
    FLtVcb23CPfVXgW3a07AM3epWTngdGpurV4iN0u6EzZ5JQAMZ+q80nAPkQ+um3Hi
    YmgM94lT4uzXo5Fk0hOADfa/mi+/wDxKVX1BtyZC6RcEyakK4q2wEllxQ8L5Rl9S
    WM6CCBcFGd75M9jX+LaxYA+u6uVba2TMdnWhGJLta3v3q2xUG/6we2+CwZTAVF0K
    iePqydg5sPUSep7vo28ZbQoCOCIU39SPIr1ny8pHbmLjlmJsEsUHA0NtawMWDXEs
    /C2oWhJuew==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=synopsys.com
    header.i=@synopsys.com header.b=RMk9RaUs x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=synopsys.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=synopsys.com
      header.i=@synopsys.com header.b=RMk9RaUs x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=synopsys.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIs4b++omL1paVZk6/x1gdD+DMIdHYzs7bpTHB5olaqAQRlHzeRz3wsWOdBQ2bm/VqaDPlLeDyeFMf6GLToDu+6+Ou0Y49QLg37rlfnq12Q4O2bB33fF
    VW6lPdLJkXMSqQc+l4IukOoKS1VGqCVvWg47WYv3s1If2Yh2GH9QaToWH5akN+/LuTFXO3/n/4XTFXiLgUsFSzKM6sSKcolBzeT9ZFBcuJI02fNOiOZsmz80
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=1diNBeniFdIA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=xucnYjTFAAAA:8 a=yUhTEyfT7DBoJHZuNvcA:9 a=QEXdDO2ut3YA:10
    a=Xlg7844Iomi71Cc9oUTC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbeERRUY (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 13:20:24 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:58499 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeERRUW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2018 13:20:22 -0400
Subject: dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH 02/20]
 dma-mapping: provide a generic dma-noncoherent implementation)
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "hch@lst.de" <hch@lst.de>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-3-hch@lst.de>
 <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <5ac5b1e3-9b96-9c7c-4dfe-f65be45ec179@synopsys.com>
Date: Fri, 18 May 2018 10:20:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.10.161.52]
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/18/2018 06:11 AM, Alexey Brodkin wrote:
>   void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
>                  size_t size, enum dma_data_direction dir)
>   {
> +       if (dir != DMA_TO_DEVICE){
> +               dump_stack();
> +               printk(" *** %s@%d: DMA direction is %s instead of %s\n",
> +                      __func__, __LINE__, dir_to_str(dir), dir_to_str(DMA_TO_DEVICE));
> +       }
> +
>          return _dma_cache_sync(dev, paddr, size, dir);
>   }
>   
>   void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
>                  size_t size, enum dma_data_direction dir)
>   {
> +       if (dir != DMA_FROM_DEVICE) {
> +               dump_stack();
> +               printk(" *** %s@%d: DMA direction is %s instead of %s\n",
> +                      __func__, __LINE__, dir_to_str(dir), dir_to_str(DMA_FROM_DEVICE));
> +       }
> +
>          return _dma_cache_sync(dev, paddr, size, dir);
>   }

...
> In case of MMC/DW_MCI (AKA DesignWare MobileStorage controller) that's an execution flow:
> 1) __dw_mci_start_request()
> 2) dw_mci_pre_dma_transfer()
> 3) dma_map_sg(..., mmc_get_dma_dir(data))
>
> Note mmc_get_dma_dir() is just "data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE".
> I.e. if we're preparing for sending data dma_noncoherent_map_sg() will have DMA_TO_DEVICE which
> is quite OK for passing to dma_noncoherent_sync_sg_for_device() but in case of reading we'll have
> DMA_FROM_DEVICE which we'll pass to dma_noncoherent_sync_sg_for_device() in dma_noncoherent_map_sg().
>
> I'd say this is not entirely correct because IMHO arch_sync_dma_for_cpu() is supposed to only be used
> in case of DMA_FROM_DEVICE and arch_sync_dma_for_device() only in case of DMA_TO_DEVICE.

So roughly 10 years ago, some kernel rookie name Vineet Gupta, asked the exact 
same question :-)

http://kernelnewbies.kernelnewbies.narkive.com/aGW1QcDv/query-about-dma-sync-for-cpu-and-direction-to-device

I never understood the need for this direction. And if memory serves me right, at 
that time I was seeing twice the amount of cache flushing !

> But the real fix of my problem is:
> ---------------------------------------->8------------------------------------
> --- a/lib/dma-noncoherent.c
> +++ b/lib/dma-noncoherent.c
> @@ -35,7 +35,7 @@ static dma_addr_t dma_noncoherent_map_page(struct device *dev, struct page *page
>   
>          addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
>          if (!dma_mapping_error(dev, addr) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -               arch_sync_dma_for_device(dev, page_to_phys(page), size, dir);
> +               arch_sync_dma_for_device(dev, page_to_phys(page) + offset, size, dir);
>          return addr;
>   }
> ---------------------------------------->8------------------------------------
>
> You seem to lost an offset in the page so if we happen to have a buffer not aligned to
> a page boundary then we were obviously corrupting data outside our data :)

Neat !
