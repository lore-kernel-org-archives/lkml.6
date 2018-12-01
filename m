Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CD5C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 22:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEE5205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 22:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEE5205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbeLBJiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 04:38:23 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:59016 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeLBJiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 04:38:22 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from sneezy.aussec.com (sneezy.aussec.com [172.16.0.4])
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTP id wB1MOZgj011553;
        Sun, 2 Dec 2018 09:24:40 +1100
Received: from c110-21-61-29.farfl4.nsw.optusnet.com.au
 (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29]) by www.aussec.com
 (Horde Framework) with HTTP; Sun, 02 Dec 2018 09:24:30 +1100
Message-ID: <20181202092430.13212jdulbjds6qm@www.aussec.com>
Date:   Sun, 02 Dec 2018 09:24:30 +1100
From:   tom burkart <tom@aussec.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/4] dt-bindings: pps: descriptor-based gpio,
 capture-clear addition
References: <20181114125432.16044-1-tom@aussec.com>
 <20181114125432.16044-2-tom@aussec.com> <20181116224919.GA18008@bogus>
 <20181117213522.12672utznrvpbn56@www.aussec.com>
 <CAL_JsqKZHg5_8ghMmU4qO4CVZibcHOvtVJH669zod_6GLGakRg@mail.gmail.com>
 <20181118113502.55634v85ybgkt586@www.aussec.com>
 <CAL_Jsq+_Fb8mRDf_g=qDVsw-KPnrdZunLksYrgBFvhehzVNX+g@mail.gmail.com>
 <20181127145729.128452ujmj4uhb55@aussec.com>
 <CAL_Jsq+-S2tF++VstMCeUrX4SXcB4B99Tc-SFUQ3R66KPHVf+Q@mail.gmail.com>
 <20181129130520.198263bp7uxu51ls@aussec.com>
 <CAL_JsqLSz+iS0Ghy26+cvOd2xHdgc8z6VY88J2hm5gHFHR9vwg@mail.gmail.com>
In-Reply-To:  <CAL_JsqLSz+iS0Ghy26+cvOd2xHdgc8z6VY88J2hm5gHFHR9vwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.3.9)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring <robh@kernel.org>:

