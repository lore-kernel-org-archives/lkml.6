Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933065AbeBVPfo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:35:44 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:41694 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932897AbeBVPfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:35:41 -0500
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
Subject: Re: [PATCH 4/6] ARM: dts: stm32: add MFX support on I2C1 on
 stm32746g-eval
Thread-Topic: [PATCH 4/6] ARM: dts: stm32: add MFX support on I2C1 on
 stm32746g-eval
Thread-Index: AQHToOkEeXZ/wauq20+UOEcVFZBBWaOwdr2AgAAb7IA=
Date: Thu, 22 Feb 2018 15:34:28 +0000
Message-ID: <9d66c639-7f3e-86f3-e744-237b4be31d09@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-5-git-send-email-amelie.delaunay@st.com>
 <CACRpkdZFrRXEBW6KnqZ=h_7BxYn-RaAzhP4ovwC_DQSbAGZCVw@mail.gmail.com>
In-Reply-To: <CACRpkdZFrRXEBW6KnqZ=h_7BxYn-RaAzhP4ovwC_DQSbAGZCVw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A4D238C51BDB04293015EAAD0F3A6F8@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1MFZpY9011278



On 02/22/2018 02:54 PM, Linus Walleij wrote:
> On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:
> 
>> MFX is used as gpio expander on stm32746g-eval.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> 
> (...)
>> +       mfx: mfx@42 {
>> +               compatible = "st,mfx";
>> +               reg = <0x42>;
>> +               interrupts = <8 1>;
>> +               interrupt-parent = <&gpioi>;
>> +               interrupt-controller;
>> +               #interrupt-cells = <1>;
>> +
>> +               mfxgpio: mfx_gpio {
>> +                       compatible = "st,mfx-gpio";
>> +                       interrupts = <0>;
>> +                       interrupt-parent = <&mfx>;
>> +                       gpio-controller;
>> +                       #gpio-cells = <2>;
> 
> So I think this node should contain some pin config states
> that can  be referenced by the drivers to set up push/pull
> etc. Probably it can use just standard pin config properties
> like sx150x.
> 

I will check that point.

Regards,
Amelie

> Yours,
> Linus Walleij
> 
