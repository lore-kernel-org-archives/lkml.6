Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeCLJKo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:10:44 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8004 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeCLJKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:10:42 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 12 Mar 2018 02:10:41 -0700
Date: Mon, 12 Mar 2018 11:10:36 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/11] dt-bindings: tegra: Update DFLL binding for PWM
 regulator
Message-ID: <20180312091036.GR6190@tbergstrom-lnx.Nvidia.com>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
 <1517934852-23255-8-git-send-email-pdeschrijver@nvidia.com>
 <c747bc00-8c04-c297-e945-784e45655421@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c747bc00-8c04-c297-e945-784e45655421@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To UKMAIL101.nvidia.com
 (10.26.138.13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 11:21:40PM +0000, Jon Hunter wrote:
> 
> On 06/02/18 16:34, Peter De Schrijver wrote:
> > Add new properties to configure the DFLL PWM regulator support. Also
> > add an example and make the I2C clock only required when I2C support is
> > used.
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> >  .../bindings/clock/nvidia,tegra124-dfll.txt        | 76 +++++++++++++++++++++-
> >  1 file changed, 74 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> > index dff236f..a4903f7 100644
> > --- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> > +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> > @@ -23,7 +23,8 @@ Required properties:
> >  - clock-names: Must include the following entries:
> >    - soc: Clock source for the DFLL control logic.
> >    - ref: The closed loop reference clock
> > -  - i2c: Clock source for the integrated I2C master.
> > +  - i2c: Clock source for the integrated I2C master (only required when
> > +	 using I2C mode).
> >  - resets: Must contain an entry for each entry in reset-names.
> >    See ../reset/reset.txt for details.
> >  - reset-names: Must include the following entries:
> > @@ -45,10 +46,28 @@ Required properties for the control loop parameters:
> >  Optional properties for the control loop parameters:
> >  - nvidia,cg-scale: Boolean value, see the field DFLL_PARAMS_CG_SCALE in the TRM.
> >  
> > +Optional properties for mode selection:
> > +- nvidia,pwm-to-pmic: Use PWM to control regulator rather then I2C.
> > +
> 
> Do we need this property? Seems that we should be able to detect if it
> is I2C or PWM based upon the other properties.
> 

I guess we could look for nvidia,pwm-period and switch to PWM mode if this is
found, but I think it's more clear to have explicit property.

Peter.
