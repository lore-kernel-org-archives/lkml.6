Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC65C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9275821763
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9275821763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbeHMMGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:06:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57462 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727070AbeHMMGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:06:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9EF5A931F807;
        Mon, 13 Aug 2018 17:24:37 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Mon, 13 Aug 2018
 17:24:35 +0800
Subject: Re: [PATCH net-next] liquidio: remove set but not used variable
 'is25G'
To:     "Shaikh, Shahed" <Shahed.Shaikh@cavium.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Chickles, Derek" <Derek.Chickles@cavium.com>,
        "Burla, Satananda" <Satananda.Burla@cavium.com>,
        "Manlunas, Felix" <Felix.Manlunas@cavium.com>,
        "Vatsavayi, Raghu" <Raghu.Vatsavayi@cavium.com>
References: <20180813072118.12448-1-yuehaibing@huawei.com>
 <BY2PR07MB245416297A60474BA77A99A39D390@BY2PR07MB2454.namprd07.prod.outlook.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <ed5f3419-6324-0327-c3bf-04ad91b2c0b1@huawei.com>
Date:   Mon, 13 Aug 2018 17:24:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <BY2PR07MB245416297A60474BA77A99A39D390@BY2PR07MB2454.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/8/13 17:08, Shaikh, Shahed wrote:
>> -----Original Message-----
>> From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org> On
>> Behalf Of YueHaibing
>> Sent: Monday, August 13, 2018 12:51 PM
>> To: davem@davemloft.net; Chickles, Derek <Derek.Chickles@cavium.com>;
>> Burla, Satananda <Satananda.Burla@cavium.com>; Manlunas, Felix
>> <Felix.Manlunas@cavium.com>; Vatsavayi, Raghu
>> <Raghu.Vatsavayi@cavium.com>
>> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; YueHaibing
>> <yuehaibing@huawei.com>
>> Subject: [PATCH net-next] liquidio: remove set but not used variable 'is25G'
>>
>> External Email
>>
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/net/ethernet/cavium/liquidio/lio_ethtool.c: In function
>> 'lio_set_link_ksettings':
>> drivers/net/ethernet/cavium/liquidio/lio_ethtool.c:392:6: warning:
>>  variable 'is25G' set but not used [-Wunused-but-set-variable]
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/net/ethernet/cavium/liquidio/lio_ethtool.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
>> b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
>> index 807ea2c..5ce604a 100644
>> --- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
>> +++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
>> @@ -389,16 +389,13 @@ static int lio_set_link_ksettings(struct net_device
>> *netdev,
>>         struct lio *lio = GET_LIO(netdev);
>>         struct oct_link_info *linfo;
>>         struct octeon_device *oct;
>> -       u32 is25G = 0;
>>
>>         oct = lio->oct_dev;
>>
>>         linfo = &lio->linfo;
>>
>> -       if (oct->subsystem_id == OCTEON_CN2350_25GB_SUBSYS_ID ||
>> -           oct->subsystem_id == OCTEON_CN2360_25GB_SUBSYS_ID) {
>> -               is25G = 1;
>> -       } else {
>> +       if (!(oct->subsystem_id == OCTEON_CN2350_25GB_SUBSYS_ID ||
>> +             oct->subsystem_id == OCTEON_CN2360_25GB_SUBSYS_ID)) {
>>                 return -EOPNOTSUPP;
>>         }
> 
> You can also remove braces which are not required for single line.

Yes, thanks.  Will post v2

> Thanks,
> Shahed
> 
> 
> 

