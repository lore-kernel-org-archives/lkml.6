Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeEKQJh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:09:37 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34664 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeEKQJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:09:35 -0400
X-Google-Smtp-Source: AB8JxZrZYJLsY/yyTQKEczN5L2qEZrQaedXbS73cUQb0ps4AswDjOZT4Cl/8/Q82mTsy95PGp16NkejJscBTCpNnPAU=
MIME-Version: 1.0
In-Reply-To: <20180511144305.GP33053@art_vandelay>
References: <1525861364-26323-1-git-send-email-hl@rock-chips.com>
 <1525861364-26323-3-git-send-email-hl@rock-chips.com> <20180511144305.GP33053@art_vandelay>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Fri, 11 May 2018 18:09:33 +0200
Message-ID: <CAFqH_51esHUZP4htLYYqHTCotb6P=fA4ozpENU7bXTaCBg8Cbg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Documentation: bindings: add phy_config for
 Rockchip USB Type-C PHY
To: Sean Paul <seanpaul@chromium.org>
Cc: Lin Huang <hl@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Chris Zhong <zyw@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lin,

2018-05-11 16:43 GMT+02:00 Sean Paul <seanpaul@chromium.org>:
> On Wed, May 09, 2018 at 06:22:43PM +0800, Lin Huang wrote:
>> If want to do training outside DP Firmware, need phy voltage swing
>> and pre_emphasis value.
>>
>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>
> Adding Rob Herring so he has a hope of seeing this.
>

And adding the devicetree ML, otherwise Rob will probably ignore the patch.

>> ---
>> Changes in v2:
>> - rebase
>>
>>  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>> index 960da7f..eda26dd 100644
>> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>> @@ -17,7 +17,9 @@ Required properties:
>>
>>  Optional properties:
>>   - extcon : extcon specifier for the Power Delivery
>> -
>> + - rockchip,phy_config : That's phy voltage swing and pre_emphasis
>> +                      setting, if want to do dp training outside
>> +                      dp firmware, need to add these value.
>
> What are the units?
>

Also, I think that will be good add an example or include the property
in the current examples to see how works. It's not clear from the
property description. I suppose it is an array of pairs <swing
pre-emphasis>?

nit:

-rockchip,phy_config: A list of voltage swing (unit) and pre-emphasis
(unit) pairs. Use this property to enable software link training
instead of hardware link training.

Best regards,
 Enric

> Sean
>
>>  Required nodes : a sub-node is required for each port the phy provides.
>>                The sub-node name is used to identify dp or usb3 port,
>>                and shall be the following entries:
>> --
>> 2.7.4
>>
>
> --
> Sean Paul, Software Engineer, Google / Chromium OS
