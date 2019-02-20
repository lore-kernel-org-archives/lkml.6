Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24265C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAF4206DD
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfBTMEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:04:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:64796 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbfBTMEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:04:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 04:04:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,390,1544515200"; 
   d="scan'208";a="125848161"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 20 Feb 2019 04:04:07 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gwQbe-000342-Af; Wed, 20 Feb 2019 14:04:06 +0200
Date:   Wed, 20 Feb 2019 14:04:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 0/2] drivers: new helper for ioremapping memory
 resources
Message-ID: <20190220120406.GN9224@smile.fi.intel.com>
References: <20190220111240.10041-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220111240.10041-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 12:12:38PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> There are currently 1200+ instances of using platform_get_resource()
> and devm_ioremap_resource() together in the kernel tree. It's a minor
> redundancy, but consolidation is always good.
> 
> The first patch in this series adds a wrapper for these two calls and
> the second uses it in a driver I could test.
> 
> If accepted I'll prepare a coccinelle script that'll make it easier
> to convert all users.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> v1 -> v2:
> - EXPORT_SYMBOL() -> EXPORT_SYMBOL_GPL()
> 
> Bartosz Golaszewski (2):
>   drivers: provide devm_platform_ioremap_resource()
>   gpio: davinci: use devm_platform_ioremap_resource()
> 
>  drivers/base/platform.c         | 18 ++++++++++++++++++
>  drivers/gpio/gpio-davinci.c     |  4 +---
>  include/linux/platform_device.h |  3 +++
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


