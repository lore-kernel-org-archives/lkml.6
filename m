Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeFDHjw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:39:52 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40500 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeFDHju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:39:50 -0400
X-Google-Smtp-Source: ADUXVKLqTAOFqjBaaudrLnTqT2Lt0klK+4xGwzlHq+Xo+CqSeGgyWCBiJYsG3+mfKmxAK8SIlM6bwQ==
Date: Mon, 4 Jun 2018 08:39:46 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
        Jian-Hong Pan <jian-hong@endlessm.com>, Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Fix Intel Cannon Lake LPSS I2C input
 clock
Message-ID: <20180604073946.GI25455@dell>
References: <20180518083827.20626-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180518083827.20626-1-jarkko.nikula@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018, Jarkko Nikula wrote:

> Intel Cannon Lake PCH has much higher 216 MHz input clock to LPSS I2C
> than Sunrisepoint which uses 120 MHz. Preliminary information was that
> both share the same clock rate but actual silicon implements elevated
> rate for better support for 3.4 MHz high-speed I2C.
> 
> This incorrect input clock rate results too high I2C bus clock in case
> ACPI doesn't provide tuned I2C timing parameters since I2C host
> controller driver calculates them from input clock rate.
> 
> Fix this by using the correct rate. We still share the same 230 ns SDA
> hold time value than Sunrisepoint.
> 
> Cc: stable@vger.kernel.org
> Fixes: b418bbff36dd ("mfd: intel-lpss: Add Intel Cannonlake PCI IDs")
> Reported-by: Jian-Hong Pan <jian-hong@endlessm.com>
> Reported-by: Chris Chiu <chiu@endlessm.com>
> Reported-by: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> Hi Jian-Hong, Chris and Daniel. Could you test does this fix your
> touchpad issue?
> ---
>  drivers/mfd/intel-lpss-pci.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
