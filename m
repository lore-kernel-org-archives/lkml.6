Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeDAFon (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 01:44:43 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44884 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeDAFom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 01:44:42 -0400
X-Google-Smtp-Source: AIpwx49i61mNAA8SfCE47AFRvUpU5ap988BN0QVOf/uNc9NyKhg570VHdf1PmFf5MMDd2vW5HY0yQA==
Subject: Re: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
To: Yisheng Xie <xieyisheng1@huawei.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-3-git-send-email-nleeder@codeaurora.org>
 <883d32ce-6581-ecf6-5088-ecb238322ebe@huawei.com>
 <e55ab4404143ea0b3cc4795a93e37480@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>,
        Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        Neil Leeder <neil.m.leeder@gmail.com>
From: Neil Leeder <neil.m.leeder@gmail.com>
Message-ID: <14f90cc6-f2c1-5a63-67c6-a5c8ddb4799e@gmail.com>
Date: Sun, 1 Apr 2018 01:44:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e55ab4404143ea0b3cc4795a93e37480@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yisheng Xie,

On 3/29/2018 03:03 AM, Yisheng Xie wrote:
> 
> Hi Neil,
> 
> On 2017/8/5 3:59, Neil Leeder wrote:
>> +    mem_resource_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    mem_map_0 = devm_ioremap_resource(&pdev->dev, mem_resource_0);
>> +
> Can we use devm_ioremap instead? for the reg_base of smmu_pmu is
> IMPLEMENTATION DEFINED. If the reg of smmu_pmu is inside smmu,
> devm_ioremap_resource will failed and return -EBUSY, eg.:
> 
>   smmu reg ranges:        0x180000000 ~ 0x1801fffff
>   its smmu_pmu reg ranges:    0x180001000 ~ 0x180001fff
> 
Just to let you know that I no longer work at Qualcomm and I won't be 
able to provide updates to this patchset. I expect that others from my 
former team at Qualcomm will pick up ownership.

Neil
