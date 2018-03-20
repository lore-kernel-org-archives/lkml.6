Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbeCTLd3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:33:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:51161 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751913AbeCTLd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:33:28 -0400
Date: Tue, 20 Mar 2018 12:33:26 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jglisse@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 3/4] mm/hmm: HMM should have a callback before MM is
 destroyed
Message-ID: <20180320113326.GJ23100@dhcp22.suse.cz>
References: <20180315183700.3843-1-jglisse@redhat.com>
 <20180315183700.3843-4-jglisse@redhat.com>
 <20180315154829.89054bfd579d03097b0f6457@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315154829.89054bfd579d03097b0f6457@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-03-18 15:48:29, Andrew Morton wrote:
> On Thu, 15 Mar 2018 14:36:59 -0400 jglisse@redhat.com wrote:
> 
> > From: Ralph Campbell <rcampbell@nvidia.com>
> > 
> > The hmm_mirror_register() function registers a callback for when
> > the CPU pagetable is modified. Normally, the device driver will
> > call hmm_mirror_unregister() when the process using the device is
> > finished. However, if the process exits uncleanly, the struct_mm
> > can be destroyed with no warning to the device driver.
> 
> The changelog doesn't tell us what the runtime effects of the bug are. 
> This makes it hard for me to answer the "did Jerome consider doing
> cc:stable" question.

There is no upstream user of this code IIRC, so does it make sense to
mark anything for stable trees?
-- 
Michal Hocko
SUSE Labs
