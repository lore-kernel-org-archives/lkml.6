Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFC4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E9C222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393877AbfBNPBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:01:20 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40984 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388581AbfBNPBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:01:18 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EEumXK025763;
        Thu, 14 Feb 2019 16:00:57 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qmwsum0k7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 14 Feb 2019 16:00:57 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8A4AC3A;
        Thu, 14 Feb 2019 15:00:56 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 53E1B56C3;
        Thu, 14 Feb 2019 15:00:56 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb
 2019 16:00:56 +0100
Subject: Re: [net-next, PATCH] net: stmmac: use correct define to get rx
 timestamp on GMAC4
To:     Jose Abreu <jose.abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1550153571-14404-1-git-send-email-alexandre.torgue@st.com>
 <7c03dff4-5185-dbd2-eeb4-867972512f2b@synopsys.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <a62c35de-7afa-14ec-5ca6-05bd61b6d09d@st.com>
Date:   Thu, 14 Feb 2019 16:00:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7c03dff4-5185-dbd2-eeb4-867972512f2b@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jose

On 2/14/19 3:18 PM, Jose Abreu wrote:
> Hi Alexandre,
> 
> On 2/14/2019 2:12 PM, Alexandre Torgue wrote:
>> In dwmac4_wrback_get_rx_timestamp_status we looking for a RX timestamp.
>> For that receive descriptors are handled and so we should use defines
>> related to receive descriptors. It'll no change the functional behavior
>> as RDES3_RDES1_VALID=TDES3_RS1V=BIT(26) but it makes code easier to read.
>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> index 20299f6..9f062b3 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> @@ -268,7 +268,7 @@ static int dwmac4_wrback_get_rx_timestamp_status(void *desc, void *next_desc,
>>   	int ret = -EINVAL;
>>   
>>   	/* Get the status from normal w/b descriptor */
>> -	if (likely(p->des3 & TDES3_RS1V)) {
>> +	if (likely(p->des3 & RDES3_RDES1_VALID)) {
> 
> Shouldn't this also use le32_to_cpu() like bellow ?

I agree. I focused on cosmetic but yes you are right, we have to take 
car about endianness as this IP is used by different processors (using 
different endianness). I gonna send a v2.
I think dwmac4_rx_check_timestamp have the same kind of issue. Another 
patch should be sent for it. no ?

regards
Alex



> 
> Thanks,
> Jose Miguel Abreu
> 
>>   		if (likely(le32_to_cpu(p->des1) & RDES1_TIMESTAMP_AVAILABLE)) {
>>   			int i = 0;
>>   
>>
