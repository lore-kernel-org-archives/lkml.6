Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeEVOjU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:39:20 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39329 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVOjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:39:18 -0400
X-Google-Smtp-Source: AB8JxZr/JmB/fnnQeFApBA8AdADMup7y8AuG3/N2mwrTWfW3rnXhJJ5uQUaqK87L/3OBbMnRjwwceg==
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
 <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
 <20180522135015.GF5512@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <0b758a1c-90e3-6f76-4f83-1e22c8fc9cd6@gmail.com>
Date: Tue, 22 May 2018 09:39:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180522135015.GF5512@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/22/2018 08:50 AM, Borislav Petkov wrote:
> On Tue, May 22, 2018 at 08:38:39AM -0500, Alex G. wrote:
>>> It looks like the *real* reason for this change is that you
>>> re-introduce ghes_severity() as a different function in the second
>>> patch.
>>
>> /me holds fist at Borislav
> 
> That was a misunderstanding with Rafael and me - we fixed it on IRC.

You mean to say this whole time I've been struggling to write emails,
there was an IRC?

> But this is not the real problem with your approach - it is the marking
> of all PCIe errors as recoverable, regardless of the signature. That's a
> no-no, IMO.

No, the problem is with the current approach, not with mine. The problem
is trying to handle the error outside of the existing handler. That's a
no-no, IMO.

Alex
