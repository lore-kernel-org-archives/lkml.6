Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeEBO4u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:56:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38052 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeEBO4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:56:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E963B60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Wed, 2 May 2018 08:56:42 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 02/10] dt-bindings: introduce RPMH RSC bindings for
 Qualcomm SoCs
Message-ID: <20180502145642.GA21162@codeaurora.org>
References: <20180419221635.17849-1-ilina@codeaurora.org>
 <20180419221635.17849-3-ilina@codeaurora.org>
 <CAD=FV=WfC5x12kFd7Uw8DTR=OFx4HFJhJrd-sDZ5EJgkWL3tQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD=FV=WfC5x12kFd7Uw8DTR=OFx4HFJhJrd-sDZ5EJgkWL3tQw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01 2018 at 17:45 -0600, Doug Anderson wrote:
>Hi,
>
>On Thu, Apr 19, 2018 at 3:16 PM, Lina Iyer <ilina@codeaurora.org> wrote:
>> +TCS-OFFSET: 0xD00
>> +
>> +       apps_rsc: rsc@179e000 {
>
>This label is wrong in two ways:
>
>1. I believe it's supposed to be the first reg listed, so 179c0000
>
>2. There's only 3 0's at the end.
>
>Thus, it should be:
>
>apps_rsc: rsc@179c0000
>
Ok. Will fix.

I did not hear back on this idea. Does this binding work for everyone
else?

Thanks,
Lina

>> +               label = "apps_rsc";
>> +               compatible = "qcom,rpmh-rsc";
>> +               reg = <0x179c0000 0x10000>, <0x179d0000 0x10000>,
>> +                     <0x179e0000 0x10000>, <0xd00 0>;
>> +               reg-names = "drv-0", "drv-1", "drv-2", "tcs-offset";
>> +               interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +               qcom,drv-id = <2>;
>> +               qcom,tcs-config = <SLEEP_TCS   3>,
>> +                                 <WAKE_TCS    3>,
>> +                                 <ACTIVE_TCS  2>,
>> +                                 <CONTROL_TCS 1>;
>> +       };
