Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEBBECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CBD21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CBD21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbeIULJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:09:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13091 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbeIULJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:09:14 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 09A8652E081AE;
        Fri, 21 Sep 2018 13:22:02 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 13:22:00 +0800
Message-ID: <5BA47FF7.8090906@huawei.com>
Date:   Fri, 21 Sep 2018 13:21:59 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     <davem@davemloft.net>, <dirk.vandermerwe@netronome.com>,
        <simon.horman@netronome.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: netronome: remove redundant continue
References: <1537430541-37817-1-git-send-email-zhongjiang@huawei.com> <20180920093857.6227710f@cakuba.netronome.com>
In-Reply-To: <20180920093857.6227710f@cakuba.netronome.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/21 0:38, Jakub Kicinski wrote:
> On Thu, 20 Sep 2018 16:02:21 +0800, zhong jiang wrote:
>> The continue will not truely skip any code. hence it is safe to
>> remove it.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> I think this came up during review at some point.  I still prefer to
> keep the continue.  The body of the loop performs initialization of
> objects, if an object is removed we shouldn't carry on with the body.
> It's easy to miss that the object got freed otherwise, there is no
> error being set and no warning printed...
IMO,  we should bring it back when the case truely occur you have said.  At present.
We should not take too much into account. Maybe it will not occur.

Thanks,
zhong jiang
>> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
>> index 0b1ac9c..50d7b58 100644
>> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
>> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
>> @@ -230,10 +230,8 @@ static void nfp_net_pf_free_vnics(struct nfp_pf *pf)
>>  		ctrl_bar += NFP_PF_CSR_SLICE_SIZE;
>>  
>>  		/* Kill the vNIC if app init marked it as invalid */
>> -		if (nn->port && nn->port->type == NFP_PORT_INVALID) {
>> +		if (nn->port && nn->port->type == NFP_PORT_INVALID)
>>  			nfp_net_pf_free_vnic(pf, nn);
>> -			continue;
>> -		}
>>  	}
>>  
>>  	if (list_empty(&pf->vnics))
>
> .
>


