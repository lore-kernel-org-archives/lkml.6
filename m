Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeEVPPn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:15:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54676 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEVPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:15:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80FDA601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tbaicar@codeaurora.org
Subject: Re: [PATCH v6 2/2] acpi: apei: Do not panic() on PCIe errors reported
 through GHES
To: "Alex G." <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-3-mr.nuke.me@gmail.com>
 <CAJZ5v0h+U1zNK+LdOH_pU7kb+c6VK7erZCRqaV2WauDE2cwc6w@mail.gmail.com>
 <5a72a503-e8d5-c317-89b4-86e574c48064@gmail.com>
From: Tyler Baicar <tbaicar@codeaurora.org>
Message-ID: <50e318d3-b581-ad8b-d0e3-3e6c7b0da080@codeaurora.org>
Date: Tue, 22 May 2018 11:15:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5a72a503-e8d5-c317-89b4-86e574c48064@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/2018 10:32 AM, Alex G. wrote:
> I think the biggest problem is having a policy to panic on "fatal"
> errors, instead of letting the error handler make that decision. I'd
> much rather kill that stupid policy, but people seem to like it for some
> reason.
>
You can get around that panic and still have the error handled as AER_FATAL in
the current code. Your FW needs to mark the error as RECOVERABLE and then
set the CPER_SEC_RESET flag.

https://elixir.bootlin.com/linux/v4.17-rc6/source/drivers/acpi/apei/ghes.c#L450

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
