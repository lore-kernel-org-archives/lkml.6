Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753834AbeDYMUm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:20:42 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38557 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753701AbeDYMUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:20:39 -0400
From: Philippe CORNU <philippe.cornu@st.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
Thread-Index: AQHT3GqLiNF0v3z3qEiUkMhGeiWEi6QRDaqAgAA3dAA=
Date: Wed, 25 Apr 2018 12:20:04 +0000
Message-ID: <e18d1a3b-a2eb-74f2-ab88-7bf01af0754b@st.com>
References: <20180425075314.19137-1-philippe.cornu@st.com>
 <20180425075314.19137-2-philippe.cornu@st.com> <16954794.QiYqgNKfkn@avalon>
In-Reply-To: <16954794.QiYqgNKfkn@avalon>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C12508B95C0E4A4D9ADA223CB2F824DD@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3PCKlG4027673

Hi Laurent & Rob :-)

On 04/25/2018 11:01 AM, Laurent Pinchart wrote:
> Hi Philippe,
> 
> Thank you for the patch.
> 
> On Wednesday, 25 April 2018 10:53:13 EEST Philippe Cornu wrote:
>> Add optional power supplies using the description found in
>> "SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".
>>
>> There is a single 1v2 supply voltage named vcc12 from which cvcc12
>> (digital core) and avcc12 (TMDS analog) are derived because according
>> to this data sheet:
>> "cvcc12 and avcc12 can be derived from the same power source"
> 
> Shouldn't the power supplies be mandatory, as explained by Mark in https://
> lists.freedesktop.org/archives/dri-devel/2018-April/172400.html ?
> 

Laurent,
Many thanks Laurent for your comment, I understood the merge of the two 
1v2 power supplies but missed the "mandatory" part... maybe because this 
patch (with optional power supplies) already got the reviewed-by from 
Rob, I thought the discussion thread you pointed out was applicable 
"only" to totally new driver documentation.

So, on my side, as a "new user" of sii902x IC, no problem to put these 
power supplies as mandatory instead of optional properties but I would 
like to be sure this is applicable to both old and new bindings doc : )

Rob,
could you please confirm these power supply properties should be 
"mandatory"?
if yes, should we then modify other optional properties like the 
reset-gpios too in the future?

Big thanks to both of you,
Philippe :-)

>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>>   Documentation/devicetree/bindings/display/bridge/sii902x.txt | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
>> b/Documentation/devicetree/bindings/display/bridge/sii902x.txt index
>> 56a3e68ccb80..9fb41fc9af51 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
>> +++ b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
>> @@ -8,6 +8,8 @@ Optional properties:
>>   	- interrupts-extended or interrupt-parent + interrupts: describe
>>   	  the interrupt line used to inform the host about hotplug events.
>>   	- reset-gpios: OF device-tree gpio specification for RST_N pin.
>> +	- iovcc-supply: I/O supply voltage (1.8V or 3.3V, host-dependent).
>> +	- vcc12-supply: TMDS analog & digital core supply voltage (1.2V).
>>
>>   Optional subnodes:
>>   	- video input: this subnode can contain a video input port node
> 
