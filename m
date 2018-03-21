Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeCURNv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:13:51 -0400
Received: from mailoutvs4.siol.net ([213.250.19.137]:54515 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751319AbeCURNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:13:49 -0400
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: linux-sunxi@googlegroups.com, icenowy@aosc.io
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH 2/7] dt-bindings: add binding for the Allwinner A64 DE2 bus
Date: Wed, 21 Mar 2018 18:13:42 +0100
Message-ID: <2866474.lRHIcLtROC@jernej-laptop>
In-Reply-To: <AAC74653-C6EB-4BE3-BB19-210687C1E158@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io> <20180320184646.dynqv6qubzabroe4@flea> <AAC74653-C6EB-4BE3-BB19-210687C1E158@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Dne sreda, 21. marec 2018 ob 03:18:13 CET je Icenowy Zheng napisal(a):
> 于 2018年3月21日 GMT+08:00 上午2:46:46, Maxime Ripard <maxime.ripard@bootlin.com> 
写到:
> >On Sat, Mar 17, 2018 at 01:53:49AM +0800, Icenowy Zheng wrote:
> >> All the sub-blocks of Allwinner A64 DE2 needs the SRAM C on A64 SoC
> >
> >to
> >
> >> be claimed, otherwise the whole DE2 space is inaccessible.
> >> 
> >> Add a device tree binding of the DE2 part as a sub-bus.
> >
> >Where did you get the info that it was a bus?
> 
> There's no direct evidence, just some guess.
> 
> The DE2 is a whole part that is just allocated a memory
> space at the user manual, and the SRAM controls the
> access to all modules in the DE2.
> 
> So it might be a bus.
> 
> Implement it as a bus is a clear representation on A64.

Since there is already syscon for same mmio region, we migh as well use it 
when loading ccu-sun8i-de2 driver on A64.

Other options, like SRAM driver or bus driver, might better represent HW, but 
then we would have two DT nodes covering same mmio region, which I think is 
not really acceptable.

Any suggestions?

BTW, H6 has same design in this regard.

Best regards,
Jernej
