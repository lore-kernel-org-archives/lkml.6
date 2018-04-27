Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757879AbeD0Jah (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:30:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37170 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbeD0Jac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:30:32 -0400
Date: Fri, 27 Apr 2018 10:30:27 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Will.Deacon@arm.com,
        jnair@caviumnetworks.com, Robert.Richter@cavium.com,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com, gklkml16@gmail.com
Subject: Re: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
Message-ID: <20180427093027.ngtuoezyh6mtz26p@lakrids.cambridge.arm.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
 <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com>
 <20180426170624.bfcba885431d57d0de2a3ddd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426170624.bfcba885431d57d0de2a3ddd@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kim,

On Thu, Apr 26, 2018 at 05:06:24PM -0500, Kim Phillips wrote:
> On Wed, 25 Apr 2018 14:30:47 +0530
> Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com> wrote:
> 
> > +static int thunderx2_uncore_event_init(struct perf_event *event)

> This PMU driver can be made more user-friendly by not just silently
> returning an error code such as -EINVAL, but by emitting a useful
> message describing the specific error via dmesg.

As has previously been discussed on several occasions, patches which log
to dmesg in a pmu::event_init() path at any level above pr_debug() are
not acceptable -- dmesg is not intended as a mechanism to inform users
of driver-specific constraints.

I would appreciate if in future you could qualify your suggestion with
the requirement that pr_debug() is used.

Thanks,
Mark.
