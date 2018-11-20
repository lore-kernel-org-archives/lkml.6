Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284DAC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2F0206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2F0206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbeKUDGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:06:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726621AbeKUDGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:06:42 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0FB38E8F8F4B0;
        Wed, 21 Nov 2018 00:36:25 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 21 Nov 2018
 00:36:19 +0800
Subject: Re: [PATCH 1/4] scsi: Add scsi_prot_op_normal()
To:     Christoph Hellwig <hch@infradead.org>
References: <1542725944-244183-1-git-send-email-john.garry@huawei.com>
 <1542725944-244183-2-git-send-email-john.garry@huawei.com>
 <20181120161940.GA10454@infradead.org>
CC:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4493598c-7c25-a1b1-dfbb-aaec0b967185@huawei.com>
Date:   Tue, 20 Nov 2018 16:36:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181120161940.GA10454@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2018 16:19, Christoph Hellwig wrote:
>> +static inline bool scsi_prot_op_normal(struct scsi_cmnd *scmd)
>> +{
>> +	return scmd->prot_op == SCSI_PROT_NORMAL;
>> +}
>
> This "wrapper" just obsfucates the check being performed, please drop
> it.
>
> .
>

ok, if you think so.

I just thought that was better for a more concise check, rather than 
this common pattern:
if ((scsi_get_prot_op(scsi_cmnd) != SCSI_PROT_NORMAL) ...

cheers,


