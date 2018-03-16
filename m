Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeCPEk2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 00:40:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750748AbeCPEk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 00:40:27 -0400
Date: Fri, 16 Mar 2018 12:40:17 +0800
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, eric.auger@redhat.com, aik@ozlabs.ru
Subject: Re: [PATCH v2 3/3] vfio/pci: Add ioeventfd support
Message-ID: <20180316044017.GC2477@xz-mi>
References: <20180315212634.15150.88094.stgit@gimli.home>
 <20180315213157.15150.86812.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315213157.15150.86812.stgit@gimli.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 03:31:58PM -0600, Alex Williamson wrote:
> The ioeventfd here is actually irqfd handling of an ioeventfd such as
> supported in KVM.  A user is able to pre-program a device write to
> occur when the eventfd triggers.  This is yet another instance of
> eventfd-irqfd triggering between KVM and vfio.  The impetus for this
> is high frequency writes to pages which are virtualized in QEMU.
> Enabling this near-direct write path for selected registers within
> the virtualized page can improve performance and reduce overhead.
> Specifically this is initially targeted at NVIDIA graphics cards where
> the driver issues a write to an MMIO register within a virtualized
> region in order to allow the MSI interrupt to re-trigger.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
