Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933109AbeBVPyg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:54:36 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:40819 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933000AbeBVPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:54:34 -0500
Date: Thu, 22 Feb 2018 16:54:14 +0100
From: Simon Horman <horms@verge.net.au>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: jacopo mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/19] ARM64: dts: r8a77965: Add EtherAVB device node
Message-ID: <20180222155411.gnn42poawtlf3rze@verge.net.au>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-20-git-send-email-jacopo+renesas@jmondi.org>
 <cf157266-5ea7-6795-1e31-0d1ccf85e7e8@cogentembedded.com>
 <20180221100716.GF7203@w540>
 <cbeb1b6b-1b02-7665-0f1f-847ab8de69e3@cogentembedded.com>
 <20180221173106.vgyshbz3kkc4p3cu@verge.net.au>
 <321c6c8c-8853-ac00-7567-c0be82b510f4@cogentembedded.com>
 <35959135-cb3b-040a-1944-26845e0c07b0@cogentembedded.com>
 <20180221182340.wvdvgtv5pw7pvd3v@verge.net.au>
 <eaf3c72b-a482-86cf-88e7-4af457f74558@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaf3c72b-a482-86cf-88e7-4af457f74558@cogentembedded.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 09:53:58PM +0300, Sergei Shtylyov wrote:
> On 02/21/2018 09:23 PM, Simon Horman wrote:
> 
> > ...
> > 
> >>>>>>>> +			clocks = <&cpg CPG_MOD 812>;
> >>>>>>>> +			power-domains = <&sysc 32>;
> >>>>>>>> +			resets = <&cpg 812>;
> >>>>>>>> +			phy-mode = "rgmii-txid";
> >>>>>>>
> >>>>>>>    Why not just "rgmii"? TX delay is a board specific detail, no?
> >>>>>>>
> >>>>>> I admit I took this one straight from r8a7796 dtsi.
> >>>>>> Would you like to me resend and change this?
> >>>>>
> >>>>>    Yes, unless Simon would fix it while merging...
> >>>>
> >>>> Can I confirm the desired change is s/rgmii-txid/rgmii/ ?
> >>>
> >>>    Yes.
> >>
> >>    Apparently that means that this prop should be overridden in the board file
> >> (which may not be an easy task given the board is Salvator-XS again).
> >>
> >> [...]
> > 
> > Can we override it in r8a77965-salvator-x.dts or r8a77965-salvator-xs.dts?
> 
>    In salvator-common.dtsi most probably -- it has the PHY data for Ether AVB.
> 
> > I feel that I'm missing an important point here.
> 
>    Well, r8a779{5|6}.dtsi also have phy-mode = "rgmii-txid" (which was
>    unjustified in my current understanding). Thus such board override
>    wouldn't hurt them. But we lack a patch modifying salvator-common.dtsi
>    in htis series, so I'm now thinking a respin of this series is needed
>    anyway... sorry for being unclear. :-)

While I've applied other patches in this series I have
not applied this one - mainly to allow this discussion to conclude.

Is an appropriate solution to do the following?

1) Atomically update
   a) r8a779{5|6}.dtsi to use "rgmii" and
   b) salvator-common.dtsi to use "rgmii-txid"
2) Update this patch to use "rgmii"

Sorry if I'm still missing the point.
