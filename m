Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeBWIZS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:25:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59364 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbeBWIZR (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:25:17 -0500
Date: Fri, 23 Feb 2018 09:25:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf annotate: Support to display the LBR data in tui
 mode
Message-ID: <20180223082500.GT25181@hirez.programming.kicks-ass.net>
References: <1519396558-23397-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519396558-23397-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 10:35:58PM +0800, Jin Yao wrote:
> Unlike the perf report interactive annotate mode, the perf annotate
> doesn't display the LBR data.
> 
> perf record -b ...
> perf annotate function
> 
> It should show IPC/cycle, but it doesn't.

There is far more than IPC/cycle for the LBR data, so this Changelog is
misleading.

Also, I think that this patch goes the wrong way, we should reduce the
divergence of the various modes, not make it worse.
