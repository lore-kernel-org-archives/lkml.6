Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046A3C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72422082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72422082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeLKN73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:59:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:20922 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeLKN73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:59:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 05:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="126944647"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 11 Dec 2018 05:59:26 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gWiZJ-0000CU-Oc; Tue, 11 Dec 2018 15:59:25 +0200
Date:   Tue, 11 Dec 2018 15:59:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/3] device property: Add fwnode_get_name() helper
Message-ID: <20181211135925.GD10650@smile.fi.intel.com>
References: <20181211131451.52832-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211131451.52832-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 04:14:48PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> Andy, I dropped you Reviewed-by tag because of the last change to this
> series, so if you could check these again I would much appreciate.

They all looks fine,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Changes since v5:
> - No longer reading "name" device property as fallback.
> 
> Changes since v4:
> - No changes. There was an extra patch in v3. This was just a resend
>   of v3 without that extra patch.
> 
> Changes since v3:
> - I'm now returning -EOVERFLOW if the buffer is not big enough as
>   proposed by Andy.
> 
> This is the cover letter from v3:
> 
> This is the third version of my proposal for this helper. The
> second version can be checked here:
> https://lkml.org/lkml/2018/11/8/1005
> 
> I'm now passing the length as proposed by both Rob and Andy. I'm also
> leaving the .get_named_child_node fwnode op untouched.
> 
> --
> heikki
> 
> 
> Heikki Krogerus (3):
>   device property: Introduce fwnode_get_name()
>   ACPI: property: Add acpi_fwnode_name()
>   of/property: Add of_fwnode_name()
> 
>  drivers/acpi/property.c  | 28 ++++++++++++++++++++++++++++
>  drivers/base/property.c  | 17 +++++++++++++++++
>  drivers/of/property.c    | 13 +++++++++++++
>  include/linux/fwnode.h   |  3 +++
>  include/linux/property.h |  2 ++
>  5 files changed, 63 insertions(+)
> 
> -- 
> 2.19.2
> 

-- 
With Best Regards,
Andy Shevchenko


