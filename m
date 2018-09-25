Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8259DC004D1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465BB214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPSjRWIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465BB214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbeIYWXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728917AbeIYWXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:23:25 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA59D21502;
        Tue, 25 Sep 2018 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537892112;
        bh=BhgRYD1jWVXvZlcqbCfzQeSB1cmxx2WlhubA0bMflOM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JPSjRWIJn4TyBaZ29oEFZ427Bpb3DdLULbaehUHQQM8lpUlGxxSIVxpYMEQVJxnx5
         SJXcC1dS0mGcNZdt8FmPNgHealp/Uk4aw2ruS6Hi46ifjRqTLY7je+PCiOCJ7Cbiif
         9O7BwEeqX82NiuWQIuHZZwNS/oGJP4bgriPr/T9A=
Received: by mail-qk1-f179.google.com with SMTP id n3-v6so13340118qkn.8;
        Tue, 25 Sep 2018 09:15:12 -0700 (PDT)
X-Gm-Message-State: ABuFfoi+ZX1B+3k/N10X7qqBJ1lghXDwSBftMJX7PIN1vQtnvOlIIPEU
        Cbx+o2WGH62Ugak2vdjl9bVBfqdE9OkVANly6Q==
X-Google-Smtp-Source: ACcGV63tdFTpWCNTeTbLP5MR7lyG9epfiDjokyrZY9IxWW6mlUAhaqy9nyQg6Qh0tvMgmOAkZwT5p+S1TLfM3ZR+Wt0=
X-Received: by 2002:a37:56c7:: with SMTP id k190-v6mr1201181qkb.29.1537892111810;
 Tue, 25 Sep 2018 09:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
 <1534447304-12919-2-git-send-email-jollys@xilinx.com> <20180820194628.GA26783@bogus>
 <CY1PR02MB2138C05E97C1EFAEA921CB5CB81A0@CY1PR02MB2138.namprd02.prod.outlook.com>
In-Reply-To: <CY1PR02MB2138C05E97C1EFAEA921CB5CB81A0@CY1PR02MB2138.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Sep 2018 11:15:00 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJOz_z9dHcG5dfx=UTXQMaLTQKBPu+vTrTOt=sdAabqSw@mail.gmail.com>
Message-ID: <CAL_JsqJOz_z9dHcG5dfx=UTXQMaLTQKBPu+vTrTOt=sdAabqSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Add ZynqMP power domain bindings
To:     Jolly Shah <JOLLYS@xilinx.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michal Simek <michals@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <RAJANV@xilinx.com>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 12:51 PM Jolly Shah <JOLLYS@xilinx.com> wrote:
>
> Hi Rob,
>
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: Monday, August 20, 2018 12:46 PM
> > To: Jolly Shah <JOLLYS@xilinx.com>
> > Cc: matthias.bgg@gmail.com; andy.gross@linaro.org; shawnguo@kernel.org;
> > geert+renesas@glider.be; bjorn.andersson@linaro.org;
> > sean.wang@mediatek.com; m.szyprowski@samsung.com; Michal Simek
> > <michals@xilinx.com>; mark.rutland@arm.com; Rajan Vaja
> > <RAJANV@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Rajan Vaja
> > <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> > Subject: Re: [PATCH v2 1/3] dt-bindings: power: Add ZynqMP power domain
> > bindings
> >
> > On Thu, Aug 16, 2018 at 12:21:42PM -0700, Jolly Shah wrote:
> > > From: Rajan Vaja <rajan.vaja@xilinx.com>
> > >
> > > Add documentation to describe ZynqMP power domain bindings.
> > >
> > > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > > ---
> > >  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 47
> > ++++++++++++++++++++++
> >
> > This should be with all the other power domain bindings.
> >
> > >  1 file changed, 47 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > > re.txt
> > > b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > > re.txt
> > > index d215d15..5fa10a0 100644
> > > ---
> > > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > > re.txt
> > > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-fi
> > > +++ rmware.txt
> > > @@ -64,6 +64,29 @@ Output clocks are registered based on clock
> > > information received  from firmware. Output clocks indexes are
> > > mentioned in  include/dt-bindings/clock/xlnx,zynqmp-clk.h.
> > >
> > > +-----------------------------------------------------------
> > > +Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
> > > +-----------------------------------------------------------
> > > +The binding for zynqmp-power-controller follow the common generic PM
> > > +domain binding[1].
> > > +
> > > +[1] Documentation/devicetree/bindings/power/power_domain.txt
> > > +
> > > +== Zynq MPSoC Generic PM Domain Node ==
> > > +
> > > +Required properties:
> > > + - compatible:     Must be: "xlnx,zynqmp-power-controller"
> > > +
> > > +This node contains a number of subnodes, each representing a single
> > > +PM domain that PM domain consumer devices reference.
> > > +
> > > +== PM Domain Nodes ==
> > > +
> > > +Required properties:
> > > + - #power-domain-cells:    Number of cells in a PM domain specifier. Must
> > be 0.
> > > + - pd-id:          Domain identifier as defined by platform firmware.
> > > +                   This identifier is passed to the PM firmware.
> >
> > Make this a cell for the power domain consumer.
> [Jolly] We have more than one Ids for GPU device. Also they don't have parent child relationship and hence are defined as flat hierarchy. (shown in example below)

Then the gpu node should have:

power-domains = <&pd 58 &pd 20 &pd 21>;

Also, for this and the firmware reset binding, there is no reason that
I see to make these all subnodes. A single firmware node can be a
provider of multiple functions. You only need child nodes if the
sub-functions have their own resources (clks, irqs, etc.). IOW, don't
create nodes just because you want to instantiate drivers that way. DT
is not the only way to instantiate devices for drivers.

Rob
