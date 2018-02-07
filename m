Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754227AbeBGOcV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:32:21 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16191 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753923AbeBGOcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:32:19 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 07 Feb 2018 06:33:01 -0800
Date: Wed, 7 Feb 2018 16:32:13 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH v3 01/11] regulator: core: add API to get voltage
 constraints
Message-ID: <20180207143213.GB5850@tbergstrom-lnx.Nvidia.com>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
 <1517934852-23255-2-git-send-email-pdeschrijver@nvidia.com>
 <20180206163544.GI5681@sirena.org.uk>
 <20180207084744.GG7031@tbergstrom-lnx.Nvidia.com>
 <20180207104351.GA6003@sirena.org.uk>
 <20180207123750.GA5850@tbergstrom-lnx.Nvidia.com>
 <20180207141846.GC6003@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180207141846.GC6003@sirena.org.uk>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To UKMAIL101.nvidia.com
 (10.26.138.13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 02:18:46PM +0000, Mark Brown wrote:
> On Wed, Feb 07, 2018 at 02:37:51PM +0200, Peter De Schrijver wrote:
> > On Wed, Feb 07, 2018 at 10:43:51AM +0000, Mark Brown wrote:
> > > On Wed, Feb 07, 2018 at 10:47:44AM +0200, Peter De Schrijver wrote:
> > > > On Tue, Feb 06, 2018 at 04:35:44PM +0000, Mark Brown wrote:
> > > > > On Tue, Feb 06, 2018 at 06:34:02PM +0200, Peter De Schrijver wrote:
> 
> > > > > > Add API to get min/max rail voltage configured from platform for
> > > > > > given rails.
> 
> > > > > because...
> 
> > > > of the next patch where this is used to retrieve the minimum rail voltage.
> 
> > > And that in turn is needed for...?
> 
> > To calculate the required voltage for each frequency.
> 
> You're going to have to provide a much better explanation of what this
> is doing - right now it seems like an abuse of constraints.  Client
> drivers can already determine if a particular voltage they want to set
> is available via regulator_list_voltage() and so on, that's what
> constraints are there to set.  It sounds like you're trying to use them
> for something else but you're really not explaining your use case
> clearly.

There is no way to query what voltage I will actually get for a given input
voltage. If you read drivers/clk/tegra/cvb. (you did do that right?), you
will see that there is a minimum and maximum voltage defined by
charaterization which needs to be capped to the regulator generated voltages
for those points.

Peter.
