Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeBBLIU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 06:08:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58052 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbeBBLIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 06:08:13 -0500
Date: Fri, 2 Feb 2018 11:08:08 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Channa <ckadabi@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, sboyd@codeaurora.org, kyan@codeaurora.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Documentation for qcom,llcc
Message-ID: <20180202110808.nnrawjhyvz273em3@lakrids.cambridge.arm.com>
References: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org>
 <1516924513-20183-2-git-send-email-ckadabi@codeaurora.org>
 <20180201104808.rxgqcrlsevtotq55@lakrids.cambridge.arm.com>
 <2c343b57bf3ee8aeb3338aee0d27dc06@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c343b57bf3ee8aeb3338aee0d27dc06@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 12:47:01PM -0800, Channa wrote:
> On 2018-02-01 02:48, Mark Rutland wrote:
> > On Thu, Jan 25, 2018 at 03:55:12PM -0800, Channagoud Kadabi wrote:
> > > Documentation for last level cache controller device tree bindings,
> > > client bindings usage examples.
> > > 
> > > Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> > > ---
> > >  .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 93
> > > ++++++++++++++++++++++
> > >  1 file changed, 93 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> > > 
> > > +Example:
> > > +
> > > +	qcom,system-cache@1300000 {
> > > +		compatible = "qcom,llcc-core", "syscon", "simple-mfd";
> > > +		reg = <0x1300000 0x50000>;
> > > +		reg-names = "llcc_base";
> > > +
> > > +		llcc: qcom,sdm845-llcc {
> > > +			compatible = "qcom,sdm845-llcc";
> > > +			#cache-cells = <1>;
> > > +			max-slices = <32>;
> > > +		};
> > > +
> > > +		qcom,llcc-ecc {
> > > +			compatible = "qcom,llcc-ecc";
> > > +		};
> > > +
> > > +		qcom,llcc-amon {
> > > +			compatible = "qcom,llcc-amon";
> > > +			qcom,fg-cnt = <0x7>;
> > > +		};
> > > +
> > > +	};
> > 
> > The "qcom,llcc-ecc" and "qcom,llcc-amon" bindings doesn't seem to be
> > used by the driver in patch 2, and it's not clear how they are intended
> > to be used, so I think they should go from the binding for now.
> 
> Sure I can remove them for now and add them when the I push other drivers
> for review.
> 
> > I don't think you need syscon and simple-mfd, and I think you can
> 
> I used syscon and simple-mfd because three drivers touch the same address
> space.

As in my other reply, I don't think that's the right way to solve the
problem.

Please have one top-level driver and associated binding. That driver can
carve up the functional units and allow other drivers to access the
registers as necessary.

Thanks,
Mark.
