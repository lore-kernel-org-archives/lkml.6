Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeCTOpg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:45:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751317AbeCTOpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:45:34 -0400
Date: Tue, 20 Mar 2018 10:45:31 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 3/4] mm/hmm: HMM should have a callback before MM is
 destroyed
Message-ID: <20180320144531.GA3716@redhat.com>
References: <20180315183700.3843-1-jglisse@redhat.com>
 <20180315183700.3843-4-jglisse@redhat.com>
 <20180315154829.89054bfd579d03097b0f6457@linux-foundation.org>
 <20180320113326.GJ23100@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180320113326.GJ23100@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 12:33:26PM +0100, Michal Hocko wrote:
> On Thu 15-03-18 15:48:29, Andrew Morton wrote:
> > On Thu, 15 Mar 2018 14:36:59 -0400 jglisse@redhat.com wrote:
> > 
> > > From: Ralph Campbell <rcampbell@nvidia.com>
> > > 
> > > The hmm_mirror_register() function registers a callback for when
> > > the CPU pagetable is modified. Normally, the device driver will
> > > call hmm_mirror_unregister() when the process using the device is
> > > finished. However, if the process exits uncleanly, the struct_mm
> > > can be destroyed with no warning to the device driver.
> > 
> > The changelog doesn't tell us what the runtime effects of the bug are. 
> > This makes it hard for me to answer the "did Jerome consider doing
> > cc:stable" question.
> 
> There is no upstream user of this code IIRC, so does it make sense to
> mark anything for stable trees?

I am fine with dropping stable, distribution that care about out of tree
drivers can easily backport themself. I am hoping to have the nouveau
part upstream in 4.18/4.19 ...

Cheers,
Jérôme
