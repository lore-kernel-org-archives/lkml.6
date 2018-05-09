Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965509AbeEIQZ4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:25:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40630 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965339AbeEIQZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:25:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 074D8605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Wed, 9 May 2018 10:25:52 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Ram Chandrasekar <rkumbako@codeaurora.org>
Subject: Re: [PATCH] drivers: thermal: step_wise: add support for hysteresis
Message-ID: <20180509162552.GE4698@codeaurora.org>
References: <20180507175408.2154-1-ilina@codeaurora.org>
 <20180508020453.GH19313@mai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180508020453.GH19313@mai>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, May 08 2018 at 20:04 -0600, Daniel Lezcano wrote:
>On Mon, May 07, 2018 at 11:54:08AM -0600, Lina Iyer wrote:
>> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>>
>> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>>
>> Step wise governor increases the mitigation level when the temperature
>> goes above a threshold and will decrease the mitigation when the
>> temperature falls below the threshold. If it were a case, where the
>> temperature hovers around a threshold, the mitigation will be applied
>> and removed at every iteration. This reaction to the temperature is
>> inefficient for performance.
>>
>> The use of hysteresis temperature could avoid this ping-pong of
>> mitigation by relaxing the mitigation to happen only when the
>> temperature goes below this lower hysteresis value.
>
>I don't disagree with this but the ping-pong around a temperature is usually
>avoided with a P-I-D computation which is implemented with the IPA governor.
>Wouldn't be more interesting to add the power numbers like some other
>platforms, so the IPA could be used?
>
Possibly. But we have had better thermal performance for our hardware, with
stepwise and custom governor. Much of the mitigation happens through the
firmware and hardware. The stepwise governor works well for us.

>You will probably have better results with the IPA than changing the step-wise
>governor behavior (which may potentially impact other users).
>
This should not impact others who have not implemented the
->get_trip_hyst method.

Thanks,
Lina
