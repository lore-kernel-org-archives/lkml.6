Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933973AbeEIH5g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:57:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17687 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933715AbeEIH5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:57:34 -0400
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] dt-bindings: pinctrl: document the STMFX pinctrl
 bindings
Thread-Topic: [PATCH 1/5] dt-bindings: pinctrl: document the STMFX pinctrl
 bindings
Thread-Index: AQHT0XoURhB9br3sCUChmBQl/h9UpqQDmnwAgA9bIgCAFBx/gA==
Date: Wed, 9 May 2018 07:56:57 +0000
Message-ID: <55392fe7-20d2-9447-60f9-4bd226b60195@st.com>
References: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
 <1523440025-18077-2-git-send-email-amelie.delaunay@st.com>
 <20180416181940.4b5z4svbde3ompij@rob-hp-laptop>
 <CACRpkdYOMjjYyWQz7PK34jqUK7z5-CmH1HY6un4k8nBn7Cq8ag@mail.gmail.com>
In-Reply-To: <CACRpkdYOMjjYyWQz7PK34jqUK7z5-CmH1HY6un4k8nBn7Cq8ag@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0BCCDC397D58B4F98AEF4626D073125@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w497vgg4021186



On 04/26/2018 02:49 PM, Linus Walleij wrote:
> On Mon, Apr 16, 2018 at 8:19 PM, Rob Herring <robh@kernel.org> wrote:
>> On Wed, Apr 11, 2018 at 11:47:01AM +0200, Amelie Delaunay wrote:
>>> This patch adds documentation of device tree bindings for the
>>> STMicroelectronics Multi-Function eXpander (STMFX) GPIO expander.
>>>
>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> 
>>> +     stmfxpinctrl: stmfx@42 {
>>> +             compatible = "st,stmfx-0300";
>>> +             reg = <0x42>;
>>> +             interrupt-parent = <&gpioi>;
>>> +             interrupts = <8 IRQ_TYPE_EDGE_RISING>;
>>> +             vdd-supply = <&v3v3>;
>>> +             status = "okay";
>>
>> Don't show status in examples.
>>
>>> +
>>> +             stmfxgpio: gpio {
>>
>> Why does this need to be a sub node? Are there functions beyond GPIO?
> 
> Amelie can answer to whether there are, I suspect there
> are and in the review of patch 2 I suggest a MFD parent
> and parent/child spawning of a MFD child for the GPIO
> and pin control device.
> 
> Yours,
> Linus Walleij
> 

Indeed, stmfx has other functions than GPIO. But, after comments done 
here: [1] and there: [2], it has been decided to move MFD parent/GPIO 
child drivers into a single PINCTRL/GPIO driver because of the following 
reasons:
- Other stmfx functions (IDD measurement and TouchScreen controller) are 
not used on any of the boards using an stmfx and supported by Linux, so 
no way to test these functions, and no need to maintain them while they 
are not being used.
- But, in the case a new board will use more than GPIO function on 
stmfx, the actual implementation allow to easily extract common init 
part of stmfx and put it in an MFD driver.

So I could remove gpio sub-node and put its contents in stmfx node and 
keep single PINCTRL/GPIO driver for the time being.
Please advise,

Thanks,
Amelie

[1] https://lkml.org/lkml/2018/2/12/265
[2] https://lkml.org/lkml/2018/2/21/1503
