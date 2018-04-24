Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeDXSbt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:31:49 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:43314 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeDXSbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:31:47 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH 7/7] ARM: dts: sun7i: Add dts file for the A20-linova1-7
 HMI
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-7-git-send-email-giulio.benetti@micronovasrl.com>
 <20180322180508.my64gobhh5rc2x2m@flea>
 <8ef3b259-03b4-6987-286e-36ff627a8b76@micronovasrl.com>
 <20180424084137.7xfwji2gcibxavvt@flea>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <03a02abb-e95c-b4ec-748f-907c0af67969@micronovasrl.com>
Date: Tue, 24 Apr 2018 20:31:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424084137.7xfwji2gcibxavvt@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime and all,
I resend the e-mail since it was refused by some address(my phone 
composed it in HTML). Sorry.

Il 24/04/2018 10:41, Maxime Ripard ha scritto:
> Hi,
> 
> On Mon, Apr 23, 2018 at 04:37:33PM +0200, Giulio Benetti wrote:
>> Il 22/03/2018 19:05, Maxime Ripard ha scritto:
>>> On Wed, Mar 21, 2018 at 09:03:13PM +0100, Giulio Benetti wrote:
>>>> The A20-Linova1-7 HMI, also called Q027_2_F which is printed on production
>>>> label, is an industrial Human Machine Interface.
>>>> It features:
>>>> - 512MB DDR RAM
>>>> - 1 Sd-card >= 4GB
>>>> - 1 Usb otg(programmable via software) with A-Usb Connector
>>>> - 1 Usb host
>>>> - 1 Buzzer
>>>> - 1 Input for LiPo
>>>> - 1 Relay to signal absence of power supply
>>>> - 1 External Rtc with 56 bytes of ram + CR2032 battery
>>>> - 1 7" 24-bits Tft 800x480 with PCap on
>>>> - 1 Mono audio 1-watt amplifier
>>>> - 1 RS485 port
>>>> - 1 Power On Line through +12Vdc reaching 57.600baud,
>>>>     from where it can be supplied and placed in a network of 50 units
>>>> - exposed jtag pins
>>>>
>>>> HMI is supplied from +12Vdc.
>>>> Ethernet is absent, so for debugging, need to enable rndis on Usb otg
>>>> port through an A-A usb cable.
>>>> It comes in different flavours for connector types and can be found with
>>>> umounted features as requested by customers.
>>>
>>> So this is essentially the same board than in patch 6, but with a
>>> different screen?
>>>
>>> You should have a single DT then, and handle the two different panels
>>> using DT overlays.
>>
>> Ok for having different DT overlays.
>> But do I have to submit them as patches? Or keep them in my company's repo?
>> I ask you this because this involves sending also patches for displays
>> and other little modifications to mainline ex:
>> - rgb888 pins
>> - 2 simple-panels
>> - 1 uart iomux pins
>> etc.
>>
>> If I don't submit those overlays, the other patches wouldn't make sense
>> alone as I've seen, just like rgb888 pins.
> 
> We don't have a repo for overlays yet

Ok I can provide them on my company Repo.

But, sorry if insist(please don't kill me! :) ), I would try to explain 
better how it's made LiNova, because I think I didn't provide enough 
information about it:
LiNova1 is not a board with various headers to connect other peripherals 
such display, pcap etc.
It's an HMI that I would consider the same as a Tablet, because it has a 
plastic enclosure also.

So I would like to understand how to manage it in the best way.
Try to consider LiNova1 as a Tablet series, with following list:
LiNova1 4.3" ctp
LiNova1 7" ctp
LiNova1 10.1" ctp
LiNova1 4.3" rtp
LiNova1 7" rtp
LiNova1 10.1" rtp

Every of those has a slightly different BOM, so they are 6 different 
boards with a common base(uP, ram). And same pcb.

So I don't know if submit only the common base and provide separately on 
our github DT-overlays, or provide as many dts patches as the HMI number 
with a base dtsi.

Basically Micronova provides entire system without the capability to 
hack hardware adding shields of various type.

There are also other 2 LiNova:
LiNova2 and LiNova3

So I understand that this could lead to 18 different dts files and 3 
dtsi files.

But with Tablet it should be the same way.
For sure people would be more interested on famous tablets instead of 
our HMI.

In the case I need to use dt-overlays, you mean .dto files with 
fragments inside loaded by u-boot or runtime, right?

Sorry if I bother you again but I wanted to understand better.

> 
>>>> +&usb_otg {
>>>> +	dr_mode = "otg";
>>>
>>> You're saying that this is a USB-A connector? Then it's not OTG since
>>> it doesn't have an ID pin, this is an host.
>>
>> Right, with a special overlay I will activate Usb Device for RNDIS,
>> so modified as host
> 
> That doesn't really make much sense. The USB OTG is wired only using a
> daughter board?

My fault, I've meant "peripheral" in one case and "host" in another case.
Usually "host".
Are there problem with this?
There is no daughter board.

Thank you very very much in advance for you patience :)

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

> 
> 
>> One last question:
>> now I have some patch already reviewed-by.
>> Do I have to re-submit entire patchset?
> 
> Yes
> 
> Maxime
> 
