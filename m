Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7B7C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F6E20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F6E20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbeJWQpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 12:45:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727470AbeJWQpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 12:45:45 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3B39ED9E0AB6;
        Tue, 23 Oct 2018 16:23:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Tue, 23 Oct 2018
 16:23:20 +0800
Message-ID: <5BCEDA77.9010505@huawei.com>
Date:   Tue, 23 Oct 2018 16:23:19 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Pkshih <pkshih@realtek.com>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtlwifi: remove set but not used variable 'radiob_array_table'
 and 'radiob_arraylen'
References: <1540273651-64688-1-git-send-email-zhongjiang@huawei.com> <1540281873.25715.2.camel@realtek.com>
In-Reply-To: <1540281873.25715.2.camel@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/23 16:05, Pkshih wrote:
> On Tue, 2018-10-23 at 13:47 +0800, zhong jiang wrote:
>> 'radiob_array_table' and 'radiob_arraylen' is not used after setting its
>> value.
>> It is safe to remove the unused variable.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
>> index 5cf29f5..3f33278 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
>> @@ -509,13 +509,10 @@ bool rtl8723e_phy_config_rf_with_headerfile(struct
>> ieee80211_hw *hw,
>>  	int i;
>>  	bool rtstatus = true;
>>  	u32 *radioa_array_table;
>> -	u32 *radiob_array_table;
>> -	u16 radioa_arraylen, radiob_arraylen;
>> +	u16 radioa_arraylen;
>>  
>>  	radioa_arraylen = RTL8723ERADIOA_1TARRAYLENGTH;
>>  	radioa_array_table = RTL8723E_RADIOA_1TARRAY;
>> -	radiob_arraylen = RTL8723E_RADIOB_1TARRAYLENGTH;
>> -	radiob_array_table = RTL8723E_RADIOB_1TARRAY;
>>  
>>  	rtstatus = true;
>>  
> I think 8723ae has only one antenna, so you can remove radio B array as well.
>
Yep,  Will do.

Thanks,
zhong jiang

