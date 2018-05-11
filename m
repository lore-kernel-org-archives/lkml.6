Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeEKRzl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 13:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbeEKRzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 13:55:39 -0400
Date: Fri, 11 May 2018 12:55:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Jesse Vincent <jesse@fsck.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-pci@vger.kernel.org, Andrew Lutomirski <amluto@gmail.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: Another NVMe failure, this time with AER info
Message-ID: <20180511175538.GH190385@bhelgaas-glaptop.roam.corp.google.com>
References: <CAObL_7G5k7XNqXqDZASChiQd1mt+AJPAdNKz-DE+xQawhUy6ZA@mail.gmail.com>
 <20180511165752.GG190385@bhelgaas-glaptop.roam.corp.google.com>
 <20180511172610.GB7344@localhost.localdomain>
 <20180511174241.GC7344@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511174241.GC7344@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 11:42:42AM -0600, Keith Busch wrote:
> On Fri, May 11, 2018 at 11:26:11AM -0600, Keith Busch wrote:
> > I trust you know the offsets here, but it's hard to tell what this
> > is doing with hard-coded addresses. Just to be safe and for clarity,
> > I recommend the 'CAP_*+<offset>' with a mask.
> > 
> > For example, disabling ASPM L1.2 can look like:
> > 
> >  # setpci -s <B:D.f> CAP_PM+8.l=0:4
> 
> My mistake above: CAP_PM is a different capability, not the intended
> one. It looks like setpci doesn't even have a convenient symbol for the
> L1 PM extended capability, so the hard-coded offsets are the only way
> for this setting. Sorry about the mistake.

No problem, would be a nice janitor job to add more of those symbolic
offsets to setpci.  I recently added more cap ID decoding to lspci, but
didn't think about updating these things for setpci.

Using the symbols would definitely make this easier and better!
