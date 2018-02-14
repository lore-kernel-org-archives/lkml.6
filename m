Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030622AbeBNN6z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:58:55 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41593 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030450AbeBNN6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:58:53 -0500
X-Google-Smtp-Source: AH8x227Ha4RgzxdXjgY5jdqk3vrwH+9gwKh+XPHzaysm4Kwl1T5ZMhfBKllM7y4w9HVXPmN4Nb4yL29jQek0SdG3/uQ=
MIME-Version: 1.0
In-Reply-To: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2018 15:58:52 +0200
Message-ID: <CAHp75Vf0shEVjdGkh6TiaGNLyK-jMeGWOq-RqvdgZRUMbCXxOA@mail.gmail.com>
Subject: Re: [PATCH 00/18] thunderbolt: Add support for Intel Titan Ridge
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 7:00 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Hi,
>
> This series adds support for Intel Titan Ridge Thunderbolt controller.
> Titan Ridge is the next generation Thunderbolt 3 controller and successor
> of Alpine Ridge.
>
> In addition to fixes and Titan Ridge support this series adds following:
>
>   - USB only security level (SL4).
>
>   - A new attribute for devices telling whether they were connected
>     automatically during boot.
>
>   - Preboot ACL allows userspace to specify a list of devices (based on
>     device unique_id) that the firmware automatically connects during boot.
>
> Bjorn, I've Cc'd you the series as well because I would like to get your
> blessing for patch [2/18] as it uses functions from PCI subsystem.
>
> Thanks!

For patches 1-17,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

The last one will take a bit more time to go through.

>
> Mika Westerberg (13):
>   thunderbolt: Resume control channel after hibernation image is created
>   thunderbolt: Serialize PCIe tunnel creation with PCI rescan
>   thunderbolt: Handle connecting device in place of host properly
>   thunderbolt: Do not overwrite error code when domain adding fails
>   thunderbolt: Wait a bit longer for root switch config space
>   thunderbolt: Wait a bit longer for ICM to authenticate the active NVM
>   thunderbolt: Handle rejected Thunderbolt devices
>   thunderbolt: Factor common ICM add and update operations out
>   thunderbolt: Add tb_switch_get()
>   thunderbolt: Add constant for approval timeout
>   thunderbolt: Move driver ready handling to struct icm
>   thunderbolt: Add support for preboot ACL
>   thunderbolt: Introduce USB only (SL4) security level
>
> Radion Mirchevsky (4):
>   thunderbolt: Correct function name in kernel-doc comment
>   thunderbolt: Add tb_switch_find_by_route()
>   thunderbolt: Add tb_xdomain_find_by_route()
>   thunderbolt: Add support for Intel Titan Ridge
>
> Yehezkel Bernat (1):
>   thunderbolt: Add 'boot' attribute for devices
>
>  Documentation/ABI/testing/sysfs-bus-thunderbolt |  33 ++
>  drivers/thunderbolt/dma_port.c                  |  28 +-
>  drivers/thunderbolt/domain.c                    | 129 +++-
>  drivers/thunderbolt/icm.c                       | 757 +++++++++++++++++++++---
>  drivers/thunderbolt/nhi.c                       |   5 +-
>  drivers/thunderbolt/nhi.h                       |   5 +
>  drivers/thunderbolt/switch.c                    |  61 +-
>  drivers/thunderbolt/tb.h                        |  14 +
>  drivers/thunderbolt/tb_msgs.h                   | 180 +++++-
>  drivers/thunderbolt/xdomain.c                   |  40 +-
>  include/linux/thunderbolt.h                     |  19 +
>  11 files changed, 1172 insertions(+), 99 deletions(-)
>
> --
> 2.15.1
>



-- 
With Best Regards,
Andy Shevchenko
