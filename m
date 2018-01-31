Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeAaHbQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:31:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:44680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752664AbeAaHbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:31:14 -0500
Date: Wed, 31 Jan 2018 16:31:05 +0900
From: Benjamin Poirier <bpoirier@suse.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Netdev <netdev@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
Message-ID: <20180131073105.7tqyzylc76wjyoav@f1.synalogic.ca>
References: <20180118065054.29844-1-bpoirier@suse.com>
 <CAKgT0Uc+sSREnAvF=TTDp2FFxGcro6JmDpE2KdnEYk5rDE3Tpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uc+sSREnAvF=TTDp2FFxGcro6JmDpE2KdnEYk5rDE3Tpw@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/01/30 11:46, Alexander Duyck wrote:
> On Wed, Jan 17, 2018 at 10:50 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> > It was reported that emulated e1000e devices in vmware esxi 6.5 Build
> > 7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid receiver
> > overrun interrupt bursts", v4.15-rc1). Some tracing shows that after
> > e1000e_trigger_lsc() is called, ICR reads out as 0x0 in e1000_msix_other()
> > on emulated e1000e devices. In comparison, on real e1000e 82574 hardware,
> > icr=0x80000004 (_INT_ASSERTED | _OTHER) in the same situation.
> >
> > Some experimentation showed that this flaw in vmware e1000e emulation can
> > be worked around by not setting Other in EIAC. This is how it was before
> > 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1).
> >
> > Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
> > Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> > ---
> 
> Hi Benjamin,
> 
> How would you feel about resubmitting this patch for net?
> 
> We have some issues that have come up and it would be useful to have
> this fixed in the kernel sooner rather than later. I would be okay
> with us applying it for now while we work on coming up with a more
> complete solution.

Ok, I've resent it in its original form. Once it's in mainline I'll
rebase the cleanups.
