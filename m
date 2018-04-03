Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeDCQ5P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 12:57:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752171AbeDCQ5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 12:57:10 -0400
Date: Tue, 3 Apr 2018 12:57:08 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Simon Que <sque@chromium.org>
Cc: linux-kernel@vger.kernel.org, frankhu@chromium.org,
        John Joseph <jnjoseph@google.com>, Rob Springer <rspringer@google.com>
Subject: Re: Looking for way to program external MMU from userspace (or
 viable alternative)
Message-ID: <20180403165708.GA5935@redhat.com>
References: <CANV8Hs0XsCnLRwOdC=r4sot+iKkivofMzEg-kA_b5UjRw9Xmng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANV8Hs0XsCnLRwOdC=r4sot+iKkivofMzEg-kA_b5UjRw9Xmng@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 01:27:36AM +0000, Simon Que wrote:
> Hi kernel community,
> 
> We have an external PCIe board with a custom coprocessor on it. We also
> have code for a kernel driver for it. We have thought about upstreaming it,
> but we realized that we can instead convert the driver to a userspace
> driver using UIO.
> 
> However, there's one aspect of the system and driver that doesn't seem to
> be covered by UIO. The external board has a MMU and a DMA interface that
> allows it to copy data between the host system's RAM and its own internal
> memory.
> 
> The current kernel driver code looks up the physical address of a page of
> user-allocated memory by traversing the page table, and then writing the
> physical address to the external MMU. If we were to move the driver to
> userspace, this procedure would require exposing the physical address to
> user space, which insecure and thus a no-go.
> 
> What possibilities are there for programming the MMU from a userspace
> driver?
> 
> For reference, here is the existing kernel driver code -- start from
> apex_driver.c.
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/981313

AFAIK not do-able and not something you want to do. UIO is for very
very basic device, no MMU or DMA. Allowing any such thing from user
space is wide opening the door to random DMA exploitation especialy
if there is no IOMMU.

Cheers,
Jérôme
