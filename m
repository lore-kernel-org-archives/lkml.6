Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7715EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B1E21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B1E21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbeIRMt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:49:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12175 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbeIRMt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:49:56 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CE1D985F808D8;
        Tue, 18 Sep 2018 15:18:35 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Tue, 18 Sep 2018
 15:18:36 +0800
Message-ID: <5BA0A6CB.1010607@huawei.com>
Date:   Tue, 18 Sep 2018 15:18:35 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Michael Chan <michael.chan@broadcom.com>
CC:     David Miller <davem@davemloft.net>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: bnxt: Fix a uninitialized variable warning.
References: <1537246516-33100-1-git-send-email-zhongjiang@huawei.com> <CACKFLin=rgt7EyWJ-P5jhkAQR5NweCWp-5AZN=FoH+AGpVNZWw@mail.gmail.com>
In-Reply-To: <CACKFLin=rgt7EyWJ-P5jhkAQR5NweCWp-5AZN=FoH+AGpVNZWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/18 15:02, Michael Chan wrote:
> On Mon, Sep 17, 2018 at 9:55 PM, zhong jiang <zhongjiang@huawei.com> wrote:
>> Fix the following compile warning:
>>
>> drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c:49:5: warning: ‘nvm_param.dir_type’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>>   if (nvm_param.dir_type == BNXT_NVM_PORT_CFG)
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>> index f3b9fbc..1ae56fc 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>> @@ -46,6 +46,9 @@ static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
>>                 }
>>         }
>>
>> +       if (i == ARRAY_SIZE(nvm_params))
>> +               return -EINVAL;
>> +
> -EOPNOTSUPP might be a better return code.  Other than that, it looks
> good to me.  Thanks.
Thanks for suggestion.  Will repost.

Sincerely,
zhong jiang
>>         if (nvm_param.dir_type == BNXT_NVM_PORT_CFG)
>>                 idx = bp->pf.port_id;
>>         else if (nvm_param.dir_type == BNXT_NVM_FUNC_CFG)
>> --
>> 1.7.12.4
>>
>


