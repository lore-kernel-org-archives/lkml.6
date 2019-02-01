Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064A3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2E121726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="jZL+5413"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfBAPuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:50:06 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:34835 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAPuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:50:06 -0500
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 3422BA433A;
        Fri,  1 Feb 2019 16:50:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1549036203;
        bh=IdJ+qnG4oGK4x2oWC2soZWimABf2rKuyDfQAEKydoUE=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=jZL+54139gSrH5nWs1cdBGBAV2tuLmDZjrtDyli7XIdsVrTMQGf93K1AzGbWwy6l9
         846Q3phsu4YIpSQJMYjg9t84p/HlzQobkFdzUo8HjufnD2MqrV1phamPnQgGR9XvyM
         51mjLagSNuAwxk5JuByHzQjdnoe1nGeNP37Ysndw=
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [RFC PATCH v3 2/2] pwm: imx: Configure output to GPIO in disabled
 state
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
 <20181212080154.kcfh57mulypwuscu@pengutronix.de>
 <52ed0614-d1f5-81cb-3b17-8eb137967872@ysoft.com>
 <20181212121255.yg6b4pw7qord7ebi@pengutronix.de>
 <4b0356b7-bc7d-a026-ac90-3f0c5754ed29@ysoft.com>
 <20190124092215.zbu62lhxf667rzvs@pengutronix.de>
 <4004896e-34fc-7160-2f21-30280d96f750@ysoft.com>
 <20190124104435.e6paqwcuz3hizwnv@pengutronix.de>
 <72bad040-05f4-607f-f210-468e46ea3228@ysoft.com>
 <20190130153921.met3kipvdsoctjoa@pengutronix.de>
Message-ID: <cc407ae4-3386-9b12-b2e7-95e3b6ddc722@ysoft.com>
Date:   Fri, 1 Feb 2019 16:50:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130153921.met3kipvdsoctjoa@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 30. 01. 19 16:39, Uwe Kleine-König wrote:
> On Wed, Jan 30, 2019 at 03:42:29PM +0100, Michal Vokáč wrote:
[...]> There are quite some drivers known (to me) being buggy here. My feeling
> is that Thierry doesn't share that impression and I think the only
> reasonable path forward is to first fix the requirements for drivers and
> when this is done, look at the implementations and fix them or conclude
> that the requirements are not practical and shift them accordingly.

I can't really comment on this as my experience is limited to the
i.MX only, but what you say sounds quite reasonable. What I think might
be a problem is it seems there is not many active members in the "PWM
community". Namely I think it is you and Thierry. Others are just
occasional contributors to PWM hw drivers. So it is not going to be an
easy task to conclude on a new/better/fixed set of requirements.
  
>  From my POV the situation is as follows: I suggested a few changes that
> seemed reasonable to me (e.g.: don't rely on the pin state to be
> inactive after disable; don't rely on a driver to block in .apply until
> the new configuration is active; thought about dropping .disable
> altogether) and Thierry shot them down indicating that he is not willing
> to change the API and all affected users for only one or a few
> implementations. My consequence is to be strict about the requirements
> because that's the only way to show the resulting pain (or see there
> isn't so much pain).

I remember those discussions. That is why I am worried if this is ever
going to move forward as the whole issue dates at least back to 2015.
Fingers crossed!

>> I did not delve into that too much but I believe there are some HW
>> requirements on those platforms to stop the PWM that way. Others
>> simply stop the PWM straight away. So I am confused even more
>> and wonder where your requirements came from?
> 
> I'm aware that many drivers don't adhere to these requirements. IMHO
> this is related to the poor situation regarding documentation for
> pwm-driver authors and lack of time for in-deep reviews by Thierry.
> Never the less: The requirement to complete the currently running period
> comes from Thierry. There is a patch by me waiting for review that
> targets improving the documentation and you already have to suffer from
> my plan to spend some time on pwm-reviews :-)

Yeah, that is unpleasant if there are some requirements coming from
the maintainer and are not documented. The response times are not
really good as well. Except from you. That is why I actually welcome
the fact that you opted to spend your time on pwm reviews!

I looked at the documentation patch you submitted and at least it
clearly describes some of the questionable situations. Whether
I like them or not is irrelevant.
  
>> Anyway, as I could not find any real example I tried to solve it
>> according to your earlier suggestion. That is configure duty_cycle=0
>> and some time later disable PWM.
>>
>> It generates additional problems. The PWM block has a FIFO with four
>> slots. Before adding the sample with duty cycle=0 into the FIFO it
>> is wise to wait for a free slot in the FIFO. Then when the sample is
>> added it may actually happen that the sample is the fourth in the
>> FIFO. So it may take up to four periods until we can disable the PWM.
>> These four periods can take up to 16s. Hmmm :(
> 
> No it cannot. Because if you put a new configuration into the FIFO you
> have to block until the requested configuration is active, so it must
> not happen that you hit the FIFO with 4 busy entries. (Unless a user
> calls pwm_apply_state() in four contexts in parallel, which should not
> happen. And if it does, we should implement serialization in the
> pwm-framework such that pwm-drivers doesn't need to care.)

I was describing what the current code does/allows. There is a function
to check there is a free slot in the FIFO. It returns without blocking
if there is at least one free slot out of the four. So currently it
is possible to run this script:

	#!/bin/sh
	echo 0 > enable	
	echo 1000000000 > period # 1 second
	echo 100000000 > duty_cycle # 1. sample, 100ms
	echo 1 > enable # clears FIFO and writes 1. sample
	echo 200000000 > duty_cycle # 2. sample, 200ms
	echo 400000000 > duty_cycle # 3. sample, 400ms
	echo 800000000 > duty_cycle # 4. sample, 800ms

and the driver does not block on writing the samples 2-4 and I can see
a pulse train of all the configured samples on a scope. This definitely
does not call pwm_apply_state() in parallel contexts.

If I attempt to write another sample unless the first period passes
(when the FIFO is still full) the driver does block for msleep(period_ms)
and then the new sample is written and I see all 5 samples on the scope.
The last (fith one) is repeated as expected.

 From what you say here and what I read in your proposed change to the
documentation you require the driver to always block until the first
sample is utilized. So effectively shrinking the FIFO from 4 to 1 sample,
right?

This makes me to think: How we can define a fixed set of requirements
for (not just) PWM HW drivers and at the same time allow to utilize
the maximum capabilities of each HW?

>> I agree there are bugs in the driver and it is far from providing
>> complete support of the i.MX PWM HW. Still, I believe those are totally
>> independent problems from the pinctrl stuff and so should not block
>> the discussion/inclusion of this series.
> 
> I think while there are people who care about a driver, the known
> problems should be addressed before a change is "sneaked" in that makes
> the contributor happy and care about other stuff.

You can argue it is subjective but isn't the fact that the i.MX PWM
HW has some issues (and people are trying to solve them), a known
problem as well? I agree that there may be reasons to change priority
and first change/fix the requirements and then fix the drivers
accordingly. Unfortunately, even though I would love, I can not really
help much with that.

Best regards,
Michal

