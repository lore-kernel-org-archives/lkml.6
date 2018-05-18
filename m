Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeERThw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:37:52 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11631 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbeERTht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:37:49 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 18 May 2018 12:37:49 -0700
Subject: Re: [PATCH v4 0/2] vfio/mdev: Device namespace protection
To: Alex Williamson <alex.williamson@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cohuck@redhat.com>, <pasic@linux.ibm.com>
References: <20180518190145.3187.7620.stgit@gimli.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <2cb44337-eea6-5953-3df9-b53f3f6e3301@nvidia.com>
Date: Sat, 19 May 2018 01:07:33 +0530
MIME-Version: 1.0
In-Reply-To: <20180518190145.3187.7620.stgit@gimli.home>
X-Originating-IP: [10.24.70.199]
X-ClientProxiedBy: DRBGMAIL104.nvidia.com (10.18.16.23) To
 bgmail102.nvidia.com (10.25.59.11)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/2018 12:40 AM, Alex Williamson wrote:
> v4: Fix the 'create' racing 'remove' gap noted by Kirti by moving
>     removal from mdev_list to mdev_device_release().  Fix missing
>     mdev_put_parent() cases in mdev_device_create(), also noted
>     by Kirti.  Added documention update regarding serialization as
>     noted by Cornelia.  Added additional commit log comment about
>     -EAGAIN vs -ENODEV for 'remove' racing 'create'.  Added second
>     patch to re-order sysfs attributes, with this my targeted
>     scripts can no longer hit the gap where -EAGAIN is regurned.
>     BTW, the gap where the current code returns -ENODEV in this
>     race condition is about 50% easier to hit than it exists in
>     this series with patch 1 alone.
> 

Thanks for fixing this. This patch set looks good to me.

Thanks,
Kirti

> Thanks,
> Alex
> 
> ---
> 
> Alex Williamson (2):
>       vfio/mdev: Check globally for duplicate devices
>       vfio/mdev: Re-order sysfs attribute creation
> 
> 
>  Documentation/vfio-mediated-device.txt |    5 ++
>  drivers/vfio/mdev/mdev_core.c          |  102 +++++++++++---------------------
>  drivers/vfio/mdev/mdev_private.h       |    2 -
>  drivers/vfio/mdev/mdev_sysfs.c         |   14 ++--
>  4 files changed, 49 insertions(+), 74 deletions(-)
> 
