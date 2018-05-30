Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935612AbeE3EwI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:52:08 -0400
Received: from 8bytes.org ([81.169.241.247]:41320 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbeE3EwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:52:05 -0400
Date: Wed, 30 May 2018 06:52:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Gary R Hook <ghook@amd.com>
Cc: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd - Optimize PPR log handling
Message-ID: <20180530045203.GO18595@8bytes.org>
References: <152668031618.108078.8188026193559324640.stgit@wsp141332wss.amd.com>
 <20180529145405.GN18595@8bytes.org>
 <223930b9-3df9-813a-6676-68072e4e1bb6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <223930b9-3df9-813a-6676-68072e4e1bb6@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 12:28:54PM -0500, Gary R Hook wrote:
> No, no numbers. We're still working out how best to test this, and
> suggestions/strategies are welcome.

Maybe run a simple kernel on the CPU that does a memcpy on a larger
portion of mmapped (but yet unmapped) process address space and measure
the time it takes for the kernel to run. The page-fault path in the
iommu-driver is only a small part of the involved code here, but maybe
you already see a difference. Doing a u-benchmark only for that code is
probably a bit more challenging.

> The change is modeled after the function iommu_poll_events(), which is much
> cleaner. The GA log handling should be changed, as well (there are
> superfluous writes in the loop), but I figured, "one thing at a time". This
> is admittedly a minor optimization, but discussions with Tom Lendacky have
> led us down this path.
> 
> Your feedback is appreciated.

Yeah, the patch looks good to me from my first review. But since I can't
test that code myself I was wondering if you did any tests and can share
something with me to run my own tests :)



	Joerg
