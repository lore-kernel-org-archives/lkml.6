Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeDXSX0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:23:26 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41386 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbeDXSXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:23:18 -0400
X-Google-Smtp-Source: AIpwx4/GXmZH8/Gi8QKUnStqlXOUE0tSZyaxbxkyrvvz4ubNv+D/WO3PpJdx6YwVPO2pKmz8u1S8Gg==
Date: Tue, 24 Apr 2018 11:23:16 -0700 (PDT)
X-Google-Original-Date: Tue, 24 Apr 2018 11:23:11 PDT (-0700)
Subject: Re: [PATCH 5/5] PCI: remove PCI_DMA_BUS_IS_PHYS
In-Reply-To: <20180424181625.22410-6-hch@lst.de>
CC: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-1f7fdc5e-bbef-409b-80cb-6a6bbb76eca4@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 11:16:25 PDT (-0700), Christoph Hellwig wrote:
> This was used by the ide, scsi and networking code in the past to
> determine if they should bounce payloads.  Now that the dma mapping
> always have to support dma to all physical memory (thanks to swiotlb
> for non-iommu systems) there is no need to this crude hack any more.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> [...]
> diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
> index 0f2fc9ef20fc..b3638c505728 100644
> --- a/arch/riscv/include/asm/pci.h
> +++ b/arch/riscv/include/asm/pci.h
> @@ -26,9 +26,6 @@
>  /* RISC-V shim does not initialize PCI bus */
>  #define pcibios_assign_all_busses() 1
>
> -/* We do not have an IOMMU */
> -#define PCI_DMA_BUS_IS_PHYS 1
> -
>  extern int isa_dma_bridge_buggy;
>
>  #ifdef CONFIG_PCI

Thanks!

Acked-by: Palmer Dabbelt <palmer@sifive.com> (For the RISC-V change)
