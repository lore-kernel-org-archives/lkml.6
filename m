Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967024AbeCAJfT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:35:19 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:56221 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966675AbeCAJfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:35:14 -0500
Date: Thu, 1 Mar 2018 10:35:10 +0100
From: Simon Horman <horms@verge.net.au>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/2] arm: Support for Renesas RZ/N1D (R9A06G032)
Message-ID: <20180301093505.2wib5uzsxrhut3tm@verge.net.au>
References: <1519647518-15579-1-git-send-email-michel.pollet@bp.renesas.com>
 <HK2PR0601MB1393B2D7E0C96590482C3726F5C00@HK2PR0601MB1393.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR0601MB1393B2D7E0C96590482C3726F5C00@HK2PR0601MB1393.apcprd06.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 01:10:36PM +0000, Phil Edworthy wrote:
> Hi Simon,
> 
> On 26 February 2018, Michel Pollet wrote:
> > 
> > This series adds the plain basic support for booting a bare
> > kernel on the RZ/N1D-DB Board. It's been trimmed to the strict
> > minimum as a 'base', further patches that will add the
> > rest of the support, pinctrl, clock architecture and quite
> > a few others.

Thanks Michel,

I am of course very happy to see support for new SoCs and boards added
to upstream and I support such efforts as best I can. However, the pattern
followed by this patchset adds a new board file. This was the common
practice some time ago but it is now upstream policy not to accept new
board files. Rather, drivers should be developed and hardware should be
described in DT. So I believe support for RZ/N1D needs to be reworked
to that end in order to be accepted upstream.

I also believe that the patches in this series are rather large.  Its much
better to submit small incremental patches for review. This allows much
smoother iteration over patch review cycles. Patches also need to be split
up so that C-code changes,  DT and ideally documentation changes are not
mixed in the same patch unless necessary. You can find examples of this on
the linux-renesas-soc mailing list.

And lastly, the use of RZN1_IRQ_* macros in the DT file does not
follow the current best practice of using numeric constants for
values derived from documentation.

Please consider reworking this patchset, I look forward
so seeing RZ/N1D support upstream some time soon.

> I spoke to Magnus about helping to get the RZ/N1 patches upstream.
> We're trying to sort out making the device manual and board schematics
> available, hopefully it won't take too long. We're also trying to sort out
> access to a board... that might take a bit longer.
> 
> btw, what do you want to do about shmobile_defconfig? Should we add
> any changes needed for RZ/N1 to it? Note that only one IP block is the
> same as R-Car.

Hi Phil,

In general I believe that the upstream policy is not to accept new
defconfigs. So my suggestion would be to expand shmobile_defconfig
if the result it produces a working kernel for both already supported
boards and the RZ/N1D-DB Board. Otherwise we need to consider what
other options we have.
