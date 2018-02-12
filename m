Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeBLRZD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:25:03 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36399 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbeBLRZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:25:02 -0500
X-Google-Smtp-Source: AH8x2245O8WHPvJ5XYkVi6rDQlmc+0pRKKjkvxXSIcbPM4aIOHMhaCED4maVqVBzsPIE/i5jw4AMAQ==
Date: Mon, 12 Feb 2018 09:24:58 -0800
From: Tejun Heo <tj@kernel.org>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v4.15-rc9] sched, cgroup: Don't reject lower cpu.max on
 ancestors
Message-ID: <20180212172458.GF695913@devbig577.frc2.facebook.com>
References: <20180122192618.GA1771050@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180122192618.GA1771050@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2018 at 11:26:18AM -0800, Tejun Heo wrote:
> While adding cgroup2 interface for the cpu controller, 0d5936344f30
> ("sched: Implement interface for cgroup unified hierarchy") forgot to
> update input validation and left it to reject cpu.max config if any
> descendant has set a higher value.
> 
> cgroup2 officially supports delegation and a descendant must not be
> able to restrict what its ancestors can configure.  For absolute
> limits such as cpu.max and memory.max, this means that the config at
> each level should only act as the upper limit at that level and
> shouldn't interfere with what other cgroups can configure.
> 
> This patch updates config validation on cgroup2 so that the cpu
> controller follows the same convention.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: 0d5936344f30 ("sched: Implement interface for cgroup unified hierarchy")

Applied to cgroup/for-4.16-fixes.

Thanks.

-- 
tejun
