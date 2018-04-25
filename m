Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeDYNRO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:17:14 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39568 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752831AbeDYNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:17:12 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Philippe CORNU <philippe.cornu@st.com>
Cc: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH v2 1/2] dt-bindings/display/bridge: sii902x: add optional power supplies
Date: Wed, 25 Apr 2018 16:17:25 +0300
Message-ID: <1559016.ZjzeSVB84W@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <e18d1a3b-a2eb-74f2-ab88-7bf01af0754b@st.com>
References: <20180425075314.19137-1-philippe.cornu@st.com> <16954794.QiYqgNKfkn@avalon> <e18d1a3b-a2eb-74f2-ab88-7bf01af0754b@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

On Wednesday, 25 April 2018 15:20:04 EEST Philippe CORNU wrote:
> On 04/25/2018 11:01 AM, Laurent Pinchart wrote:
> > On Wednesday, 25 April 2018 10:53:13 EEST Philippe Cornu wrote:
> >> Add optional power supplies using the description found in
> >> "SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".
> >>
> >> There is a single 1v2 supply voltage named vcc12 from which cvcc12
> >> (digital core) and avcc12 (TMDS analog) are derived because according
> >> to this data sheet:
> >> "cvcc12 and avcc12 can be derived from the same power source"
> > 
> > Shouldn't the power supplies be mandatory, as explained by Mark in
> > https://lists.freedesktop.org/archives/dri-devel/2018-April/172400.html
> > ? 
> 
> Laurent,
> Many thanks Laurent for your comment, I understood the merge of the two 
> 1v2 power supplies but missed the "mandatory" part... maybe because this 
> patch (with optional power supplies) already got the reviewed-by from 
> Rob, I thought the discussion thread you pointed out was applicable 
> "only" to totally new driver documentation.
> 
> So, on my side, as a "new user" of sii902x IC, no problem to put these 
> power supplies as mandatory instead of optional properties but I would 
> like to be sure this is applicable to both old and new bindings doc : )

We obviously need to retain backward compatibility, so on the driver side you 
need to treat those power supplies as optional. From a DT bindings point of 
view, however, I think they should be mandatory for new DT.

> Rob,
> could you please confirm these power supply properties should be 
> "mandatory"?
> if yes, should we then modify other optional properties like the 
> reset-gpios too in the future?

The GPIOs properties are different in my opinion, as there's no requirement to 
connect for instance the reset pin to a GPIO controllable by the SoC. The pin 
could be hardwired to VCC, or connected to a system reset that is 
automatically managed without SoC intervention. The power supplies, however, 
are mandatory, in the sense that the chip will not work if you leave the power 
supplies unconnected.

> Big thanks to both of you,

You're welcome !

> >> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> >> ---
> >> 
> >>   Documentation/devicetree/bindings/display/bridge/sii902x.txt | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> >> b/Documentation/devicetree/bindings/display/bridge/sii902x.txt index
> >> 56a3e68ccb80..9fb41fc9af51 100644
> >> --- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> >> +++ b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> >> @@ -8,6 +8,8 @@ Optional properties:
> >>   	- interrupts-extended or interrupt-parent + interrupts: describe
> >>   	  the interrupt line used to inform the host about hotplug events.
> >>   	- reset-gpios: OF device-tree gpio specification for RST_N pin.
> >> +	- iovcc-supply: I/O supply voltage (1.8V or 3.3V, host-dependent).
> >> +	- vcc12-supply: TMDS analog & digital core supply voltage (1.2V).
> >>
> >>   Optional subnodes:
> >>   	- video input: this subnode can contain a video input port node

-- 
Regards,

Laurent Pinchart
