Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932126AbeBUSyF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:54:05 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41081 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753691AbeBUSyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:54:02 -0500
X-Google-Smtp-Source: AH8x2279gUobtMImtRPDHHWm2I3j8r1VZtDALhmvMVS2NwxoibCNs0E7S271e9vud03mrFxw4pmh/g==
Subject: Re: [PATCH v2 19/19] ARM64: dts: r8a77965: Add EtherAVB device node
To: Simon Horman <horms@verge.net.au>
Cc: jacopo mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-20-git-send-email-jacopo+renesas@jmondi.org>
 <cf157266-5ea7-6795-1e31-0d1ccf85e7e8@cogentembedded.com>
 <20180221100716.GF7203@w540>
 <cbeb1b6b-1b02-7665-0f1f-847ab8de69e3@cogentembedded.com>
 <20180221173106.vgyshbz3kkc4p3cu@verge.net.au>
 <321c6c8c-8853-ac00-7567-c0be82b510f4@cogentembedded.com>
 <35959135-cb3b-040a-1944-26845e0c07b0@cogentembedded.com>
 <20180221182340.wvdvgtv5pw7pvd3v@verge.net.au>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <eaf3c72b-a482-86cf-88e7-4af457f74558@cogentembedded.com>
Date: Wed, 21 Feb 2018 21:53:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180221182340.wvdvgtv5pw7pvd3v@verge.net.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 09:23 PM, Simon Horman wrote:

> ...
> 
>>>>>>>> +			clocks = <&cpg CPG_MOD 812>;
>>>>>>>> +			power-domains = <&sysc 32>;
>>>>>>>> +			resets = <&cpg 812>;
>>>>>>>> +			phy-mode = "rgmii-txid";
>>>>>>>
>>>>>>>    Why not just "rgmii"? TX delay is a board specific detail, no?
>>>>>>>
>>>>>> I admit I took this one straight from r8a7796 dtsi.
>>>>>> Would you like to me resend and change this?
>>>>>
>>>>>    Yes, unless Simon would fix it while merging...
>>>>
>>>> Can I confirm the desired change is s/rgmii-txid/rgmii/ ?
>>>
>>>    Yes.
>>
>>    Apparently that means that this prop should be overridden in the board file
>> (which may not be an easy task given the board is Salvator-XS again).
>>
>> [...]
> 
> Can we override it in r8a77965-salvator-x.dts or r8a77965-salvator-xs.dts?

   In salvator-common.dtsi most probably -- it has the PHY data for Ether AVB.

> I feel that I'm missing an important point here.

   Well, r8a779{5|6}.dtsi also have phy-mode = "rgmii-txid" (which was unjustified
in my current understanding). Thus such board override wouldn't hurt them. But we lack
a patch modifying salvator-common.dtsi in htis series, so I'm now thinking a respin of
this series is needed anyway... sorry for being unclear. :-)

MBR, Sergei
