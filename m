Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936798AbeE2OyM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:54:12 -0400
Received: from 8bytes.org ([81.169.241.247]:57220 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936544AbeE2OyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:54:06 -0400
Date: Tue, 29 May 2018 16:54:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd - Optimize PPR log handling
Message-ID: <20180529145405.GN18595@8bytes.org>
References: <152668031618.108078.8188026193559324640.stgit@wsp141332wss.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152668031618.108078.8188026193559324640.stgit@wsp141332wss.amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Gary,

On Fri, May 18, 2018 at 04:51:56PM -0500, Gary R Hook wrote:
> Improve the performance of the PPR log polling function (i.e. the
> task of emptying the log) by minimizing MMIO operations and more
> efficiently processing groups of log entries. Cache the head
> pointer, as there's never a reason to read it. Ensure the head
> pointer register is updated every so often, to inform the IOMMU
> that space is available in the log.
> 
> Finally, since a single pass may leave logged events unread, use
> an outer loop to repeat until head has caught up to tail.
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>

Do you have numbers for the performance improvement? How did you test
this patch?


Regards,

	Joerg
