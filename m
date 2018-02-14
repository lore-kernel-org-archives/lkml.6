Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754667AbeBNIcS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:32:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754492AbeBNIcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:32:17 -0500
Date: Wed, 14 Feb 2018 09:32:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sodagudi Prasad <psodagud@codeaurora.org>
Cc: Raghavendra Rao Ananta <rananta@codeaurora.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH] perf: Add support for creating offline events
Message-ID: <20180214083213.GS25181@hirez.programming.kicks-ass.net>
References: <1518217620-28458-1-git-send-email-rananta@codeaurora.org>
 <20180213182351.GQ25201@hirez.programming.kicks-ass.net>
 <7d3d97fafa654c30b4ca776180760cb3@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d3d97fafa654c30b4ca776180760cb3@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 02:17:07PM -0800, Sodagudi Prasad wrote:

> > This is horrible.. and you seem to have forgotten to explain why you
> > care about offline CPUs.
> 
> Up to 4.9 kernel, drivers can register cpu hotplug notfiters and drivers are
> able to create perf events dynamically based cpu notifies callback events.
> As cpu hot plug is converted to state machine approach from hot plug
> notifiers,  every driver need to define a cpuhp state and registers with cpu
> hotplug state machine for creating perf events dynamically.
> 
> Qualcomm have use cases to monitor the cpu cycles and other hw events
> continuously on all cpus from kernel and profiling tools.
> So we are thinking that there could be other soc vendors, who are interested
> in perf events preserving across cpu hot plug and perf events creation on
> hot plugged cores.

But _why_ are you hotplugging to begin with? Just don't do that.
