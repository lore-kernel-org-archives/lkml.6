Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B63C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1491920644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YaJ3JTnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1491920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJKJa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 05:30:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45511 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKJa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 05:30:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id j4-v6so6690000ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 19:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D+O0pjJIwq4BL7f2f6iWE3bMiUceqiosooNhxDNa6JQ=;
        b=YaJ3JTnrl7NkddYOJyc6FOkdss1rZQLedhn01mfOlE8MOtYZh0Kbuo88FO+kAQrVuf
         BBJr7lMRjlkSdm+A6es7l5G6aLb0yWqa0+dJgheTfzQwFx9K9JrEfG9UzeNNXWOPH/dm
         A/7vFLItBAMPwAkJCG4HTBa5jBEBZvPW0kfq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D+O0pjJIwq4BL7f2f6iWE3bMiUceqiosooNhxDNa6JQ=;
        b=Zdk9OrzM8KWVG6pHSmWwP3S+VwqP7PRlFKNjjDM1SZDDkkCL21vYhDjJiZhV7Jfw60
         ql8ObyhcpXBt9oWoBf7uD11AhnfACF1vIoUP4HKTVEZWQFV5f7IXBtEnncGesrxN08+i
         F5JW+nH6Lo9j+zAQj3UtoFV2kpZw27sAmdbZtxoKWE6XRgBEWEpjfbNP8dCoMxNAurt+
         WmnZjwerbrCZ5gN6fBf3DcIwaF/nAkyF05jzjNySpl9MZ+JFHKzJAMIb7VnvK/lExm25
         osI4GkWrXExz+5YpTOuQSztmFYGldBaNT8IsJJJPJSUeDEgKUZ6REP8W5beWAcHnoTNA
         qAQQ==
X-Gm-Message-State: ABuFfohHs7NcFutuf5coYilax+RiNw41/KSBkJ0gIKYnNzjmj8GcmdQU
        /4R6sCyUiIN22NTHowMaDk5ziwT4v3Jg9uUjnXH+iQ==
X-Google-Smtp-Source: ACcGV60tm8vgeStxbhB21kuY7coousfIT/7WizrQvfevQD3aHoNWw3gJtLTdOA7D/RQnWJwRcxzlqe8KZ6fhwQQopoA=
X-Received: by 2002:a2e:3101:: with SMTP id x1-v6mr19783504ljx.83.1539223558955;
 Wed, 10 Oct 2018 19:05:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 19:05:58
 -0700 (PDT)
In-Reply-To: <20181010160041.GA22121@amd>
References: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
 <9bf6236e-83af-7156-b26b-7d88ece2d81e@gmail.com> <20181010160041.GA22121@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 11 Oct 2018 10:05:58 +0800
Message-ID: <CAMz4kuKAafWqf4VZ4vwJoZeUi2g+m7drEZettqd2UzXvOn4Vxg@mail.gmail.com>
Subject: Re: [PATCH v14 1/2] leds: core: Introduce LED pattern trigger
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        rteysseyre@gmail.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 11 October 2018 at 00:00, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> [Oops. I wrote this but forgot to send it? Anyway.. I guess it is
> redundant now.]
>
>> > +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>> > @@ -0,0 +1,76 @@
>> > +What:              /sys/class/leds/<led>/pattern
>> > +Date:              September 2018
>> > +KernelVersion:     4.20
>> > +Description:
>> > +           Specify a software pattern for the LED, that supports altering
>> > +           the brightness for the specified duration with one software
>> > +           timer. It can do gradual dimming and constant brightness.
>> > +
>> > +           The pattern is given by a series of tuples, of brightness and
>> > +           duration (ms). The LED is expected to traverse the series and
>> > +           each brightness value for the specified duration. Duration of
>> > +           0 means brightness should immediately change to new value.
>> > +
>> > +           1. When doing gradual dimming, the led brightness will be updated
>> > +           every 50 milliseconds, so the duration of each step should not
>> > +           less than 50 milliseconds.
>>
>> I'd like to avoid this constraint. Lowest supported delta_t should be 1.
>>
>> We should only prevent entering dimming mode if current delta_t
>> is lower than UPDATE_INTERVAL.
>
> I agree that documenting it like this is strange. I don't think this
> should be part of ABI as we may want to adjust it in the future.
>
>> I also propose to make the dimming interval configurable via sysfs
>> dimming_interval file.
>
> I believe we should provide "right" dimming_interval. 50msec sounds
> good. If we find it is too low / too high, we might want to adjust it.
>
> If we find out that different users need different values, I guess we
> can still add "dimming_interval" knob, but I'd suggest waiting until
> such need arises.
>
> [Now, I don't have strong feelings here, and patch would probably be
> okay with me even if it has dimming_interval, but I'd prefer to keep
> it simple. We are at v14 of the patch...]

Make sense. I will leave this feature until someone has the
dimming_interval adjustment. Thanks.

-- 
Baolin Wang
Best Regards
