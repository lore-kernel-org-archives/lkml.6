Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967104AbeCSQ1F (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:27:05 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:43869 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965769AbeCSQ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:26:57 -0400
X-Google-Smtp-Source: AG47ELt5zntUSYh3eP4A4u2RWKLLtz/dihZ07j3dR51mLlJd07IrRMQo4AeEiqPQmAlwpdoXhZKy/w==
Date: Mon, 19 Mar 2018 09:26:54 -0700
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, efault@gmx.de, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v5 2/2] cpuset: Add cpuset.flags control knob to v2
Message-ID: <20180319162654.GR2943022@devbig577.frc2.facebook.com>
References: <1521148842-15486-1-git-send-email-longman@redhat.com>
 <1521148842-15486-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521148842-15486-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Waiman.

On Thu, Mar 15, 2018 at 05:20:42PM -0400, Waiman Long wrote:
> +	The currently supported flag is:
> +
> +	  sched_load_balance
> +		When it is not set, there will be no load balancing
> +		among CPUs on this cpuset.  Tasks will stay in the
> +		CPUs they are running on and will not be moved to
> +		other CPUs.
> +
> +		When it is set, tasks within this cpuset will be
> +		load-balanced by the kernel scheduler.  Tasks will be
> +		moved from CPUs with high load to other CPUs within
> +		the same cpuset with less load periodically.

Hmm... looks like this is something which can be decided by the cgroup
itself and should be made delegatable.  Given that different flags
might need different delegation settings and the precedence of
memory.oom_group, I think it'd be better to make the flags separate
bool files - ie. cpuset.sched_load_balance which contains 0/1 and
marked delegatable.

Thanks.

-- 
tejun
