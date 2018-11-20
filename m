Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781E3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC9B20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC9B20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeKTUJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:09:23 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40355 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbeKTUJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:09:23 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 28805A677FE23;
        Tue, 20 Nov 2018 17:41:07 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 17:41:02 +0800
Subject: Re: [PATCH] scsi/lpfc/lpfc_sli.c: Use dma_zalloc_coherent
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
References: <5bf1797b.1c69fb81.2368c.1ccc@mx.google.com>
CC:     <jrdr.linux@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <brajeswar.linux@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <16c3b882-6e0e-b712-b4d6-78f68172da65@huawei.com>
Date:   Tue, 20 Nov 2018 09:40:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <5bf1797b.1c69fb81.2368c.1ccc@mx.google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2018 14:38, Sabyasachi Gupta wrote:
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>  drivers/scsi/lpfc/lpfc_sli.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
> index 783a154..3491ff7 100644
> --- a/drivers/scsi/lpfc/lpfc_sli.c
> +++ b/drivers/scsi/lpfc/lpfc_sli.c
> @@ -6229,7 +6229,7 @@ lpfc_sli4_ras_dma_alloc(struct lpfc_hba *phba,
>  			goto free_mem;
>  		}
>
> -		dmabuf->virt = dma_alloc_coherent(&phba->pcidev->dev,
> +		dmabuf->virt = dma_zalloc_coherent(&phba->pcidev->dev,
>  						  LPFC_RAS_MAX_ENTRY_SIZE,

please ensure that you maintain alignment with opening brackets

>  						  &dmabuf->phys,
>  						  GFP_KERNEL);
> @@ -6240,7 +6240,6 @@ lpfc_sli4_ras_dma_alloc(struct lpfc_hba *phba,
>  					"6187 DMA Alloc Failed FW logging");
>  			goto free_mem;
>  		}
> -		memset(dmabuf->virt, 0, LPFC_RAS_MAX_ENTRY_SIZE);
>  		dmabuf->buffer_tag = i;
>  		list_add_tail(&dmabuf->list, &ras_fwlog->fwlog_buff_list);
>  	}
>


