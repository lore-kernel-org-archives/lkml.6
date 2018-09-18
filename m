Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1F6ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF1020867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF1020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeIRHa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:30:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbeIRHa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:30:56 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BEF1C34EBFD4E;
        Tue, 18 Sep 2018 10:00:44 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Tue, 18 Sep 2018
 10:00:41 +0800
Message-ID: <5BA05C48.4000700@huawei.com>
Date:   Tue, 18 Sep 2018 10:00:40 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Michael Chan <michael.chan@broadcom.com>
CC:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: bnxt: Fix a uninitialized variable warning.
References: <1537201883-2518-1-git-send-email-zhongjiang@huawei.com> <CACKFLineQuBTUGaBLgRqSTEcVzyZaZAnzy0jOHREKdtCqmy6pQ@mail.gmail.com>
In-Reply-To: <CACKFLineQuBTUGaBLgRqSTEcVzyZaZAnzy0jOHREKdtCqmy6pQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/18 1:36, Michael Chan wrote:
> On Mon, Sep 17, 2018 at 9:31 AM, zhong jiang <zhongjiang@huawei.com> wrote:
>> Fix the following compile warning:
>>
>> drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c:49:5: warning: ‘nvm_param.dir_type’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>>   if (nvm_param.dir_type == BNXT_NVM_PORT_CFG)
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>> index f3b9fbc..ab88217 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>> @@ -31,7 +31,7 @@ static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
>>  {
>>         struct hwrm_nvm_get_variable_input *req = msg;
>>         void *data_addr = NULL, *buf = NULL;
>> -       struct bnxt_dl_nvm_param nvm_param;
>> +       struct bnxt_dl_nvm_param nvm_param = {0};
>>         int bytesize, idx = 0, rc, i;
>>         dma_addr_t data_dma_addr;
>>
> I think it is better to return error if there is no param_id match
> after the for loop.  The for loop will initialize nvm_param if there
> is param_id match.
Will do in v2. Thanks for review.

Sincerely,
zhong jiang

