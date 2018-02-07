Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754569AbeBGPU4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:20:56 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17616 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754417AbeBGPUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:20:52 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 07 Feb 2018 07:20:51 -0800
Date: Wed, 7 Feb 2018 17:20:45 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH v3 01/11] regulator: core: add API to get voltage
 constraints
Message-ID: <20180207152045.GC5850@tbergstrom-lnx.Nvidia.com>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
 <1517934852-23255-2-git-send-email-pdeschrijver@nvidia.com>
 <20180206163544.GI5681@sirena.org.uk>
 <20180207084744.GG7031@tbergstrom-lnx.Nvidia.com>
 <20180207104351.GA6003@sirena.org.uk>
 <20180207123750.GA5850@tbergstrom-lnx.Nvidia.com>
 <20180207141846.GC6003@sirena.org.uk>
 <20180207143213.GB5850@tbergstrom-lnx.Nvidia.com>
 <20180207150155.GD6003@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180207150155.GD6003@sirena.org.uk>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL101.nvidia.com
 (10.26.138.13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 03:01:55PM +0000, Mark Brown wrote:
> On Wed, Feb 07, 2018 at 04:32:13PM +0200, Peter De Schrijver wrote:
> > On Wed, Feb 07, 2018 at 02:18:46PM +0000, Mark Brown wrote:
> 
> > > You're going to have to provide a much better explanation of what this
> > > is doing - right now it seems like an abuse of constraints.  Client
> > > drivers can already determine if a particular voltage they want to set
> > > is available via regulator_list_voltage() and so on, that's what
> > > constraints are there to set.  It sounds like you're trying to use them
> > > for something else but you're really not explaining your use case
> > > clearly.
> 
> > There is no way to query what voltage I will actually get for a given input
> 
> I looked at patch 2.  It looked like an abuse of what constraints do,
> and had zero explanation of why it was doing what it was doing.  In any
> case we need the regulator code and changelog to be clear about what the
> interface is for and why it should be used, that's not happening here.
> 
> > voltage. If you read drivers/clk/tegra/cvb. (you did do that right?), you
> > will see that there is a minimum and maximum voltage defined by
> > charaterization which needs to be capped to the regulator generated voltages
> > for those points.
> 
> I can't really tell what you're saying here.  If the driver needs to
> know if it can set the a given voltage there's already an API for doing
> that as I said.  If you're trying to convey this minimum and maximum
> voltage via the constraints that sounds like an abuse of the constraints.


No, what I want is the voltage which the regulator will output for a given
regulator_set_voltage request taking constraints, regulator step etc into
account.

Peter.
