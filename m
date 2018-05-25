Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030656AbeEYWKi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 18:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030505AbeEYWKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 18:10:36 -0400
Date: Fri, 25 May 2018 17:10:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, ryan@finnie.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Don Brace <don.brace@microsemi.com>, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2] PCI/portdrv: do not disable device on reboot/shutdown
Message-ID: <20180525221024.GC92995@bhelgaas-glaptop.roam.corp.google.com>
References: <1527043490-17268-1-git-send-email-okaya@codeaurora.org>
 <20180523213249.GD150632@bhelgaas-glaptop.roam.corp.google.com>
 <61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org>
 <20180524183502.GB85822@bhelgaas-glaptop.roam.corp.google.com>
 <984b9734-244d-04e9-946f-7524f148ff7c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <984b9734-244d-04e9-946f-7524f148ff7c@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 09:30:59AM -0400, Sinan Kaya wrote:
> On 5/24/2018 2:35 PM, Bjorn Helgaas wrote:
> > That sounds like a reasonable idea, and it is definitely another can
> > of worms.  I looked briefly at some of the .shutdown() cases:
> 
> should we throw it into 4.18 and see what happens?

It wouldn't solve this particular problem because hpsa *does* have a
.shutdown() method.  The problem is that it doesn't work -- it's
supposed to stop DMA and interrupts but it apparently doesn't.

I think we need to fix hpsa first.
