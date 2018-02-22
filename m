Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933071AbeBVPhx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:37:53 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18432 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932919AbeBVPho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:37:44 -0500
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/6] ARM: dts: stm32: add joystick support on
 stm32746g-eval
Thread-Topic: [PATCH 5/6] ARM: dts: stm32: add joystick support on
 stm32746g-eval
Thread-Index: AQHToOkH6lDu2TxtlUC3foCv3rgif6Owdj+AgAAcswA=
Date: Thu, 22 Feb 2018 15:35:28 +0000
Message-ID: <f8d91cc7-66aa-72bf-c1ed-8e95d39388ba@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-6-git-send-email-amelie.delaunay@st.com>
 <CACRpkdbaFpLNdxZThVTO5V4y8wzekVpXoFJ_6EOOsKCD_h59cA@mail.gmail.com>
In-Reply-To: <CACRpkdbaFpLNdxZThVTO5V4y8wzekVpXoFJ_6EOOsKCD_h59cA@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <903C948E0C2F20429AC9EA9E2E0A4A8D@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1MFc0R2011959



On 02/22/2018 02:52 PM, Linus Walleij wrote:
> Hi Amelie,
> 
> thanks for your patch.
> 
> On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:
> 
>> The joystick on stm32746g-eval uses gpios on MFX gpio expander.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> (...)
>> +       joystick {
>> +               compatible = "gpio-keys";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               button@1 {
>> +                       label = "JoySel";
>> +                       linux,code = <KEY_ENTER>;
>> +                       gpios = <&mfxgpio 0 (GPIO_ACTIVE_LOW | GPIO_IN_PUSH_PULL | GPIO_PULL_UP)>;
>> +               };
> 
> As I think this should not all be handled by GPIO, the joystick on
> gpio-keys needs a pin control handle pointing back to pin control
> states on the respective pins in the pin control/GPIO driver,
> where it can set up these properties.
> 
> For the individual lines the pushing and pulling flags should be
> removed.
> 

Sure! I keep this in mind, thanks!

Regards,
Amelie

> Yours,
> Linus Walleij
> 
