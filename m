Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE38C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873FC21759
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kSJN+unX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kvWn4Ev7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873FC21759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbeHFW4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:56:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60660 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbeHFW4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:56:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 44055604BE; Mon,  6 Aug 2018 20:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533588366;
        bh=u3oJ/GHKx+YivpeNPcCKy+uLvmkAAkVCQTExoNmAkpo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kSJN+unXtJ1wBaOcfucJ6dkaOw8/U69w9hCCnTdpKKRJe9B9H0tXPa0VXfu5dvxsO
         qybRUn7neQxwiw9grBcDP9iMc/0sXSuM7fVetfqavlyAp19MhwdFaD6pvxY2kxOr+P
         snadPiPGvvGQUbjC0YZQ6LLyK1YUjTQh9shxSXsk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 57CC6604BE;
        Mon,  6 Aug 2018 20:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533588365;
        bh=u3oJ/GHKx+YivpeNPcCKy+uLvmkAAkVCQTExoNmAkpo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kvWn4Ev7svq40faWHNoCsLggERw/+9OG83yh/Xki9ks74/0KH6tHAVRSTvATJwiVp
         7PE6REvtivfuokF3o7aS5mA16mAuZKI9aBkT2quU3Bo3Z+DReKAxTjlbH80dx55e2+
         PUe04pLvxOqAmx/qgO/HCqgSoOT778CzoLvqhNkk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Aug 2018 13:46:05 -0700
From:   skannan@codeaurora.org
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Evan Green <evgreen@google.com>, tdas@codeaurora.org,
        rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        anischal@codeaurora.org, devicetree@vger.kernel.org,
        robh@kernel.org, amit.kucheria@linaro.org
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
In-Reply-To: <153333504360.10763.8964005567051510823@swboyd.mtv.corp.google.com>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
 <CAE=gft7_5SZKpU0i9Jbi6UV-eqW8=6Fm7rw4oKVXG6J9Q7_E+g@mail.gmail.com>
 <1ddda4b9e6dcd7ad415235f4d6af2dc7@codeaurora.org>
 <153333504360.10763.8964005567051510823@swboyd.mtv.corp.google.com>
Message-ID: <4d37a1ee4f2d5b30da3f62cbfca756a8@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-03 15:24, Stephen Boyd wrote:
> Quoting skannan@codeaurora.org (2018-08-03 12:52:48)
>> On 2018-08-03 12:40, Evan Green wrote:
>> > Hi Taniya,
>> >
>> > On Tue, Jul 24, 2018 at 3:44 AM Taniya Das <tdas@codeaurora.org> wrote:
>> >>
>> >> +               if (src)
>> >> +                       c->table[i].frequency = c->xo_rate * lval /
>> >> 1000;
>> >> +               else
>> >> +                       c->table[i].frequency = INIT_RATE / 1000;
>> >
>> > I don't know much about how this hardware works, but based on the
>> > mask, src has 4 possible values. So does 0 mean INIT_RATE, and 1, 2,
>> > and 3 all mean xo_rate?
>> >
>> > Also, is INIT_RATE really constant? It sounds like gpll0 (or
>> > gpll0_out_even?). You're already getting the xo clock, why not get
>> > gpll0's real rate as well?
>> 
>> Actually I was about to comment and say NOT to get clocks just to get
>> their rate. The XO_RATE is just a multiplication factor. This HW/FW 
>> can
>> change in the future and make the multiplication factor to 1KHz.
> 
> So future changes to this hardware are going to make this register
> return the final frequency that we should use? Sounds great! But that
> isn't how it's working right now. We need to have XO in the binding 
> here
> so the driver can work with different XO frequencies in case that ever
> happens. Same story for GPLL0. Hardcoding this stuff in the driver just
> means we'll have to swizzle things in the driver when it changes.

XO being a different frequency in a Qualcomm chip is way way less likely 
than anything else we are discussing here. In the 10+years I've been 
there this has never changed.

So, how about making this binding optional? If it's not present we can 
make assumptions for XO rate and init rate. That'll handle your 
hypothetical use case while also being optimized.

>> We also
>> can't really control any of the clocks going to this block from Linux
>> (it's all locked down).
> 
> This shouldn't matter. The clocks going to this hardware block are
> described by the firmware to the OS by means of the DT node. If the
> firmware or the hardware decides to change the input clks then the
> binding can have different clk nodes used.

There are tons of clocks that are input to blocks in an SoC that are 
never controlled by Linux. Or are expose in DT because they are set up 
ahead of time and can't change. So, why make an exception here?

>> Adding clk_get significantly delays when this
>> driver can be probed and increases boot up time.
> 
> Huh? Please fix your bootloader to increase the CPU frequency before
> booting the kernel. I really doubt probe defer is going to happen if we
> send GPLL0 here (XO is a DT clk so it's definitely registered before
> this driver), and trying to work around probe defer because the CPU
> won't go fast before that is papering over a larger problem with both
> probe defer and bootloaders not supplying enough CPU speed for you.

There are multiple reason the bootloader can't run the CPU faster. For 
one, it doesn't have thermal handling, etc. And adding all those 
features into the bootloader doesn't make sense when Linux already has 
support for it.

>> The INIT_RATE will
>> always be 300 MHz independent of what source it's coming from (as in, 
>> if
>> GPLL0 can't give 300, the HW design will be so that we'll find a
>> different source).
>> 
>> So, I'd like to remove any clock bindings for this driver.
> 
> No. Bindings describe how the hardware is connected. Please don't 
> remove
> clocks from the binding just because probe defer is a concern.

Binding describes hardware controllable by the OS. That's the reality. 
Let's not add mandatory clock bindings for clocks that the OS can't do 
anything about.

-Saravana
