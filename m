Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030431AbeEYVfi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:35:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50371 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030260AbeEYVfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:35:36 -0400
X-Google-Smtp-Source: ADUXVKKQu6mdsy5aJgOk66PmBO6NK6q/+YdNdg6UZjwxv5hms07lRZLJLNCHj0zn1u3ZmaCp9fqFGA==
Date: Fri, 25 May 2018 14:10:25 -0700
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
Message-ID: <20180525211025.c73zdcdtyuvlewng@localhost>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <2a2eb28da9fecf129f6bc0ab3d3748d9f4d25a29.1527225682.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a2eb28da9fecf129f6bc0ab3d3748d9f4d25a29.1527225682.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 11:10:01AM +0530, Viresh Kumar wrote:
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
> 
> Add such missing properties.

This seems awkward compared to just having one cooling-cells in the /cpus node
instead.

What's it used for? I don't see any properties in the device nodes on meson-gxm
that have any cooling-foo cells in them? So why should #cooling-cells be
needed?


-Olof
