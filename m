Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeBWO5V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:57:21 -0500
Received: from mail02.prevas.se ([62.95.78.10]:31611 "EHLO mail02.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbeBWO5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:57:19 -0500
X-IronPort-AV: E=Sophos;i="5.47,383,1515452400";
   d="scan'208";a="3118959"
Subject: Re: [RFC PATCH] ARM: dts: ls1021a: add size-cells and address-cells
 to scfg and dcfg nodes
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180223133114.7091-1-rasmus.villemoes@prevas.dk>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <ad7dde07-9a11-09fb-61c0-8ec97e35bb63@prevas.dk>
Date: Fri, 23 Feb 2018 15:57:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223133114.7091-1-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.8.31]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-23 14:31, Rasmus Villemoes wrote:
> A single u32 is sufficient to specify a register in the Device
> Configuration Unit/Supplemental Configuration Unit. Moreover, they only
> consist of 32 bit registers (for the DCFG we even have "These registers
> only support 32-bit accesses." according to the reference manual), so no
> size specification is needed.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> None of the in-tree .dts files using ls1021a.dtsi currently define a
> subnode of either node. It is possible, though somewhat unlikely, that
> some out-of-tree .dts file is built against the in-tree ls1021a.dtsi,
> and I don't know if such files are treated the same as out-of-tree
> modules (i.e., they get to fix the breakage).
> 
> The reason I'm proposing to add these is that I'm about to add a subnode
> of scfg with a reg property, and if possible I'd like to avoid the
> somewhat clumsy
> 
>   reg = <0 0x1ac 0 4>;

Ah, apparently I've misunderstood how address-cells/size-cells worked; I
thought they would be taken from the nearest ancestor node specifying
them, so that 2/2 would apply to scfg. But it seems they have to be
present in the parent node itself, otherwise defaulting to 2/1. So the
above should be <0 0x1ac 4>, which is still clumsier than needed.

Rasmus
