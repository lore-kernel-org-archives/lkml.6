Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeEVIPC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:15:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751392AbeEVIO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:14:59 -0400
Date: Tue, 22 May 2018 10:14:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kwankhede@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pasic@linux.ibm.com
Subject: Re: [PATCH v4 2/2] vfio/mdev: Re-order sysfs attribute creation
Message-ID: <20180522101453.1b6e99ad.cohuck@redhat.com>
In-Reply-To: <20180518191035.3187.77957.stgit@gimli.home>
References: <20180518190145.3187.7620.stgit@gimli.home>
        <20180518191035.3187.77957.stgit@gimli.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018 13:10:35 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> There exists a gap at the end of mdev_device_create() where the device
> is visible to userspace, but we're not yet ready to handle removal, as
> triggered through the 'remove' attribute.  We handle this properly in
> mdev_device_remove() with an -EAGAIN return, but we can marginally
> reduce this gap by adding this attribute as a final step of our sysfs
> setup.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/mdev/mdev_sysfs.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
