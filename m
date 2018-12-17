Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A052EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C4F206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbeLQOv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:51:56 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50784 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727643AbeLQOvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:51:54 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8DFE9C530F0C8;
        Mon, 17 Dec 2018 22:51:49 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 22:51:40 +0800
Subject: Re: [PATCH v4 4/5] scsi: hisi_sas: Add support for DIF feature for v3
 hw
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1544103284-100497-1-git-send-email-john.garry@huawei.com>
 <1544103284-100497-5-git-send-email-john.garry@huawei.com>
 <yq1o99qgobi.fsf@oracle.com>
 <4752be71-f39c-ac55-0e51-36c146108a38@huawei.com>
CC:     <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <afb32599-9b81-9d56-3ae7-2797992353a1@huawei.com>
Date:   Mon, 17 Dec 2018 14:51:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <4752be71-f39c-ac55-0e51-36c146108a38@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2018 13:35, John Garry wrote:
>
>>
>> to set your controller flags.
>>
>> +        if (prot_op == SCSI_PROT_WRITE_INSERT) {
>> +            unsigned int interval = scsi_prot_interval(scsi_cmnd);
>> +            unsigned int ilog2_interval = ilog2(interval);
>> +
>> +            len = (task->total_xfer_len >> ilog2_interval) * 8;
>>
>> scsi_transfer_length(struct scsi_cmnd *scmd)
>
> ok

Hi Martin,

We have an issue with using scsi_transfer_length().

As I understand, for our controller we need to set the host structure 
data transfer size to the size of data to write to the disk for WRITE 
type command, and at size of info received to host memory for READ type 
command. As such, for READ STRIP, we only want the SCSI buf len, and not 
the scsi buf len and PI (this is what scsi_transfer_length() provides).

Thanks,
John


