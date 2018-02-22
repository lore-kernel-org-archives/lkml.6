Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932924AbeBVPUR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:20:17 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21386 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932744AbeBVPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:20:14 -0500
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
Subject: Re: [PATCH 1/6] dt-bindings: mfd: Add ST Multi-Function eXpander
 driver
Thread-Topic: [PATCH 1/6] dt-bindings: mfd: Add ST Multi-Function eXpander
 driver
Thread-Index: AQHToOkB1gg/oaB2TkqIj2Qyt+f60KOwarQAgAAj2wA=
Date: Thu, 22 Feb 2018 15:19:46 +0000
Message-ID: <c44b4b09-8c28-5168-136f-c72c291d7b7b@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-2-git-send-email-amelie.delaunay@st.com>
 <CACRpkdZxJhntgHwgsg=P98i0aGnXSQ2rXO16H0U=cJ+sBbF27g@mail.gmail.com>
In-Reply-To: <CACRpkdZxJhntgHwgsg=P98i0aGnXSQ2rXO16H0U=cJ+sBbF27g@mail.gmail.com>
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
Content-ID: <7CC796D646A239409EA3DC0E782F1B18@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1MFKMlU006310



On 02/22/2018 02:11 PM, Linus Walleij wrote:
> On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:
> 
>> +Required properties:
>> +- compatible: must be "st,mfx"
> 
> I bet this should be more specific. Tomorrow there will be a new
> version of this expander and then we will wish that we used
> a more specific compatible for the first one.
> 
> Does this chip have any kind of product number on it?
> 
> Else I would be tempted to use the compatible "st,mfx-0000"
> or something, indicating it is the first of its kind.
> 

This chip has a FW version. So, I agree, I should use a compatible that 
reflects this FW version.

>> +- reg: I2C address of the device
>> +- interrupts: interrupt triggered by MFX_IRQ_OUT signal
>> +- interrupt-parent: interrupt controller MFX is connected to
>> +- interrupt-controller: marks the device as an interrupt controller
>> +- #interrupt-cells: should be <1>, index of the interrupt within the
>> +  controller, in accordance with the "one cell" variant of
>> +  <devicetree/bindings/interrupt-controller/interrupt.txt>
> 
> Seems fine.
> 
>> +Optional nodes:
>> +
>> +* GPIO eXpander
>> +MFX provides 16 programmable GPIOs, and it is also possible to recover 8
>> +alternate GPIOs if the main functions are not used (touchscreen controller and
>> +IDD measurement not enabled).
> 
> Apparenly Rob thinks this should go elsewhere.
> 

It would go with gpio/pinctrl driver, so in dt-bindings/(gpio|pinctrl).

Regards,
Amelie

>> +- gpio-controller: marks the device node as a GPIO controller
>> +- #gpio-cells: should be <2>, the first cell is the GPIO offset on this GPIO
>> +  controller, the second cell is the gpio flags in accordance with
>> +  <dt-bindings/gpio/st-mfx-gpio.h>.
> 
> Let's discuss these extra GPIO flag bindings separately.
> 
> Yours,
> Linus Walleij
> 
