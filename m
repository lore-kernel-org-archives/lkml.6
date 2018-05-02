Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeEBT3r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 15:29:47 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:37659 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbeEBT3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 15:29:42 -0400
X-Google-Smtp-Source: AB8JxZqoeLNkboZTNGYrNId2SNJN5STUAlZOsHBE3UKnNiDFrbayWiFkJbrMc/TdHO2rkRqLTW+bEg==
Subject: Re: [RFC PATCH v3 3/3] acpi: apei: Warn when GHES marks correctable
 errors as "fatal"
To: Pavel Machek <pavel@ucw.cz>, Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-kernel@vger.kernel.org,
        devel@acpica.org
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-4-mr.nuke.me@gmail.com>
 <20180426112057.GB15009@pd.tnic> <20180502191029.hcvf56xbdna7oi4k@devuan>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <2e1b1d18-08b5-fa85-be7b-ab29ac2195b3@gmail.com>
Date: Wed, 2 May 2018 14:29:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180502191029.hcvf56xbdna7oi4k@devuan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 02:10 PM, Pavel Machek wrote:
> On Thu 2018-04-26 13:20:57, Borislav Petkov wrote:
>> On Wed, Apr 25, 2018 at 03:39:51PM -0500, Alexandru Gagniuc wrote:
>>> There seems to be a culture amongst BIOS teams to want to crash the
>>> OS when an error can't be handled in firmware. Marking GHES errors as
>>> "fatal" is a very common way to do this.
>>>
>>> However, a number of errors reported by GHES may be fatal in the sense
>>> a device or link is lost, but are not fatal to the system. When there
>>> is a disagreement with firmware about the handleability of an error,
>>> print a warning message.
> 
> 
>>> +
>>> +	if ((sev >= GHES_SEV_PANIC) && (ghes_actual_severity(ghes) < sev)) {
>>> +		pr_warn("FIRMWARE BUG: Firmware sent fatal error that we were able to correct");
>>> +		pr_warn("BROKEN FIRMWARE: Complain to your hardware vendor");
>>
>> Pasting the same comment from last time since you missed it:
>>
>> "No, I don't want any of that crap issuing stuff in dmesg and then people
>> opening bugs and running around and trying to replace hardware.
> 
> We want to see warnings. Maybe they can be toned done. We even have
> dedicated distros for firmware testing.

I'm told that had we had this warning when the r740 BIOS was in
development, we would have solved a lot of the issues that I'm currently
working on. That would, in turn, have exposed bigger issues, and we
would have had a platform to fix and test those bigger issues.

Hardware vendors who test on linux might be scratching their heads at
this error, though they tend to figure out what they're doing wrong, and
fix it.

One argument against was "expensive support calls", on which I call BS.
The firmware resources are expensive, but those are there whether or not
the customers call to complain.

Alex

>> Good mailing practices for 400: avoid top-posting and trim the reply.
> 
> Good mailing practices -- limit use of four letter words on public lists.

Then can't show word 'four'.
