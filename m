Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753826AbeDWA1p (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 20:27:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:45430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753791AbeDWA1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 20:27:42 -0400
Date: Sun, 22 Apr 2018 18:27:38 -0600
From: Michal Hocko <mhocko@kernel.org>
To: vcaputo@pengaru.com
Cc: Pavel Machek <pavel@ucw.cz>, Ferry Toth <ftoth@telfort.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: DOS by unprivileged user
Message-ID: <20180423002738.GF16083@dhcp22.suse.cz>
References: <9023506.UBh6vynRGa@delfion>
 <20180422101654.GA26243@amd>
 <20180422174300.srzhf3veqxfigqhg@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422174300.srzhf3veqxfigqhg@shells.gnugeneration.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 22-04-18 10:43:00, vcaputo@pengaru.com wrote:
> On Sun, Apr 22, 2018 at 12:16:54PM +0200, Pavel Machek wrote:
> > On Thu 2018-04-19 21:13:35, Ferry Toth wrote:
> > > It appears any ordinary user can easily create a DOS on linux.
> > > 
> > > One sure way to reproduce this is to open gitk on the linux kernel repo 
> > > (SIC) on a machine with 8GB RAM 16 GB swap on a HDD with btrfs and quad core 
> > > + hyperthreading. But I will be easy enough to get the same effect with more 
> > > RAM, other fs etc.
> > 
> > You may want to disable swap.
> > 
> 
> I run without swap on my laptops, and still observe long periods of
> thrashing on the road towards OOM.  What seems to occur is the active
> file-backed mappings of executables/libraries become a sort of swap
> area, repeatedly being discarded and faulted back in as the context
> switches occur.
> 
> If there's any good way to prevent this, I'd like to know.

I am afraid there is none yet. Johannes had some ground work for
page cache trashing detection https://marc.info/?i=20170727153010.23347-1-hannes%40cmpxchg.org
but there was no version of the patchseries for quite some time and
there was no integration into the oom detection which would be
non-trivial as well.

I realize this sucks. But the reality is that this is far from trivial
to resolve without introducing pre-mature OOM killer invocations.
-- 
Michal Hocko
SUSE Labs
