Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A972C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 03:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65A921532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 03:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyWul5Bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65A921532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbeIVJWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 05:22:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42006 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbeIVJWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 05:22:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1-v6so13694420ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 20:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nk2Z8opOKsSKxYWStQ81v0b7LqWXXCSpIf+wUgSfYEc=;
        b=DyWul5BsvmH0A0OQk0ko/of0cNskPrUQiLfUXZO1D8Dm4Dfqcag3Nm1Zr7Peswcrb2
         tzOo0mo1vK+/XUmhGS8LoThRhgje48hIMs0kcx49CyO3rR1LBUB5JXg4B5MLo8TeAnbl
         fvhFbuDsgwc6EHkUosyyAs7siIJILIb9qfpTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nk2Z8opOKsSKxYWStQ81v0b7LqWXXCSpIf+wUgSfYEc=;
        b=hGROOIM/NEkZZGycqW3UUnTHWoDWoGg0s/r4+xVKqxQcpGWvsvxfKRme2GcFCESrjH
         aJ7KZn/6YND/k5L5yjkeo66ELsVyrP6vf1bzNRR2aJAbDtfZFHinSSrqfjRxzpKYAqM9
         APCf8mN1OwzVFQp1POEkowPj34aRDnooPytKPbbe0RGchRQq63zINV8H3WNrve1O5O+A
         oHOC0ExPZ+GNfR0O+7vMEvI3ussQL3aZ/7RFAnSaSGWqGsRCv02pkH4Y6OV1X//khu2Y
         vwr721GO5FpYhmsHEs3NsZSRNvpVDDBndqThv034CWOdOlUopc+2IM+KZCnoGJprFqCi
         6wdg==
X-Gm-Message-State: ABuFfoguRA+s6e/7SQ7floDjf1j8+25kMpwI2aekYH9GuGxPUDxJBwTi
        ZUTKA7kaEUcNGhS645EEHXCCSEgKxgQ+wnnaBrsqIA==
X-Google-Smtp-Source: ACcGV60AGbnFNN9OITbF01/N31SX5VuYF0BCe4CAaKSFhOPxTKJPkpUPTuoVJ0wtTXjgrVbMs/fFYl46gGRBZvfH8qM=
X-Received: by 2002:a2e:d1:: with SMTP id e78-v6mr4044034lji.127.1537587054308;
 Fri, 21 Sep 2018 20:30:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9045:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 20:30:53
 -0700 (PDT)
In-Reply-To: <20180921221813.GA20355@amd>
References: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
 <CAMz4kuJx9twJ=wM5qsucV3JH_VS-AC1aWMqpQOwAMkCuKBHLRg@mail.gmail.com>
 <324778a9-a32c-ae6e-337a-39845f214bfc@gmail.com> <20180921211758.GC18062@amd>
 <ccac8e5f-e122-9f7d-aa43-fa89c79cb1fe@gmail.com> <20180921221813.GA20355@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Sat, 22 Sep 2018 11:30:53 +0800
Message-ID: <CAMz4kuLw+js9c0RfpNyEOc3hgqB6tbpX3g+-XpAR7oZx56gtYg@mail.gmail.com>
Subject: Re: [PATCH v12 1/2] leds: core: Introduce LED pattern trigger
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        rteysseyre@gmail.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22 September 2018 at 06:18, Pavel Machek <pavel@ucw.cz> wrote:
> On Sat 2018-09-22 00:11:29, Jacek Anaszewski wrote:
>> On 09/21/2018 11:17 PM, Pavel Machek wrote:
>> > On Fri 2018-09-21 22:59:40, Jacek Anaszewski wrote:
>> >> Hi Baolin,
>> >>
>> >> On 09/21/2018 05:31 AM, Baolin Wang wrote:
>> >>> Hi Jacek and Pavel,
>> >>>
>> >>> On 11 September 2018 at 10:47, Baolin Wang <baolin.wang@linaro.org> wrote:
>> >>>> This patch adds one new led trigger that LED device can configure
>> >>>> the software or hardware pattern and trigger it.
>> >>>>
>> >>>> Consumers can write 'pattern' file to enable the software pattern
>> >>>> which alters the brightness for the specified duration with one
>> >>>> software timer.
>> >>>>
>> >>>> Moreover consumers can write 'hw_pattern' file to enable the hardware
>> >>>> pattern for some LED controllers which can autonomously control
>> >>>> brightness over time, according to some preprogrammed hardware
>> >>>> patterns.
>> >>>>
>> >>>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
>> >>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> >
>> >>> Do you have any comments for the v12 patch set? Thanks.
>> >>
>> >> We will probably have to remove hw_pattern from ledtrig-pattern
>> >> since we are unable to come up with generic interface for it.
>> >> Unless thread [0] will end up with some brilliant ideas. So far
>> >> we're waiting for Pavel's reply.
>> >>
>> >> [0] https://lkml.org/lkml/2018/9/13/1216
>> >
>> > To paint a picture:
>> >
>> > brightness
>> >
>> >    rise hold          lower       hold down
>> >   ^    XXXXXXXXXXXXXXX
>> >   |   X               XX
>> >   |  X                  XX
>> >   | X                     XXXXXXXXXXXXXXXXXXXXXXXXXX
>> >   +-------------------------------------------------------> time
>> >
>> > This is what Baolin's hardware can do, right?
>> >
>> > This is also what pattern trigger can do, right?
>> >
>> > So all we need to do is match the two interfaces, so that hw_pattern
>> > returns -EINVAL on patterns hardware can not actually do.
>> >
>> > I believe I described code to do that in [0] above.
>>
>> You said that we should get the same effect by writing the
>> same series of tuples to either pattern or hw_pattern file.
>>
>> Below command consists of four tuples (marked with brackets
>> to highlight), and it will activate breathing mode in Baolin's
>> hw_pattern:
>>
>> "[0 rise_duration] [brightness high_duration] [brightness fall_duration]
>> [0   low_duration]"
>>
>> Now, I can't see how these four tuples could force the software
>> fallback to produce breathing effect you depicted.
>
> I really should get some sleep now. But my intention was that software
> fallback produces just that with those four tuples. (If it does not,
> we can fix the software fallback to do just that).

I agree with Jacek. For our SC27XX led, we just need set 4 components
(low state, rise stage, high stage and fall stage) for one hardware
pattern to enable the breathing mode, but it is hard to use software
pattern to simulate the hardware breathing mode if failed to set the
hardware pattern, especially for the rising time and falling time
which are hard for software pattern to simulate.

-- 
Baolin Wang
Best Regards
