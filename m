Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeCZWXE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:23:04 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35354 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbeCZWXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:23:01 -0400
X-Google-Smtp-Source: AG47ELtvYw//tQWvYIoZH9D/e2s+ByJoOvmG52h/mzqOofpjJcP2thfnYnZpjtb5uD8v/+Zg0HEHkg==
Date: Mon, 26 Mar 2018 17:22:58 -0500
From: Rob Herring <robh@kernel.org>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: jernej.skrabec@siol.net, linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH 2/7] dt-bindings: add binding for the
 Allwinner A64 DE2 bus
Message-ID: <20180326222258.uxpgj4bk4pg56b7o@rob-hp-laptop>
References: <20180316175354.21437-1-icenowy@aosc.io>
 <20180320184646.dynqv6qubzabroe4@flea>
 <AAC74653-C6EB-4BE3-BB19-210687C1E158@aosc.io>
 <2866474.lRHIcLtROC@jernej-laptop>
 <9520BDDE-BFE3-4220-B48D-01A00CFA94DE@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9520BDDE-BFE3-4220-B48D-01A00CFA94DE@aosc.io>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 02:08:43PM +0800, Icenowy Zheng wrote:
> 
> 
> 于 2018年3月22日 GMT+08:00 上午1:13:42, "Jernej Škrabec" <jernej.skrabec@siol.net> 写到:
> >Hi all,
> >
> >Dne sreda, 21. marec 2018 ob 03:18:13 CET je Icenowy Zheng napisal(a):
> >> 于 2018年3月21日 GMT+08:00 上午2:46:46, Maxime Ripard
> ><maxime.ripard@bootlin.com> 
> >写到:
> >> >On Sat, Mar 17, 2018 at 01:53:49AM +0800, Icenowy Zheng wrote:
> >> >> All the sub-blocks of Allwinner A64 DE2 needs the SRAM C on A64
> >SoC
> >> >
> >> >to
> >> >
> >> >> be claimed, otherwise the whole DE2 space is inaccessible.
> >> >> 
> >> >> Add a device tree binding of the DE2 part as a sub-bus.
> >> >
> >> >Where did you get the info that it was a bus?
> >> 
> >> There's no direct evidence, just some guess.
> >> 
> >> The DE2 is a whole part that is just allocated a memory
> >> space at the user manual, and the SRAM controls the
> >> access to all modules in the DE2.
> >> 
> >> So it might be a bus.
> >> 
> >> Implement it as a bus is a clear representation on A64.
> >
> >Since there is already syscon for same mmio region, we migh as well use
> >it 
> >when loading ccu-sun8i-de2 driver on A64.
> >
> >Other options, like SRAM driver or bus driver, might better represent
> >HW, but 
> 
> I think the device tree should properly represent the HW,
> it's a basic requirment.
> 
> >then we would have two DT nodes covering same mmio region, which I
> >think is 
> >not really acceptable.
> 
> It's acceptable, and DE2 is not the only user of SRAM controller so far.

No, it's not acceptable. Don't create overlapping mmio regions in DT.

> 
> VE will also need a SRAM region to be claimed.
> 
> >
> >Any suggestions?
> >
> >BTW, H6 has same design in this regard.
> >
> >Best regards,
> >Jernej
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
