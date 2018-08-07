Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73675C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C9A2178F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C9A2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbeHGOKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:10:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11525 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbeHGOKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:10:46 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w77BnGBM005275;
        Tue, 7 Aug 2018 13:56:22 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2knxjnafat-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 07 Aug 2018 13:56:22 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3B9D731;
        Tue,  7 Aug 2018 11:56:22 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0CCC12D34;
        Tue,  7 Aug 2018 11:56:22 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 7 Aug
 2018 13:56:21 +0200
Subject: Re: [PATCH 1/3] ARM: dts: stm32: Fix DT dtc warnings for stm32h7
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     <patrice.chotard@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lee.jones@linaro.org>
CC:     <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1533639995-27047-1-git-send-email-patrice.chotard@st.com>
 <1533639995-27047-2-git-send-email-patrice.chotard@st.com>
 <8bd7a402-fc88-f4d9-451f-9533f2898ce0@st.com>
Message-ID: <f5933d5c-8da3-5112-351c-6b1ba669a9b6@st.com>
Date:   Tue, 7 Aug 2018 13:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8bd7a402-fc88-f4d9-451f-9533f2898ce0@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrice

On 08/07/2018 01:38 PM, Alexandre Torgue wrote:
>> +    #address-cells = <1>;
>> +    #size-cells = <1>;
>> +
>>       clocks {
>>           clk_hse: clk-hse {
>>               #clock-cells = <0>;
>> @@ -60,7 +62,7 @@
>>               clock-frequency = <32768>;
>>           };
>> -        clk_i2s: i2s_ckin {
>> +        clk_i2s: i2s-ckin {
> 
> clock driver deals with "i2s_ckin" for clock  source selection. I need 
> to check deeper if this change could cause an issue.

Sorry I didn't check in the well driver. As far I can see it's ok for 
this part of patch.

cheers
Alex

> 
> thx
> Alex
