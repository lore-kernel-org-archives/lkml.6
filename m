Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeERH3j (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:29:39 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25338 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752317AbeERH3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:29:34 -0400
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Lee Jones <lee.jones@linaro.org>
CC: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/5] dt-bindings: pinctrl: document the STMFX pinctrl
 bindings
Thread-Topic: [PATCH 1/5] dt-bindings: pinctrl: document the STMFX pinctrl
 bindings
Thread-Index: AQHT0XoURhB9br3sCUChmBQl/h9UpqQDmnwAgA9bIgCAFBx/gIALa4OAgAALVoCAAQVhAIABoPiA
Date: Fri, 18 May 2018 07:29:04 +0000
Message-ID: <28c374e6-b440-f785-b371-03fe15c8bc4b@st.com>
References: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
 <1523440025-18077-2-git-send-email-amelie.delaunay@st.com>
 <20180416181940.4b5z4svbde3ompij@rob-hp-laptop>
 <CACRpkdYOMjjYyWQz7PK34jqUK7z5-CmH1HY6un4k8nBn7Cq8ag@mail.gmail.com>
 <55392fe7-20d2-9447-60f9-4bd226b60195@st.com>
 <CACRpkda2VGo0FOdR09tKiTpg66NgoWjubaHp_J3372y=a772Zg@mail.gmail.com>
 <b9005dd8-8214-ceab-0f88-ff1a51b44e34@st.com> <20180517063640.GK5130@dell>
In-Reply-To: <20180517063640.GK5130@dell>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8B6A2FB85CB2C43A0FB3B16F8C2746D@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4I7Tjd8028928

On 05/17/2018 08:36 AM, Lee Jones wrote:
> On Wed, 16 May 2018, Amelie DELAUNAY wrote:
> 
>>
>>
>> On 05/16/2018 04:20 PM, Linus Walleij wrote:
>>> On Wed, May 9, 2018 at 9:56 AM, Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
>>>
>>>> Indeed, stmfx has other functions than GPIO. But, after comments done
>>>> here: [1] and there: [2], it has been decided to move MFD parent/GPIO
>>>> child drivers into a single PINCTRL/GPIO driver because of the following
>>>> reasons:
>>>> - Other stmfx functions (IDD measurement and TouchScreen controller) are
>>>> not used on any of the boards using an stmfx and supported by Linux, so
>>>> no way to test these functions, and no need to maintain them while they
>>>> are not being used.
>>>> - But, in the case a new board will use more than GPIO function on
>>>> stmfx, the actual implementation allow to easily extract common init
>>>> part of stmfx and put it in an MFD driver.
>>>>
>>>> So I could remove gpio sub-node and put its contents in stmfx node and
>>>> keep single PINCTRL/GPIO driver for the time being.
>>>> Please advise,
>>>
>>> I would normally advice to use the right modeling from the start, create
>>> the MFD driver and spawn the devices from there. It is confusing
>>> if the layout of the driver(s) doesn't really match the layout of the
>>> hardware.
>>>
>>> I understand that it is a pain to write new MFD drivers to get your
>>> things going and it would be "nice to get this working really quick
>>> now" but in my experience it is better to do it right from the start.
>>>
>>
>> Hi Linus,
>>
>> Thanks for your advice. I understand the point.
>> So, the right modeling would be to:
>> - create an MFD driver with the common init part of stmfx
>> - remove all common init part of stmfx-pinctrl driver and keep only all
>> gpio/pinctrl functions.
>>
>> I will not develop the other stmfx functions (IDD measurement driver and
>> TouchScreen controller driver) because, as explained ealier, they are
>> not used on any of the boards using an stmfx and supported by Linux, so
>> no way to test these functions, and no need to maintain them while they
>> are not being used.
>>
>> Lee, are you OK with that ?
> 
> I missed a lot of this conversation I think, but from what I've read,
> it sounds fine.
> 

I summarize the situation:
- I still don't have an official datasheet for STMFX device which could 
justify the use of an MFD driver;
- the MFD driver will contain the STMFX chip initialization stuff such 
as regmap initialization (regmap structure will be shared with the 
child), chip initialization, global interrupt management;
- there will be only one child (GPIO/PINCTRL node) for the time being.

So, is "MFD driver + GPIO/PINCTRL driver" the right modeling, and does 
it still sound fine after this summary ? :)

Thanks,
Amelie
