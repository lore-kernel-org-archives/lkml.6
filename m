Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbeCTVOY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:14:24 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34221 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeCTVOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:14:20 -0400
X-Google-Smtp-Source: AG47ELtK1ZcIv9dlxxZPT4RXv8RqxTO4YfePYyabj/4pY7y/w8myoX2T+6yWYPI/YBrZYImnMzdXMg==
Date: Tue, 20 Mar 2018 14:14:17 -0700
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, efault@gmx.de, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v5 1/2] cpuset: Enable cpuset controller in default
 hierarchy
Message-ID: <20180320211417.GA2149215@devbig577.frc2.facebook.com>
References: <1521148842-15486-1-git-send-email-longman@redhat.com>
 <1521148842-15486-2-git-send-email-longman@redhat.com>
 <20180319155937.GQ2943022@devbig577.frc2.facebook.com>
 <1881c1da-56ec-d76b-b736-fd0919737ec6@redhat.com>
 <20180320201029.GO519464@devbig577.frc2.facebook.com>
 <2b9261b8-6a3a-81d1-9c9a-394524a0d413@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b9261b8-6a3a-81d1-9c9a-394524a0d413@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 20, 2018 at 04:53:37PM -0400, Waiman Long wrote:
> ASAIK for v2, when cpuset.cpus is empty, cpuset.effective_cpus will show
> all the cpus available from the parent. It is a different behavior from
> v1. So do we still need a cpuset.cpus_available?

Heh, you're right.  Let's forget about available and do
cpuset.cpus.effective.  The primary reason for suggesting that was
because of the similarity with cgroup.controllers and
cgroup.subtree_control; however, they're that way because
subtree_control is delegatable.  For a normal resource knob like
cpuset.cpus, the knob is owned by the parent and what's interesting to
the parent is its effective set that it's distributing from.

Thanks.

-- 
tejun
