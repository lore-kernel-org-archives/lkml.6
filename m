Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeEVStK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:49:10 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34132 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeEVStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:49:08 -0400
X-Google-Smtp-Source: AB8JxZpnYkaeyN4zjcVwlalWDA3UZQjaoTNnVxxsXtyuuX+V4P+MPMyM1RnkjGoLsL1QzEHF2L/8uQ==
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@alien8.de>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tyler Baicar <tbaicar@codeaurora.org>,
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
 <0b758a1c-90e3-6f76-4f83-1e22c8fc9cd6@gmail.com>
 <20180522145426.GG5512@pd.tnic> <20180522175742.GA3543@agluck-desk>
 <CAJZ5v0j1E-kg3RPcasSJn=uZj9uaZcL4Zw9tp4mJgnsbWcPWbw@mail.gmail.com>
 <5dc58180-d3c0-a9f0-282f-4be433c94052@gmail.com>
 <20180522184532.GA4360@agluck-desk>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <9d4b10fa-dcd8-8071-e68b-24536b24e780@gmail.com>
Date: Tue, 22 May 2018 13:49:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180522184532.GA4360@agluck-desk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 01:45 PM, Luck, Tony wrote:
> On Tue, May 22, 2018 at 01:19:34PM -0500, Alex G. wrote:
>> Firmware started passing "fatal" GHES headers with the explicit intent of
>> crashing an OS. At the same time, we've learnt how to handle these errors in
>> a number of cases. With DPC (coming soon to firmware-first) the error is
>> contained, and a non-issue.
> 
> Perhaps DPC is the change that you need to emphasize as to
> why things are different now, so we can change the default
> Linux behavior.
> 
> With the h/w guaranteeing that corrupt data is contained, we
> should be safe to disregard BIOS indications of "fatal" problems
> that could be anything and might show up in unknown ways some
> time later if we keep running.

Sure. DPC is much harder to contest as a reason. However, the AER path
benefits as well from this change in behavior. I'm certain there are
other classes of errors that benefit as well from the change, though I
haven't had the time or the inclination to look for them.

Alex
