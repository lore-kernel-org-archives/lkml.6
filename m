Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932074AbeE3Pmy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:42:54 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:60855 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeE3Pms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:42:48 -0400
Subject: Re: [PATCH v2 1/6] ARM: dra762: hwmod: Add MCAN support
To: Tony Lindgren <tony@atomide.com>
CC: Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <robh+dt@kernel.org>, <bcousson@baylibre.com>, <paul@pwsan.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-2-faiz_abbas@ti.com> <20180530145047.GC5705@atomide.com>
 <cfa9c9df-57a2-69f6-9509-440dc18292e7@ti.com>
 <20180530152825.GG5705@atomide.com>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <b0476932-a6e9-6ef1-69ad-c9a8c55d9739@ti.com>
Date: Wed, 30 May 2018 18:41:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180530152825.GG5705@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/18 18:28, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [180530 15:18]:
>> For the OCP if part, I think that is still needed until we switch over to
>> full sysc driver. clkctrl_offs you probably also need because that is used
>> for mapping the omap_hwmod against a specific clkctrl clock. Those can be
>> only removed once we are done with hwmod (or figure out some other way to
>> assign the clkctrl clock to a hwmod.)
> 
> Hmm might be worth testing. I thought your commit 70f05be32133
> ("ARM: OMAP2+: hwmod: populate clkctrl clocks for hwmods if available")
> already parses the clkctrl from dts?

It maps the clkctrl clock to be used by hwmod, if those are available. 
We didn't add any specific clock entries to DT for mapping the actual 
clkctrl clock without the hwmod_data hints yet though, as that was 
deemed temporary solution only due to transition to interconnect driver. 
I.e., you would need something like this in DT for every device node:

&uart3 {
   clocks = <l4per_clkctrl UART3_CLK 0>;
   clock-names = "clkctrl";
};

... which is currently not present.

Alternatively you could rename the main_clk in the hwmod_data to point 
towards the clkctrl clock, but again, that would be a temporary solution 
only.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
