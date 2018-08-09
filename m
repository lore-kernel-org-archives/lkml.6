Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880ECC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E974217FE
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epEUY63E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E974217FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbeHITcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:32:24 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45373 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbeHITcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:32:24 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so11014635oic.12;
        Thu, 09 Aug 2018 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4Tae2c/tXSAym/+pbX+3Q8E3OMphRRZ2zCvnnMZucU4=;
        b=epEUY63EF89m/wsjROg95xof+tabZ7g9kUxIp0LDA+EnNLfM/EYcBCpUK0dBdHxP2g
         l59VGb2rcALUcCkKCPzckvAr+x2k6+LH6di2/oG5vY/FPYblPD0L+46DNbyv3ynLHVvA
         TDAN6W3P5dcE5FHSvJW7dcq8lZvcRI77IBjqaYmxAReFsfsDNDXC2+Px/zRABdHa8F4H
         wBhU0Nm9oFKHkXCh61NhCzHNcMBBmvgzI2c0ACrRNYsH4qWgvTQ19QfuYZJq1ZKQaLMi
         3ZlCd9wmYI3K9KgCYxo65yOgKrTZ3MzljkzNZ9LTl2wZPthsKMF8nQCOn9Gwv2rV1Q+O
         Z84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4Tae2c/tXSAym/+pbX+3Q8E3OMphRRZ2zCvnnMZucU4=;
        b=gRNeP58T7K38XfV9FNi+pw05MtllII8C0xBTfNntTSerZQs3B3ZQfr/hAik8pDY1kE
         a+M9BlkSloBnIvMndbZu8IQ2nu0mnvH+asm5/43CB1340qFHFGhp2cTwHpQSBkWfdLCz
         j+HRQDuv0Q8ArUaH0P5JHqwHWYPJJ1HqQjpptxmuyC/xwdhxhTpX6BYVNXTWNiHNG6nv
         0bhVHHom63nuM73dG3d+ibYH7rEc/bWuKDI/6AVhBC8mM1ImrR4m9jvioOK8dleJZ59P
         06tHrJhnyCTsXQAzkJVPqvq9Z/vCm1WHBt49qHlLmRBw0zEuAzc2Bkt28zsZY+X0LNUg
         jJWA==
X-Gm-Message-State: AOUpUlEkSXiDpdqPEJCklLlezY+cYJaAXhgE2Ktg/HB/OpIvwLrMgebX
        XB7ILUQvaw21rNn4AxUGUcMYlDWvxejtDCR3TAg=
X-Google-Smtp-Source: AA+uWPymXtuAbLG1eFyRCvsD3GHzNGrbhpMHGJvalaIAlKlJ1gGMwFFk0yS+r12Mp0/dzHPLl5W5dZ70xGd9dhNDdno=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr3034482oie.174.1533834397115;
 Thu, 09 Aug 2018 10:06:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 10:06:36 -0700 (PDT)
In-Reply-To: <20180809170449.GE14362@leoy-ThinkPad-X240s>
References: <1533793647-5628-1-git-send-email-leo.yan@linaro.org>
 <2704016.RYJlhC2yyo@aspire.rjw.lan> <CAJZ5v0goNUVR8UZPnBegVZjBshkt+G-D7UK_x5dOi+BCjAr5Yg@mail.gmail.com>
 <20180809162957.GD14362@leoy-ThinkPad-X240s> <CAJZ5v0it0XM29OGnNfanrRAH3E8uHkJjXVwgHBQRiT9aZ0747A@mail.gmail.com>
 <20180809170449.GE14362@leoy-ThinkPad-X240s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Aug 2018 19:06:36 +0200
X-Google-Sender-Auth: -nXhBeZ29YQZfTG9HfwtidtmIbg
Message-ID: <CAJZ5v0h215dcOhESqu=E51kKX2TS9zUvz5hX5u2ogzP9OeVhsA@mail.gmail.com>
Subject: Re: [PATCH] sched: idle: Reenable sched tick for cpuidle request
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 7:04 PM,  <leo.yan@linaro.org> wrote:
> On Thu, Aug 09, 2018 at 06:43:55PM +0200, Rafael J. Wysocki wrote:
>> On Thu, Aug 9, 2018 at 6:29 PM,  <leo.yan@linaro.org> wrote:
>> > On Thu, Aug 09, 2018 at 05:42:30PM +0200, Rafael J. Wysocki wrote:
>> >
>> > [...]
>> >
>> >> >> This issue can be easily reproduce with the case on Arm Hikey board: use
>> >> >> CPU0 to send IPI to CPU7, CPU7 receives the IPI and in the callback
>> >> >> function it start a hrtimer with 4ms, so the 4ms timer delta value can
>> >> >> let 'menu' governor to choose deepest state in the next entering idle
>> >> >> time.  From then on, CPU7 restarts hrtimer with 1ms interval for total
>> >> >> 10 times, so this can utilize the typical pattern in 'menu' governor to
>> >> >> have prediction for 1ms duration, finally idle governor is easily to
>> >> >> select a shallow state, on Hikey board it usually is to select CPU off
>> >> >> state.  From then on, CPU7 stays in this shallow state for long time
>> >> >> until there have other interrupts on it.
>> >> >
>> >> > And which means that the above-mentioned code misses this case.
>> >>
>> >> And I don't really understand how this happens. :-/
>> >>
>> >> If menu sees that the tick has been stopped, it sets
>> >> data->predicted_us to the minimum of TICK_USEC and
>> >> ktime_to_us(delta_next) and the latency requirements comes from PM QoS
>> >> (no interactivity boost).  Thus the only case when it will say "do not
>> >> stop the tick" is when delta_next is below the tick period length, but
>> >> that's OK, because it means that there is a timer pending that much
>> >> time away, so it doesn't make sense to select a deeper idle state
>> >> then.
>> >>
>> >> If there is a short-interval timer pending every time we go idle, it
>> >> doesn't matter that the tick is stopped really, because the other
>> >> timer will wake the CPU up anyway.
>> >>
>> >> Have I missed anything?
>> >
>> > Yeah, you miss one case is if there haven't anymore timer event, for this
>> > case the ktime_to_us(delta_next) is a quite large value and
>> > data->predicted_us will be to set TICK_USEC; if HZ=1000 then TICK_USEC is
>> > 1000us, on Hikey board if data->predicted_us is 1000us then it's easily
>> > to set shallow state (C1) rather than C2.  Unfortunately, this is the
>> > last time the CPU can predict idle state before it will stay in idle
>> > for long period.
>>
>> Fair enough, but in that case the governor will want the tick to be
>> stopped, because expected_interval is TICK_USEC then, so I'm not sure
>> how the patch helps?
>
> Correct, I might introduce confusion at here and I mentioned in
> another email I have one prerequisite patch [1]: "cpuidle: menu: Correct
> the criteria for stopping tick", if without this dependency patch, the idle
> governor will always stop the tick even it selects one shallow state.
>
> Sorry when I sent patchs with [1], I didn't send to linux-pm mailing list,
> do you want me to send these patches to linux-pm?

Please do.
