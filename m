Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeECQ4a (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:56:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:10654 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbeECQ43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:56:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,359,1520924400";
   d="scan'208";a="38446804"
Message-ID: <1525366584.21176.654.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] HISI LPC: Add ACPI UART support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, xuwei5@huawei.com,
        mika.westerberg@linux.intel.com, lee.jones@linaro.org
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, arnd@arndb.de,
        graeme.gregory@linaro.org, helgaas@kernel.org,
        z.liuxinliang@hisilicon.com, linuxarm@huawei.com
Date: Thu, 03 May 2018 19:56:24 +0300
In-Reply-To: <1525360119-102166-3-git-send-email-john.garry@huawei.com>
References: <1525360119-102166-1-git-send-email-john.garry@huawei.com>
         <1525360119-102166-3-git-send-email-john.garry@huawei.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-03 at 23:08 +0800, John Garry wrote:
> On the Huawei D03 development board the system UART is
> the UART connected on the LPC bus.
> 
> The profile for the device driver required for this HW
> would be as follows:
> - platform driver
> - supports 16550
> - supports ACPI
> - supports polling mode
> - supports IO space
> 
> In principle we should use the PNP driver (8250_dw.c) for
> 8250-devices with ACPI FW. However since this host driver
> does not support PNP devices, and modifying the PNP core
> code to support it is not worth the effort, use the generic
> 8250 isa driver.
> 
> For this, we need to setup the MFD cell platform data for
> a serial 8250 Port.
> 
> In addition to this change, we also make the following
> changes:
> - set child ACPI device as enumerated. This fixes a conflict
>   in serdev setup for the UART
> - use platform device ID auto for creating the uart child
>   platform device to avoid conflict with platform devices
>   created for serial8250_isa_devs from 8250_core.c

> +	mfd_cell->platform_data = devm_kmemdup(hostdev, &ref_port,
> +					       sizeof(ref_port),
> GFP_KERNEL);

Isn't this done by MFD core?


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
