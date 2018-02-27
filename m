Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeB0Ifa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 03:35:30 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:54717 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752012AbeB0If2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 03:35:28 -0500
Date: Tue, 27 Feb 2018 09:35:09 +0100
From: Simon Horman <horms@verge.net.au>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] R-Car M3-N: Enable EtherAVB device node
Message-ID: <20180227083509.6qrp2g3wstq7j24x@verge.net.au>
References: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdXwxhT7MP5xs3HLP3oFX+V9rhCM5jQycXUiCyBOKOUg1Q@mail.gmail.com>
 <20180227082838.GA23738@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227082838.GA23738@w540>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 09:28:38AM +0100, jacopo mondi wrote:
> Hi Geert,
> 
> On Mon, Feb 26, 2018 at 07:28:47PM +0100, Geert Uytterhoeven wrote:
> > Hi Jacopo,
> >
> > On Mon, Feb 26, 2018 at 6:57 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > >   as discussed with you Sergei and Geert, in order to enable EtherAVB for
> > > R8A77965 we first wanted to make the phy-mode "rgmii-txid" a board specific
> > > property for all other SoCs.
> >
> > Thanks for your series!
> >
> > > This series adds  the phy-mode property to salvator-common.dtsi and reset the
> > > one for R8A77965/R8A7796/R8A77995 to "rgmii".
> >
> > I forgot that r8a7795.dtsi and r8a7796.dtsi are used for the ULCB boards, too.
> > So to avoid regressions, you need to make a similar change to ulcb.dtsi like you
> > made for salvator-common.dtsi.
> >
> > In addition, r8a77995.dtsi is only used for the Draak board.
> > So you have to update r8a7795-draak.dtsi first, too.
> 
> Of course! I forgot about ULCB (and had a patch for Draak I lost while
> rebasing :/ )
> >
> > > Then, in order to enable EtherAVB for R-Car M3-N, iommu nodes had to be added
> > > as they are referenced by the "avb" device node (CC the iommu list for the
> > > series for that reason).
> >
> > I don't think we need the iommu properties and nodes at this early stage.
> > Ethernet works fine without them. Simon, do you agree?
> 
> I'll wait for Simon reply and then resend, possibly without iommu and
> ULCB and Draak patches!

I don't feel strongly about this but I don't think iommu is a strict
dependency of enabling Ethernet and I think its good not to include extra
dependencies - if it was me I'd try to get Ethernet accepted then follow-up
on iommu.
