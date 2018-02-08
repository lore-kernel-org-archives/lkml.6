Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeBHN4A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:56:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750876AbeBHNz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:55:57 -0500
Date: Thu, 8 Feb 2018 14:55:54 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, wcohen@redhat.com, will.deacon@arm.com,
        ganapatrao.kulkarni@cavium.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/9] perf utils: add support for pmu events vendor
 sub-directory
Message-ID: <20180208135554.GL10234@krava>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517939104-230881-3-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 01:44:57AM +0800, John Garry wrote:
> For some architectures (like arm), it is required to support
> a vendor sub-directory and not locate all the JSONs for a
> specific vendor in the same folder.
> 
> This is because all the events for the same vendor will be
> placed in the same pmu events table, which may cause conflict.
> This conflict would be in the instance that a vendor's custom
> implemented events do have the same meaning on different platforms,
> so events in the pmu table would conflict. In addition, per list
> command may show events which are not even supported for a given
> platform.
> 
> This patch adds support for a arch/vendor/platform directory
> hierarchy, while maintaining backwards-compatibility for existing
> arch/platform structure. In this, each platform would always have
> its own pmu events table.
> 
> In generated file pmu_events.c, each platform table name is in
> the format pme{_vendor}_platform, like this:
> 
> struct pmu_events_map pmu_events_map[] = {
> {
> 	.cpuid = "0x00000000420f5160",
> 	.version = "v1",
> 	.type = "core",
> 	.table = pme_cavium_thunderx2
> },
> {
> 	.cpuid = 0,
> 	.version = 0,
> 	.type = 0,
> 	.table = 0,
> },
> };
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
