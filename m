Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92F7C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AF8218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfA3KXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:23:21 -0500
Received: from foss.arm.com ([217.140.101.70]:51780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbfA3KXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:23:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CC5EA78;
        Wed, 30 Jan 2019 02:23:20 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2B1C3F59C;
        Wed, 30 Jan 2019 02:23:17 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:23:13 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, mka@chromium.org
Subject: Re: [PATCH 6/7] arm64: dts: juno: Add cpu dynamic-power-coefficient
 information
Message-ID: <20190130102311.6ayym7bbo4lvlezl@queper01-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-7-quentin.perret@arm.com>
 <20190129152735.GA24772@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129152735.GA24772@e107155-lin>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 Jan 2019 at 15:27:35 (+0000), Sudeep Holla wrote:
> On Mon, Jan 28, 2019 at 04:55:21PM +0000, Quentin Perret wrote:
> > From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >
> > A CPUfreq driver, like the scpi driver used on Juno boards, which
> > provide the Energy Model with power cost information via the PM_OPP
> > of_dev_pm_opp_get_cpu_power() function, do need the
> > dynamic-power-coefficient (C) in the device tree.
> >
> > Method used to obtain the C value:
> > C is computed by measuring energy (E) consumption of a frequency domain
> > (FD) over a 10s runtime (t) sysbench workload running at each Operating
> > Performance Point (OPP) affine to 1 or 2 CPUs of that FD while the other
> > CPUs of the system are hotplugged out.
> > By definition all CPUs of a FD have the the same micro-architecture. An
> > OPP is characterized by a certain frequency (f) and voltage (V) value.
> > The corresponding power values (P) are calculated by dividing the delta
> > of the E values between the runs with 2 and 1 CPUs by t.
> >
> > With n data tuples (P, f, V), n equal to number of OPPs for this
> > frequency domain, we can solve C by:
> >
> > P = Pstat + Pdyn
> >
> > P = Pstat + CV²f
> >
> > Cx = (Px - P1)/(Vx²fx - V1²f1) with x = {2, ..., n}
> >
> > The C value is the arithmetic mean out of {C2, ..., Cn}.
> >
> > Since DVFS is broken on Juno r1, no dynamic-power-coefficient
> > information has been added to its dts file.
> >
> 
> Since the binding for "dynamic-power-coefficient" property already exist,
> and I don't see any dependency for this and the next patch(TC2) on this
> series, I will apply them. Please shout if for any reason that's not true.

Thanks Sudeep !
Quentin
