Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeEVPSH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:18:07 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45764 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeEVPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:18:04 -0400
X-Google-Smtp-Source: AB8JxZr7FYHVUfINDxbi2xERy6XeZGWO1ufieTWA7XqdVrzrRt6LqsOwMOQ+q5rgJTnABzEUNGbWCQ==
Subject: Re: [PATCH v6 2/2] acpi: apei: Do not panic() on PCIe errors reported
 through GHES
To: Tyler Baicar <tbaicar@codeaurora.org>,
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
 <50e318d3-b581-ad8b-d0e3-3e6c7b0da080@codeaurora.org>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <cf2e0a02-fb99-efde-0b41-63585c9d8844@gmail.com>
Date: Tue, 22 May 2018 10:18:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <50e318d3-b581-ad8b-d0e3-3e6c7b0da080@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/22/2018 10:15 AM, Tyler Baicar wrote:
> On 5/22/2018 10:32 AM, Alex G. wrote:
>> I think the biggest problem is having a policy to panic on "fatal"
>> errors, instead of letting the error handler make that decision. I'd
>> much rather kill that stupid policy, but people seem to like it for some
>> reason.
>>
> You can get around that panic and still have the error handled as
> AER_FATAL in
> the current code. Your FW needs to mark the error as RECOVERABLE and then
> set the CPER_SEC_RESET flag.

Of course, that would be ideal. But experience shows that firmware
doesn't do this. That's the whole point: firmware sends questionable data.

Alex

> https://elixir.bootlin.com/linux/v4.17-rc6/source/drivers/acpi/apei/ghes.c#L450
> 
> 
> Thanks,
> Tyler
> 
