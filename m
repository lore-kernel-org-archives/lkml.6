Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B73C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFA021486
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OlvOywFN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oMsrkp1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFA021486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbeGLARl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:17:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53766 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733048AbeGLARl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:17:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4C18060B7E; Thu, 12 Jul 2018 00:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531354253;
        bh=X5E6RYRpzOMkaLmU9vRTjLJpHpU7iFQWI25dn0CwZAs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OlvOywFNO1Ou6fpSvbH7YJm5yQhULKAIfhmjyCcHCYtekUAx/9Myqr29FIUUyyjlv
         XIXYxFfTjplaXdAdk4Jry+CYt40jzlrlzLqC3/YD1RUTLqKwhA0bVQ2IjUV8VFWifM
         zjN0Jq7byAJj4L9kvmaWSAQAI4mHjvU5NloiWHcs=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E0DF60B7E;
        Thu, 12 Jul 2018 00:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531354251;
        bh=X5E6RYRpzOMkaLmU9vRTjLJpHpU7iFQWI25dn0CwZAs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oMsrkp1KwzMe5yPtZ0m6AOLNzkzBwhBneuztlmxLoLRhckUglz5VkhP10swEXI7lZ
         fdg3x6c/8vURhmIbavtp4Q22R8Zn2bUce8jTkbkJOo6GgKI9Dg4L772bp+2G7klTa/
         bPDI9Med80KkkJ4cZHv7GA+nD+2ptWETxxJ/fIDk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E0DF60B7E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
To:     Doug Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
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
 <3b5054bb-76e4-a06f-54bb-e6ea7bbbcc69@codeaurora.org>
 <20180629235417.GY129942@google.com>
 <8144dd3c-6138-7f16-ec17-d75e84fcfb34@codeaurora.org>
 <CAD=FV=XqoRajjNcW8RyJfrcXQVDihfjAnAsN+O9g+6qDrLHfJw@mail.gmail.com>
 <03904a71-c6be-4f93-ad43-7d25631f9a04@codeaurora.org>
 <CAD=FV=XbnuNg_B_Uoj8j9hz0t7=ORdcVB16oDmVk1q2iZYGs9A@mail.gmail.com>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <aff517d2-df92-da86-fc1e-5f8f8c42f736@codeaurora.org>
Date:   Wed, 11 Jul 2018 17:10:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XbnuNg_B_Uoj8j9hz0t7=ORdcVB16oDmVk1q2iZYGs9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Doug,

On 07/11/2018 03:43 PM, Doug Anderson wrote:
> On Wed, Jul 11, 2018 at 3:36 PM, David Collins <collinsd@codeaurora.org> wrote:
>>> On Tue, Jul 10, 2018 at 10:45 AM, David Collins <collinsd@codeaurora.org> wrote:
>>>> On 06/29/2018 04:54 PM, Matthias Kaehlcke wrote:
>>>>> On Fri, Jun 29, 2018 at 02:29:55PM -0700, David Collins wrote:
>>>> ...
>>>>>> The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
>>>>>> PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
>>>>>> off peripherals within the PMIC that are expected to draw significant
>>>>>> current.  The set of peripherals included varies between PMICs.  This
>>>>>> partial shutdown will occur simultaneously with the triggering of an
>>>>>> interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
>>>>>> driver that an over-temperature threshold has been crossed.
>>>>>>
>>>>>> The TEMP_ALARM peripheral will perform an automatic full PMIC shutdown
>>>>>> upon hitting over-temperature stage 3 (145 C).  Software won't receive an
>>>>>> interrupt in this case because all power is cut.
>>>>>
>>>>> This information is very useful, thanks David!
>>>>>
>>>>> The (partial) hardware shutdown seems like a good measure of last
>>>>> resort, however I suppose we prefer Linux to initiate a shutdown
>>>>> before losing part of the peripherals (drivers might not be happy
>>>>> about this and probably not revover even when the temperature goes
>>>>> down again) or reach a full PMIC shutdown.
>>>>>
>>>>> Please let me know if there are reasons to prefer to go the hardware
>>>>> limits, it's also an option for device makers to overwrite these
>>>>> settings if they want different behavior.
>>>>
>>>> Disabling stage 3 automatic full PMIC shutdown at 145 C is definitely a
>>>> bad idea.  This exists as a last resort in order to save the hardware and
>>>> ensure end user safety in case of excessive temperature even if software
>>>> is locked up.
>>>>
>>>> Disabling stage 2 automatic partial PMIC shutdown at 125 C is not
>>>> recommended as the PMIC is already outside of reasonable operating
>>>> conditions and needs to take corrective action quickly.  However, doing so
>>>> may be acceptable if software is taking action to shut down the system
>>>> immediately upon receiving the stage 2 over-temperature interrupt.
>>>> Just to confirm: is it expected that at stage 2 the CPU's on the SoC
>>> should continue running even with partial PMIC shutdown enabled?
>>
>> This is not guaranteed.
>>
>>
>>> It sounded to me like partial PMIC shutdown was supposed to shut down
>>> high-power rails that were not essential to the task of performing an
>>> orderly shutdown.
>>
>> Shutting down high-power peripherals is accurate; however, special care is
>> not taken to ensure that an orderly shutdown is possible.  At the very
>> least, the HW and SW state will be out of sync for the peripherals that
>> are shut down.
> 
> OK, I guess I'm confused now.  Why does partial PMIC shutdown even
> exist then?  What is the point of leaving some rails alive if software
> could stop running?  It seems like it would be better to just shut
> everything down.
> 
> Said another way: can you describe what benefit you see for only
> partially shutting down the PMIC at stage 2 compared to just fully
> shutting it down at stage 2?

Stage 2 partial shutdown is present on PM8998 for legacy reasons.  It is
being phased out on future PMICs.  My understanding is that it was
originally intended to be a less aggressive mitigation option than a full
shutdown and that it allows for more post-mitigation analysis (e.g.
preserved RAM contents).

The set of peripherals which are disabled during stage 2 partial shutdown
is not well defined which leads to the kind of uncertainty and ill-defined
behavior being discussed in this thread.


>> Disabling stage 2 partial shutdown and then using software to
>> perform a controlled shutdown at 125 C is probably the best option for you
>> at this point.
> 
> This seems OK to me given that I don't understand the original purpose
> of the partial PMIC shutdown.  Would you expect that all upstream PMIC
> users would want stage 2 partial shutdown disabled, so we should just
> do this for all users of the PMIC?

I'd think that we only want to override stage 2 partial shutdown if
thermal nodes are defined which cause a graceful software controlled
shutdown in place of the PMIC partial shutdown.  Therefore, management of
the feature should probably be tied to a boolean DT property.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
