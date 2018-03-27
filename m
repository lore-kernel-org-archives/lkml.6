Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbeC0GPh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:15:37 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:36861 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeC0GPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:15:35 -0400
Subject: Re: [PATCH v6 1/3] dt-bindings: display: bridge: Document
 THC63LVD1024 LVDS decoder
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
References: <1521213399-31947-1-git-send-email-jacopo+renesas@jmondi.org>
 <1521213399-31947-2-git-send-email-jacopo+renesas@jmondi.org>
 <4060923.7DxT9ae38L@avalon> <20180326222249.tvjiutyd4amlibpa@rob-hp-laptop>
CC: Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <architt@codeaurora.org>, <a.hajda@samsung.com>, <airlied@linux.ie>,
        <horms@verge.net.au>, <magnus.damm@gmail.com>, <geert@linux-m68k.org>,
        <niklas.soderlund@ragnatech.se>, <sergei.shtylyov@cogentembedded.com>,
        <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <a1b0e678-38b8-dd29-b441-e2a09b565105@mentor.com>
Date: Tue, 27 Mar 2018 09:15:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180326222249.tvjiutyd4amlibpa@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On 03/27/2018 01:22 AM, Rob Herring wrote:
> On Tue, Mar 20, 2018 at 02:43:33PM +0200, Laurent Pinchart wrote:
>> Hi Jacopo,
>>
>> (CC'ing Rob)
>>
>> Thank you for the patch.
>>
>> On Friday, 16 March 2018 17:16:37 EET Jacopo Mondi wrote:
>>> Document Thine THC63LVD1024 LVDS decoder device tree bindings.
>>>
>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>>> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>>> ---
>>>  .../bindings/display/bridge/thine,thc63lvd1024.txt | 66 +++++++++++++++++++
>>>  1 file changed, 66 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>>> b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>>> new file mode 100644
>>> index 0000000..8225c6a
>>> --- /dev/null
>>> +++
>>> b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>>> @@ -0,0 +1,66 @@
>>> +Thine Electronics THC63LVD1024 LVDS decoder
>>> +-------------------------------------------
>>> +
>>> +The THC63LVD1024 is a dual link LVDS receiver designed to convert LVDS
>>> streams
>>> +to parallel data outputs. The chip supports single/dual input/output modes,
>>> +handling up to two two input LVDS stream and up to two digital CMOS/TTL
>>> outputs.
>>> +
>>> +Single or dual operation modes, output data mapping and DDR output modes
>>> are
>>> +configured through input signals and the chip does not expose any control
>>> bus.
>>> +
>>> +Required properties:
>>> +- compatible: Shall be "thine,thc63lvd1024"
>>> +
>>> +Optional properties:
>>> +- vcc-supply: Power supply for TTL output and digital circuitry
>>> +- cvcc-supply: Power supply for TTL CLOCKOUT signal
>>> +- lvcc-supply: Power supply for LVDS inputs
>>> +- pvcc-supply: Power supply for PLL circuitry
>>
>> As explained in a comment to one of the previous versions of this series, I'm 
>> tempted to make vcc-supply mandatory and drop the three other power supplies 
>> for now, as I believe there's very little chance they will be connected to 
>> separately controllable regulators (all supplies use the same voltage). In the 
>> very unlikely event that this occurs in design we need to support in the 
>> future, the cvcc, lvcc and pvcc supplies can be added later as optional 
>> without breaking backward compatibility.
> 
> I'm okay with that.
> 
>> Apart from that,
>>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>>> +- pdwn-gpios: Power down GPIO signal. Active low
> 
> powerdown-gpios is the semi-standard name.
> 

right, I've also noticed it. If possible please avoid shortenings in
property names.

>>> +- oe-gpios: Output enable GPIO signal. Active high
>>> +

And this one is also a not ever met property name, please consider to
rename it to 'enable-gpios', for instance display panels define it.

>>> +The THC63LVD1024 video port connections are modeled according
>>> +to OF graph bindings specified by
>>> Documentation/devicetree/bindings/graph.txt

[snip]

>>> +
>>> +			port@2{
>>> +				reg = <2>;
>>> +
>>> +				lvds_dec_out_2: endpoint {
>>> +					remote-endpoint = <&adv7511_in>;
>>> +				};
>>> +

Drop a surplus empty line above.

>>> +			};
>>> +

Drop a surplus empty line above.

>>> +		};
>>> +	};

--
With best wishes,
Vladimir
