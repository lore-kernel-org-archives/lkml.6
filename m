Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeA3Gy6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 01:54:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbeA3Gy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 01:54:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 738216024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH 1/1] scsi: ufs-qcom: remove broken hci version quirk
To: Vivek Gautam <vivek.gautam@codeaurora.org>, subhashj@codeaurora.org,
        cang@codeaurora.org, rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <1517287281-8622-1-git-send-email-asutoshd@codeaurora.org>
 <1cbfdeb0-084d-8f8b-ed66-d00fbed4a968@codeaurora.org>
From: "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <525ba25a-b699-3bb3-df06-4b3ff165d42a@codeaurora.org>
Date: Tue, 30 Jan 2018 12:24:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1cbfdeb0-084d-8f8b-ed66-d00fbed4a968@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/2018 11:33 AM, Vivek Gautam wrote:
> Hi Asutosh,
> 
> 
> On 1/30/2018 10:11 AM, Asutosh Das wrote:
>> From: Subhash Jadavani <subhashj@codeaurora.org>
>>
>> UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION is only applicable for QCOM UFS host
>> controller version 2.x.y and this has been fixed from version 3.x.y
>> onwards, hence this change removes this quirk for version 3.x.y onwards.
>>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> ---
> 
> This patch and all other ufs patches that you have posted recently,
> do they all fall under one 'ufs-qcom fixes' patch series for fixes that
> we would want to do?
> If it is so, then please club them together in a series, so that
> it's easy for reviewers and maintainers to review, and keep track
> of all the patches that can get-in after the reviews.
> If they belong to two or more separate patch-series then please
> create such patch series.
> It's difficult to read through a lot of [PATCH 1/1] ... patch.
Sure Vivek - Makes sense. Will resend it.

> 
> Regards
> Vivek
> 
>>   drivers/scsi/ufs/ufs-qcom.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
>> index 2b38db2..221820a 100644
>> --- a/drivers/scsi/ufs/ufs-qcom.c
>> +++ b/drivers/scsi/ufs/ufs-qcom.c
>> @@ -1098,7 +1098,7 @@ static void ufs_qcom_advertise_quirks(struct 
>> ufs_hba *hba)
>>           hba->quirks |= UFSHCD_QUIRK_BROKEN_LCC;
>>       }
>> -    if (host->hw_ver.major >= 0x2) {
>> +    if (host->hw_ver.major == 0x2) {
>>           hba->quirks |= UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION;
>>           if (!ufs_qcom_cap_qunipro(host))
> 


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
