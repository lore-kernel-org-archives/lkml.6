Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426604AbeBOQwZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:52:25 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:51721 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426577AbeBOQwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:52:15 -0500
Date: Thu, 15 Feb 2018 17:52:11 +0100
From: Simon Horman <horms@verge.net.au>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ulrich Hecht <ulrich.hecht@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, geert@glider.be,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] arm64: dts: renesas: r8a77995-draak: Enable DU
Message-ID: <20180215165210.lsreissnzg4wxtgp@verge.net.au>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
 <1518683903-10681-7-git-send-email-kbingham@kernel.org>
 <6281511.bskcdgqsgb@avalon>
 <8b2c853c-2963-a116-a246-5fdb30b0688e@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b2c853c-2963-a116-a246-5fdb30b0688e@ideasonboard.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 02:30:28PM +0000, Kieran Bingham wrote:
> Hi Laurent, Simon,
> 
> On 15/02/18 14:12, Laurent Pinchart wrote:
> > Hi Kieran,
> > 
> > Thank you for the patch.
> > 
> > On Thursday, 15 February 2018 10:38:21 EET Kieran Bingham wrote:
> >> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> >>
> >> Enable the DU, providing only the VGA output for now.
> >>
> >> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > I assume Simon will take care of this patch.
> 
> That will be great, - One small caveat on this patch though:
> 
> 
> >> ---
> >>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 51 +++++++++++++++++++++++
> >>  1 file changed, 51 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> >> b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts index
> >> af07da240be0..668e246dfc5d 100644
> >> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> >> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> >> @@ -27,6 +27,38 @@
> >>  		stdout-path = "serial0:115200n8";
> >>  	};
> >>
> >> +	vga {
> >> +		compatible = "vga-connector";
> >> +
> >> +		port {
> >> +			vga_in: endpoint {
> >> +				remote-endpoint = <&adv7123_out>;
> >> +			};
> >> +		};
> >> +	};
> >> +
> >> +	vga-encoder {
> >> +		compatible = "adi,adv7123";
> >> +
> >> +		ports {
> >> +			#address-cells = <1>;
> >> +			#size-cells = <0>;
> >> +
> >> +			port@0 {
> >> +				reg = <0>;
> >> +				adv7123_in: endpoint {
> >> +					remote-endpoint = <&du_out_rgb>;
> >> +				};
> >> +			};
> >> +			port@1 {
> >> +				reg = <1>;
> >> +				adv7123_out: endpoint {
> >> +					remote-endpoint = <&vga_in>;
> >> +				};
> >> +			};
> >> +		};
> >> +	};
> >> +
> >>  	memory@48000000 {
> >>  		device_type = "memory";
> >>  		/* first 128MB is reserved for secure area. */
> >> @@ -46,6 +78,11 @@
> >>  		};
> >>  	};
> >>
> >> +	du_pins: du {
> >> +		groups = "du_rgb888", "du_sync", "du_disp", "du_dotclkout0";
> 
> The du_dotclkout0 is named differently in Uli's patch. (Of course I believe my
> version is correct, but there is some precedent set it would seem).
> 
> Anyway, If Uli's version of the PFC is accepted (Which I'm sure it will be),
> then I will have to re-spin this patch with the 'different' "du_clk_out_0" value
> in the groups.

Thanks, please repost once this has been shaken out.
