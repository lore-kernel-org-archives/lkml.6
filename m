Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D1AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0053A208DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0053A208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeHBIGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:06:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55444 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726194AbeHBIGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:06:35 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 40D91EE180E94;
        Thu,  2 Aug 2018 14:16:59 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Thu, 2 Aug 2018
 14:16:49 +0800
Message-ID: <5B62A1CF.7040904@huawei.com>
Date:   Thu, 2 Aug 2018 14:16:47 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     John Garry <john.garry@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <aacraid@microsemi.com>, linux-scsi <linux-scsi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] driver/scsi/fnic/fnic_trace: Use vzalloc to zero
 instead of vmalloc+memset
References: <1533129976-51930-1-git-send-email-zhongjiang@huawei.com> <1533129976-51930-2-git-send-email-zhongjiang@huawei.com> <CAHp75Vchu7QwNBeYQxa9fY8=PinGzPpUPaRbk_MyoZ+w07hA4A@mail.gmail.com>
In-Reply-To: <CAHp75Vchu7QwNBeYQxa9fY8=PinGzPpUPaRbk_MyoZ+w07hA4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/1 23:30, Andy Shevchenko wrote:
> On Wed, Aug 1, 2018 at 4:26 PM, zhong jiang <zhongjiang@huawei.com> wrote:
>> The vzalloc is better than vmalloc+memset, so replace them to make
>> the code concise.
>> -       fnic_trace_buf_p = (unsigned long)vmalloc((trace_max_pages * PAGE_SIZE));
>> +       fnic_trace_buf_p = (unsigned long)vzalloc((trace_max_pages * PAGE_SIZE));
> At the same time you may get rid of unnecessary parens.
>
Thanks , I will repost with the change.

Thanks
zhong jiang

