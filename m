Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757361AbeEJMfs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:35:48 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:43810 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757217AbeEJMfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:35:46 -0400
X-Google-Smtp-Source: AB8JxZoFBL6V3Y/lXibyVt1JIx/+ZtnON45tbwcUjue/gEpLOHNiU8T9iWsP4nHVhdoEDSgoTf1rxA==
Date: Thu, 10 May 2018 05:35:41 -0700
From: Tejun Heo <tj@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org, riel@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH] cgroup: Don't mess with tasks in exec
Message-ID: <20180510123541.GO2368884@devbig577.frc2.facebook.com>
References: <20180504145435.GA26573@redhat.com>
 <87y3gzfmjt.fsf@xmission.com>
 <20180504162209.GB26573@redhat.com>
 <871serfk77.fsf@xmission.com>
 <20180507143358.GA3071@redhat.com>
 <87vabyvnw0.fsf@xmission.com>
 <20180509144016.GA25742@redhat.com>
 <87vabwp5p6.fsf@xmission.com>
 <871sekp378.fsf_-_@xmission.com>
 <20180510121531.GA29222@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510121531.GA29222@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, May 10, 2018 at 02:15:32PM +0200, Oleg Nesterov wrote:
> > So avoid the problems by simply blocking cgroup migration over the
> > entirety of exec.
> 
> This patch, even if it was correct, will bring much more problems.
> 
> If nothing else exec() is very slow. If it races with migration which needs
> this sem for writing the new readers will be blocked. This means that clone(),
> exit(), or another exec() will block too.

Agreed.  I don't think it's a good idea to expand threadgroup coverage
larger than it already is.  I'd much prefer either working around the
copy_string case specifically or just ignoring it.

Thanks.

-- 
tejun