> On Wed, Nov 28, 2018 at 8:05 PM tom burkart <tom@aussec.com> wrote:
>>
>> Quoting Rob Herring <robh@kernel.org>:
>>
>> > On Mon, Nov 26, 2018 at 9:57 PM tom burkart <tom@aussec.com> wrote:
>> >>
>> >> Quoting Rob Herring <robh@kernel.org>:
>> >>
>> >> > On Sat, Nov 17, 2018 at 6:35 PM tom burkart <tom@aussec.com> wrote:
>> >> >>
>> >> >> Quoting Rob Herring <robh@kernel.org>:
>> >> >>
>> >> >> > On Sat, Nov 17, 2018 at 4:35 AM tom burkart <tom@aussec.com> wrote:
>> >> >> >>
>> >> >> >> Quoting Rob Herring <robh@kernel.org>:
>> >> >> >>
>> >> >> >> > On Wed, Nov 14, 2018 at 11:54:29PM +1100, Tom Burkart wrote:
>> >> >> >> >> This patch changes the devicetree bindings for the  
>> pps-gpio driver
>> >> >> >> >> from the integer based ABI to the descriptor based ABI.
>> >> >> >> > ? That has nothing to do with DT.
>> >> >> >>
>> >> >> >> I believe it does, as the change in ABI forces a rename in the DT
>> >> >> >> naming convention.
>> >> >> >> This is due to the descriptor based ABI appending "-gpio" or
>> >> >> "-gpios" (see
>> >> >> >> Documentation/gpio/base.txt.)
>> >> >> >> Admittedly, I may have called it by the wrong name due to  
>> ignorance,
>> >> >> >> my apologies.
>> >> >> >
>> >> >> > If what you say is correct, then you can't change this  
>> driver. You'll
>> >> >> > break compatibility with any existing DT.
>> >> >> >
>> >> >> > Changing the binding reasoning should purely be that this is the
>> >> >> > preferred form. Bindings must be independent from changing kernel
>> >> >> > APIs.
>> >> >>
>> >> >> See comments from Philip Zabel.  I misread the documentation and this
>> >> >> has now been corrected in v8 of the patch.  I hope that eliminates all
>> >> >> comments made above.
>> >> >>
>> >> >> >> >>  It also adds
>> >> >> >> >> documentation for the device tree capture-clear option.  
>>  The legacy
>> >> >> >> >> device tree entry for the GPIO pin is supported.
>> >> >> >> >>
>> >> >> >> >> Signed-off-by: Tom Burkart <tom@aussec.com>
>> >> >> >> >> ---
>> >> >> >> >>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 8 ++++++--
>> >> >> >> >>  1 file changed, 6 insertions(+), 2 deletions(-)
>> >> >> >> >>
>> >> >> >> >> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> >> >> >> >> b/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> >> >> >> >> index 3683874832ae..6c9fc0998d94 100644
>> >> >> >> >> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> >> >> >> >> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> >> >> >> >> @@ -5,19 +5,23 @@ a GPIO pin.
>> >> >> >> >>
>> >> >> >> >>  Required properties:
>> >> >> >> >>  - compatible: should be "pps-gpio"
>> >> >> >> >> -- gpios: one PPS GPIO in the format described by  
>> ../gpio/gpio.txt
>> >> >> >> >> +- pps-gpios: one PPS GPIO in the format described by
>> >> ../gpio/gpio.txt
>> >> >> >> >> +Alternatively (DEPRECATED), instead of pps-gpios above,
>> >> it may have:
>> >> >> >> >> +- gpios: one PPS GPIO as above
>> >> >> >> >>
>> >> >> >> >>  Optional properties:
>> >> >> >> >>  - assert-falling-edge: when present, assert is indicated by a
>> >> >> >> falling edge
>> >> >> >> >>                         (instead of by a rising edge)
>> >> >> >> >> +- capture-clear: when present, also capture the PPS clear event
>> >> >> >> >
>> >> >> >> > Is this a h/w thing? or driver configuration?
>> >> >> >>
>> >> >> >> Driver configuration.  Most of the code was present in the  
>> driver, yet
>> >> >> >> it was not documented, or usable due to a two line (code) omission
>> >> >> >> (the value was not being fetched from DT).
>> >> >> >
>> >> >> > So what determines how you want to configure this? If the user will
>> >> >> > want to change it, then it should be a sysfs attr and exposed to
>> >> >> > userspace. If it depends on h/w config for a board then it can be in
>> >> >> > DT.
>> >> >>
>> >> >> Sorry, I misled you somewhat.  If the PPS pulse active transition from
>> >> >> the hardware is on the falling edge, this flag is required to get the
>> >> >> OS to use that as the active transition.  This would not change at the
>> >> >> user's whim but rather it is dependent on connected hardware.
>> >> >
>> >> > This description sounds more like 'assert-falling-edge' than
>> >> 'capture-clear'.
>> >> >
>> >> > I'm still not clear on what 'capture-clear' is.
>> >>
>> >> Ignoring my patch for a minute, the pps_gpio_irq_handler will only
>> >> report a pps PPS_CAPTURECLEAR event if 'capture-clear' is set.  As the
>> >> current pps-gpio driver is not able to set this flag, it cannot ever
>> >> report a PPS_CAPTURECLEAR event.
>> >>
>> >> My patch adds the ability to set this flag and adds the documentation
>> >> to go with it.
>> >> Admittedly, I do not require this functionality for what I want, but
>> >> working with the code, I noticed the omission and decided to add it
>> >> for someone else to use it, if they need it.
>> >>
>> >> I am happy to remove this out of my patch, if you feel this to be the
>> >> best way forward.
>> >
>> > I found this prior discussion on adding this[1]. Seems to me this
>> > should be userspace configurable if the GPIO line can interrupt on
>> > both edges. We shouldn't need a DT property to determine that.
>> >
>> > Rob
>> >
>> > [1] https://lore.kernel.org/patchwork/patch/557781/
>>
>> Hi Rob,
>> the fact that prior knowledge of board/CPU/SOC specifics is required
>> is the most compelling argument for this to be in the DT.  This is not
>> something a user should need to know or remember.
>>
>> Userspace is already asking for what they need via the
>> time_pps_setparams call, but to do that they have to first call
>> time_pps_getparams.  Time_pps_getparams will not return
>> PPS_CAPTURECLEAR as it is never set in the driver due to it being
>> hardware specific/unable to be set.
>
> My understanding is it is a 2 step process. The capability is exposed
> to the user if the hardware supports it, but it is still a user
> decision whether or not to enable it. So as far as DT bindings are
> concerned, we're only concerned with the first part. Whether the
> hardware supports capture clear in the GPIO PPS case just depends on
> whether the GPIO controller can support both edge interrupts (or
> emulate that by switching between rising/falling edge interrupts). Do
> we agree on that part?

Yes and no.  While it is desirable to have a complete separation of  
the two parts as described above, we do live in a world that isn't  
perfect and we do need to compromise to maximise the benefit to all.   
See explanation below.

> Needing to know GPIO interrupt capabilities is hardly specific to PPS.
> There is not any explicit property in DT for this capability because
> it is implicit based on the GPIO controller's compatible string (or
> driver capabilities if emulated). Therefore, it is up to the GPIO
> driver and API to expose this information to client drivers like PPS.

Let me pose the following scenario:  Say, the GPIO driver/API tell the  
PPS driver that both edges are indeed supported.  This then means that  
the PPS driver will blindly configure itself for returning data for  
both the ASSERT and DEASSERT edges of the PPS pulse.  However, say,  
the user only wants the ASSERT edge (as would be the case in most  
instances).  As the kernel currently stands, there is no way for the  
PPS driver to reconfigure itself after the pps_gpio_probe function  
exits.  This then means that you will automatically be servicing two  
interrupts per PPS cycle, even though the user only wants one (for PPS  
this is probably not a big deal...)

The reason for the PPS driver to have to blindly configure itself is  
that there is always going to be a delay between the driver being  
loaded and the userspace program becoming active and actually  
requesting what it wants.  On a modern x86 system this may be in the  
order of milliseconds, but on an embedded system this would be in the  
order of seconds as some systems load all configured modules at boot,  
before userspace gets control.

In the ideal case, it would be nice for the PPS driver to load and  
only configure itself after the time_pps_setparams function has been  
called by the user.

Here is the compromise:  It is usually the hardware vendor/integrator  
who has a good idea (hopefully) as to what capabilities are going to  
be used by the system.  Hence the devicetree would be the most logical  
place to put a flag that embodies the capabilities of the GPIO  
subsystem as well as the GPS or other peripheral device creating the  
PPS pulses.  To me, that is what capture_clear is.

Anyway, v11 of my patch now excludes all changes made previously to  
the capture_clear flag.

Tom

