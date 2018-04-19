Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeDSJbv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:31:51 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:4767 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752633AbeDSJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:31:45 -0400
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
Subject: Re: [PATCH 1/2] dt-bindings/display/bridge: sii902x: add optional
 power supplies
Thread-Topic: [PATCH 1/2] dt-bindings/display/bridge: sii902x: add optional
 power supplies
Thread-Index: AQHT17YD8tnOVv8280mJzub+yGd3ZKQHsV4A
Date: Thu, 19 Apr 2018 09:31:15 +0000
Message-ID: <e709e4f7-2266-f99f-5864-5a8c037dbdc2@st.com>
References: <20180410051927.8268-1-philippe.cornu@st.com>
 <20180410051927.8268-2-philippe.cornu@st.com> <20599695.GSkeUvMnvx@avalon>
In-Reply-To: <20599695.GSkeUvMnvx@avalon>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.118]
Content-Type: text/plain; charset="utf-8"
Content-ID: <577F0AB04DDEC941AA5E2A39AB505DB4@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3J9VunW017316

Hi Laurent : )

On 04/19/2018 10:11 AM, Laurent Pinchart wrote:
> Hi Philippe,
> 
> Thank you for the patch.
> 
> On Tuesday, 10 April 2018 08:19:26 EEST Philippe Cornu wrote:
>> Add the 3 optional power supplies using the exact description
>> found in the document named
>> "SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>>   Documentation/devicetree/bindings/display/bridge/sii902x.txt | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
>> b/Documentation/devicetree/bindings/display/bridge/sii902x.txt index
>> 56a3e68ccb80..cf53678fe574 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
>> +++ b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
>> @@ -8,6 +8,9 @@ Optional properties:
>>   	- interrupts-extended or interrupt-parent + interrupts: describe
>>   	  the interrupt line used to inform the host about hotplug events.
>>   	- reset-gpios: OF device-tree gpio specification for RST_N pin.
>> +	- iovcc-supply: I/O supply voltage (1.8V or 3.3V, host-dependent).
>> +	- avcc12-supply: TMDS analog supply voltage (1.2V).
>> +	- cvcc12-supply: Digital core supply voltage (1.2V).
> 
> It seems that the AVCC12 and CVCC12 power supplies are usually derived from
> the same source. How about starting with one DT property for both, and adding
> a second one later if needed ?
> 

Well, I do not know what is the best. Here I took the description from 
the documentation, and to allow all possible board configurations, I 
added these supplies as "optional" properties: if there is only one 1v2 
regulator on the board, the dt will contain only avcc12 or cvcc12 and 
everything will work fine (we will have a dummy regulator for the 
missing optional 1v2 reg), if both regulators are there for any reasons 
(stability, noise, whatever...) then both entries will be in the dt.

If you confirm you prefer a single 1v2 supply (named for instance 
"vcc12-supply") then I will do :-)

Many thanks,
Philippe


>>   Optional subnodes:
>>   	- video input: this subnode can contain a video input port node
> 
