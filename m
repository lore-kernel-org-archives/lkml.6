Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F847ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40ABA2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40ABA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeJZCXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:23:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:16893 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbeJZCXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:23:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 10:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,425,1534834800"; 
   d="scan'208";a="98668910"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 25 Oct 2018 10:49:55 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gFjla-0004jB-JM; Thu, 25 Oct 2018 20:49:54 +0300
Date:   Thu, 25 Oct 2018 20:49:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan O'Donovan <dan@emutex.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>
Subject: Re: [PATCH v3 0/3] iio: adc128s052: add matching options
Message-ID: <20181025174954.GC10650@smile.fi.intel.com>
References: <20180423213805.12591-1-javier@emutex.com>
 <1540481742-23596-1-git-send-email-dan@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540481742-23596-1-git-send-email-dan@emutex.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 04:35:39PM +0100, Dan O'Donovan wrote:
> Hi all,
> 
> On some SKUs of AAEON's UP Squared board, there is an ADC124S101
> enumerated via ACPI. This is a pin-compatible variant of ADC124S021,
> which is already supported by the adc128s052 driver.
> 
> This patchset adds missing DT compatible strings for ADC124S021 (and
> ADC122S021) variants, adds AAEON's allocated ACPI HID, and adds the
> SPDX GPL identifier to the driver.
> 
> v2 was posted at:
> https://lore.kernel.org/lkml/20180423213805.12591-1-javier@emutex.com/

Overall LGTM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Changes from v2:
> * Added device-tree bindings documentation for new chip variants
> * Simplified code to get ACPI match data
> * Dropped redundant patch to facilitate OF matching via ACPI _DSD
> * Added patch to replace GPL license text with SPDX identifier
> 
> Changes from v1:
> * Improved patch descriptions and series title
> * Added an initial commit introducing new compatible strings
>   (as per Jonathan's suggestion)
> * Moved of_match_ptr removal last as this patch is less important to us
> 
> Dan O'Donovan (1):
>   iio: adc128s052: use SPDX-License-Identifier
> 
> Javier Arteaga (1):
>   iio: adc128s052: Add pin-compatible IDs
> 
> Nicola Lunghi (1):
>   iio: adc128s052: add ACPI _HID AANT1280
> 
>  .../devicetree/bindings/iio/adc/ti-adc128s052.txt  |  9 ++++-
>  drivers/iio/adc/ti-adc128s052.c                    | 39 +++++++++++++++++-----
>  2 files changed, 38 insertions(+), 10 deletions(-)
> 
> -- 
> 2.7.4
> 
> 
> ------
> This email has been scanned for spam and malware by The Email Laundry.
> 

-- 
With Best Regards,
Andy Shevchenko


