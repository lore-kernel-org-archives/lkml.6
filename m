Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF1EC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AD62084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AD62084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeJZQyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:54:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35885 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbeJZQyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:54:07 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CAC111915CCC4;
        Fri, 26 Oct 2018 16:17:47 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 26 Oct 2018
 16:17:42 +0800
Subject: Re: [PATCH -next] scsi: hisi_sas: Remove set but not used variable
 'dq_list'
To:     YueHaibing <yuehaibing@huawei.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
References: <20181026070731.20024-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c88cf61a-7798-0616-7cc6-4ae704402ef3@huawei.com>
Date:   Fri, 26 Oct 2018 09:17:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181026070731.20024-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2018 08:07, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/scsi/hisi_sas/hisi_sas_v1_hw.c: In function 'start_delivery_v1_hw':
> drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:907:20: warning:
>  variable 'dq_list' set but not used [-Wunused-but-set-variable]
>
> drivers/scsi/hisi_sas/hisi_sas_v2_hw.c: In function 'start_delivery_v2_hw':
> drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:1671:20: warning:
>  variable 'dq_list' set but not used [-Wunused-but-set-variable]
>
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c: In function 'start_delivery_v3_hw':
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:889:20: warning:
>  variable 'dq_list' set but not used [-Wunused-but-set-variable]
>
> It never used since introduction in commit
> fa222db0b036 ("scsi: hisi_sas: Don't lock DQ for complete task sending")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: John Garry <john.garry@huawei.com>


