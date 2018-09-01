Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1B7C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 06:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4743C20837
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 06:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4743C20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeIALFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 07:05:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbeIALFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 07:05:35 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0EE9079EB8334;
        Sat,  1 Sep 2018 14:54:35 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Sat, 1 Sep 2018
 14:54:33 +0800
Subject: Re: [PATCH v2] rsi: remove set but not used variable 'header_size'
To:     Siva Rebbagondla <siva8118@gmail.com>
References: <20180831111325.16984-1-yuehaibing@huawei.com>
 <CANGSkXTDOa-TCz2wbNh7=C9px4_T7besT6jBPzfs70kVoK+PtA@mail.gmail.com>
CC:     Kalle Valo <kvalo@codeaurora.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        Amit karwar <amit.karwar@redpinesignals.com>,
        <pavani.muthyala@redpinesignals.com>, <keescook@chromium.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <6216c073-dadc-e593-dbb6-7c5b1cb7ee70@huawei.com>
Date:   Sat, 1 Sep 2018 14:54:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CANGSkXTDOa-TCz2wbNh7=C9px4_T7besT6jBPzfs70kVoK+PtA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/1 11:41, Siva Rebbagondla wrote:
> On Fri, Aug 31, 2018 at 4:45 PM YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/net/wireless/rsi/rsi_91x_hal.c: In function 'rsi_send_data_pkt':
>> drivers/net/wireless/rsi/rsi_91x_hal.c:288:5: warning:
>>  variable 'header_size' set but not used [-Wunused-but-set-variable]
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>> v2: remove unused 'tx_params'
>> ---
>>  drivers/net/wireless/rsi/rsi_91x_hal.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
>> index 01edf96..182b066 100644
>> --- a/drivers/net/wireless/rsi/rsi_91x_hal.c
>> +++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
>> @@ -282,10 +282,8 @@ int rsi_send_data_pkt(struct rsi_common *common, struct sk_buff *skb)
>>         struct rsi_hw *adapter = common->priv;
>>         struct ieee80211_vif *vif;
>>         struct ieee80211_tx_info *info;
>> -       struct skb_info *tx_params;
>>         struct ieee80211_bss_conf *bss;
>>         int status = -EINVAL;
>> -       u8 header_size;
>>
>>         if (!skb)
>>                 return 0;
>> @@ -297,8 +295,6 @@ int rsi_send_data_pkt(struct rsi_common *common, struct sk_buff *skb)
>>                 goto err;
>>         vif = info->control.vif;
>>         bss = &vif->bss_conf;
>> -       tx_params = (struct skb_info *)info->driver_data;
>> -       header_size = tx_params->internal_hdr_size;
> Yes, These redundant variables shall be removed.
>>
>>         if (((vif->type == NL80211_IFTYPE_STATION) ||
>>              (vif->type == NL80211_IFTYPE_P2P_CLIENT)) &&
>> --
>> 2.7.0
>>
>>
> Also, Patch title also can be changed to "[v2] rsi: remove unused variables"

Ok, will fix in v3.

Thank you.

> 
> Thanks,
> Siva Rebbagondla
> 
> .
> 

