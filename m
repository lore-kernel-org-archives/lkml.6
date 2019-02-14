Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC96EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BC02177E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437101AbfBNLkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:40:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388002AbfBNLkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:40:02 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ACFA64FFB4C498C3A9F2;
        Thu, 14 Feb 2019 19:39:37 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Thu, 14 Feb 2019
 19:39:29 +0800
Subject: Re: [PATCH v2 0/2] Work around for Hisilicon CPPC cpufreq
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <gcherianv@gmail.com>, <pprakash@codeaurora.org>,
        <george.cherian@cavium.com>, <robert.moore@intel.com>
References: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2f397788-fcb0-a781-c497-9e698494f508@huawei.com>
Date:   Thu, 14 Feb 2019 11:39:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2019 07:46, Xiongfeng Wang wrote:
> Hisilicon chips do not support delivered performance counter register
> and reference performance counter register. But the platform can
> calculate the real performance using its own method. This patch provide
> a workaround for this problem, and other platforms can also use this
> workaround framework. We reuse the desired performance register to
> store the real performance calculated by the platform. After the
> platform finished the frequency adjust, it gets the real performance and
> writes it into desired performance register. OS can use it to calculate
> the real frequency.
>

It would be convenient for reviewers to detail what changed between 
versions in future.

John

> Xiongfeng Wang (2):
>   ACPI / CPPC: Add a helper to get desired performance
>   cpufreq / cppc: Work around for Hisilicon CPPC cpufreq
>
>  drivers/acpi/cppc_acpi.c       | 38 +++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 70 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h       |  1 +
>  3 files changed, 109 insertions(+)
>


