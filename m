Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AACEC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EF9279FA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J2Raa194";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BCPUOMvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EF9279FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933489AbeF2V37 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:29:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33396 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbeF2V35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:29:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E06E46081B; Fri, 29 Jun 2018 21:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530307797;
        bh=lGpbkvofYIf6WedoFP4VvE8ENr3rOLQCFkNhhm/wACk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=J2Raa194JAQgXBQeFHPgadKJYPYMxFQhYIM7v5pTEoUOb/LHikwDjl41PcCx+Q4Ht
         +WdVH1TeINBtlZrz4GAGPkwM8bGokCnkiCQ+IwfnLcrmjbagRDkidwpjcgauxGtWz6
         mo7KG3HBIIfBGo86JUfjZbi6jFZAZGFKv4ERGQjk=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8EAB606FC;
        Fri, 29 Jun 2018 21:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530307796;
        bh=lGpbkvofYIf6WedoFP4VvE8ENr3rOLQCFkNhhm/wACk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BCPUOMvSwSFwSUIcgCZuWwFN0JyIRIlHkPp5yfeV/eCIsaWMRy2Uvh67Bej4/jDam
         vd3iel2LA49ky65xa9Q8/b/z6OAyqwmgBCkX1MZJjUYK5YqUrwZT3gaYOC0bFb7EeS
         Ud/5/kyVLym6xoH/YgkGBszKu2DD9tqG8aGDOqQs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8EAB606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
To:     Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <20180628210915.160893-1-mka@chromium.org>
 <20180628210915.160893-3-mka@chromium.org>
 <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
 <20180629185102.GV129942@google.com>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <3b5054bb-76e4-a06f-54bb-e6ea7bbbcc69@codeaurora.org>
Date:   Fri, 29 Jun 2018 14:29:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180629185102.GV129942@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthias,

On 06/29/2018 11:51 AM, Matthias Kaehlcke wrote:
> On Thu, Jun 28, 2018 at 03:58:41PM -0700, Doug Anderson wrote:
>> Hi,
>>
>> On Thu, Jun 28, 2018 at 2:09 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
>>> Add pm8998 thermal zone based on the examples in the spmi-temp-alarm
>>> bindings.
>>>
>>> Note: devices with the pm8998 need to have a 'thermal-zones' node (which
>>> may be empty) with a label 'thermal_zones'.
>>>
>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 28 ++++++++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>
>> Do you know if this patch actually does anything since you didn't
>> define a cooling-maps?  Hopefully at least the critical shuts things
>> down?
> 
> I need to do some additional testing, currently waiting to get the
> heat gun back ...
> 
> I would expect the critical trip point to shut the system down, though
> I'm not sure whether the HW temperature watchdog wouldn't cut power
> before that. The documentation I have access to contains some register
> descriptions, but isn't very verbose about the overall behavior and
> from the driver code that's also not really clear to me. The driver
> "disables software override of stage 2 and 3 shutdowns" which make me
> guess that a hardware shutdown kicks in at stage 2 (135°C ?). This
> would be roughly in line with a system reset I observed in an earlier
> test at a temperature > 125°C. If that's correct the trip points need
> to be revisited.
> 
> Maybe David Collins who recently extended the driver to add support
> for GEN2 PMIC peripherals can provide more details.

The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
off peripherals within the PMIC that are expected to draw significant
current.  The set of peripherals included varies between PMICs.  This
partial shutdown will occur simultaneously with the triggering of an
interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
driver that an over-temperature threshold has been crossed.

The TEMP_ALARM peripheral will perform an automatic full PMIC shutdown
upon hitting over-temperature stage 3 (145 C).  Software won't receive an
interrupt in this case because all power is cut.

If you are not specifying an ADC channel for the qcom-spmi-temp-alarm
device (which would allow for polling of the real-time PMIC die
temperature), then notifications about stage 0 -> 1 and 1 -> 0 transitions
(105 C) are the only time that software could take meaningful corrective
action to avoid a PMIC automatic partial or full shutdown.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
