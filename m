Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeBIC6q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 21:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:46566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752111AbeBIC6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 21:58:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80B32173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Fri, 9 Feb 2018 10:58:18 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: stefan@agner.ch
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.oss.09@gmail.com, marcel.ziswiler@toradex.com
Subject: Re: [PATCH v2] ARM: dts: imx6ull: add Toradex Colibri iMX6ULL support
Message-ID: <20180209025817.GJ31910@dragon>
References: <20180206164903.24913-1-stefan@agner.ch>
 <20180208074730.GF31910@dragon>
 <e441573ee4f3b66fc39ffce2a4fb7a04@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e441573ee4f3b66fc39ffce2a4fb7a04@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 10:25:47AM +0100, stefan@agner.ch wrote:
> On 08.02.2018 08:47, Shawn Guo wrote:
> > On Tue, Feb 06, 2018 at 05:49:03PM +0100, Stefan Agner wrote:
> >> Add support for the Computer on Module Colibri iMX6ULL and its
> >> Bluetooth/Wifi variant along with the development/evaluation carrier
> >> board device trees. Follow the usual hierarchic include model,
> >> maintaining shared configuration in imx6ull-colibri.dtsi and
> >> imx6ull-colibri-eval-v3.dtsi respectively.
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >> This depends on the following patchsets work:
> >> - https://lkml.org/lkml/2018/1/6/129 (applied)
> >> - https://lkml.org/lkml/2018/1/10/998 (applied)
> >> - https://www.spinics.net/lists/arm-kernel/msg632671.html (pending, required)
> >> - https://lkml.org/lkml/2018/1/18/850 (only for highest CPU frequency)
> > 
> > So the only dependency is the cpufreq change now.  So we have two
> > options:
> > 
> > 1. Hold the patch until the cpufreq change appear on my tree.  That
> >    will require us wait for another release cycle.
> > 
> > 2. Drop the highest CPU frequency, so that we can apply the patch right
> >    away, and add that setpoint after dependant cpufreq change lands
> >    mainline.
> 
> The way cpufreq currently works is that for everything higher than
> 396MHz it just will set the CPU parent to pll2_bus_clk which can go up
> to 528MHz. Also voltage should be within operation range even for
> 528MHz.
> 
> So I think we can safely merge the current device tree.

Okay, thanks for the info.  Patch applied.

Shawn
