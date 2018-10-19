Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71B5ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FC821470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q7acS+6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FC821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeJTCqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:46:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37676 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeJTCqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:46:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id 185-v6so4608636wmt.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SplUevsLp+LzH2TY51KDNrpqIc/UWNggz6hbVrJ44lE=;
        b=Q7acS+6xp5kQrDbx+EYJ1oqSjQiMn3oOc28hAVG3Hjs3jC6J6dmX9W5xMP5aS1ckdz
         E4Krpap5y8c2UcAjkEabgXj+5XNXxFZCsbBQZLDfrhzqas0Pyx/dT16QV12rYpURO6xv
         xCwCWMNwyn8+0hceEM8bgan61Ub0AupoD4Oh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SplUevsLp+LzH2TY51KDNrpqIc/UWNggz6hbVrJ44lE=;
        b=s0LsJt98i2I3VhP+uuABmOvgiga/NC64MN5XqUUznPIayqU56WJA1/lGmkR62YkuTj
         Nf4nXkHVWkN1XSvGn/5f3YM5GZjoIIZMNASDGkpj+qv/t0sfTugQU4O7Jwh25S02sHPJ
         MO46yYWHka/1oR48Mvt6WJOXekoqoPrYi7SgoDFvwKODH/ua14jFD4ScQ1E7DvoKejt8
         NWaX+t7Vvw+WJERuYlzC5xK+eJDTo3pcu9qzQsr2f21Exsce7swRBuK26cEsTzAxfNu2
         SxiHWJIYaPif1LnzijmrULdX3jUArtOgiILP3H3bAdzM2jX0EVPbi4XvSc8iiloJ19if
         i7sw==
X-Gm-Message-State: ABuFfoiSMuD4mOIJB3nvuQyL4/vEaBLFZQIS73vz/UYs5FySg4lRiiO+
        NBK7TD1gTZ9FrcTWZYiSvIPbOh4S+6ScsHF+ncp5oA==
X-Google-Smtp-Source: ACcGV60FZJQD5InGPW4MX7GlV5vWw5sAngCZ0kDvlARMflYrubB2xhO5yCZfroEMbRsgI679mkBqSOBq1x/B/++9y8k=
X-Received: by 2002:a1c:2984:: with SMTP id p126-v6mr6390766wmp.5.1539974364033;
 Fri, 19 Oct 2018 11:39:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 11:39:23
 -0700 (PDT)
In-Reply-To: <CALAqxLU-riM7e2u3c-eOnsSJwvvHvq75aYpwELCCmMTSdGAdxw@mail.gmail.com>
References: <20181015160945.5993-1-christopher.s.hall@intel.com>
 <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de> <CALAqxLU-riM7e2u3c-eOnsSJwvvHvq75aYpwELCCmMTSdGAdxw@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 19 Oct 2018 11:39:23 -0700
Message-ID: <CALAqxLX1ncJZwZw3CyR-NjoZoZj9XaeR9_VEDT9m=dHZD4KUaQ@mail.gmail.com>
Subject: Re: TSC to Mono-raw Drift
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com, gavin.hindman@intel.com,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 11:34 AM, John Stultz <john.stultz@linaro.org> wrote:
> On Fri, Oct 19, 2018 at 8:25 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> Christopher,
>>
>> Please Cc LKML on such issues in the future.
>>
>> On Mon, 15 Oct 2018, Christopher Hall wrote:
>>
>> Leaving context around for new readers:
>>
>>> Problem Statement:
>>>
>>> The TSC clocksource mult/shift values are derived from CPUID[15H], but the
>>> monotonic raw clock value is not equal to TSC in nominal nanoseconds, i.e.
>>> the timekeeping code is not accurately transforming TSC ticks to nominal
>>> nanoseconds based on CPUID[15H}.
>>>
>>> The included code calculates the drift between nominal TSC nanoseconds and
>>> the monotonic raw clock.
>>>
>>> Background:
>>>
>>> Starting with 6th generation Intel CPUs, the TSC is "phase locked" to the
>>> Always Running Timer (ART). The relation between TSC and ART is read from
>>> CPUID[15H]. Details of the TSC-ART relation are in the "Invariant
>>> Timekeeping" section of the SDM.
>>>
>>> CPUID[15H].ECX returns the nominal frequency of ART (or crystal frequency).
>>> CPU feature TSC_KNOWN_FREQ indicates that tsc_khz (tsc.c) is derived from
>>> CPUID[15H]. The calculation is in tsc.c:native_calibrate_tsc().
>>>
>>> When the TSC clocksource is selected, the timekeeping code uses mult/shift
>>> values to transform TSC into nanoseconds. The mult/shift value is determined
>>> using tsc_khz.
>>>
>>> Example Output:
>>>
>>> Running for 3 seconds trial 1
>>> Scaled TSC delta: 3000328845
>>> Monotonic raw delta: 3000329117
>>> Ran for 3 seconds with 272 ns skew
>>>
>>> Running for 3 seconds trial 2
>>> Scaled TSC delta: 3000295209
>>> Monotonic raw delta: 3000295482
>>> Ran for 3 seconds with 273 ns skew
>>>
>>> Running for 3 seconds trial 3
>>> Scaled TSC delta: 3000262870
>>> Monotonic raw delta: 3000263142
>>> Ran for 3 seconds with 272 ns skew
>>>
>>> Running for 300 seconds trial 4
>>> Scaled TSC delta: 300000281725
>>> Monotonic raw delta: 300000308905
>>> Ran for 300 seconds with 27180 ns skew
>>>
>>> The skew between tsc and monotonic raw is about 91 PPB.
>>>
>>> System Information:
>>>
>>> CPU model string: Intel(R) Core(TM) i5-6600 CPU @ 3.30GHz
>>> Kernel version tested: 4.14.71-rt44
>>>       NOTE: The skew seems to be insensitive to kernel version after
>>>               introduction of TSC_KNOWN_FREQ capability
>>>
>>> >From CPUID[15H]:
>>>       Time Stamp Counter/Core Crystal Clock Information (0x15):
>>>               TSC/clock ratio = 276/2
>>>               nominal core crystal clock = 24000000 Hz (table lookup)
>>>
>>> TSC kHz used to calculate mult/shift value: 3312000
>
> So, just to understand, your saying the problem that we calculate a
> tsc_khz value before calculating the mult/shift and the intermediate
> step is losing some precision?
>
> Or is the cause from something else?

The other potential cause here might be just that when we calculate
the mult/shift pair, we select a shift small enough that avoids the
multiplication from overflowing if we have a long timerval. So there
is liklely always some granularity error converting to mult/shift
pair.

thanks
-john
