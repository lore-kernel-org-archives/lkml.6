Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbeCFFsS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 00:48:18 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42212 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeCFFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 00:48:16 -0500
X-Google-Smtp-Source: AG47ELvNyvcjy0NcycM5bT2PDPHlsVYExudGLHOs+SP3g9lJTxpHxpPbcfbagy8ymZJI59s4Q06xViUPH4EQ4/Ry0ss=
MIME-Version: 1.0
In-Reply-To: <e6c78c81-f18d-c811-925d-5b1dd427fb65@linaro.org>
References: <cover.1520274879.git.amit.kucheria@linaro.org>
 <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
 <e6c78c81-f18d-c811-925d-5b1dd427fb65@linaro.org>
From: Amit Kucheria <amit.kucheria@linaro.org>
Date: Tue, 6 Mar 2018 11:18:15 +0530
Message-ID: <CAP245DWvBjcS73YhPxwh2OKW_PYvBLTe-ay6XD8VrSWpukQ3CQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: of: Allow selection of thermal governor in DT
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: DTML <devicetree@vger.kernel.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 2:41 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 05/03/2018 19:36, Amit Kucheria wrote:
>> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>>
>> There is currently no way for the governor to be selected for each thermal
>> zone in devicetree. This results in the default governor being used for all
>> thermal zones even though no such restriction exists in the core code.
>>
>> Add support for specifying the thermal governor to be used for a thermal
>> zone in the devicetree. The devicetree config should specify the governor
>> name as a string that matches any available governors. If not specified, we
>> maintain the current behaviour of using the default governor.
>>
>> Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>
> Why not create a kernel parameter (eg. thermal.governor=) ? So everyone
> can gain benefit of this feature. And in order to specify that from the
> DT, add the 'chosen' node and bootargs with the desired kernel parameter?
>

This is supposed to be a per-thermal zone property. So specifying it
on the command-line, while possible, might be a little cumbersome. I'm
not even sure if kernel parameters can have a variable number of
arguments. IOW, thermal.tz0.governor=userspace,
thermal.tz1.governor=step_wise, thermal.tz2.governor=userspace, .....

I'm already seeing SoCs defining 8 or more thermal zones.
