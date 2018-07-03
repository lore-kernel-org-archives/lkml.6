Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651D3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106EA24EB7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RnO6qjTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106EA24EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933065AbeGCG0M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:26:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33560 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932767AbeGCG0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:26:09 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w636Q3uu001556;
        Tue, 3 Jul 2018 01:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530599163;
        bh=h2QgRJf0iFe7H0xTkGIbdWH/og6la7E4lO9drq6l9Ws=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=RnO6qjTGh5UOWEDIdoi0jcS+fNSLgmNg+v4ZMQGpsgCYaKEqpb9e3SU4eiST6Z6YE
         HkzWY1z0yagvOJ+wWU92htN7HocjAoauHqz9hN254Q3pWtmz6kJ3YqdPMSvRztl6mE
         wg2kReBwPTYWn+sODvG/IFkNtkpgAg/das3lth9M=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w636Q2jT032314;
        Tue, 3 Jul 2018 01:26:02 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 3 Jul
 2018 01:26:02 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 3 Jul 2018 01:26:02 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w636PwrH019191;
        Tue, 3 Jul 2018 01:25:59 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] ARM: dts: am33xx: Add pinmux data for mmc1 in am335x-evm,
 evmsk and beaglebone
To:     Tony Lindgren <tony@atomide.com>,
        Robert Nelson <robertcnelson@gmail.com>
CC:     linux kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>
References: <1523447304-21037-1-git-send-email-faiz_abbas@ti.com>
 <CAOCHtYjrgRTAz4ZfkQVWL0YzC8SGbC9p1b8VYJ1TWLy5JXs3mQ@mail.gmail.com>
 <20180702105037.GQ112168@atomide.com>
Message-ID: <29062557-037e-04c8-8ae9-757ef66e20f6@ti.com>
Date:   Tue, 3 Jul 2018 11:57:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180702105037.GQ112168@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 02 July 2018 04:20 PM, Tony Lindgren wrote:
> * Robert Nelson <robertcnelson@gmail.com> [180618 14:00]:
>> On Wed, Apr 11, 2018 at 6:48 AM, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>> am335x-evm, am335x-evmsk and am335x-beaglebone are currently relying on
>>> pinmux set by the bootloader to set the correct value for mmc1. Fix
>>> this by adding pinmux data for the same in kernel.
>>>
>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>> ---
>>>  arch/arm/boot/dts/am335x-bone-common.dtsi | 9 ++++++++-
>>>  arch/arm/boot/dts/am335x-evm.dts          | 9 ++++++++-
>>>  arch/arm/boot/dts/am335x-evmsk.dts        | 9 ++++++++-
>>>  3 files changed, 24 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
>>> index e67b4d6..f9e8667 100644
>>> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
>>> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
>>> @@ -161,7 +161,14 @@
>>>
>>>         mmc1_pins: pinmux_mmc1_pins {
>>>                 pinctrl-single,pins = <
>>> -                       AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* GPIO0_6 */
>>> +                       AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)              /* spio0_cs1.gpio0_6 */
>>> +                       AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat0.mmc0_dat0 */
>>> +                       AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat1.mmc0_dat1 */
>>> +                       AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat2.mmc0_dat2 */
>>> +                       AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat3.mmc0_dat3 */
>>> +                       AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_cmd.mmc0_cmd */
>>> +                       AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_clk.mmc0_clk */
>>> +                       AM33XX_IOPAD(0x9a0, PIN_INPUT | MUX_MODE4)              /* mcasp0_aclkr.mmc0_sdwp */
>>
>> We went one pin too far on the Beagle's here:
>>
>> 0x9a0 ( mcasp0_aclkr.mmc0_sdwp ) = Routed to P9_42, (muxed with C18,
>> to a shared pin on the header), so not connected to the microSD
>> socket...
>>
>> https://github.com/beagleboard/beaglebone-black/blob/master/BBB_SCH.pdf
>>
>> Looking at this evm schematic, it looks like 0x9a0 should be removed
>> too, but I'm not sure on all revisions:
>>
>> http://processors.wiki.ti.com/images/a/a2/TMDSSK3358_3H0009_REV1_2B_SCH.pdf
> 
> Hmm care to post a fix for this?
> 

Apologies for not replying here earlier.

You're right. The sdwp pin needs to be removed from bone and evm sk. It
needs to stay only for gp evm. Looks like this needs to be fixed for
bone in U-boot also.

Thanks,
Faiz
