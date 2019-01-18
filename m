Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4C9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB1D2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfARKRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:17:35 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:40342 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfARKRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:17:35 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 2745513F8C0;
        Fri, 18 Jan 2019 11:17:18 +0100 (CET)
Subject: Re: [PATCH v11 0/9] Add power domain driver for corners on
 msm8996/sdm845
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190110040209.6028-1-rnayak@codeaurora.org>
 <90f8bfec-f1dd-6031-9d98-468b29627a2f@free.fr>
 <6da2a843-c8d9-70f6-733d-e4bbb3947f04@codeaurora.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <40459ee8-7933-505a-bc39-64858d4e7637@free.fr>
Date:   Fri, 18 Jan 2019 11:17:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6da2a843-c8d9-70f6-733d-e4bbb3947f04@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2019 04:54, Rajendra Nayak wrote:

> On 1/17/2019 8:33 PM, Marc Gonzalez wrote:
> 
>> On 10/01/2019 05:02, Rajendra Nayak wrote:
>>
>>> Rajendra Nayak (9):
>>>    dt-bindings: opp: Introduce opp-level bindings
>>>    OPP: Add support for parsing the 'opp-level' property
>>>    dt-bindings: power: Add qcom rpm power domain driver bindings
>>>    soc: qcom: rpmpd: Add a Power domain driver to model corners
>>>    soc: qcom: rpmpd: Add support for get/set performance state
>>>    arm64: dts: msm8996: Add rpmpd device node
>>>    soc: qcom: rpmhpd: Add RPMh power domain driver
>>>    arm64: dts: sdm845: Add rpmh powercontroller node
>>>    soc: qcom: rpmhpd: Mark mx as a parent for cx
>>>
>>>   Documentation/devicetree/bindings/opp/opp.txt |   3 +
>>>   .../devicetree/bindings/power/qcom,rpmpd.txt  | 145 +++++++
>>>   arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
>>>   arch/arm64/boot/dts/qcom/sdm845.dtsi          |  51 +++
>>
>> Whenever I see these patches adding support for msm8996 (aka sdm820) and sdm845
>> simultaneously, I think to myself: "Why is sdm835 being left out? It was released
>> between sdm820 and sdm845, it cannot be /that/ different."
> 
> It isn't that different, and it should be quite straight forward to add support for it
> with the rpmpd driver (the rpmhpd is for platforms sdm845 and beyond which use rpmh)
> 
> When I started working on these patches, support for sdm835 upstream was non-existent
> so I started off with what was the better supported one which was the 820 (msm8996).

Once you land this patch series, could you take a quick look at how much work is needed
to add msm8998 support? I'm betting it would take you only a few hours.

Regards.
