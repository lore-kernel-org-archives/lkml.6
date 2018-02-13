Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965518AbeBMSYB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:24:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35266 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965217AbeBMSYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:24:00 -0500
Date: Tue, 13 Feb 2018 19:23:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Raghavendra Rao Ananta <rananta@codeaurora.org>
Cc: mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org
Subject: Re: [PATCH] perf: Add support for creating offline events
Message-ID: <20180213182351.GQ25201@hirez.programming.kicks-ass.net>
References: <1518217620-28458-1-git-send-email-rananta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518217620-28458-1-git-send-email-rananta@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 03:07:00PM -0800, Raghavendra Rao Ananta wrote:
> Perf framework doesn't allow creation of hardware events if
> the requested CPU is offline. However, creation of an event
> is achievable if the event is attached to the PMU as soon
> as the CPU is online again.
> 
> So, introducing a feature that could allow to create events
> even when the CPU is offline and return a success to the caller.
> If, during the time of event creation, the CPU is found offline,
> the event is moved to a new state (PERF_EVENT_STATE_DORMANT). As
> and when the CPU is know to be woken up (through hotplug notifiers),
> all the dormant events would be attached to the PMU (by
> perf_install_in_context()). If during the life time of the event,
> the CPU hasn't come online, the dormant event would just be freed.

This is horrible.. and you seem to have forgotten to explain why you
care about offline CPUs.
