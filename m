Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F254C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA192075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA192075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbeIDGw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 02:52:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11223 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbeIDGw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 02:52:56 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D4157FA701A39;
        Tue,  4 Sep 2018 10:29:59 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Tue, 4 Sep 2018
 10:29:55 +0800
Subject: Re: [PATCH net-next] i40e: remove inline directive
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <davem@davemloft.net>, <jeffrey.t.kirsher@intel.com>
References: <20180903123621.8696-1-yuehaibing@huawei.com>
 <b7bfa13d-d33d-87f1-6f0a-95d040610847@cogentembedded.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <814ba312-37a9-40c0-710b-cafac9d7278c@huawei.com>
Date:   Tue, 4 Sep 2018 10:29:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <b7bfa13d-d33d-87f1-6f0a-95d040610847@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/4 0:05, Sergei Shtylyov wrote:
> On 09/03/2018 03:36 PM, YueHaibing wrote:
> 
>> Fixes follow gcc warning:
>>
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function '__i40e_add_stat_strings':
>> drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error: function '__i40e_add_stat_strings' can never be inlined because it uses variable argument lists
>>
>> Fixes: 8fd75c58a09a ("i40e: move ethtool stats boiler plate code to i40e_ethtool_stats.h")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
>> index bba1cb0..0290ade 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
>> @@ -190,7 +190,7 @@ i40e_add_queue_stats(u64 **data, struct i40e_ring *ring)
>>   * Format and copy the strings described by stats into the buffer pointed at
>>   * by p.
>>   **/
>> -static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
>> +static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
>>  				    const unsigned int size, ...)
>>  {
>>  	unsigned int i;
> 
>    You now need to move this function to a .c file and leave here only its prototype.

Thanks, will send v2.

> 
> MBR, Sergei
> 
> .
> 

