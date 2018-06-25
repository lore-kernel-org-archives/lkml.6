Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7C2C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0E725C05
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0E725C05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934729AbeFYPGA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:06:00 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:31470 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934567AbeFYPF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:05:58 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5PExIkD024566;
        Mon, 25 Jun 2018 17:05:15 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ju0hc8mr9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 Jun 2018 17:05:15 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 742CC38;
        Mon, 25 Jun 2018 15:05:14 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5310226D6;
        Mon, 25 Jun 2018 15:05:14 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Jun
 2018 17:05:13 +0200
Subject: Re: [PATCH V4 2/4] watchdog: stm32: add pclk feature for stm32mp1
To:     Guenter Roeck <linux@roeck-us.net>,
        Ludovic BARRE <ludovic.barre@st.com>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
 <1529571737-3552-3-git-send-email-ludovic.Barre@st.com>
 <20180621165335.GA4563@roeck-us.net>
 <0bfe0082-2134-2d3b-322f-cd6c193a9974@st.com>
 <3f65a889-f625-9521-ea09-bcf7b5b24927@roeck-us.net>
 <b5f62568-ff2f-4a04-212e-a952bf009c88@st.com>
 <d92ec883-09ae-271f-69dd-156df17c3e98@roeck-us.net>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <630b72f7-d7f1-2975-8974-f6540f1b61dc@st.com>
Date:   Mon, 25 Jun 2018 17:04:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d92ec883-09ae-271f-69dd-156df17c3e98@roeck-us.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/25/2018 03:15 PM, Guenter Roeck wrote:
> On 06/25/2018 05:52 AM, Alexandre Torgue wrote:
>> Hi Guenter,
>>
>>
>>>> But you are right I forgot to change stm32f429.dtsi.
>>>> If I add a commit for stm32f429.dtsi, it's Ok for you ?
>>>>
>>>
>>> Not really. You are imposing a personal preference on others,
>>> and you would make stm32f429.dtsi inconsistent since it doesn't
>>> use clock names for anything else.This in turn means that people
>>> will have an endless source of irritation since they will need
>>> a clock name for this node but not for others.
>>
>> Why? This kind of implementation depends on each driver. Isn't ?
>>
>> Or do you mean that if iwdg driver uses this implementation (clock 
>> name usage) all nodes inside stm32f429.dtsi should follow the same 
>> implementation ?
>>
>>>
>>> You will have to get the arm and DT maintainers to agree on this change.
>>
>> As this patch makes easier integration of new platform, I agree with 
>> Ludovic proposition.
>>
> 
> Please provide a formal Acked-by:.
Sure

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

Ludovic, can you please resend a version by adding updates for 
stm32f429.dtsi.

Thanks
Alex

> 
> Guenter
