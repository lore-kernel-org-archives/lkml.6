Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932086AbeDWQJZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:09:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:53414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755306AbeDWQJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:09:24 -0400
Date: Mon, 23 Apr 2018 10:09:20 -0600
From: Michal Hocko <mhocko@kernel.org>
To: David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper unmap
Message-ID: <20180423160920.GX17484@dhcp22.suse.cz>
References: <201804180057.w3I0vieV034949@www262.sakura.ne.jp>
 <alpine.DEB.2.21.1804171928040.100886@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1804171951440.105401@chino.kir.corp.google.com>
 <20180418075051.GO17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804181159020.227784@chino.kir.corp.google.com>
 <20180419063556.GK17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804191214130.157851@chino.kir.corp.google.com>
 <20180420082349.GW17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804212023120.84222@chino.kir.corp.google.com>
 <20180422131857.GI17484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422131857.GI17484@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 22-04-18 07:18:57, Michal Hocko wrote:
> On Sat 21-04-18 20:45:11, David Rientjes wrote:
[...]
> Maybe invoking the reaper as suggested by Tetsuo will help here. Maybe
> we will come up with something more smart. But I would like to have a
> stop gap solution for stable that is easy enough. And your patch is not
> doing that because it adds a very subtle dependency on the page lock.
> So please stop repeating your arguments all over and either come with
> an argument which proves me wrong and the lock_page dependency is not
> real or come with an alternative solution which doesn't make
> MMF_OOM_SKIP depend on the page lock.

I though I would give this a try but I am at a conference and quite
busy. Tetsuo are you willing to give it a try so that we have something
to compare and decide, please?
-- 
Michal Hocko
SUSE Labs
