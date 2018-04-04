Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2906851-1522805226-5-17220545952718831228
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522805225; b=IhFfxVYZgxmtMqjgtftHWCOako3+AwdiTEV4/MZdQhavO3ZoOz
    xy7nxiHaQoi2CfnxS1kwwrYF/gLJWKitt3h/lyupYWUTHPqU4o31MQ/hWaVthubR
    gt59j0hOyRNOtGfLcK8yWl0V6akrr3iw5A3t922RHU+XStelMdAr7DHPYqmm0loj
    gvHyzeGDsS3VGG/RBoc3jrPfnv77xQcBzOX/toozg3NWRvTdSYo91CCjTbGFAirk
    OMB5gWSktBAFNEORIuICaeesgNmxLF+drt8mp+Umk4WsjoxdYrMn+bg4ufWvA1dP
    OGEzWF9mk4dDkyikfUpeNp4F2nMvegpJWecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522805225; bh=WF8GCle0EvMVD6+/88cFLSAwVZt3x6IPLPvlWxxwG3
    0=; b=OSCVe+vVys3yt4nrrUN7hWwQSYKClRRObdERCc4TdfPokFomLAE59r5ojc
    hovrMz5A71wl3zRA4Wm3R1vZJ4hrap2lPpQbEu/qa+roQu1sW6yO99nEbvmFC3qx
    L/NkcSPCHyAsrNPbfRpl70wNJOqII2EAzv4Sfxj3viFNPQSoByEGiFHFZjGOaaWQ
    PBpJ0Y+sClKl4gFPsnHVCnhfTGx8mh/wv1y2SAUFRnfft15drY3l4KFchB7AeWSZ
    kuuVi56xQjNPOh7aCkb3l0AlIxg61dHRSlGjphm1C3iiU4vfnQuL7E3gS5CY9X0Z
    kqHSzlBy/4P+qIqQvcFfz8jSoowQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=zIz1k5St x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=zIz1k5St x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOeFUMIDLPFvPxzmFXdzqeAkuB302ngoBNP+ewl0rDJvGUd1lfGxqXv3N0DSkxTSmYWcoLdU6hDKoPOh7yB/foEtmINJ0ZNnuVwb8HtDsyEvl54K5KM5
    2E+d9Jl1OYU1QcjcyltFrl0YAsZM+L5Vk2vCLOJbmKPTFOyVMdJz3Z707RTkyp0NsrfkUQA7XzNJ2+tBK0aKxeByC0fNXtfd2EpZzHxe1nP8swnEvUNmDiNf
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=LpQP-O61AAAA:8 a=c-n4J4-pAAAA:8 a=VwQbUJbxAAAA:8 a=87Stvw7ua9tTjDHUg0YA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22
    a=L0NDqeB7ZLmQzAogN4cw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeDDB0w (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 21:26:52 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:26070 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753124AbeDDB0v (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 3 Apr 2018 21:26:51 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w341QU5H002196
X-Nifty-SrcIP: [209.85.217.174]
X-Google-Smtp-Source: AIpwx48FCzNf+SXNPR0l6CUmDVJaVVk/8YXHkzelwHbgEDNmPTuM/qOn15FsEWslP8ZszNmZGPEa9q/jwiWMNh10XpY=
MIME-Version: 1.0
In-Reply-To: <adf0ab8f-2808-8772-76c5-b4a3075557c4@codeaurora.org>
References: <1522303676-7035-1-git-send-email-yamada.masahiro@socionext.com>
 <1522742421.5089.1.camel@pengutronix.de> <CAK7LNARmw5-d5v41GRPhmVk69obK0gVt_EEGnpydk3GU2UaV9Q@mail.gmail.com>
 <1522745178.5089.10.camel@pengutronix.de> <CAK7LNAQ8ySPxyetOU_m5Sjrzb_4PTsVkZd0KzH7cVmq3yJtWcQ@mail.gmail.com>
 <adf0ab8f-2808-8772-76c5-b4a3075557c4@codeaurora.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 4 Apr 2018 10:25:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNASifFt+5UPMPz=UxOkNbNgkgjP64+kPe=1SkqEx2RKb0g@mail.gmail.com>
Message-ID: <CAK7LNASifFt+5UPMPz=UxOkNbNgkgjP64+kPe=1SkqEx2RKb0g@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: of-simple: use managed and shared reset control
To: Vivek Gautam <vivek.gautam@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-03 19:35 GMT+09:00 Vivek Gautam <vivek.gautam@codeaurora.org>:
>
>
> On 4/3/2018 3:49 PM, Masahiro Yamada wrote:
>>
>> 2018-04-03 17:46 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
>>>
>>> On Tue, 2018-04-03 at 17:30 +0900, Masahiro Yamada wrote:
>>>>
>>>> 2018-04-03 17:00 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
>>>>>
>>>>> On Thu, 2018-03-29 at 15:07 +0900, Masahiro Yamada wrote:
>>>>>>
>>>>>> This driver handles the reset control in a common manner; deassert
>>>>>> resets before use, assert them after use.  There is no good reason
>>>>>> why it should be exclusive.
>>>>>
>>>>> Is this preemptive cleanup, or do you have hardware on the horizon that
>>>>> shares these reset lines with other peripherals?
>>>>
>>>> This patch is necessary for Socionext SoCs.
>>>>
>>>> The same reset lines are shared between
>>>> this dwc3-of_simple and other glue circuits.
>>>
>>> Thanks, this is helpful information.
>>>
>>>>>> Also, use devm_ for clean-up.
>>>>>>
>>>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>>>> ---
>>>>>>
>>>>>> CCing Philipp Zabel.
>>>>>> I see his sob in commit 06c47e6286d5.
>>>>>
>>>>> At the time I was concerned with the reset_control_array addition and
>>>>> didn't look closely at the exclusive vs shared issue.
>>>>>>
>>>>>>   drivers/usb/dwc3/dwc3-of-simple.c | 7 ++-----
>>>>>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c
>>>>>> b/drivers/usb/dwc3/dwc3-of-simple.c
>>>>>> index e54c362..bd6ab65 100644
>>>>>> --- a/drivers/usb/dwc3/dwc3-of-simple.c
>>>>>> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
>>>>>> @@ -91,7 +91,7 @@ static int dwc3_of_simple_probe(struct
>>>>>> platform_device *pdev)
>>>>>>        platform_set_drvdata(pdev, simple);
>>>>>>        simple->dev = dev;
>>>>>>
>>>>>> -     simple->resets =
>>>>>> of_reset_control_array_get_optional_exclusive(np);
>>>>>> +     simple->resets =
>>>>>> devm_reset_control_array_get_optional_shared(dev);
>>>>>
>>>>>  From the usage in the driver, it does indeed look like _shared reset
>>>>> usage is appropriate. I assume that the hardware has no need for the
>>>>> reset to be asserted right before probe or after remove, it just
>>>>> requires that the reset line is kept deasserted while the driver is
>>>>> probed.
>>>>>
>>>>>>        if (IS_ERR(simple->resets)) {
>>>>>>                ret = PTR_ERR(simple->resets);
>>>>>>                dev_err(dev, "failed to get device resets, err=%d\n",
>>>>>> ret);
>>>>>> @@ -100,7 +100,7 @@ static int dwc3_of_simple_probe(struct
>>>>>> platform_device *pdev)
>>>>>>
>>>>>>        ret = reset_control_deassert(simple->resets);
>>>>>>        if (ret)
>>>>>> -             goto err_resetc_put;
>>>>>> +             return ret;
>>>>>>
>>>>>>        ret = dwc3_of_simple_clk_init(simple,
>>>>>> of_count_phandle_with_args(np,
>>>>>>                                                "clocks",
>>>>>> "#clock-cells"));
>>>>>> @@ -126,8 +126,6 @@ static int dwc3_of_simple_probe(struct
>>>>>> platform_device *pdev)
>>>>>>   err_resetc_assert:
>>>>>>        reset_control_assert(simple->resets);
>>>>>>
>>>>>> -err_resetc_put:
>>>>>> -     reset_control_put(simple->resets);
>>>>>>        return ret;
>>>>>>   }
>>>>>>
>>>>>> @@ -146,7 +144,6 @@ static int dwc3_of_simple_remove(struct
>>>>>> platform_device *pdev)
>>>>>>        simple->num_clocks = 0;
>>>>>>
>>>>>>        reset_control_assert(simple->resets);
>>>>>> -     reset_control_put(simple->resets);
>>>>>>
>>>>>>        pm_runtime_put_sync(dev);
>>>>>>        pm_runtime_disable(dev);
>>>>>
>>>>> Changing to devm_ changes the order here. Whether or not it could be a
>>>>> problem to assert the reset only after pm_runtime_put (or potentially
>>>>> never), I can't say. I assume this is a non-issue, but somebody who
>>>>> knows the hardware better would have to decide.
>>>>
>>>>
>>>>
>>>> I do not understand what you mean.
>>>
>>> Sorry for the confusion, I have mixed up things here.
>>>
>>>> Can you describe your concern in more details?
>>>>
>>>> I am not touching reset_control_assert() here.
>>>
>>> With the change to shared reset control, reset_control_assert
>>> potentially does nothing, so it could be possible that
>>> pm_runtime_put_sync cuts the power before the reset es asserted again.
>>>
>>>> I am delaying the call for reset_control_put().
>>>
>>> Yes, please disregard my comment about the devm_ change, that should
>>> have no effect whatsoever and looks fine to me.
>>>
>>>> If I understand reset_control_put() correctly,
>>>> the effects of this change are:
>>>>    - The ref_count and module ownership for the reset controller
>>>>      driver will be held a little longer
>>>>    - The call for kfree() will be a little bit delayed.
>>>
>>> Correct.
>>>
>>>> Why do you need knowledge about this hardware?
>>>
>>> Is it ok to keep the reset deasserted while the power is cut?
>>> Or do you
>>> have to guarantee that drivers sharing the same reset also keep the same
>>> power domains active?
>>>
>> If this were really a problem, the driver would have to check
>> the error code from reset_control_assert().
>
>
> Just to understand this - If the power domain isn't active for the said
> device,
> does it matter if it is in reset state or not?
>
>>
>>
>>   ret = reset_control_assert(simple->resets);
>>   if (ret)
>>             return ret; /* if we cannot assert reset, do not allow
>> driver detach */
>
>
> What's the point of this. The power domain and reset should be independent
> of each other, and when we are doing a driver detach, the state of hardware
> should be of less concern.
> The device should anyways not leak power when the power domain isn't active.
>

I do not see any point in worrying about this.


Philipp,
Do you agree this patch is no problem?



-- 
Best Regards
Masahiro Yamada
