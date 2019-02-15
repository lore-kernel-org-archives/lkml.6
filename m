Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D900C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44F7222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfBOQbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:31:04 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:12875 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726137AbfBOQbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:31:04 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FGUiLv025972;
        Fri, 15 Feb 2019 17:30:47 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qmy1njgm8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 15 Feb 2019 17:30:47 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8574F31;
        Fri, 15 Feb 2019 16:30:46 +0000 (GMT)
Received: from Webmail-eu.st.com (gpxdag3node5.st.com [10.75.127.72])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 544B25AD5;
        Fri, 15 Feb 2019 16:30:46 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.47) by GPXDAG3NODE5.st.com
 (10.75.127.72) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Feb
 2019 17:30:45 +0100
Subject: Re: [PATCH 0/2] ARM errata 814220
To:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
 <CAK8P3a0mbEqfzQhP0qX3kSnErBLws9ojkmbVQng9HhujFLCMvA@mail.gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <755c9689-9027-b085-d511-05d833d1e6ef@st.com>
Date:   Fri, 15 Feb 2019 17:30:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0mbEqfzQhP0qX3kSnErBLws9ojkmbVQng9HhujFLCMvA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To GPXDAG3NODE5.st.com
 (10.75.127.72)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/19 3:52 PM, Arnd Bergmann wrote:
> On Wed, Feb 13, 2019 at 10:56 AM Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
>>
>> Implement ARM errata 814220 for Cortex A7.
>>
>> This patch has been wroten by Jason Liu years ago but never send upstream.
>> I have tried to contact the author on multiple email addresses but I haven't
>> found any valid one...
>> I have keep Jason's sign-off and just rebase the patch on to v5-rc6.
>>
>> Benjamin Gaignard (2):
>>    ARM: errata 814220-B-Cache maintenance by set/way operations can
>>      execute out of order.
>>    ARM: stm32: select ARM errata 814220
>>
>>   arch/arm/Kconfig            | 10 ++++++++++
>>   arch/arm/mach-stm32/Kconfig |  1 +
>>   arch/arm/mm/cache-v7.S      |  3 +++
>>   3 files changed, 14 insertions(+)
> 
> Looks good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> It probably makes most sense to keep them as a series, either
> through the soc tree or Russell's patch tracker, so feel free to add
> it there, and have them both in the stm32 soc branch for arm-soc
> if Russell prefers.

Russel, what do you think about Arnd proposition? I could take both
patches in my stm32 tree. It'll make part of future v5.2 pull request.

Alex


> 
> As we have a number of Cortex-A7 based platforms with all
> kinds of revisions, I wonder if we should also select the workaround
> for the others. I can probably figure out which SoC platforms
> are based on Cortex-A7, but I have no idea about the revisions,
> so that might mean we'd have to do it for all of them. According
> to the latest TRM I found, only revisions r0p0 through r0p5
> exist, and the erraturm text lists r0p2 through r0p5, which may
> mean all products ever shipped in practice (the oldest public
> TRM from 2012 already describe r0p3).
> 
> 
> 
> 
>       Arnd
> 
