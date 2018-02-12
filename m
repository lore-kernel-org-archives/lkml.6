Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753490AbeBLP3Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:29:16 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47196 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752720AbeBLP3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:29:13 -0500
Date: Mon, 12 Feb 2018 16:28:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rohit Jain <rohit.k.jain@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        steven.sistare@oracle.com, joelaf@google.com, jbacik@fb.com,
        riel@redhat.com, juri.lelli@redhat.com, dhaval.giani@oracle.com,
        efault@gmx.de
Subject: Re: [RFC 2/2] Introduce sysctl(s) for the migration costs
Message-ID: <20180212152855.GV25201@hirez.programming.kicks-ass.net>
References: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
 <1518128395-14606-3-git-send-email-rohit.k.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518128395-14606-3-git-send-email-rohit.k.jain@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 02:19:55PM -0800, Rohit Jain wrote:
> This patch introduces the sysctl for sched_domain based migration costs.
> These in turn can be used for performance tuning of workloads.

Smells like a bad attempt to (again) revive commit:

  0437e109e184 ("sched: zap the migration init / cache-hot balancing code")

Yes, the migration cost would ideally be per domain, in practise it all
sucks because more tunables is more confusion. And as that commit
states, runtime measurements suck too, they cause run-to-run variation
which causes repeatability issues and degrade boot times.

Static numbers suck worse, because they'll be wrong for everyone.
