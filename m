Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CADC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419832054F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419832054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbeH2TH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:07:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:53437 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbeH2TH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:07:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 08:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="258217213"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2018 08:09:56 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1fv26V-00024y-Pw; Wed, 29 Aug 2018 18:09:55 +0300
Date:   Wed, 29 Aug 2018 18:09:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [andriy.shevchenko@linux.intel.com: Re: [PATCH] spi: dw-mmio: add
 MSCC Jaguar2 support]
Message-ID: <20180829150955.GB7459@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Andy Shevchenko <andriy.shevchenko@linux.intel.com> -----

Date: Wed, 29 Aug 2018 18:08:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] spi: dw-mmio: add MSCC Jaguar2 support
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Aug 29, 2018 at 02:45:48PM +0200, Alexandre Belloni wrote:
> Unfortunately, the Jaguar2 CPU_SYSTEM_CTRL register set has a different
> layout than the Ocelot one. Handle that while keeping most of the code
> common.

> -#define OCELOT_IF_SI_OWNER_MASK			GENMASK(5, 4)

> +			   0x3 << if_si_owner_offset,

Perhaps,

#define MSCC_IF_SI_OWNER_MASK		GENMASK(1, 0)

...

	MSCC_IF_SI_OWNER_MASK << if_si_owner_offset,


-- 
With Best Regards,
Andy Shevchenko



----- End forwarded message -----

-- 
With Best Regards,
Andy Shevchenko


