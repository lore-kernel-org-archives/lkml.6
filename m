Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeEKRD0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 13:03:26 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36809 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeEKRDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 13:03:23 -0400
X-Google-Smtp-Source: AB8JxZp9ebuIpgHerZCiEWgYLb/PIOcizp+XeaT35Y6WXe7z+fBgS9hkDekMwGYAgEKRG8ROO4ai4g==
Subject: Re: [RFC PATCH v4 2/3] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
To: Borislav Petkov <bp@alien8.de>
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-2-mr.nuke.me@gmail.com> <20180511153947.GC12705@pd.tnic>
 <56d445b2-ace3-6ee2-9699-f2a684518de9@gmail.com>
 <20180511155833.GE12705@pd.tnic>
 <f70e209d-00ec-1969-16de-09d6142668da@gmail.com>
 <20180511161933.GG12705@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <70c2b5f2-ec54-da9c-4ab0-1ff22be9a142@gmail.com>
Date: Fri, 11 May 2018 12:03:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180511161933.GG12705@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/11/2018 11:19 AM, Borislav Petkov wrote:
> On Fri, May 11, 2018 at 11:12:24AM -0500, Alex G. wrote:
>> Because the GHES structure uses CPER values, but all the code is written
>> to use GHES_SEV_ values. GHES_SEV_ is a made up enum, specifically for
>> linux.
> 
> Again, what does that even matter?

I will shorten the commit message.


> They're defines in both cases. The *actual* value means shit.
> 
> Ah, I see it:
> 
> 	...
> 		sec_sev = ghes_sec_pcie_severity(gdata);
> 
> 	worst_sev = max(worst_sev, sec_sev);
> 
> 
> Yeah, no, you can't do that. No apples and oranges comparisons.

That was a mistake on my part. Despite my godlike ability to produce
great fixes, I am, in fact, human.

Alex
