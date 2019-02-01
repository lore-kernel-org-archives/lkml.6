Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D87CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B432184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfBAIbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:31:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49500 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbfBAIbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:31:52 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 20CD6C916FF1BD67CEA3;
        Fri,  1 Feb 2019 16:31:50 +0800 (CST)
Received: from [127.0.0.1] (10.151.21.212) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 16:31:44 +0800
Subject: Re: [PATCH] staging: android: ion: fix sys heap pool's gfp_flags
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <labbott@redhat.com>, <sumit.semwal@linaro.org>,
        <gregkh@linuxfoundation.org>, <arve@android.com>,
        <tkjos@android.com>, <maco@android.com>,
        <devel@driverdev.osuosl.org>, <puck.chen@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <kongfei@hisilicon.com>, <linaro-mm-sig@lists.linaro.org>,
        <daniel.liuyi@hisilicon.com>, <yudongbin@hisilicon.com>
References: <1549004386-38778-1-git-send-email-saberlily.xia@hisilicon.com>
 <20190201081530.GC14343@kadam>
From:   "Xiaqing (A)" <saberlily.xia@hisilicon.com>
Message-ID: <b39b4839-ee9a-802b-8d46-674a61adfa8c@hisilicon.com>
Date:   Fri, 1 Feb 2019 16:30:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190201081530.GC14343@kadam>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.21.212]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/2/1 16:15, Dan Carpenter wrote:
> On Fri, Feb 01, 2019 at 02:59:46PM +0800, Qing Xia wrote:
>> In the first loop, gfp_flags will be modified to high_order_gfp_flags,
>> and there will be no chance to change back to low_order_gfp_flags.
>>
>> Fixes: e7f63771 ("ION: Sys_heap: Add cached pool to spead up cached buffer alloc")
> 
> Huh...  Presumably you found this bug just by reading the code.  I
> wonder how it affects runtime?
> 
The problem is that when I found that there was no page allocation failure warning
after the failure of the ion alloc in my test, and then I found the problem of gfp_flags.

regards,
Qing

> regards,
> dan carpenter
> 
> 
> .
> 

