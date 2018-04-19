Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeDSMlc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:41:32 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25014 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751865AbeDSMla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:41:30 -0400
From: Philippe CORNU <philippe.cornu@st.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings/display/bridge: sii902x: add optional
 power supplies
Thread-Topic: [PATCH 1/2] dt-bindings/display/bridge: sii902x: add optional
 power supplies
Thread-Index: AQHT17YD8tnOVv8280mJzub+yGd3ZKQHsV4AgAAbjwCAABmOAA==
Date: Thu, 19 Apr 2018 12:41:20 +0000
Message-ID: <a10d41bc-c766-568b-a9cb-d1f0f03390a8@st.com>
References: <20180410051927.8268-1-philippe.cornu@st.com>
 <20599695.GSkeUvMnvx@avalon> <e709e4f7-2266-f99f-5864-5a8c037dbdc2@st.com>
 <1733412.i2Wslp7VkI@avalon>
In-Reply-To: <1733412.i2Wslp7VkI@avalon>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <63B4169087856944A9896EBD4F7B6F5A@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3JCfdfs028504

Hi Laurent,


On 04/19/2018 01:09 PM, Laurent Pinchart wrote:
> Hi Philippe,
> 
> On Thursday, 19 April 2018 12:31:15 EEST Philippe CORNU wrote:
>> On 04/19/2018 10:11 AM, Laurent Pinchart wrote:
>>> On Tuesday, 10 April 2018 08:19:26 EEST Philippe Cornu wrote:
>>>
>>>> Add the 3 optional power supplies using the exact description
>>>> found in the document named
>>>> "SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".
>>>>
>>>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>>>> ---
>>>>
>>>>    Documentation/devicetree/bindings/display/bridge/sii902x.txt | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
>>>> b/Documentation/devicetree/bindings/display/bridge/sii902x.txt index
>>>> 56a3e68ccb80..cf53678fe574 100644
>>>> --- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
>>>> +++ b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
>>>> @@ -8,6 +8,9 @@ Optional properties:
>>>>    	- interrupts-extended or interrupt-parent + interrupts: describe
>>>>    	  the interrupt line used to inform the host about hotplug events.
>>>>    	- reset-gpios: OF device-tree gpio specification for RST_N pin.
>>>> +	- iovcc-supply: I/O supply voltage (1.8V or 3.3V, host-dependent).
>>>> +	- avcc12-supply: TMDS analog supply voltage (1.2V).
>>>> +	- cvcc12-supply: Digital core supply voltage (1.2V).
>>>
>>> It seems that the AVCC12 and CVCC12 power supplies are usually derived
>>> from the same source. How about starting with one DT property for both,
>>> and adding a second one later if needed ?
>>
>> Well, I do not know what is the best. Here I took the description from
>> the documentation, and to allow all possible board configurations, I
>> added these supplies as "optional" properties: if there is only one 1v2
>> regulator on the board, the dt will contain only avcc12 or cvcc12 and
>> everything will work fine (we will have a dummy regulator for the
>> missing optional 1v2 reg), if both regulators are there for any reasons
>> (stability, noise, whatever...) then both entries will be in the dt.
>>
>> If you confirm you prefer a single 1v2 supply (named for instance
>> "vcc12-supply") then I will do :-)
> 
> Please see https://lists.freedesktop.org/archives/dri-devel/2018-April/
> 172400.html (and the messages that lead to it) and https://
> lists.freedesktop.org/archives/dri-devel/2018-March/170763.html.
> 

Thanks for this discussion thread.

On my side, I found "CVCC12 and AVCC12 can be derived from the same 
power source" written with a small font (august 2016 datasheet p13) so 
then your advice is clearly what we have to do :-)
I will add this info in v2 too.
Thank you,
Philippe :-)

>>>>    Optional subnodes:
>>>>    	- video input: this subnode can contain a video input port node
> 
