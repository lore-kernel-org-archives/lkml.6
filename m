Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC76C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E5B20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E5B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbeHALFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:05:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51901 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732437AbeHALFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:05:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4CFE02FC52C9A;
        Wed,  1 Aug 2018 17:20:10 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 1 Aug 2018
 17:20:04 +0800
Subject: Re: [PATCH 1/2] staging: erofs: add the missing break in
 z_erofs_map_blocks_iter
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <yuchao0@huawei.com>,
        <linux-erofs@lists.ozlabs.org>, <hsiangkao@aol.com>,
        <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        <miaoxie@huawei.com>, <chao@kernel.org>
References: <1532915461-2512-1-git-send-email-gaoxiang25@huawei.com>
 <1533105511-26197-1-git-send-email-gaoxiang25@huawei.com>
 <20180801090243.ah7lhj2h6hjtvn4a@mwanda>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <ea978a27-efd4-9d58-e4c0-f9d00420304f@huawei.com>
Date:   Wed, 1 Aug 2018 17:19:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180801090243.ah7lhj2h6hjtvn4a@mwanda>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2018/8/1 17:02, Dan Carpenter wrote:
> On Wed, Aug 01, 2018 at 02:38:30PM +0800, Gao Xiang wrote:
>> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
>> index bd2d7a8..6d3ab31 100644
>> --- a/drivers/staging/erofs/unzip_vle.c
>> +++ b/drivers/staging/erofs/unzip_vle.c
>> @@ -1596,10 +1596,10 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>>  	cluster_type = vle_cluster_type(di);
>>  
>>  	switch (cluster_type) {
>> -	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
>> +	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:	/* fallthrough */
> This fallthrough comment is in the wrong place.  It should be at the end
> where the break would have been.  Like this:
> 
> 	switch (cluster_type) {
> 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> 		frob();
> 		frob();
> 		frob();
> 		/* fallthrough */
> 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> 		frob();
> 

I am sorry.. I will send a new patch.
Thanks for your reply...

Thanks,
Gao Xiang

> regards,
> dan carpenter
> 
