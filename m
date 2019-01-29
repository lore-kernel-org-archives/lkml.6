Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013DFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E8220856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y1X2bi7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfA2Sep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:34:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57230 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbfA2Seo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:34:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0TIYD8L133387;
        Tue, 29 Jan 2019 18:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ypH7IrrNSWOceZlUho1WTRsdQ0nuKO44mMungza/3/A=;
 b=y1X2bi7nnXUjeIWIjUSzEVgsrcIT92rw30GieotdgqpFwtJaIOTEm2ZegvstNJwbrNSu
 cbeFf9WWZLbJnlUho6RCSKlcNEPLSMAYlU6vVl7ELkDm0vAZmgp7gLEeYK5CXQvY+P86
 idvn1WICvXOy6CkFdMo6R/qbZYY2k5jGWHQxTeSxxgljIcoKgx6C4flhPwrtUOR+OKd+
 5nAMZDVzJFv1dBKDbhivXpMF1ZoZxg2XWJbXcf9W38JBOi1TDVzAOdH4UNUeDsXmJcvy
 seZdzqSLQzM035hTrUpUcYoZ96t47xlEbG0UhnVJyU7qjDIRIL7jIaH6ib6Ao8t3sKWe Ew== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2q8g6r64y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 18:34:34 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0TIYXVX004572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 18:34:33 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0TIYWsr014197;
        Tue, 29 Jan 2019 18:34:33 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Jan 2019 10:34:32 -0800
Subject: Re: [PATCH] soc: ti: knav_dma: Use proper enum in pktdma_init_chan
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181211004114.28029-1-natechancellor@gmail.com>
 <20190126191115.GA25003@archlinux-ryzen>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <d7057508-8800-8998-f9fb-1db5659d182d@oracle.com>
Date:   Tue, 29 Jan 2019 10:35:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190126191115.GA25003@archlinux-ryzen>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9151 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=852
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/2019 11:11 AM, Nathan Chancellor wrote:
> On Mon, Dec 10, 2018 at 05:41:14PM -0700, Nathan Chancellor wrote:
>> Clang warns when one enumerated type is implicitly converted to another:
>>
>> drivers/soc/ti/knav_dma.c:601:20: warning: implicit conversion from
>> enumeration type 'enum dma_data_direction' to different enumeration type
>> 'enum dma_transfer_direction' [-Wenum-conversion]
>>          chan->direction = DMA_NONE;
>>                          ~ ^~~~~~~~
>> 1 warning generated.
>>
>> While DMA_NONE and DMA_TRANS_NONE have different values, there is no
>> functional change because direction is never checked against DMA_NONE,
>> only against DMA_MEM_TO_DEV and DMA_DEV_TO_MEM.
>>
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> ---
>>   drivers/soc/ti/knav_dma.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
>> index e05ab16d9a9e..6285cd8efb21 100644
>> --- a/drivers/soc/ti/knav_dma.c
>> +++ b/drivers/soc/ti/knav_dma.c
>> @@ -598,7 +598,7 @@ static int pktdma_init_chan(struct knav_dma_device *dma,
>>   
>>   	INIT_LIST_HEAD(&chan->list);
>>   	chan->dma	= dma;
>> -	chan->direction	= DMA_NONE;
>> +	chan->direction	= DMA_TRANS_NONE;
>>   	atomic_set(&chan->ref_count, 0);
>>   	spin_lock_init(&chan->lock);
>>   
>> -- 
>> 2.20.0
>>
> 
> Ping?
>I have marked this to picked up. Thanks !!

