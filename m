Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeFEQib (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:38:31 -0400
Received: from foss.arm.com ([217.140.101.70]:58358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751688AbeFEQi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:38:29 -0400
Subject: Re: [PATCH v2 3/3] arm64: disable ACPI PPTT support temporarily
To: Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>
References: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com>
 <1528209304-3280-3-git-send-email-sudeep.holla@arm.com>
 <CAJZ5v0hn+sya29bZJzksDEDt2QPZDY36Hwn=ckw3ikTGp7T1Zw@mail.gmail.com>
 <a93212e3-7965-9ae2-34b0-407f04590567@arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <10ae59bd-1767-317e-111d-d4d4d71e077a@arm.com>
Date: Tue, 5 Jun 2018 11:38:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a93212e3-7965-9ae2-34b0-407f04590567@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/05/2018 10:27 AM, Sudeep Holla wrote:
> 
> 
> On 05/06/18 16:02, Rafael J. Wysocki wrote:
>> On Tue, Jun 5, 2018 at 4:35 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> Currently, ARM64 doesn't support updating the CPU topology masks on
>>> CPU hotplug operations. ACPI PPTT support rely on that missing feature
>>> which is technically not incorrect. Instead of reverting all the PPTT
>>> support, let's keep it simple and disable ACPI PPTT support on ARM64
>>> for time-being until the topology updates are added for CPU hotplug
>>> operations.
>>
>> When is that going to happen?
>>> Nobody else uses PPTT now.
>>
> 
> No we need it on ARM64. I have even the fixes for the original issue
> but it's bit invasive and too late as we are already in the merge
> window. It needs to be tested on NUMA platforms, I have asked for that
> explicitly.
> 

So, there is a lot simpler fix for this, and its to remove the numa mask 
dependency from the scheduler domain building. That is just a couple 
line fix, and it reverts !ACPI to its original behavior, while the ACPI 
LLC building will work around the NUMA in package issue that caused 
patch 12/12 as the machine in question doesn't have a LLC crossing numa 
domains.
