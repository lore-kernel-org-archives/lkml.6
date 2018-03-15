Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeCOOW5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:22:57 -0400
Received: from 8bytes.org ([81.169.241.247]:42904 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752425AbeCOOWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:22:55 -0400
Date: Thu, 15 Mar 2018 15:22:53 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Subject: Re: [PATCHv3] iommu/intel: Ratelimit each dmar fault printing
Message-ID: <20180315142253.GC5259@8bytes.org>
References: <20180215191729.15777-1-dima@arista.com>
 <20180315134649.skh2aukcmg5ud74y@8bytes.org>
 <1521123183.2686.7.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521123183.2686.7.camel@arista.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 02:13:03PM +0000, Dmitry Safonov wrote:
> So, you suggest to remove ratelimit at all?
> Do we really need printk flood for each happened fault?
> Imagine, you've hundreds of mappings and then PCI link flapped..
> Wouldn't it be better to keep ratelimiting?
> I don't mind, just it looks a bit strange to me.

I never said you should remove the ratelimiting, after all you are
trying to fix a soft-lockup, no?

And that should not be fixed by changes to the ratelimiting, but with
proper irq handling.


	Joerg
