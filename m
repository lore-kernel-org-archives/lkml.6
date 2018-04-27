Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758299AbeD0NPa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:15:30 -0400
Received: from foss.arm.com ([217.140.101.70]:39992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758215AbeD0NP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:15:29 -0400
Date: Fri, 27 Apr 2018 08:15:25 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Will.Deacon@arm.com>,
        <jnair@caviumnetworks.com>, <Robert.Richter@cavium.com>,
        <Vadim.Lomovtsev@cavium.com>, <Jan.Glauber@cavium.com>,
        <gklkml16@gmail.com>
Subject: Re: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
Message-Id: <20180427081525.f9dcc756678baf3bb6e6e473@arm.com>
In-Reply-To: <20180427093027.ngtuoezyh6mtz26p@lakrids.cambridge.arm.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
        <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com>
        <20180426170624.bfcba885431d57d0de2a3ddd@arm.com>
        <20180427093027.ngtuoezyh6mtz26p@lakrids.cambridge.arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018 10:30:27 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Hi Kim,
> 
> On Thu, Apr 26, 2018 at 05:06:24PM -0500, Kim Phillips wrote:
> > On Wed, 25 Apr 2018 14:30:47 +0530
> > Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com> wrote:
> > 
> > > +static int thunderx2_uncore_event_init(struct perf_event *event)
> 
> > This PMU driver can be made more user-friendly by not just silently
> > returning an error code such as -EINVAL, but by emitting a useful
> > message describing the specific error via dmesg.
> 
> As has previously been discussed on several occasions, patches which log
> to dmesg in a pmu::event_init() path at any level above pr_debug() are
> not acceptable -- dmesg is not intended as a mechanism to inform users
> of driver-specific constraints.

I disagree - drivers do it all the time, using dev_err(), dev_warn(), etc.

> I would appreciate if in future you could qualify your suggestion with
> the requirement that pr_debug() is used.

It shouldn't - the driver isn't being debugged, it's in regular use.

Thanks,

Kim
