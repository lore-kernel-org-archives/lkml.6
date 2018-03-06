Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753779AbeCFPnK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:43:10 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54001 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753487AbeCFPnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:43:07 -0500
X-Google-Smtp-Source: AG47ELu3nCT6ITwf8QmpKXm83BwVA4AELucrDLynDO4nLn9CFw37QpIGOZdpELuOd2IzcEb2KVSh2Q==
Subject: Re: [PATCH] thermal: of: Allow selection of thermal governor in DT
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: DTML <devicetree@vger.kernel.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1520274879.git.amit.kucheria@linaro.org>
 <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
 <e6c78c81-f18d-c811-925d-5b1dd427fb65@linaro.org>
 <CAP245DWvBjcS73YhPxwh2OKW_PYvBLTe-ay6XD8VrSWpukQ3CQ@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4e3cc8a6-4b4b-4b09-5c04-b7b331158339@linaro.org>
Date: Tue, 6 Mar 2018 16:43:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAP245DWvBjcS73YhPxwh2OKW_PYvBLTe-ay6XD8VrSWpukQ3CQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2018 06:48, Amit Kucheria wrote:
> On Tue, Mar 6, 2018 at 2:41 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 05/03/2018 19:36, Amit Kucheria wrote:
>>> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>>>
>>> There is currently no way for the governor to be selected for each thermal
>>> zone in devicetree. This results in the default governor being used for all
>>> thermal zones even though no such restriction exists in the core code.
>>>
>>> Add support for specifying the thermal governor to be used for a thermal
>>> zone in the devicetree. The devicetree config should specify the governor
>>> name as a string that matches any available governors. If not specified, we
>>> maintain the current behaviour of using the default governor.
>>>
>>> Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
>>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>>
>> Why not create a kernel parameter (eg. thermal.governor=) ? So everyone
>> can gain benefit of this feature. And in order to specify that from the
>> DT, add the 'chosen' node and bootargs with the desired kernel parameter?
>>
> 
> This is supposed to be a per-thermal zone property. So specifying it
> on the command-line, while possible, might be a little cumbersome. I'm
> not even sure if kernel parameters can have a variable number of
> arguments. IOW, thermal.tz0.governor=userspace,
> thermal.tz1.governor=step_wise, thermal.tz2.governor=userspace, .....
> 
> I'm already seeing SoCs defining 8 or more thermal zones.

Ah yes indeed.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
