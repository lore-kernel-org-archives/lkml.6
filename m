Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C235C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04112146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AY70yvrN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mIROpE33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04112146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390702AbeGKWuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 18:50:07 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38917 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbeGKWuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 18:50:07 -0400
Received: by mail-vk0-f68.google.com with SMTP id e139-v6so13863536vkf.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 15:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wn+ADyahtBHf1bhOUWOQ43kl9a/vBBqSuihRnxO7wto=;
        b=AY70yvrN3HnNE46JaMDflAFPk9smEzG/I1x585Hf1ioA6Mqmc+5A9qyMATTfljzfVU
         nacm9ChOWOYuL8nl6NJ0CaURQJPxMrr0Isxc3cNsOZv3nWJ0FJc2Ku059a60DK6mFmrr
         Zzc3uIvI7T5EZwU9KwF1VQd7DCOFSWmRD0pCwTiYQ/HW9KxJz3EsoOpkcYtFLfw8PPkv
         NwoPXTMHgTcLlapFRQy8aBUjGOlneTa9Biwdh9H6zSEF9c4lLgWIKolqCpICPnjZi9b7
         r5b/2T3fezKZr443KnGqHCkikVxkg94cZUqLWP/KMdOvI7KgxtXwkIvaDN2qhqDC8WVa
         z2aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wn+ADyahtBHf1bhOUWOQ43kl9a/vBBqSuihRnxO7wto=;
        b=mIROpE33870dOH4e3RX8URBUnnmgyujwVCzVa9aRA6P4rLcBlejxzKLW91zmIEif0i
         hFMsQpVZGGYErQyFLR0IaOGRTLfKexuR5eQcfE8Je7t5N4HcR4LLtVKEBcnLNVqjcjnR
         BGjGJnSTSVrEcR8FOmpBsTOEw+TbbkDdH5Aks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wn+ADyahtBHf1bhOUWOQ43kl9a/vBBqSuihRnxO7wto=;
        b=QDWAZJLh3oUl7nmajxpduGmfz2z1u+bIjJ+o94hNadUPg3sgFVbokPzoV2X6H+X8lO
         IOQkgEKevwR/TXCQmlPIJHb0UEkZGW9Sgw3r8iHRVbA7mWzOnoJxqgk0el2NYSzGmMV8
         TD5YZaGR1pd5kbolUpuJjaSbOrQmMbCY9D+7rCnlPKFgy8MJwPs3XEc6AcJAhBQnSOX+
         AlOaXLcmJeP7lS48bwikpHj3uLsxkxxsXQ5K+vPuw0M9ZiP2i4NHJAGCg2KEPaxCogOP
         okA2Gn4uXfaCJXPA80mYmOQReh6YC1+eYAfnkZoNO0RV23exWKdyYm5c8TLhmEmakOax
         J8RQ==
X-Gm-Message-State: AOUpUlHVSGFo5qGayA1NE4nRWMySPzbBD4aIuUfaYo+7G/k4uHx8JtTO
        UvgpbrWuJ5hMZo8zZzetsuV2sgX64h1CEucbvekJ2w==
X-Google-Smtp-Source: AAOMgpfPZSeNd8nL3wRGPsxgxzReqZ3idr5Xbod6vVkq3qil7bWcAm7OMcQDSP+Ts437FtfNUVtL8TH8MnELc5Rv+vE=
X-Received: by 2002:a1f:4a03:: with SMTP id x3-v6mr341393vka.90.1531349015232;
 Wed, 11 Jul 2018 15:43:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 15:43:34
 -0700 (PDT)
In-Reply-To: <03904a71-c6be-4f93-ad43-7d25631f9a04@codeaurora.org>
References: <20180628210915.160893-1-mka@chromium.org> <20180628210915.160893-3-mka@chromium.org>
 <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
 <20180629185102.GV129942@google.com> <3b5054bb-76e4-a06f-54bb-e6ea7bbbcc69@codeaurora.org>
 <20180629235417.GY129942@google.com> <8144dd3c-6138-7f16-ec17-d75e84fcfb34@codeaurora.org>
 <CAD=FV=XqoRajjNcW8RyJfrcXQVDihfjAnAsN+O9g+6qDrLHfJw@mail.gmail.com> <03904a71-c6be-4f93-ad43-7d25631f9a04@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Jul 2018 15:43:34 -0700
