Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeDSNPV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:15:21 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:58918 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752854AbeDSNPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:15:19 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.899
Subject: Re: [PATCH 4/6] drm/panel: simple: Add support for Banana Pi 7"
 S070WV20-CT16 panel
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Liu <net147@gmail.com>
References: <20180419093225.614-1-wens@csie.org>
 <20180419093225.614-5-wens@csie.org>
 <58ce9e3b-00ee-87d2-f05b-b9f1414d1cfa@micronovasrl.com>
 <CAGb2v65tH_8_J27Xmx4TeEYhpHLJf4m0AzXJoGXZYMfJH=51xQ@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <3341fcae-2146-b3b4-be41-b7e5167c2147@micronovasrl.com>
Date: Thu, 19 Apr 2018 15:15:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v65tH_8_J27Xmx4TeEYhpHLJf4m0AzXJoGXZYMfJH=51xQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 19/04/2018 14:45, Chen-Yu Tsai ha scritto:
> On Thu, Apr 19, 2018 at 8:31 PM, Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
>> Hi,
>>
>> Il 19/04/2018 11:32, Chen-Yu Tsai ha scritto:
>>>
>>> This panel is marketed as Banana Pi 7" LCD display. On the back is
>>> a sticker denoting the model name S070WV20-CT16.
>>
>>
>> Judging from the code, the real vendor should be CDTech.
>> Take a look at their website:
>> http://www.cdtech-lcd.com/en/standardscreen.html
>>
>> I point you my patch for inserting another similar panel:
>> https://patchwork.freedesktop.org/patch/211914/
>>
>> Maybe it would make sense to use CDTech as the vendor,
>> because maybe Bananapi resells only it.
>> Or maybe it is a custom panel done for them,
>> but the same is for other panels I've submitted patches.
>> Micronova srl custom, but vendor is CDTech.
>>
>> What do you think?
> 
> That might be true. But for people without access to the vendors,
> this is horribly hard to figure out. People are only going to look
> at whatever marking there is on the LCD panel, and whatever the
> seller says. This panel has the model number stickered on, but the
> PCB attached to it only has the Banana Pi logo.

Ah ok, my fault, I didn't see it has a PCB attached with Banana Pi logo.
Also it makes a lot of sense what you say about people looking for display.

> 
> And given it's a custom piece, probably OEM or ODM, the real
> manufacturer matters less. You don't mention "Foxconn" as the
> vendor of the iPhone, do you?

:) that's right.

Best regards

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
> ChenYu
> 
>>
>> --
>> Giulio Benetti
>> CTO
>>
>> MICRONOVA SRL
>> Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
>> Tel. 049/8931563 - Fax 049/8931346
>> Cod.Fiscale - P.IVA 02663420285
>> Capitale Sociale € 26.000 i.v.
>> Iscritta al Reg. Imprese di Padova N. 02663420285
>> Numero R.E.A. 258642
>>
>>
>>>
>>> This is a 7" 800x480 panel connected through a 24-bit RGB interface.
>>> However the panel only does 262k colors.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>    .../display/panel/bananapi,s070wv20-ct16.txt  |  7 ++++++
>>>    drivers/gpu/drm/panel/panel-simple.c          | 25 +++++++++++++++++++
>>>    2 files changed, 32 insertions(+)
>>>    create mode 100644
>>> Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>> b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>> new file mode 100644
>>> index 000000000000..2ec35ce36e9a
>>> --- /dev/null
>>> +++
>>> b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>> @@ -0,0 +1,7 @@
>>> +Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
>>> +
>>> +Required properties:
>>> +- compatible: should be "bananapi,s070wv20-ct16"
>>> +
>>> +This binding is compatible with the simple-panel binding, which is
>>> specified
>>> +in simple-panel.txt in this directory.
>>> diff --git a/drivers/gpu/drm/panel/panel-simple.c
>>> b/drivers/gpu/drm/panel/panel-simple.c
>>> index cbf1ab404ee7..9bc037f74d6c 100644
>>> --- a/drivers/gpu/drm/panel/panel-simple.c
>>> +++ b/drivers/gpu/drm/panel/panel-simple.c
>>> @@ -745,6 +745,28 @@ static const struct panel_desc avic_tm070ddh03 = {
>>>          },
>>>    };
>>>    +static const struct drm_display_mode bananapi_s070wv20_ct16_mode = {
>>> +       .clock = 30000,
>>> +       .hdisplay = 800,
>>> +       .hsync_start = 800 + 40,
>>> +       .hsync_end = 800 + 40 + 48,
>>> +       .htotal = 800 + 40 + 48 + 40,
>>> +       .vdisplay = 480,
>>> +       .vsync_start = 480 + 13,
>>> +       .vsync_end = 480 + 13 + 3,
>>> +       .vtotal = 480 + 13 + 3 + 29,
>>> +};
>>> +
>>> +static const struct panel_desc bananapi_s070wv20_ct16 = {
>>> +       .modes = &bananapi_s070wv20_ct16_mode,
>>> +       .num_modes = 1,
>>> +       .bpc = 6,
>>> +       .size = {
>>> +               .width = 154,
>>> +               .height = 86,
>>> +       },
>>> +};
>>> +
>>>    static const struct drm_display_mode boe_nv101wxmn51_modes[] = {
>>>          {
>>>                  .clock = 71900,
>>> @@ -2112,6 +2134,9 @@ static const struct of_device_id platform_of_match[]
>>> = {
>>>          }, {
>>>                  .compatible = "avic,tm070ddh03",
>>>                  .data = &avic_tm070ddh03,
>>> +       }, {
>>> +               .compatible = "bananapi,s070wv20-ct16",
>>> +               .data = &bananapi_s070wv20_ct16,
>>>          }, {
>>>                  .compatible = "boe,nv101wxmn51",
>>>                  .data = &boe_nv101wxmn51,
>>>
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
