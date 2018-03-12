Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeCLMNa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:13:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59697 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751053AbeCLMN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:13:29 -0400
Subject: Re: [RFC PATCH 0/4] add support for CommonLPIAff field
To: Marc Zyngier <marc.zyngier@arm.com>
References: <1520837395-10288-1-git-send-email-yangyingliang@huawei.com>
 <3b6997c9-761f-3f5e-79ac-6b785a9a14d9@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5AA66ED7.7080007@huawei.com>
Date: Mon, 12 Mar 2018 20:13:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <3b6997c9-761f-3f5e-79ac-6b785a9a14d9@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/3/12 17:55, Marc Zyngier wrote:
> On 12/03/18 06:49, Yang Yingliang wrote:
>> This patch set adjust struct rdists to support CommonLPIAff field.
>> This field is described in spec:
>>
>> CommonLPIAff, bits [25:24]
>> The affinity level at which Redistributors share a LPI Configuration table.
>> 00 All Redistributors must share a LPI Configuration table.
>> 01 All Redistributors with the same Aff3 value must share an LPI Configurationt table.
>> 10 All Redistributors with the same Aff3.Aff2 value must share an LPI Configuration table.
>> 11 All Redistributors with the same Aff3.Aff2.Aff1 value must share an LPI Configuration
>> table.
>
> What are you trying to achieve here? We already share the same
> configuration table across all the redistributors, irrelevant the of
> CommonLPIAff. Why would we need to do anything else?

In some cases, such as "with the same Aff3.Aff2 value must share an LPI
Configuration table", redistributors will access local memory node
only, it may improve the performance. And I don't have any beneficial
data now. I may provide it later.

Regards,
Yang
>
> Thanks,
>
> 	M.
>
