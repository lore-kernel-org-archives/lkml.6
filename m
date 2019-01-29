Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F13C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514A02175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548782474;
	bh=PyKtQ7qC0wxh867jSDYtEOMZFEMPUvSYGi3ho30F6nw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lHqb3dW7gH4U7nx7S/boBP8YugxngtOmNNYACZAuv2bX3WZjLxUKeuTzAZJmquyV2
	 j0fBeFD//qNtiDPLvcfPUmoqk5TvV7hJ0MrRL6S4o/8Ny3sq3yYRT+Rg9CV1AmGAOf
	 jxJg6CRn9ziO0Lzarnq1I7n9XTMUNDmalNoVlI98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfA2RVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:21:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfA2RVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:21:12 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27A402087E;
        Tue, 29 Jan 2019 17:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548782471;
        bh=PyKtQ7qC0wxh867jSDYtEOMZFEMPUvSYGi3ho30F6nw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TKYbqiFIxy6BaIUEB492tU9Zc1c3Kt5rbDZYPNfIRtowMevK7x2MVXWJl9Dg9/cm4
         xqqDWu09wDkgzwpMxUQ6aphNy6jdbMlIg4CPwovsqjAL2DnLQM0lUCADN7P1iZvKE8
         Qr1Iw35jjnmyo7Fe+zHnTvwIwfFHNnjan5pSrp10=
Date:   Tue, 29 Jan 2019 18:21:00 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        BrianNorris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: nand: Add Cadence NAND controller
 driver
Message-ID: <20190129182100.2fcb4e9f@bbrezillon>
In-Reply-To: <20190129161040.20299-1-piotrs@cadence.com>
References: <20190129160337.24350-1-piotrs@cadence.com>
        <20190129161040.20299-1-piotrs@cadence.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

On Tue, 29 Jan 2019 16:10:40 +0000
Piotr Sroka <piotrs@cadence.com> wrote:

> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
>  .../devicetree/bindings/mtd/cadence-nand.txt       | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand.txt b/Documentation/devicetree/bindings/mtd/cadence-nand.txt
> new file mode 100644
> index 000000000000..82afa34d5652
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/cadence-nand.txt
> @@ -0,0 +1,35 @@
> +* Cadence NAND controller
> +
> +Required properties:
> +  - compatible : "cdns,hpnfc-nand"

"nfc" already means nand flash controller, no need to suffix it with
-nand, "cdns,hpnfc" should be enough. 

> +  - reg : Contains two entries, each of which is a tuple consisting of a
> +	  physical address and length. The first entry is the address and
> +	  length of the controller register set. The second entry is the
> +	  address and length of the Slave DMA data port.

Please name the register ranges.

> +  - interrupts : The interrupt number.
> +  - clocks: phandle of the controller core clock (nf_clk).
> +
> +Optional properties:
> +Driver calculates controller timings base on NAND flash memory timings and
> +the following delays in picoseconds.
> +  - cdns,if-skew : Skew value of the output signals of the NAND Flash interface
> +  - cdns,nand2-delay : Delay value of one NAND2 gate from which
> +    the delay element is build
> +  - cdns,board-delay : Estimated Board delay. The value includes the total
> +    round trip delay for the signals and is used for deciding on values
> +    associated with data read capture. The example formula for SDR mode is
> +    the following:
> +    board_delay = RE#PAD_delay + PCB trace to device + PCB trace from device
> +    + DQ PAD delay

The unit of those props is not defined, and if possible I'd like to
avoid specifying custom timing adjustment values in the DT. Looks like
some of these values are SoC specific (depends on the integration of
this IP in a SoC) and others are board specific. For SoC specific
values, this should be attached to the SoC specific compatible at the
driver level. For board-specific values, I'd prefer to have a generic
way to describe boards constraints. 

Please point to the generic bindings to describe NAND chip
representation under the NAND controller node.

> +
> +Example
> +
> +nand: nand@60000000 {

nand_controller: nand-controller@60000000 { 

> +	  compatible = "cdns,hpnfc-nand";
> +	  reg = <0x60000000 0x10000>, <0x80000000 0x10000>;
> +	  clocks = <&nf_clk>;
> +	  cdns,if-skew = <50>;
> +	  cdns,nand2-delay = <37>;
> +	  cdns,board-delay = <4830>;
> +	  interrupts = <2 0>;

Add a NAND chip in the example.

> +};

Regards,

Boris
