Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeERAQY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 20:16:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36830 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbeERAQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 20:16:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 562FD602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v3 2/2] regulator: add QCOM RPMh regulator driver
To: Doug Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <cover.1526088081.git.collinsd@codeaurora.org>
 <3a4195365ab0d252fdf064d2300f45b9b777991c.1526088081.git.collinsd@codeaurora.org>
 <CAD=FV=UiZEFTAtO9C0UbRO=ow5=dv6zNG-XMqhHm1Fmp2GwVcA@mail.gmail.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <8847014e-4d27-b47a-8dc1-5b4a35123ce6@codeaurora.org>
Date: Thu, 17 May 2018 17:16:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UiZEFTAtO9C0UbRO=ow5=dv6zNG-XMqhHm1Fmp2GwVcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 02:23 PM, Doug Anderson wrote:
> On Fri, May 11, 2018 at 7:28 PM, David Collins <collinsd@codeaurora.org> wrote:
>> +                       /*
>> +                        * Default the voltage selector to an error value in the
>> +                        * case that qcom,regulator-initial-microvolt is not
>> +                        * specified in device tree since the true voltage is
>> +                        * not known.  Note that this value causes
>> +                        * devm_regulator_register() to fail in the case that
>> +                        * regulator-min-microvolt and regulator-max-microvolt
>> +                        * are specified in device tree due to
>> +                        * machine_constraints_voltage() bailing when the
>> +                        * get_voltage_sel() callback returns this error value.
>> +                        */
>> +                       vreg->voltage_selector = -EINVAL;
> 
> As per comments in other threads, adjust this comment and use
> -ENOTRECOVERABLE now.

I'll make this change.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
