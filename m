Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22260C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01AD20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBKLgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:36:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3279 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbfBKLgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:36:13 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AE710AE27DC14EEF17B9;
        Mon, 11 Feb 2019 19:36:08 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Mon, 11 Feb 2019
 19:36:00 +0800
Subject: Re: [PATCH 1/6] scsi: hisi_sas: Add support for DIX feature for v3 hw
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>
References: <1549450376-114929-1-git-send-email-john.garry@huawei.com>
 <1549450376-114929-2-git-send-email-john.garry@huawei.com>
 <yq1zhr5vpos.fsf@oracle.com>
CC:     <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <53c516cc-cce3-a3e1-718f-6fc465b6e401@hisilicon.com>
Date:   Mon, 11 Feb 2019 19:36:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <yq1zhr5vpos.fsf@oracle.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

ÔÚ 2019/2/9 7:13, Martin K. Petersen Ð´µÀ:
> John,
>
> Just noticed this while inspecting the resulting complete diff:
>
>>   static u32 get_prot_chk_msk_v3_hw(struct scsi_cmnd *scsi_cmnd)
>>   {
>>   	unsigned char prot_flags = scsi_cmnd->prot_flags;
>>   
>> -	if (prot_flags & SCSI_PROT_TRANSFER_PI) {
>> -		if (prot_flags & SCSI_PROT_REF_CHECK)
>> -			return 0xc << 16;
>> -		return 0xfc << 16;
>> -	}
>> -	return 0;
>> +	if (prot_flags & SCSI_PROT_REF_CHECK)
>> +		return T10_CHK_APP_TAG_MSK;
> Polarity is a bit unclear here. Is this statement disabling checking of
> the app tag?

Yes, disabling checking of app tag.
For here, 1'b0 presents the related byte in DIF will be checked, and 
1'b1 presents the related byte in DIF will not be checked.


>
>> +	return T10_CHK_REF_TAG_MSK | T10_CHK_APP_TAG_MSK;
>>   }


