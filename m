Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753800AbeDMHAT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 03:00:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753703AbeDMHAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 03:00:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 911D260274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v4 2/7] phy: qcom-qmp: Enable pipe_clk before PHY
 initialization
To: Stephen Boyd <sboyd@kernel.org>, Doug Anderson <dianders@chromium.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, linux-arm-msm@vger.kernel.org,
        Varadarajan Narayanan <varada@codeaurora.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Fengguang Wu <fengguang.wu@intel.com>
References: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org>
 <1522321466-21755-3-git-send-email-mgautam@codeaurora.org>
 <CAD=FV=XtviSYq=2w=Ld1xq5U2VPy=u=q6a3+4qd2zVGB+f9P8A@mail.gmail.com>
 <CAD=FV=WGEKy98De_zH9rp+g-tE2YuVK2vRxLJrjeeSx=ijBAww@mail.gmail.com>
 <19c66b02-4f8e-902a-9397-21e7690db7b8@codeaurora.org>
 <CAD=FV=XqH69_LXcCyTS1nF5fHpen=PnRxd-WTz=y3dKvMsRtuw@mail.gmail.com>
 <152338515540.180276.4273344163431724770@swboyd.mtv.corp.google.com>
 <f8f47dc2-74ab-96c6-b3bd-a476bd19514d@codeaurora.org>
 <152356552631.37499.9860530043266211290@swboyd.mtv.corp.google.com>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <e978fa34-d9a6-281c-6620-c9d10c7b54ae@codeaurora.org>
Date: Fri, 13 Apr 2018 12:30:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152356552631.37499.9860530043266211290@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 4/13/2018 2:08 AM, Stephen Boyd wrote:
> Quoting Manu Gautam (2018-04-11 08:37:38)
>>> I ask because it may be easier to never expose these clks in Linux, hit
>>> the enable bits in the branches during clk driver probe, and then act
>>> like they never exist because we don't really use them.
>> This sounds better idea. Let me check if I can get a patch for same in msm8996
>> and sdm845 clock drivers.
>>
> Ok! Presumably the PHY has a way to tell if it failed to turn on right?
> Put another way, I'm hoping these branch bits aren't there to help us
> debug and figure out when the PHY PLL fails to lock.

Yes, PHY has a PCS_STATUS3 register that indicates whether pipe_clk got enabled or
not.


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
