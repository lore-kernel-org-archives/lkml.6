Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279B0ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB19C214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB19C214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbeISH2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:28:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728226AbeISH2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:28:33 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8E72B22691DBB;
        Wed, 19 Sep 2018 09:53:06 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 09:53:03 +0800
Message-ID: <5BA1ABFB.2080401@huawei.com>
Date:   Wed, 19 Sep 2018 09:52:59 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Andy Gross <andy.gross@linaro.org>
CC:     <david.brown@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: qcom: Fix a uninitialized warning.
References: <1537247208-33632-1-git-send-email-zhongjiang@huawei.com> <20180918171707.GA6240@hector.localdomain>
In-Reply-To: <20180918171707.GA6240@hector.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/19 1:17, Andy Gross wrote:
> On Tue, Sep 18, 2018 at 01:06:48PM +0800, zhong jiang wrote:
>> Fix the following compile warning:
>>
>> drivers/soc/qcom/cmd-db.c:194:38: warning: 'ent.addr' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>   return ret < 0 ? 0 : le32_to_cpu(ent.addr);
>>
>> drivers/soc/qcom/cmd-db.c:247:38: warning: 'ent.len' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>   return ret < 0 ? 0 : le16_to_cpu(ent.len);
>>
>> drivers/soc/qcom/cmd-db.c:269:24: warning: 'ent.addr' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>   addr = le32_to_cpu(ent.addr);
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/soc/qcom/cmd-db.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
> This is kind of an odd subject for the patch.  It should be something like
> drivers: qcom: cmd-db: XXXXXXXXXXXXX
>
> ASOC is sound related.
Thank you for your reply and review.  I will update the subject and repost.

Sincerely,
zhong jiang
>
> Regards,
>
> Andy
>
>


