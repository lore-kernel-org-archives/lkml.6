Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F01C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DE7214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfA2Ixc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:53:32 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36080 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbfA2Ixb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:53:31 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3FF769CD6482AC19C798;
        Tue, 29 Jan 2019 16:53:29 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 29 Jan
 2019 16:53:21 +0800
Subject: Re: [PATCH v4 2/2] staging: erofs: complete POSIX ACL support
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <weidu.du@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190129083520.28607-1-gaoxiang25@huawei.com>
 <20190129083520.28607-2-gaoxiang25@huawei.com> <20190129084320.GN1795@kadam>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <acf57850-cf3f-76e3-5d61-6720dd1af5c4@huawei.com>
Date:   Tue, 29 Jan 2019 16:53:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190129084320.GN1795@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/29 16:43, Dan Carpenter wrote:
> On Tue, Jan 29, 2019 at 04:35:20PM +0800, Gao Xiang wrote:
>> Let's add .get_acl() to read the file's acl from its xattrs
>> to make POSIX ACL usable.
>>
>> Here is the on-disk detail,
>> fullname: system.posix_acl_access
>> struct erofs_xattr_entry:
>>         .e_name_len = 0
>>         .e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS (2)
>>
>> fullname: system.posix_acl_default
>> struct erofs_xattr_entry:
>> 	.e_name_len = 0
>> 	.e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT (3)
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>> change log v4:
>>  - leave kmalloc and wait the conclusion of fault injection
>>    pointed out by Dan Carpenter;
> 
> I do think this is the right thing, but I also wasn't going to ask you
> do redo v3.  Anyway, thanks!
> 
> regards,
> dan carpenter

OK, let's wait the Chao's idea then...

Thanks,
Gao Xiang

> 
