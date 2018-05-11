Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeEKRkx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 13:40:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:32937 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751263AbeEKRkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 13:40:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,389,1520924400";
   d="scan'208";a="48528356"
Date: Fri, 11 May 2018 11:42:42 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jesse Vincent <jesse@fsck.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-pci@vger.kernel.org, Andrew Lutomirski <amluto@gmail.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: Another NVMe failure, this time with AER info
Message-ID: <20180511174241.GC7344@localhost.localdomain>
References: <CAObL_7G5k7XNqXqDZASChiQd1mt+AJPAdNKz-DE+xQawhUy6ZA@mail.gmail.com>
 <20180511165752.GG190385@bhelgaas-glaptop.roam.corp.google.com>
 <20180511172610.GB7344@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511172610.GB7344@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 11:26:11AM -0600, Keith Busch wrote:
> I trust you know the offsets here, but it's hard to tell what this
> is doing with hard-coded addresses. Just to be safe and for clarity,
> I recommend the 'CAP_*+<offset>' with a mask.
> 
> For example, disabling ASPM L1.2 can look like:
> 
>  # setpci -s <B:D.f> CAP_PM+8.l=0:4

My mistake above: CAP_PM is a different capability, not the intended
one. It looks like setpci doesn't even have a convenient symbol for the
L1 PM extended capability, so the hard-coded offsets are the only way
for this setting. Sorry about the mistake.
