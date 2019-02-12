Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A7CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6112073D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfBLJIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:08:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:36700 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfBLJIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:08:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 01:08:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="299077865"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga005.jf.intel.com with SMTP; 12 Feb 2019 01:08:36 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 12 Feb 2019 11:08:35 +0200
Date:   Tue, 12 Feb 2019 11:08:35 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     egranata@chromium.org
Cc:     hdegoede@redhat.com, dtor@chromium.org, andy.shevchenko@gmail.com,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        gwendal@chromium.org, linux-acpi@vger.kernel.org,
        briannorris@chromium.org, andriy.shevchenko@linux.intel.com,
        egranata@google.com
Subject: Re: [PATCH v2] driver: platform: Support parsing GpioInt 0 in
 platform_get_irq()
Message-ID: <20190212090835.GD7875@lahna.fi.intel.com>
References: <20190207185917.167829-1-egranata@google.com>
 <20190211190112.209286-1-egranata@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211190112.209286-1-egranata@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:01:12AM -0800, egranata@chromium.org wrote:
> From: Enrico Granata <egranata@chromium.org>
> 
> ACPI 5 added support for GpioInt resources as a way to provide
> information about interrupts mediated via a GPIO controller.
> 
> Several device buses (e.g. SPI, I2C) have support for retrieving
> an IRQ specified via this type of resource, and providing it
> directly to the driver as an IRQ number.
> 
> This is not currently done for the platform drivers, as platform_get_irq()
> does not try to parse GpioInt() resources. This requires drivers to
> either have to support only one possible IRQ resource, or to have code
> in place to try both as a failsafe.
> 
> While there is a possibility of ambiguity for devices that exposes
> multiple IRQs, it is easy and feasible to support the common case
> of devices that only expose one IRQ which would be of either type
> depending on the underlying system's architecture.
> 
> This commit adds support for parsing a GpioInt resource in order
> to fulfill a request for the index 0 IRQ for a platform device.
> 
> Signed-off-by: Enrico Granata <egranata@chromium.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
