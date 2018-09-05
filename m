Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2374C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737B820861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737B820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIEP7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:59:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727530AbeIEP7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:59:51 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F0F1C4D822E04;
        Wed,  5 Sep 2018 19:29:59 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Wed, 5 Sep 2018
 19:29:59 +0800
Subject: Re: [PATCH net-next] bnxt_en: Properly get address type of
 encapsulation IP headers
To:     Sathya Perla <sathya.perla@broadcom.com>
References: <20180901092529.11828-1-yuehaibing@huawei.com>
 <CAKvpyk3RZB8ioSKLRxjD-DsJwsFOEsum9r2kH34WkktLkd9FNg@mail.gmail.com>
CC:     David Miller <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <93182032-de54-03b1-eeeb-3ea5fa644f83@huawei.com>
Date:   Wed, 5 Sep 2018 19:29:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAKvpyk3RZB8ioSKLRxjD-DsJwsFOEsum9r2kH34WkktLkd9FNg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/4 14:01, Sathya Perla wrote:
> On Sat, Sep 1, 2018 at 2:56 PM YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c: In function 'bnxt_tc_parse_flow':
>> drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c:186:6: warning:
>>  variable 'addr_type' set but not used [-Wunused-but-set-variable]
>>
>> As done elsewhere in TC/flower offload code, the address type of
>> the encapsulation IP headers should be realized accroding to the
>> addr_type field of the encapsulation control dissector key.
> ...
>>  drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
>> index 092c817..5c625e5 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
>> @@ -242,7 +242,7 @@ static int bnxt_tc_parse_flow(struct bnxt *bp,
>>                 flow->l2_key.num_vlans = 1;
>>         }
>>
>> -       if (dissector_uses_key(dissector, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
> 
>  __skb_flow_dissect() (in net/core/flow_dissector.c) uses the same
> construct. So, can you clarify what you are trying to fix here
> functionally. Thanks.
> 
sorry, I misread the code.

However, the 'addr_type' can be removed.  Will send a new cleanup patch.

> .
> 

