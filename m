Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7835C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5355720684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5355720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJCTiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:38:19 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:4416 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbeJCTiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:38:19 -0400
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="20630677"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Oct 2018 05:50:02 -0700
Received: from [10.159.205.91] (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Wed, 3 Oct 2018
 05:50:01 -0700
Subject: Re: [RESEND PATCH v5 0/9] extend PWM framework to support PWM modes
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <thierry.reding@gmail.com>, <alexandre.belloni@bootlin.com>,
        <linux-pwm@vger.kernel.org>, <treding@nvidia.com>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <shc_work@mail.ru>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <b95d0de2-1a97-36f0-03ad-3b5e52b1fa5d@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <a72a2774-27b5-9fc5-97c5-d13a8067c990@microchip.com>
Date:   Wed, 3 Oct 2018 14:49:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b95d0de2-1a97-36f0-03ad-3b5e52b1fa5d@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2018 at 18:20, Nicolas Ferre wrote:
> Thierry,
> 
> On 28/08/2018 at 15:01, Claudiu Beznea wrote:
>> Hi,
>>
>> Please give feedback on these patches which extends the PWM framework in
>> order to support multiple PWM modes of operations. This series is a rework
>> of [1] and [2].
> 
> This series started with a RFC back on 5 April 2017 "extend PWM
> framework to support PWM modes". The continuous work starting with v2 of
> this series on January 12, 2018.
> 
> Then Claudiu tried to address all comments up to v4 which didn't have
> any more reviews. He posted a v5 without comments since May 22, 2018.
> This series is basically a resent of the v5 (as said in the $subject).
> 
> We would like to know what is preventing this series to be included in
> the PWM sub-system. Note that if some issue still remain with it, we are
> ready to help to solve them.
> 
> Without feedback from you side, we fear that we would miss a merge
> window again for no obvious reason (DT part is Acked by Rob: patch 5/9).

3 weeks no news about my previous ping...

ping again!

> Best regards,
>     Nicolas
> 
> 
>> The current patch series add the following PWM modes:
>> - PWM mode normal
>> - PWM mode complementary
>> - PWM mode push-pull
>>
>> Normal mode - for PWM channels with one output; output waveforms looks like
>> this:
>>                __    __    __    __
>>       PWM   __|  |__|  |__|  |__|  |__
>>               <--T-->
>>
>>       Where T is the signal period
>>
>> Since PWMs with more than one output per channel could be used as one
>> output PWM the normal mode is the default mode for all PWMs (if not
>> specified otherwise).
>>
>> Complementary mode - for PWM channels with two outputs; output waveforms
>> for a PWM channel in complementary mode looks line this:
>>                __    __    __    __
>>       PWMH1 __|  |__|  |__|  |__|  |__
>>             __    __    __    __    __
>>       PWML1   |__|  |__|  |__|  |__|
>>               <--T-->
>>
>>       Where T is the signal period.
>>
>> Push-pull mode - for PWM channels with two outputs; output waveforms for a
>> PWM channel in push-pull mode with normal polarity looks like this:
>>               __          __
>>       PWMH __|  |________|  |________
>>                     __          __
>>       PWML ________|  |________|  |__
>>              <--T-->
>>
>>       If polarity is inversed:
>>            __    ________    ________
>>       PWMH   |__|        |__|
>>            ________    ________    __
>>       PWML         |__|        |__|
>>              <--T-->
>>
>>       Where T is the signal period.
>>
>> The PWM working modes are per PWM channel registered as PWM's capabilities.
>> The driver registers itself to PWM core a get_caps() function, in
>> struct pwm_ops, that will be used by PWM core to retrieve PWM capabilities.
>> If this function is not registered in driver's probe, a default function
>> will be used to retrieve PWM capabilities. Currently, the default
>> capabilities includes only PWM normal mode.
>>
>> PWM state has been updated to keep PWM mode. PWM mode could be configured
>> via sysfs or via DT. pwm_apply_state() will do the preliminary validation
>> for PWM mode to be applied.
>>
>> In sysfs, user could get PWM modes by reading mode file of PWM device:
>> root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# ls -l
>> total 0
>> -r--r--r-- 1 root root 4096 Oct  9 09:07 capture
>> lrwxrwxrwx 1 root root    0 Oct  9 09:07 device -> ../../pwmchip0
>> -rw-r--r-- 1 root root 4096 Oct  9 08:42 duty_cycle
>> -rw-r--r-- 1 root root 4096 Oct  9 08:44 enable
>> --w------- 1 root root 4096 Oct  9 09:07 export
>> -rw-r--r-- 1 root root 4096 Oct  9 08:43 mode
>> -r--r--r-- 1 root root 4096 Oct  9 09:07 npwm
>> -rw-r--r-- 1 root root 4096 Oct  9 08:42 period
>> -rw-r--r-- 1 root root 4096 Oct  9 08:44 polarity
>> drwxr-xr-x 2 root root    0 Oct  9 09:07 power
>> lrwxrwxrwx 1 root root    0 Oct  9 09:07 subsystem -> ../../../../../../../../class/pwm
>> -rw-r--r-- 1 root root 4096 Oct  9 08:42 uevent
>> --w------- 1 root root 4096 Oct  9 09:07 unexport
>> root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# cat mode
>> normal complementary [push-pull]
>>
>> The mode enclosed in bracket is the currently active mode.
>>
>> The mode could be set, via sysfs, by writing to mode file one of the modes
>> displayed at read:
>> root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# echo normal > mode
>> root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# cat mode
>> [normal] complementary push-pull
>>
>> The PWM push-pull mode could be usefull in applications like half bridge
>> converters.
>>
>> This series also add PWM modes support for Atmel/Microchip SoCs.
>>
>> Thank you,
>> Claudiu Beznea
>>
>> [1] https://www.spinics.net/lists/arm-kernel/msg580275.html
>> [2] https://lkml.org/lkml/2018/1/12/359
>>
>> Changes in v5:
>> - solved kbuild errors by removing dummy functions for case where
>>     CONFIG_PWM is not defined; adopted this approach since the removed
>>     function are used only when CONFIG_PWM is defined (in PWM core
>>     and few drivers from drivers/pwm/ directory)
>>
>> Changes in v4:
>> - removed changes related to pwm_config() as per maintainer proposals
>> - added pwm_mode_get_valid() to retrieve a valid PWM mode fror PWM device
>>     instead of using BIT(ffs(caps.mode) - 1) and changed drivers to use
>>     pwm_mode_get_valid() instead of pwm_get_caps() + BIT(ffs(caps.mode) - 1)
>>     (patches 2, 3, 4 from this series)
>> - renamed PWM_MODE() macro in PWMC_MODE() to avoid conflicts with
>>     pwm-sun4i.c driver ('C' stands for capability)
>> - removed pwm_caps_valid() function
>> - renamed PWM_DTMODE_COMPLEMENTARY and PWM_DTMODE_PUSH_PULL macros in
>>     PWM_MODE_COMPLEMENTARY and PWM_MODE_PUSH_PULL
>>
>> Changes in v3:
>> - removed changes related to only one of_xlate function for all PWM drivers
>> - switch to PWM capabilities per PWM channel nor per PWM chip
>> - squash documentation and bindings patches as requeted by reviewer
>> - introduced PWM_MODE(name) macro and used a bit enum for pwm modes
>> - related to DT bindings, used flags cell also for PWM modes
>> - updated of_xlate specific functions with "state->mode = mode;"
>>     instructions to avoid pwm_apply_state() failures
>> - use available modes for PWM channel in pwm_config() by first calling
>>     pwm_get_caps() to get caps.modes
>> - use loops through available modes in mode_store()/mode_show() and also in
>>     of_pwm_xlate_with_flags() instead of "if else" instructions; in this way,
>>     the addition of a new mode is independent of this code sections
>> - use DTLI=1, DTHI=0 register settings to obtain push-pull mode waveforms
>>     for Atmel/Microchip PWM controller.
>>
>> Changes in v2:
>> - remove of_xlate and of_pwm_n_cells and use generic functions to pharse DT
>>     inputs; this is done in patches 1, 2, 3, 4, 5, 6, 7 of this series; this will
>>     make easy the addition of PWM mode support from DT
>> - add PWM mode normal
>> - register PWM modes as capabilities of PWM chips at driver probe and, in case
>>     driver doesn't provide these capabilities use default ones
>> - change the way PWM mode is pharsed via DT by using a new input for pwms
>>     binding property
>>
>>
>> Claudiu Beznea (9):
>>     pwm: extend PWM framework with PWM modes
>>     pwm: clps711x: populate PWM mode in of_xlate function
>>     pwm: cros-ec: populate PWM mode in of_xlate function
>>     pwm: pxa: populate PWM mode in of_xlate function
>>     pwm: add PWM modes
>>     pwm: atmel: add pwm capabilities
>>     pwm: add push-pull mode support
>>     pwm: add documentation for pwm push-pull mode
>>     pwm: atmel: add push-pull mode support
>>
>>    Documentation/devicetree/bindings/pwm/pwm.txt |  11 ++-
>>    Documentation/pwm.txt                         |  42 ++++++++-
>>    drivers/pwm/core.c                            | 125 +++++++++++++++++++++++++-
>>    drivers/pwm/pwm-atmel.c                       | 118 +++++++++++++++++-------
>>    drivers/pwm/pwm-clps711x.c                    |  10 ++-
>>    drivers/pwm/pwm-cros-ec.c                     |   1 +
>>    drivers/pwm/pwm-pxa.c                         |   1 +
>>    drivers/pwm/sysfs.c                           |  61 +++++++++++++
>>    include/dt-bindings/pwm/pwm.h                 |   2 +
>>    include/linux/pwm.h                           |  64 +++++++++++++
>>    10 files changed, 395 insertions(+), 40 deletions(-)
>>
> 
> 


-- 
Nicolas Ferre
