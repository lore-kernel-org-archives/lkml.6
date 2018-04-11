Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754531AbeDKV0X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 17:26:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60680 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753364AbeDKV0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 17:26:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 582E56079B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Wed, 11 Apr 2018 15:26:18 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 02/10] dt-bindings: introduce RPMH RSC bindings for
 Qualcomm SoCs
Message-ID: <20180411212618.GH19682@codeaurora.org>
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-3-ilina@codeaurora.org>
 <152306368031.94378.14957212064809086345@swboyd.mtv.corp.google.com>
 <20180409160800.GC19682@codeaurora.org>
 <20180410193621.GB6727@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180410193621.GB6727@builder>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10 2018 at 13:36 -0600, Bjorn Andersson wrote:
>On Mon 09 Apr 09:08 PDT 2018, Lina Iyer wrote:
>
>> On Fri, Apr 06 2018 at 19:14 -0600, Stephen Boyd wrote:
>> > Quoting Lina Iyer (2018-04-05 09:18:26)
>> > > diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
>[..]
>> > > +Example 1:
>> > > +
>> > > +For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
>> > > +register offsets for DRV2 start at 0D00, the register calculations are like
>> > > +this -
>> > > +First tuple: 0x179C0000 + 0x10000 * 2 = 0x179E0000
>> > > +Second tuple: 0x179E0000 + 0xD00 = 0x179E0D00
>> > > +
>> > > +       apps_rsc: rsc@179e000 {
>> > > +               label = "apps_rsc";
>> > > +               compatible = "qcom,rpmh-rsc";
>> > > +               reg = <0x179e0000 0x10000>, <0x179e0d00 0x3000>;
>> >
>> > The first reg property overlaps the second one. Does this second one
>> > ever move around? I would hardcode it in the driver to be 0xd00 away
>> > from the drv base instead of specifying it in DT if it's the same all
>> > the time.
>[..]
>> >
>> The DRV is the voter for an execution environment (Linux, Hypervisor,
>> ATF) in the RSC. The RSC has a lot of other registers that Linux is not
>> privy to. They are access restricted. The memory organization of the RSC
>> mandates that we know the DRV id to access registers specific to the
>> DRV. Unfortunately, not all RSC have identical DRV configuration and the
>> register space is also variable depending on the capability of the RSC.
>> There are functionalities supported by other RSCs in the SoC that are
>> not supported by the RSC associated with the application processor,
>> while not many RSCs' support multiple DRVs. Therefore it doesn't benefit
>> describing the whole RSC as it is not usable from Linux (because of
>> access restrictions).
>>
>
>I generally prefer that we describe the hardware blocks as accurate as
>possible, instead of applying current restrictions on Linux onto the
>description. This ensures that we can reuse the binding and drivers in
>configurations not considered today. However, afaict we still have the
>problem that we need a way to express where in the RSC our TCS sits.
>
>Regardless of what's right or not, the given example causes the driver
>to fail probing, so something needs to be changed.
I have been using this in DT and I haven't seen failures. Could you send
me the logs?

Thanks,
Lina

>(Making the drv size
>0xd00 is functional but doesn't really relate to any bondary in the
>register space).
>
>Regards,
>Bjorn
