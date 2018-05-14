Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeENJWm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:22:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40784 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751954AbeENJWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:22:39 -0400
From: Philippe CORNU <philippe.cornu@st.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh@kernel.org>
CC: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH v2 1/2] dt-bindings/display/bridge: sii902x: add optional
 power supplies
Thread-Topic: [PATCH v2 1/2] dt-bindings/display/bridge: sii902x: add optional
 power supplies
Thread-Index: AQHT3GqLiNF0v3z3qEiUkMhGeiWEi6QRDaqAgAA3dACAABAGgIAAQV+AgABSEACAHQcqAA==
Date: Mon, 14 May 2018 09:22:16 +0000
Message-ID: <7fe8e766-56f5-38a3-b4dd-b44d4a5bdcf8@st.com>
References: <20180425075314.19137-1-philippe.cornu@st.com>
 <1559016.ZjzeSVB84W@avalon> <20180425171123.xhyoay3nu463btoq@rob-hp-laptop>
 <3518575.OAoTTXDygq@avalon>
In-Reply-To: <3518575.OAoTTXDygq@avalon>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3FA63A0D7F76045BDE4D3964FB1FCFF@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E9MmKA012722

Hi Rob & Laurent :)

On 04/26/2018 12:05 AM, Laurent Pinchart wrote:
> Hi Rob,
> 
> On Wednesday, 25 April 2018 20:11:23 EEST Rob Herring wrote:
>> On Wed, Apr 25, 2018 at 04:17:25PM +0300, Laurent Pinchart wrote:
>>> On Wednesday, 25 April 2018 15:20:04 EEST Philippe CORNU wrote:
>>>> On 04/25/2018 11:01 AM, Laurent Pinchart wrote:
>>>>> On Wednesday, 25 April 2018 10:53:13 EEST Philippe Cornu wrote:
>>>>>> Add optional power supplies using the description found in
>>>>>> "SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".
>>>>>>
>>>>>> There is a single 1v2 supply voltage named vcc12 from which cvcc12
>>>>>> (digital core) and avcc12 (TMDS analog) are derived because according
>>>>>> to this data sheet:
>>>>>> "cvcc12 and avcc12 can be derived from the same power source"
>>>>>
>>>>> Shouldn't the power supplies be mandatory, as explained by Mark in
>>>>> https://lists.freedesktop.org/archives/dri-devel/2018-April/172400.html
>>>>> ?
>>>>
>>>> Laurent,
>>>> Many thanks Laurent for your comment, I understood the merge of the two
>>>> 1v2 power supplies but missed the "mandatory" part... maybe because this
>>>> patch (with optional power supplies) already got the reviewed-by from
>>>> Rob, I thought the discussion thread you pointed out was applicable
>>>> "only" to totally new driver documentation.
>>>>
>>>> So, on my side, as a "new user" of sii902x IC, no problem to put these
>>>> power supplies as mandatory instead of optional properties but I would
>>>> like to be sure this is applicable to both old and new bindings doc : )
>>>
>>> We obviously need to retain backward compatibility, so on the driver side
>>> you need to treat those power supplies as optional. From a DT bindings
>>> point of view, however, I think they should be mandatory for new DT.
>>
>> We don't really have a way to describe these 3 conditions (required for
>> all, optional for all, and required for new). So generally we make
>> additions optional. The exception sometimes is if we update all the dts
>> files.
> 
> Can't we just make it mandatory in the bindings, as long as we treat it as
> optional in drivers ?
> 

How to progress on this patch? Do you have any suggestions?

Many thanks for your help,
Philippe :-)

>>>> Rob,
>>>> could you please confirm these power supply properties should be
>>>> "mandatory"? if yes, should we then modify other optional properties like
>>>> the reset-gpios too in the future?
>>>
>>> The GPIOs properties are different in my opinion, as there's no
>>> requirement to connect for instance the reset pin to a GPIO controllable
>>> by the SoC. The pin could be hardwired to VCC, or connected to a system
>>> reset that is automatically managed without SoC intervention. The power
>>> supplies, however, are mandatory, in the sense that the chip will not work
>>> if you leave the power supplies unconnected.
>>
>> DT only needs to describe what matters to s/w. If a regulator is
>> fixed and you don't need to know its voltage (or other read-only
>> parameters), then there's not much point in putting it in DT.
>>
>> I'd probably base this more at a platform level and you either use
>> regulator binding or you don't. It's perfectly valid that you want to do
>> things like regulator setup, pin ctrl and muxing setup, etc. all in
>> firmware and the OS doesn't touch any of that.
>>
>> That's all a big can of worms which we shouldn't solve on this 2 line
>> change. I think this change is fine as-is, so:
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
