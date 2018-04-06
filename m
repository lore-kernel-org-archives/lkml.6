Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeDFHiN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:38:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:40236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbeDFHiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:38:12 -0400
Date: Fri, 6 Apr 2018 09:38:09 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Buddy Lumpkin <buddy.lumpkin@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
        riel@surriel.com, mgorman@suse.de, willy@infradead.org,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH 1/1 v2] vmscan: Support multiple kswapd threads per
 node
Message-ID: <20180406073809.GF8286@dhcp22.suse.cz>
References: <1522878594-52281-1-git-send-email-buddy.lumpkin@oracle.com>
 <20180405061015.GU6312@dhcp22.suse.cz>
 <99DC1801-1ADC-488B-BA8D-736BCE4BA372@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99DC1801-1ADC-488B-BA8D-736BCE4BA372@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-04-18 23:25:14, Buddy Lumpkin wrote:
> 
> > On Apr 4, 2018, at 11:10 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > On Wed 04-04-18 21:49:54, Buddy Lumpkin wrote:
> >> v2:
> >> - Make update_kswapd_threads_node less racy
> >> - Handle locking for case where CONFIG_MEMORY_HOTPLUG=n
> > 
> > Please do not repost with such a small changes. It is much more
> > important to sort out the big picture first and only then deal with
> > minor implementation details. The more versions you post the more
> > fragmented and messy the discussion will become.
> > 
> > You will have to be patient because this is a rather big change and it
> > will take _quite_ some time to get sorted.
> > 
> > Thanks!
> > -- 
> > Michal Hocko
> > SUSE Labs
> > 
> 
> 
> Sorry about that, I actually had three people review my code internally,
> then I managed to send out an old version. 100% guilty of submitting
> code when I needed sleep. As for the change, that was in response
> to a request from Andrew to make the update function less racy.
> 
> Should I resend a correct v2 now that the thread exists?

Let's just discuss open questions for now. Specifics of the code are the
least interesting at this stage.

If you want some help with the code review, you can put it somewhere in
the git tree and send a reference for those who are interested.
-- 
Michal Hocko
SUSE Labs
