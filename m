Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeEAU6e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:58:34 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:42843 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeEAU6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:58:32 -0400
X-Google-Smtp-Source: AB8JxZprzz5pAV/qOlXBTG1S3jyKEikDu+GL2h6AK9t0wKDHKVZpOMXWi/HU2/yckiqDljxaeQSCBg==
Date: Tue, 1 May 2018 13:58:28 -0700
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v7 4/5] cpuset: Restrict load balancing off cpus to
 subset of cpus.isolated
Message-ID: <20180501205828.GD2368884@devbig577.frc2.facebook.com>
References: <1524145624-23655-1-git-send-email-longman@redhat.com>
 <1524145624-23655-5-git-send-email-longman@redhat.com>
 <20180501195148.GC2368884@devbig577.frc2.facebook.com>
 <9eb2c45e-e71e-61ef-aa6d-b8124b739cdf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eb2c45e-e71e-61ef-aa6d-b8124b739cdf@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, May 01, 2018 at 04:33:45PM -0400, Waiman Long wrote:
> I think that will work too. We currently don't have a flag to make a
> file visible on first-level children only, but it shouldn't be hard to
> make one.

I think it'd be fine to make the flag file exist on all !root cgroups
but only writable on the first level children.

> Putting CPUs into an isolated child cpuset means removing it from the
> root's effective CPUs. So I would probably like to expose the read-only
> cpus.effective in the root cgroup so that we can check changes in the
> effective cpu list.

Ah, yeah, that makes sense.

> I will renew the patchset will your suggestion.

Thank you very much.

-- 
tejun
