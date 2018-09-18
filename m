Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810CEECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EDB21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EDB21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbeIRTkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:40:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12606 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727846AbeIRTkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:40:12 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 85F7459D4BA4;
        Tue, 18 Sep 2018 22:06:17 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 18 Sep
 2018 22:06:10 +0800
Subject: Re: [PATCH] staging: erofs: initialize `pblk' with 0 first in
 `z_erofs_map_blocks_iter'
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20180918130911.GA16187@kroah.com>
 <1537278276-110982-1-git-send-email-gaoxiang25@huawei.com>
 <20180918135745.GA25679@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <434e3781-23da-c69f-1ed1-066e3879cd80@huawei.com>
Date:   Tue, 18 Sep 2018 22:06:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180918135745.GA25679@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/9/18 21:57, Greg Kroah-Hartman wrote:
> On Tue, Sep 18, 2018 at 09:44:36PM +0800, Gao Xiang wrote:
>> This commit message helps to understand why `pblk' is assigned with 0 here.
>>
>> [ Greg reported a warning raised by gcc. ]
>> In file included from drivers/staging/erofs/unzip_vle.h:16:0,
>>                  from drivers/staging/erofs/unzip_vle.c:13:
>> drivers/staging/erofs/unzip_vle.c: In function ‘z_erofs_map_blocks_iter’:
>> drivers/staging/erofs/internal.h:303:34: warning: ‘pblk’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>>  #define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
>>                                   ^
>> drivers/staging/erofs/unzip_vle.c:1574:20: note: ‘pblk’ was declared here
>>   erofs_blk_t mblk, pblk;
>>                     ^~~~
>>
>> Actually, it is a false-positive warning when looking into that. [1]
>> Just initialize the variable to keep gcc from printing foolish warnings.
>>
>> [1] https://lists.ozlabs.org/pipermail/linux-erofs/2018-September/000637.html
>>
>> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Thanks-to: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>>  drivers/staging/erofs/unzip_vle.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Please roll this into the original patch.  I have dropped that whole
> series from my tree, it is no longer present and needs to be resent in
> order for me to be able to accept any of these.

OK, will send. it's my honor.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 