X-Google-Sender-Auth: 59vxgdZWp9AvEXTtRSfVpxwealw
Message-ID: <CAD=FV=XbnuNg_B_Uoj8j9hz0t7=ORdcVB16oDmVk1q2iZYGs9A@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
To:     David Collins <collinsd@codeaurora.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, Jul 11, 2018 at 3:36 PM, David Collins <collinsd@codeaurora.org> wrote:
> Hello Doug,
>
>> On Tue, Jul 10, 2018 at 10:45 AM, David Collins <collinsd@codeaurora.org> wrote:
>>> On 06/29/2018 04:54 PM, Matthias Kaehlcke wrote:
>>>> On Fri, Jun 29, 2018 at 02:29:55PM -0700, David Collins wrote:
>>> ...
>>>>> The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
>>>>> PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
>>>>> off peripherals within the PMIC that are expected to draw significant
>>>>> current.  The set of peripherals included varies between PMICs.  This
>>>>> partial shutdown will occur simultaneously with the triggering of an
>>>>> interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
>>>>> driver that an over-temperature threshold has been crossed.
>>>>>
>>>>> The TEMP_ALARM peripheral will perform an automatic full PMIC shutdown
>>>>> upon hitting over-temperature stage 3 (145 C).  Software won't receive an
>>>>> interrupt in this case because all power is cut.
>>>>
>>>> This information is very useful, thanks David!
>>>>
>>>> The (partial) hardware shutdown seems like a good measure of last
>>>> resort, however I suppose we prefer Linux to initiate a shutdown
>>>> before losing part of the peripherals (drivers might not be happy
>>>> about this and probably not revover even when the temperature goes
>>>> down again) or reach a full PMIC shutdown.
>>>>
>>>> Please let me know if there are reasons to prefer to go the hardware
>>>> limits, it's also an option for device makers to overwrite these
>>>> settings if they want different behavior.
>>>
>>> Disabling stage 3 automatic full PMIC shutdown at 145 C is definitely a
>>> bad idea.  This exists as a last resort in order to save the hardware and
>>> ensure end user safety in case of excessive temperature even if software
>>> is locked up.
>>>
>>> Disabling stage 2 automatic partial PMIC shutdown at 125 C is not
>>> recommended as the PMIC is already outside of reasonable operating
>>> conditions and needs to take corrective action quickly.  However, doing so
>>> may be acceptable if software is taking action to shut down the system
>>> immediately upon receiving the stage 2 over-temperature interrupt.
>>> Just to confirm: is it expected that at stage 2 the CPU's on the SoC
>> should continue running even with partial PMIC shutdown enabled?
>
> This is not guaranteed.
>
>
>> It sounded to me like partial PMIC shutdown was supposed to shut down
>> high-power rails that were not essential to the task of performing an
>> orderly shutdown.
>
> Shutting down high-power peripherals is accurate; however, special care is
> not taken to ensure that an orderly shutdown is possible.  At the very
> least, the HW and SW state will be out of sync for the peripherals that
> are shut down.

OK, I guess I'm confused now.  Why does partial PMIC shutdown even
exist then?  What is the point of leaving some rails alive if software
could stop running?  It seems like it would be better to just shut
everything down.

Said another way: can you describe what benefit you see for only
partially shutting down the PMIC at stage 2 compared to just fully
shutting it down at stage 2?


>> I think Matthias was seeing that when he reached stage 2 and partial
>> PMIC shutdown happened that the system was just falling on the floor.
>> ...maybe we just have things configured incorrectly?
>
> More information about the exact crash steps would be helpful to
> investigate this further.  I'm not sure how much time you want to put into
> it though.

Matthias can add more, but basically he heated the system up and when
it reached the stage 2 shutdown it was no longer responsive.


> Disabling stage 2 partial shutdown and then using software to
> perform a controlled shutdown at 125 C is probably the best option for you
> at this point.

This seems OK to me given that I don't understand the original purpose
of the partial PMIC shutdown.  Would you expect that all upstream PMIC
users would want stage 2 partial shutdown disabled, so we should just
do this for all users of the PMIC?


-Doug
