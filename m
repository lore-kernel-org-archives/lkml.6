Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756518AbeDZNxN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:53:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756321AbeDZNw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:52:58 -0400
Date: Thu, 26 Apr 2018 15:52:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org, riel@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, ebiederm@xmission.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] exit: Make unlikely case in mm_update_next_owner()
 more scalable
Message-ID: <20180426135250.GA14269@redhat.com>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <20180426130700.GP17484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426130700.GP17484@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26, Michal Hocko wrote:
>
> then I suspect that we should be better off reconsidering
> mm->owner and try to come up with something more clever. I've had a
> patch to remove owner few years back.

Yeees, I do remember we discussed this but I forgot everything.

I agree, it would nice to turn mm->owner into mm->mem_cgroup and just kill
the ugly mm_update_next_owner/etc.

Oleg.
