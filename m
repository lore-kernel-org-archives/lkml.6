Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeC0G1d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:27:33 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:37958 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeC0G13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:27:29 -0400
Subject: Re: [PATCH v6 3/3] arm64: dts: renesas: Add LVDS decoder to R-Car V3M
 Eagle
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
References: <1521213399-31947-1-git-send-email-jacopo+renesas@jmondi.org>
 <1521213399-31947-4-git-send-email-jacopo+renesas@jmondi.org>
 <3127791.hHqCBynxiV@avalon>
CC: <architt@codeaurora.org>, <a.hajda@samsung.com>, <airlied@linux.ie>,
        <horms@verge.net.au>, <magnus.damm@gmail.com>, <geert@linux-m68k.org>,
        <niklas.soderlund@ragnatech.se>, <sergei.shtylyov@cogentembedded.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <41ccb195-09d1-5765-9344-e489e81943b1@mentor.com>
Date: Tue, 27 Mar 2018 09:27:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <3127791.hHqCBynxiV@avalon>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On 03/20/2018 03:01 PM, Laurent Pinchart wrote:
> Hi Jacopo,
> 
> Thank you for the patch.
> 
> On Friday, 16 March 2018 17:16:39 EET Jacopo Mondi wrote:
>> The R-Car V3M Eagle board includes a transparent THC63LVD1024 LVDS
>> decoder, connected to the on-chip LVDS encoder output on one side
>> and to HDMI encoder ADV7511w on the other one.
>>
>> As the decoder does not need any configuration it has been so-far
>> omitted from DTS. Now that a driver is available, describe it in DT
>> as well.
>>
>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> 
> The patch looks OK to me, but I think it should be squashed with Niklas' patch 
> that added display HDMI output support to the V3M Eagle DT.
> 
>> ---
>>
>> List of patch dependencies, as of renesas-drivers-2018-03-13-v4.16-rc5:
>>
>> - [PATCH v2 0/5] arm64: dts: renesas: r8a77970: enable HDMI output
>>    which includes DU, LVDS and FCPD enablement from:
>>   [PATCH v2 0/5] Add R8A77970/V3MSK LVDS/HDMI support
>> - [PATCH v4] v4l: vsp1: Fix video output on R8A77970
>>
>> Patches to be applied on top of
>> "arm64: dts: renesas: eagle: add HDMI output using the ADV7511W"
>>
>> Thanks
>>    j
>> ---
>>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 33 ++++++++++++++++++++---
>>  1 file changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
>> b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts index c0fd144..69f43b8
>> 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
>> +++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
>> @@ -42,6 +42,33 @@
>>  			};
>>  		};
>>  	};
>> +
>> +	thc63lvd1024: lvds-decoder {
>> +		compatible = "thine,thc63lvd1024";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@0 {
>> +				reg = <0>;
>> +
>> +				thc63lvd1024_in_0: endpoint {
>> +					remote-endpoint = <&lvds0_out>;
>> +				};
>> +			};
>> +
>> +			port@2{
>> +				reg = <2>;
>> +
>> +				thc63lvd1024_out_2: endpoint {
>> +					remote-endpoint = <&adv7511_in>;
>> +				};
>> +

Remove the empty line above.

>> +			};
>> +

Remove the empty line above.

>> +		};
>> +	};
>>  };
>>

--
With best wishes,
Vladimir
