Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeC0Oba (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:31:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751122AbeC0Ob3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:31:29 -0400
Date: Tue, 27 Mar 2018 16:31:23 +0200
From: Mateusz Guzik <mguzik@redhat.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>, adobriyan@gmail.com,
        willy@infradead.org, gorcunov@openvz.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180327143122.rjgxjoj2adzvfck2@mguzik>
References: <1522088439-105930-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180327062939.GV5652@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180327062939.GV5652@dhcp22.suse.cz>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 08:29:39AM +0200, Michal Hocko wrote:
> On Tue 27-03-18 02:20:39, Yang Shi wrote:
> [...]
> The patch looks reasonable to me. Maybe it would be better to be more
> explicit about the purpose of the patch. As others noticed, this alone
> wouldn't solve the mmap_sem contention issues. I _think_ that if you
> were more explicit about the mmap_sem abuse it would trigger less
> questions.
> 

>From what I gather even with other fixes the kernel will still end up
grabbing the semaphore. In this case I don't see what's the upside of
adding the spinlock for args. The downside is growth of mm_struct.

i.e. the code can be refactored to just hold the lock and relock only if
necessary (unable to copy to user without faulting)

-- 
Mateusz Guzik
