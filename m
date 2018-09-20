Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B814C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11D521531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F+ZxiDYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11D521531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbeITUIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:08:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52478 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731135AbeITUIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:08:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8KEIp05142883;
        Thu, 20 Sep 2018 14:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=nHKiJk8rpfpezRHqmd2UI47n0rjXWHA6Ul5QpzGxKLk=;
 b=F+ZxiDYmQKOSJobDd3wNUIXkhfKKCrO1r64t2F0S0kYHECjLjsixoJZiU2wIJ0Uxc5Rm
 cS6tHa8NZVsSWT8lsnduB4Rs88Wc+VVyQJO6tR0EQ/tCvBndpsT6DXEMkjRrXwXhxEk9
 pVJueiw6lxXQYkW+OyxQmNKOGrQCihd3lvGGnSuaXoNyxVS0PeQMiZI2mAbekpsdxO+p
 4wxS0JRSgHH4X59v1v7IoYMOjE1a/0Yt0BmOgXWTVtXhELXHapjHYcbmdQLuF73PUh56
 hAvEgMD3MfspkgXosdsW+BEAchS0Z9h2hVNvhJrct/q0ErQCiHFeqdruGyGTnweU/4UD Pw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2mgt1q33q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 14:24:56 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8KEOs2S000931
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 14:24:55 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8KEOspi026180;
        Thu, 20 Sep 2018 14:24:54 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Sep 2018 07:24:54 -0700
Subject: Re: [PATCH] jfs: remove redundant dquot_initialize() in
 jfs_evict_inode()
To:     Chao Yu <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        "open list:JFS FILESYSTEM" <jfs-discussion@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>
References: <20180917071221.13187-1-yuchao0@huawei.com>
 <be3a41fb-9a83-19a8-b3da-ca91500471fc@kernel.org>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <d6360818-2808-d5a6-119d-97cb506b7d15@oracle.com>
Date:   Thu, 20 Sep 2018 09:24:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <be3a41fb-9a83-19a8-b3da-ca91500471fc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9021 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809200142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/18 9:18 AM, Chao Yu wrote:
> Ping,
> 
> Any comments?

Sorry for putting it off. It looks good to me. I'll push it upstream.

Thanks,
Dave

> 
> On 2018/9/17 15:12, Chao Yu wrote:
>> We don't need to call dquot_initialize() twice in jfs_evict_inode(),
>> remove one of them for cleanup.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/jfs/inode.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
>> index 054cc761b426..805ae9e8944a 100644
>> --- a/fs/jfs/inode.c
>> +++ b/fs/jfs/inode.c
>> @@ -166,7 +166,6 @@ void jfs_evict_inode(struct inode *inode)
>>  			/*
>>  			 * Free the inode from the quota allocation.
>>  			 */
>> -			dquot_initialize(inode);
>>  			dquot_free_inode(inode);
>>  		}
>>  	} else {
>>
