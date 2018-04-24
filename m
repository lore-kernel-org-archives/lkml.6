Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeDXT2L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:28:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:53983 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751483AbeDXT2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:28:08 -0400
Date: Tue, 24 Apr 2018 13:28:03 -0600
From: Michal Hocko <mhocko@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>, linux-mtd@lists.infradead.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: vmalloc with GFP_NOFS
Message-ID: <20180424192803.GT17484@dhcp22.suse.cz>
References: <20180424162712.GL17484@dhcp22.suse.cz>
 <3732370.1623zxSvNg@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3732370.1623zxSvNg@blindfold>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-04-18 21:03:43, Richard Weinberger wrote:
> Am Dienstag, 24. April 2018, 18:27:12 CEST schrieb Michal Hocko:
> > fs/ubifs/debug.c
> 
> This one is just for debugging.
> So, preallocating + locking would not hurt much.
> 
> > fs/ubifs/lprops.c
> 
> Ditto.
> 
> > fs/ubifs/lpt_commit.c
> 
> Here we use it also only in debugging mode and in one case for
> fatal error reporting.
> No hot paths.
> 
> > fs/ubifs/orphan.c
> 
> Also only for debugging.
> Getting rid of vmalloc with GFP_NOFS in UBIFS is no big problem.
> I can prepare a patch.

Cool!

Anyway, if UBIFS has some reclaim recursion critical sections in general
it would be really great to have them documented and that is where the
scope api is really handy. Just add the scope and document what is the
recursion issue. This will help people reading the code as well. Ideally
there shouldn't be any explicit GFP_NOFS in the code.

Thanks for a quick turnaround.

-- 
Michal Hocko
SUSE Labs
