Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E097C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0842D218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfAYN6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:58:43 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59534 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726095AbfAYN6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:58:43 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 372D3AA3F930004B6C4E;
        Fri, 25 Jan 2019 21:58:41 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 25 Jan
 2019 21:58:34 +0800
Subject: Re: [PATCH 1/2] staging: erofs: use xattr_prefix to wrap up
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <weidu.du@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190125115103.47250-1-gaoxiang25@huawei.com>
 <20190125132614.GB1795@kadam>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <52def699-7f59-04d8-9045-6f85db11111a@huawei.com>
Date:   Fri, 25 Jan 2019 21:58:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190125132614.GB1795@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2019/1/25 21:26, Dan Carpenter wrote:
> On Fri, Jan 25, 2019 at 07:51:03PM +0800, Gao Xiang wrote:
>> Let's use xattr_prefix instead of open code.
>> No logic changes.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>>  drivers/staging/erofs/xattr.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
>> index 1c9498e38f0e..eca65df46133 100644
>> --- a/drivers/staging/erofs/xattr.c
>> +++ b/drivers/staging/erofs/xattr.c
>> @@ -521,7 +521,7 @@ static int xattr_entrylist(struct xattr_iter *_it,
>>  		return 1;
>>  
>>  	/* Note that at least one of 'prefix' and 'name' should be non-NULL */
> 
> The comment is sort of confusing now.

OK, I will remove this line.

And I think I will send the whole patchset instead of this cleanup patch
only after I test the ACL feature and confirm that it works.

Sorry again about the [PATCH 2/2]...

Thanks,
Gao Xiang

> 
>> -	prefix = h->prefix != NULL ? h->prefix : h->name;
>> +	prefix = xattr_prefix(h);
>>  	prefix_len = strlen(prefix);
> 
> regards,
> dan carpenter
> 
