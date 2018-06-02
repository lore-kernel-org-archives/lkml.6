Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbeFBIrK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 04:47:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42176 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeFBIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 04:47:06 -0400
X-Google-Smtp-Source: ADUXVKKN/4PY9G/yJJQ178zRRP3vl3r2isbCPtsUCcB9L2oLssNLV0/2V4TXxd1uN0AYHYFavfCozw==
Date: Sat, 2 Jun 2018 01:14:18 -0700
From: Olof Johansson <olof@lixom.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64: dts: amlogic: Add missing cooling device
 properties for CPUs
Message-ID: <20180602081418.jcl2vjc6saoj3z3d@localhost>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <2a2eb28da9fecf129f6bc0ab3d3748d9f4d25a29.1527225682.git.viresh.kumar@linaro.org>
 <20180525211025.c73zdcdtyuvlewng@localhost>
 <20180528111358.meyle364fy6wuruf@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528111358.meyle364fy6wuruf@vireshk-i7>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 04:43:58PM +0530, Viresh Kumar wrote:
> On 25-05-18, 14:10, Olof Johansson wrote:
> > On Fri, May 25, 2018 at 11:10:01AM +0530, Viresh Kumar wrote:
> > > The cooling device properties, like "#cooling-cells" and
> > > "dynamic-power-coefficient", should either be present for all the CPUs
> > > of a cluster or none. If these are present only for a subset of CPUs of
> > > a cluster then things will start falling apart as soon as the CPUs are
> > > brought online in a different order. For example, this will happen
> > > because the operating system looks for such properties in the CPU node
> > > it is trying to bring up, so that it can register a cooling device.
> > > 
> > > Add such missing properties.
> > 
> > This seems awkward compared to just having one cooling-cells in the /cpus node
> > instead.
> 
> Well, we don't allow that property to be present in /cpus node right
> now and it is per device. And then we may not want all the CPUs to be
> cooling devices really.

And what I am saying is that it sounds like a broken binding if you don't allow
that, especially since it'll be a super common case that all CPUs will specify
the same cooling-device specifier.

> > What's it used for? I don't see any properties in the device nodes on meson-gxm
> > that have any cooling-foo cells in them? So why should #cooling-cells be
> > needed?
> 
> This property is required to declare a device as a cooling-device and
> the device here is CPU. We use it as a cooling device by limiting its
> higher range of frequencies, so that it doesn't generate too much
> heat.
> 
> It is already there for CPU0 and CPU4, but it should really be there
> for all the CPUs, like we have clock, supply, caches, etc.

You have #cooling-cells in the cpu node, but the actual data is in the
thermal-zones nodes. Why isn't #cooling-cells under thermal-zones, next to
cooling-maps?


-Olof
