Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeE1C1E (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 22:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752970AbeE1C1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 22:27:02 -0400
Date: Mon, 28 May 2018 10:26:54 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
Message-ID: <20180528022652.GA3143@dragon>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
 <20180224074543.GF3217@dragon>
 <20180226134741.neqkpge33zo3pfzt@earth.universe>
 <20180227011033.GV3217@dragon>
 <20180227101712.3zwobvs4ox4jchcj@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227101712.3zwobvs4ox4jchcj@earth.universe>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 11:17:12AM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Feb 27, 2018 at 09:10:34AM +0800, Shawn Guo wrote:
> > On Mon, Feb 26, 2018 at 02:47:41PM +0100, Sebastian Reichel wrote:
> > > On Sat, Feb 24, 2018 at 03:45:44PM +0800, Shawn Guo wrote:
> > > > On Mon, Feb 12, 2018 at 01:39:44PM +0100, Sebastian Reichel wrote:
> > > > > On i.MX53 it is necessary to set the DBG_EN bit in the
> > > > > platform GPC register to enable access to PMU counters
> > > > > other than the cycle counter.
> > > > > 
> > > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > > > > ---
> > > > >  arch/arm/mach-imx/mach-imx53.c | 39 ++++++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 38 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> > > > > index 07c2e8dca494..658e28604dca 100644
> > > > > --- a/arch/arm/mach-imx/mach-imx53.c
> > > > > +++ b/arch/arm/mach-imx/mach-imx53.c
> > > > > @@ -28,10 +28,47 @@ static void __init imx53_init_early(void)
> > > > >  	mxc_set_cpu_type(MXC_CPU_MX53);
> > > > >  }
> > > > >  
> > > > > +#define MXC_CORTEXA8_PLAT_GPC 0x63fa0004
> > > > 
> > > > The base address should be retrieved from device tree.
> > > 
> > > DT has no entry for 0x63fa0000-0x63fa3fff. iMX53 TRM lists it as "ARM Platform"
> > > with 8 platform specific 32 bit registers. Do you think it's worth the trouble
> > > adding a new binding? Do you have a suggestion for a compatible value?
> > 
> > Looking at it more closely, I feel that patching every single platform
> > which needs to set up additional register for secure-reg-access support
> > doesn't really scale.  Can we have pmu driver do it with a phandle in
> > DT pointing to the register and bit that need to be configured?
> 
> The PMU driver used to have a feature for initialising platform
> specific bits, but it is currently being removed to make the PMU
> code more maintainable. My understanding is, that it's very uncommon
> to require platform specific setup to get secure-reg-access working.
> I.e. it is not needed for newer iMX platforms.

Are you saying this is a very specific setup required by i.MX53 only?
In that case, I can live with it.

Shawn
