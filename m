Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754654AbeBNIJs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:09:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754620AbeBNIJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:09:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56EB260791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 2/3] arm64: dts: sdm845: Add minimal dts files for
 sdm845 SoC/MTP
To: Doug Anderson <dianders@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>, evgreen@chromium.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20180212062832.2791-1-rnayak@codeaurora.org>
 <20180212062832.2791-3-rnayak@codeaurora.org>
 <CAD=FV=UQ4YD7M8pqReBwE2etUbhuewye0akp0P9SuTnjwLgL4w@mail.gmail.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <2b726c57-3e7c-8406-bb49-3bd56193e009@codeaurora.org>
Date: Wed, 14 Feb 2018 13:39:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UQ4YD7M8pqReBwE2etUbhuewye0akp0P9SuTnjwLgL4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[]..

>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> new file mode 100644
>> index 000000000000..617c7bb25fb1
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> @@ -0,0 +1,13 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> It would, of course, be up to Qualcomm.  ...but might I suggest instead:
> 
> // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> 
> The device tree files really don't have any special secret sauce in
> them and IIRC allowing them to have a more permissive MIT license _or_
> a GPL allowed people to run other operating systems on these boards.
> This kind of thing is better to fix now so we don't have to go and get
> everyone's permission later on.

sure, sounds reasonable, but I am told I need to get this reviewed once
by qualcomm legal before we go ahead and use the dual licensing copyright.
I will update based on what I hear.

[]..
> 
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
> 
> IMHO add an extra line to this comment with a description to avoid the
> bike shedding of how we're supposed to do 1-line comments in device
> tree files.  AKA:
> 
> /*
>  * SDM845 MTP board device tree source
>  *
>  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>  */

sure will update.

> 
> 
>> +
>> +/dts-v1/;
>> +
>> +#include "sdm845.dtsi"
>> +
>> +/ {
>> +       model = "Qualcomm Technologies, Inc. SDM845 MTP";
>> +       compatible = "qcom,sdm845-mtp";
> 
> For me checkpatch complains about this.  It looks like the file
> "Documentation/devicetree/bindings/arm/qcom.txt" needs to be updated
> with "sdm845".  I don't think that will make checkpatch be quiet
> (since  that file doesn't have a full list of every board), but it
> still should be the correct thing to do.

sure, I missed updating it, will fix.

> 
> 
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> new file mode 100644
>> index 000000000000..55a7e0b454e1
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -0,0 +1,275 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> As per above, suggest dual licensed?
> 
> 
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> 
> As per above, suggest adding an extra line to avoid the bikeshed.
> 
> SDM845 SoC device tree source
> 
> 
> Besides those things, everything looks good as far as I can see.  I'm
> not an expert on every one of the devices used in this file, but
> reading through bindings docs and looking at other users of them, it
> looks sane enough.  Thus, with the above nits fixed you can feel free
> to add my Reviewed-by.

Thanks, the only thing I need to wait for before I respin this is to
get a go ahead from legal for the dual licensing copyright header.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
