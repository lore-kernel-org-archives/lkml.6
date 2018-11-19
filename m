Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E85C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4A020831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4A020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbeKTBpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:45:36 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49918 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729483AbeKTBpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:45:36 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 639D320791; Mon, 19 Nov 2018 16:21:40 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0C49A2037D;
        Mon, 19 Nov 2018 16:21:30 +0100 (CET)
Date:   Mon, 19 Nov 2018 16:21:27 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        tpiepho@impinj.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH 2/2] dt-binding: spi: Document Renesas R-Car RPC
 controller bindings
Message-ID: <20181119162127.71d0665d@bbrezillon>
In-Reply-To: <4c0683d3-fe9d-5a10-6f5c-4774024cb12a@gmail.com>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
        <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
        <629a5d6f-5c13-9b24-1c21-461d09f1aa8a@gmail.com>
        <20181119151009.490413d9@bbrezillon>
        <b22b9bb3-17e3-1971-6986-33132c5ae232@gmail.com>
        <20181119154338.2dfa7a5a@bbrezillon>
        <4c0683d3-fe9d-5a10-6f5c-4774024cb12a@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 16:12:41 +0100
Marek Vasut <marek.vasut@gmail.com> wrote:

> On 11/19/2018 03:43 PM, Boris Brezillon wrote:
> > On Mon, 19 Nov 2018 15:14:07 +0100
> > Marek Vasut <marek.vasut@gmail.com> wrote:
> >   
> >> On 11/19/2018 03:10 PM, Boris Brezillon wrote:  
> >>> On Mon, 19 Nov 2018 14:49:31 +0100
> >>> Marek Vasut <marek.vasut@gmail.com> wrote:
> >>>     
> >>>> On 11/19/2018 11:01 AM, Mason Yang wrote:    
> >>>>> Document the bindings used by the Renesas R-Car D3 RPC controller.
> >>>>>
> >>>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> >>>>> ---
> >>>>>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 33 ++++++++++++++++++++++
> >>>>>  1 file changed, 33 insertions(+)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> >>>>> new file mode 100644
> >>>>> index 0000000..8286cc8
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> >>>>> @@ -0,0 +1,33 @@
> >>>>> +Renesas R-Car D3 RPC controller Device Tree Bindings
> >>>>> +----------------------------------------------------
> >>>>> +
> >>>>> +Required properties:
> >>>>> +- compatible: should be "renesas,rpc-r8a77995"
> >>>>> +- #address-cells: should be 1
> >>>>> +- #size-cells: should be 0
> >>>>> +- reg: should contain 2 entries, one for the registers and one for the direct
> >>>>> +       mapping area
> >>>>> +- reg-names: should contain "rpc_regs" and "dirmap"
> >>>>> +- interrupts: interrupt line connected to the RPC SPI controller      
> >>>>
> >>>> Do you also plan to support the RPC HF mode ? And if so, how would that
> >>>> look in the bindings ?    
> >>>
> >>> Not sure this approach is still accepted, but that's how we solved the
> >>> problem for the flexcom block [1].
> >>>
> >>> [1]https://elixir.bootlin.com/linux/v4.20-rc3/source/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt    
> >>
> >> That looks pretty horrible.
> >>
> >> In U-Boot we check whether the device hanging under the controller node
> >> is JEDEC SPI flash or CFI flash and based on that decide what the config
> >> of the controller should be (SPI or HF). Not sure that's much better,but
> >> at least it doesn't need extra nodes which do not really represent any
> >> kind of real hardware.
> >>  
> > 
> > The subnodes are not needed, you can just have a property that tells in
> > which mode the controller is supposed to operate, and the MFD would
> > create a sub-device that points to the same device_node.  
> 
> Do you even need a dedicated property ? I think you can decide purely on
> what node is hanging under the controller (jedec spi nor or cfi nor).

Yes, that could work if they have well-known compatibles. As soon as
people start using flash-specific compats (like some people do for
their SPI NORs) it becomes a maintenance burden.

> 
> > Or we can have
> > a single driver that decides what to declare (a spi_controller or flash
> > controller), but you'd still have to decide where to place this
> > driver...  
> 
> I'd definitely prefer a single driver.
> 

Where would you put this driver? I really don't like the idea of having
MTD drivers spread over the tree. Don't know what's Mark's opinion on
this matter.
