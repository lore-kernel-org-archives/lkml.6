Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeBWLgB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:36:01 -0500
Received: from foss.arm.com ([217.140.101.70]:53150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbeBWLgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:36:00 -0500
Date: Fri, 23 Feb 2018 11:35:52 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, will.deacon@arm.com,
        robh@kernel.org, sudeep.holla@arm.com, mathieu.poirier@linaro.org,
        peterz@infradead.org, jonathan.cameron@huawei.com,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com, leo.yan@linaro.org,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        avilaj@codeaurora.org
Subject: Re: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
Message-ID: <20180223113552.2gn27h4uxbpo5zoq@lakrids.cambridge.arm.com>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
 <20180102112533.13640-9-suzuki.poulose@arm.com>
 <5A8E2BCE.3050509@codeaurora.org>
 <20180222113352.oeedj7upx3zxvdcc@lakrids.cambridge.arm.com>
 <5A8F2A4F.5020105@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A8F2A4F.5020105@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 12:38:39PM -0800, Saravana Kannan wrote:
> On 02/22/2018 03:33 AM, Mark Rutland wrote:
> > On Wed, Feb 21, 2018 at 06:32:46PM -0800, Saravana Kannan wrote:
> > > I'm not exactly sure if we can add entries to perf_type_id. If that's
> > > allowed maybe we need to add something line PERF_TYPE_DSU and use that?
> > > 
> > > Or if that's not allowed then would it be better to offset the DSU PMU
> > > events by some number (say 0x1000) and then delete the event type check or
> > > pass PERF_TYPE_RAW to perf_pmu_register()?
> > 
> > As above, neither of these should be necessary.
> 
> For the userspace interface. How about the kernel interface though?
> perf_event_create_kernel_counter() takes attr.type as an input. But there's
> no way to look up the DSU PMU's "type".

There is no lookup mechanism currently.

I take it you want to use DSU events from a kernel module?

It would be possible to have a simlar name -> type lookup mechanism
kernel-side, if necessary.

Thanks,
Mark.
