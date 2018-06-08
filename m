Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fwycK7JhGlufFAAAmS7hNA
	; Fri, 08 Jun 2018 11:00:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6C6EE607E4; Fri,  8 Jun 2018 11:00:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vpOU3ntB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BC1D5602FC;
	Fri,  8 Jun 2018 11:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC1D5602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeFHLAY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:00:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57920 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeFHLAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:00:22 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D998057;
        Fri,  8 Jun 2018 13:00:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1528455619;
        bh=4Vv6Nh1VzCheYZ2isn5rXBZ0FVK/rRbwXwpv6m8Aoc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vpOU3ntBpsV4hsdc4Cy2Q49YrANsL5xtUiu5EOHPH/bdLcjo7//8LLB1/WeYZ3+A6
         A4MI8TWDORL11dF9HbDComdQ8Epap9D5TQmqI19TrUBJTkMVk5Zt3rv1ALuHGarMnx
         SwpLskjvOyw4AMdCDvdwqaymZFIynwCnyhhYxIqU=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 11/17] arm64: dts: r8a77965: Add VSP instances
Date: Fri, 08 Jun 2018 14:00:36 +0300
Message-ID: <7269469.ESYJcRDGIc@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAMuHMdU7OyUvgNqbkjtHyb0LPjgTdPp_BBcGNbjiqfQUgCdMuw@mail.gmail.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com> <1787243.JuNJAuBqMb@avalon> <CAMuHMdU7OyUvgNqbkjtHyb0LPjgTdPp_BBcGNbjiqfQUgCdMuw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Friday, 8 June 2018 12:29:29 EEST Geert Uytterhoeven wrote:
> On Thu, Apr 26, 2018 at 11:11 PM, Laurent Pinchart wrote:
> > On Thursday, 26 April 2018 19:53:40 EEST Kieran Bingham wrote:
> >> The r8a77965 has 4 VSP instances.
> >> 
> >> Based on a similar patch of the R8A7796 device tree
> >> by Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>.
> >> 
> >> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >> [Kieran: Rebased to top of tree, fixed sort orders]
> >> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> >> ---
> >> 
> >>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 44 +++++++++++++++++++++++
> >>  1 file changed, 44 insertions(+)
> >> 
> >> diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> >> b/arch/arm64/boot/dts/renesas/r8a77965.dtsi index
> >> 1f44ed7c1b1c..e92e6b03333a 100644
> >> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> >> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> >> @@ -1025,6 +1047,17 @@
> >>                       resets = <&cpg 611>;
> >>               };
> >> 
> >> +             vspd0: vsp@fea20000 {
> >> +                     compatible = "renesas,vsp2";
> >> +                     reg = <0 0xfea20000 0 0x4000>;
> > 
> > RFP2 has a CLUT so the register range needs to be extended. I'd recommend
> > covering the entire space (0x8000) even if no LUT or CLU module is
> > present.
> 
> Even on V3H/V3M, which have some part of the CLUT, and could do
> with 0x5000?
> 
> Note that this makes it overlap with fcpvd0 on all R-Car Gen3 SoCs,
> as mentioned by Simon on IRC.

My bad :-/ I'll submit fixes shortly.

> >> +                     interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
> >> +                     clocks = <&cpg CPG_MOD 623>;
> >> +                     power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
> >> +                     resets = <&cpg 623>;
> >> +
> >> +                     renesas,fcp = <&fcpvd0>;
> >> +             };
> >> +
> >>               fcpvd0: fcp@fea27000 {
> >>                       compatible = "renesas,fcpv";
> >>                       reg = <0 0xfea27000 0 0x200>;

-- 
Regards,

Laurent Pinchart
