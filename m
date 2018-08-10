Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A62C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2082223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSBZHP16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2082223F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeHJJur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:50:47 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44404 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbeHJJur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:50:47 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so14200349oih.11;
        Fri, 10 Aug 2018 00:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bej40m6jaUQMaVoh9CftabVmceVnhkWzmHHmWjCPz+8=;
        b=iSBZHP1605f0D8iajPNbeWCJPKNz2SdXAJrVnPqs3R/rVpB6sxAezV62pVIbwEuUQf
         ksRaffQZE7SZH1nAFqgRU0f56lJMJ+KOpskY/cIcrlGiQd422uTN9mbhihoMA5pf6yZp
         yJ/ysQwfSal06e/64FdJarIYUoZ2IegJuqr5L+PtBQb5wOt21aQ0PbYnl95SeLdg31AD
         Q2Rn86CAGQoLHsM9cBkCbxaKGFS9DW/TV3HXiVziRH2c6RXj0AjHMnP6x8GBQHkyA/db
         wxToMRekn9NTeYygpXrpTQFcSgsguEHp1yGFX3mz5ooDaB7xzQQ+vZUVmomKuYiYpc8U
         4aQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bej40m6jaUQMaVoh9CftabVmceVnhkWzmHHmWjCPz+8=;
        b=roIfxZutHlhghvhCyl5npjdgYT5RF7J9ZkVgOCEDAJOTgbvB66G8S4ESTAxWRFD3lU
         ehuvS6kyfMA/kzdurHG0bDUaxW3pBD7ch/rd1746L7BHC+WcvFF4LtqNnTYz3yuM00yJ
         PL7RwSvExsSo4JGQOHcsTTILlH7OlsoAuropAx9yjT5w0niuAfX5aPyCr4fiAMVsZja1
         /lIMH3LzNVV0Zr0wlIsuipB8xrpfX7WDGfw0td9iKcTCk8PewD9Ct+swEIJ8mTUoAUFi
         33NE27IRXEiCJIDHWVLlkZDeVFjcJk3IBSFZwk8P6DAKK9vfAdxpq5R+gVDdswJGBqk6
         8rWA==
X-Gm-Message-State: AOUpUlESDaJhARZlfojhB1xjbpnOiUV5Ocx6WHmqbPh00O9TOFryOCUS
        Y7+vaZeDgXW4CFvjmnw/2oPoNg8b3gu48QyaGMw=
X-Google-Smtp-Source: AA+uWPwE8i5ymF54MJGwQInPYni6AT1Gn0cE0ON8RzWkVStkbUKAJspfLs9AWPvy2kgY9V3Y2oiFUdvCVWdXwMWA9Gg=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr5938875oib.116.1533885731020;
 Fri, 10 Aug 2018 00:22:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 00:22:10
 -0700 (PDT)
In-Reply-To: <20180810071321.GC11817@leoy-ThinkPad-X240s>
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
 <1533835203-5789-2-git-send-email-leo.yan@linaro.org> <CAJZ5v0hU3Qp3ycJ=aGHtPMMC_6A+XsByYALYN22dz2VJ1Z0MgQ@mail.gmail.com>
 <20180810071321.GC11817@leoy-ThinkPad-X240s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Aug 2018 09:22:10 +0200
X-Google-Sender-Auth: mAto10KpJu47-aO-tsCcaNLtofk
Message-ID: <CAJZ5v0iyGFFDO83KGcET9a+UpPCDQ=_sxZeGxuG6fL4O+hcw+w@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 1/2] cpuidle: menu: Correct the criteria for
 stopping tick
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 9:13 AM,  <leo.yan@linaro.org> wrote:
> On Thu, Aug 09, 2018 at 10:47:17PM +0200, Rafael J. Wysocki wrote:
>> On Thu, Aug 9, 2018 at 7:20 PM, Leo Yan <leo.yan@linaro.org> wrote:

[cut]

>> And that will cause the tick to be stopped unnecessarily in certain
>> situations, so why is this better?
>
> Let's see below two cases, the first one case we configure
> TICK_USEC=1000 (1ms) and the second case we configure TICK_USEC=4000
> (4ms).
>
> Let's assume we do the testing one the same platform and have two runs,
> in the Case 1 we configure HZ=1000 so TICK_USEC=1ms, expected_interval
> is 3ms and deepest idle state target residency is 2ms, finally the idle
> governor will choose the deepest state and skip to calibrate to shallow
> state caused by 'expected_interval' > TICK_USEC;
>
> In the Case 2 we configure HZ=250 so TICK_USE=4ms, expected_interval
> (3ms) and deepest idle state target residency (2ms) are same with the
> Case 1; but because expected_interval < TICK_USEC so the idle governor
> will do calibration to select a shallower state.  If we image on one
> platform, the deepest idle state's target residency is smaller value,
> then it has bigger gap with TICK_USEC, the deepest idle state is harder
> to be selected due 'expected_interval' can be easily hit the range
> [Deepest target residency..TICK_USEC).
>
> This patch has no any change for Case 1 and it wants to optimize for
> Case 2 so Case 2 has chance to stay in deepest idle state.  I
> understand from the performance pespective, we need to avoid to stop
> tick for shallow states; on the other hand we cannot prevent CPU run
> into deepest idle state just only we want to keep the tick running,
> especially the expected interval is longer than the deepest state
> target residency.
>
> Case 1:
>       Deepest idle state's target residency=2ms
>                      |
>                      V
> |--------------------------------------------------------> time (ms)
>       ^                              ^
>       |                              |
> TICK_USEC=1ms           expected_interval=3ms
>
>
> Case 2:
>       Deepest idle state's target residency = 2ms
>                      |
>                      V
> |--------------------------------------------------------> time (ms)
>                                      ^                  ^
>                                      |                  |
>                           expected_interval = 3ms   TICK_USEC = 4ms
>
>
>
>> >                 unsigned int delta_next_us = ktime_to_us(delta_next);
>> >
>> >                 *stop_tick = false;
>> > --

Well, I don't quite agree with the approach here, then.

As I said in the previous reply, IMO restarting the stopped tick
before leaving the loop in do_idle() is pointless overhead.  It is not
necessary to do that to avoid leaving CPUs in shallow idle states for
too long (I'll send an alternative patch to fix this issue shortly).

While you may think that pointless overhead is not a problem, I don't
quite agree with that.
