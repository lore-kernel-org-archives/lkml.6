Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ADFC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 03:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C062081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 03:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C062081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeLIDIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 22:08:25 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:40860 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeLIDIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 22:08:25 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from sneezy.aussec.com (sneezy.aussec.com [172.16.0.4])
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTP id wB9384dX012814;
        Sun, 9 Dec 2018 14:08:09 +1100
Received: from 1.128.104.17 ([1.128.104.17]) by www.aussec.com (Horde
 Framework) with HTTP; Sun, 09 Dec 2018 14:07:59 +1100
Message-ID: <20181209140759.18342zz66oeo3767@www.aussec.com>
Date:   Sun, 09 Dec 2018 14:07:59 +1100
From:   tom burkart <tom@aussec.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, lukas@fridolin.com
Subject: Re: [PATCH v9 3/4] dt-bindings: pps: pps-gpio PPS ECHO
 implementation
References: <20181122094602.5156-1-tom@aussec.com>
 <20181122094602.5156-2-tom@aussec.com>
 <20181122094602.5156-3-tom@aussec.com>
 <20181122094602.5156-4-tom@aussec.com>
 <CAL_JsqJ6fM3+pcC3b-eXEex=j_ft6Z=vukhLK9wULfWJqOTN-A@mail.gmail.com>
 <20181127150629.10795h1esqtc53ut@aussec.com>
 <CAL_JsqJmuDbPgc3WYRU8y3hbDL5A4_Luj0FfAiSvJ2+J-TM9_g@mail.gmail.com>
In-Reply-To:  <CAL_JsqJmuDbPgc3WYRU8y3hbDL5A4_Luj0FfAiSvJ2+J-TM9_g@mail.gmail.com>
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

> On Mon, Nov 26, 2018 at 10:06 PM tom burkart <tom@aussec.com> wrote:
>>
>> Hi Rob,
>>
>> Quoting Rob Herring <robh@kernel.org>:
>>
>> > On Thu, Nov 22, 2018 at 3:49 AM Tom Burkart <tom@aussec.com> wrote:
>> >>
>> >> This patch implements the device tree changes required for the pps
>> >> echo functionality for pps-gpio, that sysfs claims is available
>> >> already.
>> >>
>> >> This patch was originally written by Lukas Senger as part of a masters
>> >> thesis project and modified for inclusion into the linux kernel by Tom
>> >> Burkart.
>> >>
>> >> Signed-off-by: Lukas Senger <lukas@fridolin.com>
>> >> Signed-off-by: Tom Burkart <tom@aussec.com>
>> >> ---
>> >>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 9 +++++++++
>> >>  1 file changed, 9 insertions(+)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> >> b/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> >> index 1155d49c2699..e09f6f2405c5 100644
>> >> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> >> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
>> >> @@ -7,10 +7,15 @@ Required properties:
>> >>  - compatible: should be "pps-gpio"
>> >>  - gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
>> >>
>> >> +Additional required properties for the PPS ECHO functionality:
>> >> +- echo-gpios: one PPS ECHO GPIO in the format described by  
>> ../gpio/gpio.txt
>> >> +- echo-active-ms: duration in ms of the active portion of the echo pulse
>> >> +
>> >>  Optional properties:
>> >>  - assert-falling-edge: when present, assert is indicated by a  
>> falling edge
>> >>                         (instead of by a rising edge)
>> >>  - capture-clear: when present, also capture the PPS clear event
>> >> +- invert-pps-echo: when present, invert the PPS ECHO pulse
>> >
>> > Why do you need this? Can't you just make the echo gpio GPIO_ACTIVE_LOW?
>> >
>> > BTW, using the flag probably should have been done for
>> > 'assert-falling-edge' as well.
>>
>> The hardware I use expects a positive-going echo pulse, however, it
>> was really easy to give users the option to have it inverted in case
>> they use different hardware that expects a negative-going edge.
>
> It will be even easier to implement if you use GPIO_ACTIVE_LOW or
> GPIO_ACTIVE_HIGH as appropriate. If the flag is set appropriately,
> then gpiod_set_value(gpio, 1) asserts the pulse and
> gpiod_set_value(gpio, 0) deasserts it no matter which way the h/w is
> wired. You can then get rid of invert_pps_echo in the driver.

Hi Rob,
sure we can do that, however, a hardware change will need a recompile  
of the kernel, rather than setting a flag.
You still need something to help decide whether to use GPIO_ACTIVE_LOW  
or GPIO_ACTIVE_HIGH depending on what hardware is currently connected  
to the system.

I am happy to delete that code as well, if it makes you happy.

Tom

