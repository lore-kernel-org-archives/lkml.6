Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54DAC04EBF
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 00:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8455420817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 00:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8455420817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeKRKxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 05:53:51 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:39036 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeKRKxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 05:53:50 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from sneezy.aussec.com (sneezy.aussec.com [172.16.0.4])
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTP id wAI0Z7rp022573;
        Sun, 18 Nov 2018 11:35:12 +1100
Received: from c110-21-61-29.farfl4.nsw.optusnet.com.au
 (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29]) by www.aussec.com
 (Horde Framework) with HTTP; Sun, 18 Nov 2018 11:35:02 +1100
Message-ID: <20181118113502.55634v85ybgkt586@www.aussec.com>
Date:   Sun, 18 Nov 2018 11:35:02 +1100
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
In-Reply-To:  <CAL_JsqKZHg5_8ghMmU4qO4CVZibcHOvtVJH669zod_6GLGakRg@mail.gmail.com>
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

> On Sat, Nov 17, 2018 at 4:35 AM tom burkart <tom@aussec.com> wrote:
>>
>> Quoting Rob Herring <robh@kernel.org>:
>>
>> > On Wed, Nov 14, 2018 at 11:54:29PM +1100, Tom Burkart wrote:
>> >> This patch changes the devicetree bindings for the pps-gpio driver
>> >> from the integer based ABI to the descriptor based ABI.
>> > ? That has nothing to do with DT.
>>
>> I believe it does, as the change in ABI forces a rename in the DT
>> naming convention.
>> This is due to the descriptor based ABI appending "-gpio" or "-gpios" (see
>> Documentation/gpio/base.txt.)
>> Admittedly, I may have called it by the wrong name due to ignorance,
>> my apologies.
>
> If what you say is correct, then you can't change this driver. You'll
> break compatibility with any existing DT.
>
> Changing the binding reasoning should purely be that this is the
> preferred form. Bindings must be independent from changing kernel
> APIs.

See comments from Philip Zabel.  I misread the documentation and this  
has now been corrected in v8 of the patch.  I hope that eliminates all  
comments made above.

>> >>  It also adds
>> >> documentation for the device tree capture-clear option.  The legacy
>> >> device tree entry for the GPIO pin is supported.
>> >>
>> >> Signed-off-by: Tom Burkart <tom@aussec.com>
>> >> ---
>> >>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 8 ++++++--
>> >>  1 file changed, 6 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> >> b/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> >> index 3683874832ae..6c9fc0998d94 100644
>> >> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> >> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> >> @@ -5,19 +5,23 @@ a GPIO pin.
>> >>
>> >>  Required properties:
>> >>  - compatible: should be "pps-gpio"
>> >> -- gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
>> >> +- pps-gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
>> >> +Alternatively (DEPRECATED), instead of pps-gpios above, it may have:
>> >> +- gpios: one PPS GPIO as above
>> >>
>> >>  Optional properties:
>> >>  - assert-falling-edge: when present, assert is indicated by a  
>> falling edge
>> >>                         (instead of by a rising edge)
>> >> +- capture-clear: when present, also capture the PPS clear event
>> >
>> > Is this a h/w thing? or driver configuration?
>>
>> Driver configuration.  Most of the code was present in the driver, yet
>> it was not documented, or usable due to a two line (code) omission
>> (the value was not being fetched from DT).
>
> So what determines how you want to configure this? If the user will
> want to change it, then it should be a sysfs attr and exposed to
> userspace. If it depends on h/w config for a board then it can be in
> DT.

Sorry, I misled you somewhat.  If the PPS pulse active transition from  
the hardware is on the falling edge, this flag is required to get the  
OS to use that as the active transition.  This would not change at the  
user's whim but rather it is dependent on connected hardware.

Tom

