Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752760AbeCOP2a (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:28:30 -0400
Received: from 8bytes.org ([81.169.241.247]:46796 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751983AbeCOP23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:28:29 -0400
Date: Thu, 15 Mar 2018 16:28:28 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Subject: Re: [PATCHv3] iommu/intel: Ratelimit each dmar fault printing
Message-ID: <20180315152828.GA11365@8bytes.org>
References: <20180215191729.15777-1-dima@arista.com>
 <20180315134649.skh2aukcmg5ud74y@8bytes.org>
 <1521123183.2686.7.camel@arista.com>
 <20180315142253.GC5259@8bytes.org>
 <1521124490.2686.16.camel@arista.com>
 <1521124920.2686.20.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521124920.2686.20.camel@arista.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 02:42:00PM +0000, Dmitry Safonov wrote:
> But even with loop-limit we will need ratelimit each printk() *also*.
> Otherwise loop-limit will be based on time spent printing, not on
> anything else..
> The patch makes sense even with loop-limit in my opinion.

Looks like I mis-read your patch, somehow it looked to me as if you
replace all 'ratelimited' usages with a call to __ratelimit(), but you
just move 'ratelimited' into the loop, which actually makes sense.

But still, this alone is no proper fix for the soft-lockups you are
seeing.


	Joerg
