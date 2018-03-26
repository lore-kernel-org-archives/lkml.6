Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeCZL1J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 07:27:09 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:52238 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbeCZL1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 07:27:08 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.91
Subject: Re: [PATCH 4/7] ARM: dts: sun7i: Add pinmux settings for LCD0 RGB888
 output.
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <contact@paulk.fr>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-4-git-send-email-giulio.benetti@micronovasrl.com>
 <1521986953.5301.4.camel@paulk.fr> <20180326100114.fa7vjw342ad6vrb6@flea>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <e3e51afb-bb32-7f2f-877e-b6c74d71ab06@micronovasrl.com>
Date: Mon, 26 Mar 2018 13:27:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326100114.fa7vjw342ad6vrb6@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 26/03/2018 12:01, Maxime Ripard ha scritto:
> Hi,
> 
> On Sun, Mar 25, 2018 at 04:09:13PM +0200, Paul Kocialkowski wrote:
>> Le mercredi 21 mars 2018 à 21:03 +0100, Giulio Benetti a écrit :
>>> The A20 supports RGB888 with H/V sync from LCD0. Add a pinmux setting
>>> for the needed pins.
>>>
>>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>> ---
>>>   arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi
>>> b/arch/arm/boot/dts/sun7i-a20.dtsi
>>> index efb5607..bfe6728 100644
>>> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
>>> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
>>> @@ -922,6 +922,14 @@
>>>   				pins = "PI20", "PI21";
>>>   				function = "uart7";
>>>   			};
>>> +
>>> +			lcd0_rgb888_pins: lcd0-rgb888-pins {
>>
>> It would be more consistent with other pins definitions to have
>> underscores in both names and to indicate the index, such as:
>> lcd0_rgb888_pins: lcd0_rgb888_pins@0 {
> 
> Both your suggestions will generate DTC warnings, and we'd like to get
> rid of them eventually :)
> 
>> This way, other set of pins for LCD (PH0-PH27) can be declared as @1
>> when they are needed in the future.
> 
> A better idea would be to call it lcd0-rgb888-pd-pins, and introduce
> the ph variant when it's done.

As I know, only PD is muxed with LCD0.
And PH is for LCD1 only.

And LCD0 seems to come out only from PD port according to datasheet,
this is why I didn't put @0 after lcd0-rgb888-pins.

So I don't think it makes sense to handle pins in the way Paul suggests.

What do you all think?

Giulio

> 
> Maxime
> 
> 
> 


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
