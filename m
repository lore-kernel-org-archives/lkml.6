Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934592AbeBMLKr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:10:47 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:9972 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934226AbeBMLKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:10:44 -0500
Subject: Re: [PATCH v2 15/15] ARM: dts: dra7: Add high speed modes capability
 to MMC1/MMC2 dt node
To: Kishon Vijay Abraham I <kishon@ti.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180206125806.19350-1-kishon@ti.com>
 <20180206125806.19350-16-kishon@ti.com>
 <210939ed-67fc-fa37-b4f2-c1faefcc4642@ti.com>
 <b411cf11-61e9-e688-6f04-e624fe52ac66@ti.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <4f18dab9-aee3-1023-d301-f142c6e2d358@ti.com>
Date: Tue, 13 Feb 2018 16:40:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b411cf11-61e9-e688-6f04-e624fe52ac66@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 February 2018 02:51 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Wednesday 07 February 2018 02:41 PM, Sekhar Nori wrote:
>> Kishon,
>>
>> On Tuesday 06 February 2018 06:28 PM, Kishon Vijay Abraham I wrote:
>>> Add UHS/HS200/DDR speed mode capability to MMC1 and MMC2 dt nodes.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Along with this, dont we need to have
>>
>> 	/delete-property/ mmc-hs200-1_8v;
>>
>> for eMMC on Beagle x15 which does not support HS200?
>>
>> Or are you planning to depend on lack of pinctrl entries for HS200 to
>> take care of that?
> 
> right now it relies on lack of pinctrl entries but I think adding delete
> property is appropriate. Actually I missed porting the patch that adds
> /delete-property/.

Actually, thinking more, this should be probably be handled using
"no-1-8-v" property. Reading the comment above SDHCI_QUIRK2_NO_1_8_V, it
is specifically meant for the case when system (board) does not support
1.8V even when host (controller) does. Which is exactly the case with
Beagle x15.

Thanks,
Sekhar
