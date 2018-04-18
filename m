Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeDRVoO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 17:44:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33876 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbeDRVoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 17:44:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6711601E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
To: Doug Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <39b676d2ba7dac2436196cc5a090c6f151498dc8.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=UxabaHPa-pkGBvQDcmh7e+bqMRX4WdMS8xfhAQSKD9gg@mail.gmail.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <0a52dfe6-d1e1-9171-aa20-8e55e47919f4@codeaurora.org>
Date: Wed, 18 Apr 2018 14:44:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UxabaHPa-pkGBvQDcmh7e+bqMRX4WdMS8xfhAQSKD9gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 01:06 PM, Doug Anderson wrote:
> [...]
>> +- qcom,regulator-initial-voltage
> 
> nit: regulator framework tends to include "microvolt" in the name to
> make it really obvious in the device tree what the units are.  Can you
> do that too?

Sure, I'll change the name to be: qcom,regulator-initial-microvolt.


>> +- qcom,drms-mode-threshold-currents
> 
> Could use microamp in the name of the property too...

Ok, I'll change the name to be: qcom,drms-mode-max-microamps.


>> +                       qcom,allowed-drms-modes =
>> +                               <RPMH_REGULATOR_MODE_LPM
>> +                                RPMH_REGULATOR_MODE_HPM>;
>> +                       qcom,drms-mode-threshold-currents = <10000 1000000>;
> 
> optional nit: to make it match downstream drivers, does it make sense
> to change this to:
> 
>   <9999 999999>
> 
> ...so if a driver used to request exactly 10000 mA that it will end up
> with the same mode (no idea if drivers actually do that).

I'd prefer to leave the example with <10000 1000000> as it looks cleaner
to me and the example numbers are arbitrary.  It would also be good to use
<10000 1000000> in actual board DT files.  We can address consumers
expecting legacy behavior for 10000 uA requests as needed.

Take care,
David


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
